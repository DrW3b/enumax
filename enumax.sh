#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <target_domain>"
    exit 1
fi

TARGET=$1
OUTPUT_FOLDER="${TARGET}"

# ANSI color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored text
print_colored() {
    local color="$1"
    local message="$2"
    echo -e "${color}${message}${NC}"
}

# Create output folder
mkdir -p "$OUTPUT_FOLDER"

# Run sublist3r and display results
sublist3r_output="$OUTPUT_FOLDER/sublist3r_subdomains.txt"
print_colored "$GREEN" "Running sublist3r..."
sublist3r -d "$TARGET" -o "$sublist3r_output" >/dev/null 2>&1
sublist3r_count=$(cat "$sublist3r_output" | wc -l)
print_colored "$YELLOW" "Subdomains collected by sublist3r: $sublist3r_count"

# Run subfinder and display results
subfinder_output="$OUTPUT_FOLDER/subfinder_subdomains.txt"
print_colored "$GREEN" "Running subfinder..."
subfinder -d "$TARGET" -o "$subfinder_output" >/dev/null 2>&1
subfinder_count=$(cat "$subfinder_output" | wc -l)
print_colored "$YELLOW" "Subdomains collected by subfinder: $subfinder_count"

# Run findomain and display results
findomain_output="$OUTPUT_FOLDER/findomain_subdomains.txt"
print_colored "$GREEN" "Running findomain..."
findomain -t "$TARGET" -q -u "$findomain_output" >/dev/null 2>&1
findomain_count=$(cat "$findomain_output" | wc -l)
print_colored "$YELLOW" "Subdomains collected by findomain: $findomain_count"

# Run assetfinder and display results
assetfinder_output="$OUTPUT_FOLDER/assetfinder_subdomains.txt"
print_colored "$GREEN" "Running assetfinder..."
assetfinder "$TARGET" > "$assetfinder_output" 2>/dev/null
assetfinder_count=$(cat "$assetfinder_output" | wc -l)
print_colored "$YELLOW" "Subdomains collected by assetfinder: $assetfinder_count"

# Combine and unique subdomains
cat "$OUTPUT_FOLDER"/*_subdomains.txt | sort -u > "$OUTPUT_FOLDER/all-subdomains.txt"

# Remove individual tool output files (excluding all_subdomains.txt)
rm "$OUTPUT_FOLDER"/*_subdomains.txt 2> /dev/null

# Display total number of subdomains
total_count=$(cat "$OUTPUT_FOLDER/all-subdomains.txt" | wc -l)
print_colored "$YELLOW" "Total combined and unique subdomains: $total_count"
print_colored "$GREEN" "Subdomains enumeration completed. Results saved in: $OUTPUT_FOLDER/all-subdomains.txt"
