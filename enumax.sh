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
print_colored "$GREEN" "Running sublist3r..."
sublist3r_result=$(sublist3r -d "$TARGET" 2>/dev/null | sort -u)
echo "$sublist3r_result" > "$OUTPUT_FOLDER/sublist3r_subdomains.txt"
sublist3r_count=$(echo "$sublist3r_result" | wc -l)
print_colored "$YELLOW" "Subdomains collected by sublist3r: $sublist3r_count"

# Run subfinder and display results
print_colored "$GREEN" "Running subfinder..."
subfinder_result=$(subfinder -d "$TARGET" 2>/dev/null | sort -u)
echo "$subfinder_result" > "$OUTPUT_FOLDER/subfinder_subdomains.txt"
subfinder_count=$(echo "$subfinder_result" | wc -l)
print_colored "$YELLOW" "Subdomains collected by subfinder: $subfinder_count"

# Run findomain and display results
print_colored "$GREEN" "Running findomain..."
findomain_result=$(findomain -t "$TARGET" 2>/dev/null | sort -u)
echo "$findomain_result" > "$OUTPUT_FOLDER/findomain_subdomains.txt"
findomain_count=$(echo "$findomain_result" | wc -l)
print_colored "$YELLOW" "Subdomains collected by findomain: $findomain_count"

# Run assetfinder and display results
print_colored "$GREEN" "Running assetfinder..."
assetfinder_result=$(assetfinder "$TARGET" 2>/dev/null | sort -u)
echo "$assetfinder_result" > "$OUTPUT_FOLDER/assetfinder_subdomains.txt"
assetfinder_count=$(echo "$assetfinder_result" | wc -l)
print_colored "$YELLOW" "Subdomains collected by assetfinder: $assetfinder_count"

# Combine and unique subdomains
cat "$OUTPUT_FOLDER"/*_subdomains.txt | sort -u > "$OUTPUT_FOLDER/all_subdomains.txt"

# Remove individual tool output files (excluding all_subdomains.txt)
rm "$OUTPUT_FOLDER"/*_subdomains.txt 2> /dev/null

# Display total number of subdomains
total_count=$(cat "$OUTPUT_FOLDER/all_subdomains.txt" | wc -l)
print_colored "$YELLOW" "Total combined and unique subdomains: $total_count"
print_colored "$GREEN" "Subdomains enumeration completed. Results saved in: $OUTPUT_FOLDER/all_subdomains.txt"
