# Package
pacman::p_load(data.table, stringr, yaml)
# Find all image files in the Gallery directory
img_files =
  list.files(
    'Gallery',
    pattern = "\\.(png|jpg|jpeg|JPG|JPEG)$",
    full.names = TRUE
  )
# Create a data frame with file paths and modification dates
img_dt =
  data.table(
    path = img_files,
    modified = file.info(img_files)$mtime |> as.Date() |> as.character(),
    captured =
      img_files |>
      str_extract('[0-9]{8}') |>
      as.Date(format = '%Y%m%d') |>
      as.character()
  )
# Sort the data frame by modification date in descending order
setorder(img_dt, -modified)
# Write to YML file
write_yaml(img_dt, 'photos.yml', column.major = FALSE)