# ========================================================================================
# Project:  magnet-model.org
# Subject:  Script to copy files from sharepoint to repo
# Author:   Michiel van Dijk
# Contact:  michiel.vandijk@wur.nl
# ========================================================================================

# ========================================================================================
# SETUP ----------------------------------------------------------------------------------
# ========================================================================================

# Load pacman for p_load
if(!require(pacman)){
  install.packages("pacman")
  library(pacman)
} else {
  library(pacman)
}

# Load key packages
p_load("here", "tidyverse", "readxl", "stringr", "scales", "glue")

# R options
options(scipen=999) # Surpress scientific notation
options(digits=4)
options(viewer = NULL)

# ========================================================================================
# COPY SHAREPOINT FILES ------------------------------------------------------------------
# ========================================================================================


# COPY FROM SHAREPOINT -------------------------------------------------------------------

# For now we first manually copy files from the sharepoint to the sharepoint folder in the
# repository. When sync works again, we can add a script to copy it from a location on the
# hard drive.


# COPY TO REPO ---------------------------------------------------------------------------

# Load folder name mapping
# As it is not clear if we can use the full names (seems to cause an error, which might)
# be fixed in an update of the wowchemy template) we use initials for the folder name
team_names <- read_csv(here("support/update_website/team_names.csv"))


# function to copy files into right location per team member folder
copy_team_member <- function(folder, out = here("content/authors")){
  blogdown::stop_server()
  cat("\n",basename(folder), sep = "")

  # Files in folder
  files <- list.files(folder, full.names = T)

  # Copy CV to static folder in repo
  cv <- glue("{basename(folder)}.pdf")
  if(!cv %in% basename(files)){
    message("\ncv not found in folder. Please check")
  } else {
    file.copy(files[basename(files) == cv], here(glue("static/cv/{cv}")), overwrite = T)
    cat("\n", cv, " copied", sep = "")
  }

  # copy _index to team member folder
  new_folder <- team_names$website_name[team_names$sharepoint_name == basename(folder)]
  if(!"_index.md" %in% basename(files)){
    message("_index.md not found in folder. Please check")
  } else {
    dir.create(glue("{out}/{new_folder}"), recursive = T, showWarnings = F)
    file.copy(files[basename(files) == "_index.md"], glue("{out}/{new_folder}/_index.md"), overwrite = T)
    cat("\n_index.md copied", sep = "")
  }

  # copy avatar to team member folder
  if(!"avatar.jpg" %in% basename(files)){
    message("avatar.jpg not found in folder. Please check")
  } else {
    dir.create(glue("{out}/{new_folder}"), recursive = T, showWarnings = F)
    file.copy(files[basename(files) == "avatar.jpg"], glue("{out}/{new_folder}/avatar.jpg"), overwrite = T)
    cat("\navatar.jpg copied\n", sep = "")
  }
}

# Copy sharepoint files to repo
# Get list of folder names
team_member_folders <- list.files(here("support/update_website/sharepoint"), full.names = T)
walk(team_member_folders, copy_team_member)
