#!/usr/bin/env bash
# #!/bin/bash
if [[ $# -eq 0 ]] || [[ "" == "--help" ]]
then
  echo ""
  echo ""
  echo "Usage: $0 "
  echo "Work under working directory."
  echo "by Le CHEN, (chenle02@gmail.com)"
  echo "Sat Nov 25 08:30:22 AM EST 2023"
  echo ""
  echo ""
  exit 1
fi


pdftoppm -png -f 1 -r 600 -singlefile ../slides/Slides_8-6.pdf Slides_8-6
