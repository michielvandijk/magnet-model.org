# ========================================================================================
# Project:  michielvandijk.org
# Subject:  updates publications
# Author:   Michiel van Dijk
# Contact:  michiel.vandijk@wur.nl
# ========================================================================================

# ========================================================================================
# SETUP ----------------------------------------------------------------------------------
# ========================================================================================

# Load pacman for p_load
if(!require(pacman)) install.packages("pacman")
library(pacman)

# Load key packages
p_load(here)

# R options
options(scipen = 999)
options(digits = 4)

# ========================================================================================
# TO ADD ---------------------------------------------------------------------------------
# ========================================================================================

# Fix special symbols in Mendeley/LATEX
# write function to add figure


# ========================================================================================
# UPDATE PUBLICATIONS---------------------------------------------------------------------
# ========================================================================================
# Source function
source(here::here("support/update_publications/bibtex_2_hugo.R"))

# Set input and output file
bibfile <- "C:/Data/zotero/magnet-publications.bib"
outfold   <- here::here("content/publication/")

# process
bibtex2academic(bibfile  = bibfile, outfold   = outfold)


# ========================================================================================
# UPDATE CV ------------------------------------------------------------------------------
# ========================================================================================

# cv_source <- "C:/data/github/CV/cv/michiel_van_dijk_cv_long.pdf"
# file.copy(cv_source, here::here("static/cv/michiel_van_dijk_cv_long.pdf"), overwrite = TRUE)
