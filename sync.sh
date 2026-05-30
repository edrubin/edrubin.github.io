# copy slides from original location to this repo
rsync -avh --delete --itemize-changes \
  --exclude='.DS_Store' \
  /Users/edwardr/Dropbox/Teaching/Misc/2026-ibeo-keynote/slides/ \
  /Users/edwardr/Dropbox/Websites/edrubin.github.io/slides/slides-ibeo-2026/
