# Load packages
pacman::p_load(stringr, magrittr, rmarkdown)

# Read the CV (to change formatting)
cv <- here::here("cv.qmd") |> readLines()
# Remove PDF link and its formatting
cv[grep("\\[PDF\\]", cv)] <- ""
cv[grep("<br><br>", cv)] <- ""
cv %<>%
  # str_replace_all("<br>", "<br>  ") %<>%
  # str_replace_all("##", "#") %>%
  str_replace_all("`oh`", "0") %>%
  str_replace_all("`zero`", "0") %>%
  str_replace_all("`one`", "1") %>%
  str_replace_all("`two`", "2") %>%
  str_replace_all("`three`", "3") %>%
  str_replace_all("`four`", "4") %>%
  str_replace_all("`five`", "5") %>%
  str_replace_all("`six`", "6") %>%
  str_replace_all("`seven`", "7") %>%
  str_replace_all("`eight`", "8") %>%
  str_replace_all("`nine`", "9") %>%
  str_replace_all(" `ampersat` ", "\\@") %>%
  str_replace_all(" `period` ", "\\.")

# Replace toc call to be false
cv[grep("toc: true", cv)] = "toc: false"

# Add two spaces at the end of lines
cv %<>% paste0("  ")
# Remove unnecessary line breaks
# cv[grep("#", cv) - 2] <- "  "
# Remove two spaces from lists
cv[grep("-", substr(cv, 1, 1))] %<>% str_replace_all("  ", "")
# New page above Academic Service section
# cv[grep("# Academic Service", cv) - 2] <- "\\pagebreak"

# Remove script call at the end
cv = cv[-(grep("```\\{r\\}", cv):length(cv))]

# Create the new qmd file
con <- file("tmp.qmd")
writeLines(cv, con)
close(con)

# Render to pdf
render(
  here::here("tmp.qmd"),
  pdf_document(
    latex_engine = "xelatex",
    toc = FALSE,
    number_sections = FALSE,
    highlight = "pygments",
    extra_dependencies = c("sectsty"),
    pandoc_args = c(
      # "--metadata=author:\"Ed Rubin\"",
      # pandoc_variable_arg("mainfont", "Charter"),
      # pandoc_variable_arg("mainfont", "Georgia"),
      # pandoc_variable_arg("mainfont", "Avenir"),
      # pandoc_variable_arg("monofont", "Hack"),
      pandoc_variable_arg("fontsize", "10pt"),
      # pandoc_variable_arg("mainfont", "Lato"),
      pandoc_variable_arg("mainfont", "Fira Sans Condensed"),
      # pandoc_variable_arg("mainfont", "Fira Sans Book"),
      # pandoc_variable_arg("mainfont", "Roboto Mono"),
      # pandoc_variable_arg("sansfont", "Lato"),
      # pandoc_variable_arg("mainfont", "Bell MT"),
      # pandoc_variable_arg("monofont", "Hack"),
      # pandoc_variable_arg("fontsize", "10pt"),
      pandoc_variable_arg("linestretch", "0.9")
      )
    ),
  output_file = "cvEdRubin.pdf",
  output_dir = "."
)

# Clean up temporary files
file.remove("tmp.qmd")
file.remove("cvEdRubin.log")
