# Enumax - Subdomain Enumeration Tool

Enumax is a simple Bash script that automates subdomain enumeration using popular tools such as sublist3r, subfinder, findomain, and assetfinder. It combines and saves the unique subdomains into a single text file.

## Prerequisites

Before using Enumax, make sure you have the following tools installed:

- [sublist3r](https://github.com/aboul3la/Sublist3r)
- [subfinder](https://github.com/projectdiscovery/subfinder)
- [findomain](https://github.com/Edu4rdSHL/findomain)
- [assetfinder](https://github.com/tomnomnom/assetfinder)

You can install these tools by following the instructions provided in their respective repositories.

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/DrW3b/enumax.git
    cd enumax
    ```

2. Make the script executable:

    ```bash
    chmod +x enumax.sh
    ```

3. Run the script with your target domain:

    ```bash
    ./enumax.sh target.com
    ```

4. The script will create a folder named after the target domain and save the results inside it.

## Features

- Uses sublist3r, subfinder, findomain, and assetfinder for comprehensive subdomain enumeration.
- Combines and saves unique subdomains in a single text file.
- Colored output for better readability.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- The Enumax script is inspired by the need for a simple and effective subdomain enumeration tool.

Feel free to contribute and enhance the tool!

Happy enumerating!
