# Libraries
library(RCurl)
library(stringr)
library(data.table)

# Server path configuration
SERVER_ROOT <- "/reference"

FORMS_FOLDER        <- "forms"
STATS_FORMS_FOLDER  <- paste0(FORMS_FOLDER, "/stats/")
ROS_FORMS_FOLDER    <- paste0(FORMS_FOLDER, "/ros/")

DATA_IOTC_SERVER_IP <- Sys.getenv("DATA_IOTC_SERVER_IP")
DATA_IOTC_USERNAME  <- Sys.getenv("DATA_IOTC_USERNAME")
DATA_IOTC_PASSWORD  <- Sys.getenv("DATA_IOTC_PASSWORD")

print(paste0("IOTC data server IP: ", DATA_IOTC_SERVER_IP))
print(paste0("IOTC data username : ", DATA_IOTC_USERNAME))
print(paste0("IOTC data password : ", str_replace_all(DATA_IOTC_PASSWORD, ".", "*")))

# Upload functions
# CURL_CMD <- function(url, cmd) {
#   curlPerform(url = url, quote = cmd)
# }

CURL_CMD <- function(url, cmd) {
  invisible(
    curlPerform(
      url = url,
      quote = cmd,
      writefunction = function(x) nchar(x)
    )
  )
}

CURL_FTPu <- function(filename, target_url, asText = FALSE) {
  ftpUpload(what = filename, 
            to = target_url, 
            asText = asText,
            .opts = list(ftp.create.missing.dirs = TRUE))
}

CURL_FTPd <- function(filename) {
  CURL_CMD(
    url = ftp_url("/"),
    cmd = paste0('rm "', filename, '"')
  )
}

check_connection <- function(command) {
  if(!can_connect()) 
    stop(
      paste0("Cannot connect with remote server at ", DATA_IOTC_SERVER_IP, " using ", DATA_IOTC_USERNAME, " as username: please check that server IP and credentials are correct...")
    )
}

userpwd <- function() {
  return(paste0(DATA_IOTC_USERNAME, ":", DATA_IOTC_PASSWORD))
}

ftp_root <- function() {
  return(ftp_url())
}

ftp_url <- function(path = NA) {
  return(
    paste0(
      "sftp://", 
      userpwd(), 
      "@", DATA_IOTC_SERVER_IP, 
      ifelse(is.na(path), "", paste0("/", path))
    )
  )
}

can_connect <- function() {
  return(url.exists(ftp_url(), userpwd = userpwd()))
}

full_folder <- function(version, folder = NA) {
  return(
    paste0(SERVER_ROOT, "/", version, ifelse(is.na(folder), "", paste0("/", folder)))
  )
}

create_folder <- function(version, folder) {
  folder = paste0(full_folder(version, folder), "/")
  
  print(paste0("Creating empty remote folder ", folder, "..."))
  
  cmd = paste0("mkdir ", folder)
  
  CURL_CMD(ftp_root(), cmd)
}

initialize_folder <- function(version, folder) {
  folder = full_folder(version, folder)
  
  print(paste0("FOLDER: ", folder))
  
  if(url.exists(ftp_url(folder), userpwd = userpwd())) {
    print(paste0("Remote folder ", folder, " already exists...")) 
  } else {
    print(paste0("Creating empty remote folder ", folder, "..."))
    
    cmd = paste0("mkdir ", folder)
    
    CURL_CMD(ftp_root(), cmd)
  }
}

initialize_version <- function(version) {
  check_connection()
  
  folder <- full_folder(version)
  
  if(url.exists(ftp_url(folder))) {
    print(paste0("Remote folder for version ", version, " already exists... Skipping folder creation."))
  } else {
    print(paste0("Creating remote folder for version '", version, "'..."))
    
    CURL_CMD(ftp_root(), paste0("mkdir ", folder))
  }
  
  initialize_forms(version)
}

