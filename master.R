
# Load two packages
library(pacman)
p_load(rmarkdown)
# Set working directory
setwd("/Users/edwardarubin/Dropbox/Websites/edrubin.github.io/")
# Find files
the_files <- grep("[\\.][R][m][d]", dir(), value = T)
# Compile the pages
for (i in the_files) {
  # Run the render script on the ith file
  render_site(i)
  # Clear memory
  # rm(list = setdiff(ls(), c("i", "the_files")))
  # # Unload all packages except pacman and rmarkdown
  # p_unload(pacman, rmarkdown, negate = T)
}
