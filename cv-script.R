# Load packages
pacman::p_load(stringr, magrittr, rmarkdown)

# Read the CV (to change formatting)
cv = here::here('cv.qmd') |> readLines()

# Remove YAML and initial header
cv =
  cv[seq(
    str_detect(cv, '## Academic positions') |> which(),
    length(cv)
  )]

# Formatting
cv %<>%
  # str_replace_all('<br>', '<br>  ') %<>%
  # str_replace_all('##', '#') %>%
  str_replace_all('`oh`', '0') %>%
  str_replace_all('`zero`', '0') %>%
  str_replace_all('`one`', '1') %>%
  str_replace_all('`two`', '2') %>%
  str_replace_all('`three`', '3') %>%
  str_replace_all('`four`', '4') %>%
  str_replace_all('`five`', '5') %>%
  str_replace_all('`six`', '6') %>%
  str_replace_all('`seven`', '7') %>%
  str_replace_all('`eight`', '8') %>%
  str_replace_all('`nine`', '9') %>%
  str_replace_all(' `ampersat` ', '\\@') %>%
  str_replace_all(' `period` ', '\\.')

# Add two spaces at the end of lines
cv %<>% paste0('  ')
# Remove two spaces from lists
cv[grep('-', substr(cv, 1, 1))] %<>% str_replace_all('  ', '')

# Add page break before academic service
cv[grep('## Academic service', cv)] %<>%
  paste0('{{< pagebreak >}}\n\n', .)

# Add header
header = here::here('cv-pdf-header.qmd') |> readLines()
cv = c(header, '', cv)

# Remove script call at the end
cv = cv[-(grep('```\\{r\\}', cv):length(cv))]

# If last line is blank, remove it
if (cv[length(cv)] == '  ') cv = cv[-length(cv)]
# Add phone
cv = c(
  cv,
  '- __phone__ +1 (402) 802-7672'
)

# Create the new qmd file
con = file('tmp.qmd')
writeLines(cv, con)
close(con)

# Render to pdf
system('quarto render tmp.qmd -o cv-edward-rubin.pdf')

# Clean up temporary files
file.remove('tmp.qmd')