# Remove previous reporting forms available from the server 
clean_reporting_forms <- function(type = c("ros", "stats")) {
  
  type <- match.arg(type)
  
  folder <- switch(
    type,
    ros   = full_folder(ROS_FORMS_FOLDER),
    stats = full_folder(STATS_FORMS_FOLDER)
  )
  
  # Get current files
  files <- getURL(
    ftp_url(folder),
    dirlistonly = TRUE
  )
  
  files <- strsplit(files, "\r?\n")[[1]]
  files <- files[nzchar(files)]
  
  # Only files managed by this release process
  files <- files[
    grepl("\\.(xlsx|zip)$", files, ignore.case = TRUE) |
      files == "form_versions.csv"
  ]
  
  # Delete
  for (file in files) {
    
    remote_file <- paste0(
      sub("/$", "", folder),
      "/",
      file
    )
    
    print(paste0(
      "Removing previous file '",
      remote_file,
      "'..."
    ))
    
    CURL_FTPd(remote_file)
  }
  
  invisible(files)
}

# Add most recent version of reporting forms, including a zip file
upload_reporting_forms <- function(type = c("ros", "stats")) {
    
    type <- match.arg(type)
    
    forms_dir <- file.path("./form_reporting_templates", type)
    
    # Get Excel forms
    files <- list.files(
      forms_dir,
      pattern = "\\.xlsx$",
      recursive = TRUE
    )
    
    # Exclude beta / non-release forms
    exclude_file <- file.path(forms_dir, "exclude_from_release.txt")
    
    if (file.exists(exclude_file)) {
      
      excluded <- readLines(exclude_file, warn = FALSE)
      excluded <- trimws(excluded)
      excluded <- excluded[nzchar(excluded) & !startsWith(excluded, "#")]
      
      files <- setdiff(files, excluded)
    }
    
    # Identify form and version
    dt <- data.table(file = files)
    
    dt[, `:=`(
      form    = sub("/.*", "", file),
      version = sub(".*/v([^/]+)/.*", "\\1", file)
    )]
    
    dt[, c("major", "minor", "patch") :=
         tstrsplit(version, ".", fixed = TRUE, type.convert = TRUE)]
    
    # Select latest released version of each form
    latest <- dt[
      order(major, minor, patch),
      .SD[.N],
      by = form
    ]
    
    latest[, local_file := file.path(forms_dir, file)]
    
    # Create manifest to describe the form versions available
    manifest <- latest[, .(
      form,
      version,
      filename = basename(file)
    )]
    
    manifest[, url := paste0(
      "https://data.iotc.org/reference/forms/",
      type,
      "/",
      filename
    )]
    
    manifest_file <- file.path(forms_dir, "form_versions.csv")
    
    fwrite(manifest, manifest_file)
    
    # Destination FTP folder
    folder <- switch(
      type,
      ros   = full_folder(ROS_FORMS_FOLDER),
      stats = full_folder(STATS_FORMS_FOLDER)
    )
    
    # Clean previous public release
    clean_reporting_forms(type)
    
    # Upload individual forms
    for (i in seq_len(nrow(latest))) {
      
      filename <- basename(latest$file[i])
      
      print(paste0(
        "Uploading form '", filename,
        "' in ", folder, "..."
      ))
      
      CURL_FTPu(
        filename   = latest$local_file[i],
        target_url = ftp_url(paste0(folder, "/", filename))
      )
    }
    
    # Create archive
    zip_name <- switch(
      type,
      ros   = "IOTC-ROS-forms.zip",
      stats = "IOTC-statistical-forms.zip"
    )
    
    zipfile <- file.path(forms_dir, zip_name)
    
    print(paste0(
      "Uploading all ", type,
      " forms as a zipped archive in ", folder, "..."
    ))
    
    zip::zip(
      zipfile = zipfile,
      files   = latest$local_file,
      mode    = "cherry-pick"
    )
    
    CURL_FTPu(
      filename   = zipfile,
      target_url = ftp_url(paste0(folder, "/", zip_name))
    )
    
    # Upload release manifest
    CURL_FTPu(
      filename   = manifest_file,
      target_url = ftp_url(paste0(folder, "/form_versions.csv"))
    )
}

# Load most recent reporting
upload_reporting_forms("ros")
upload_reporting_forms("stats")



