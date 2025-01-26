#!/bin/bash
# Reduce PDF version to be compatible with older Acrobat versions (e.g., Acrobat 7.0).
# Acrobat 7.0 is free and can be used with Wine on Linux for OCR and image size reduction.

# Ensure both input and output files are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input-pdf> <output-pdf>"
    exit 1
fi

input_pdf="$1"
output_pdf="$2"

# Check if input file exists
if [ ! -f "$input_pdf" ]; then
    echo "Error: Input file '$input_pdf' not found!"
    exit 1
fi

# Run Ghostscript to reduce PDF version and optimize for compatibility with Acrobat 7.0
gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.0 \
   -dNOPAUSE \
   -dBATCH \
   -sOutputFile="$output_pdf" \
   "$input_pdf"

# Check if the Ghostscript command was successful
if [ $? -eq 0 ]; then
    echo "PDF successfully reduced and saved to '$output_pdf'."
else
    echo "Error: Failed to process the PDF."
    exit 1
fi

