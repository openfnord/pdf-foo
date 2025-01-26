#!/bin/bash
# Script to convert a PDF to a fax-style graphic-only version without text
#
# Why: faxify fakes pdf to be faxes faxify is needed if you want to send a "copy" of your fax via email, 
# and you want to omit the discussion if a computer fax is a "real" fax, because it has pdf letters and only a signature picture
# faxify "scans" your fax to g4 fax tiff and converts it back to pdf. So the document was a fax for legal purposes and looks alike:-)
#

# Check if the input file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <input-pdf>"
  exit 1
fi

input_pdf="$1"
output_pdf="${input_pdf%.*}_fax.pdf"

# Create a temporary directory for intermediate files
temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

# Generate a temporary TIFF file with graphic-only content
temp_tiff="$temp_dir/faxify_tmptiff.tiff"
gs -sDEVICE=tiffg4 \
   -dNOPAUSE \
   -dBATCH \
   -dSAFER \
   -sOutputFile="$temp_tiff" \
   "$input_pdf"

# Convert the TIFF back to PDF (faxified version)
tiff2pdf "$temp_tiff" > "$output_pdf"

# Output the result and clean up
echo "Faxified PDF saved to: $output_pdf"




