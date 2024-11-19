# Here's a breakdown of the script:

# download_file(url, dest_path): Downloads the file from the given URL and saves it to the specified destination path.

# calculate_checksum(file_path, hash_algo='sha256'): Calculates the checksum of the file using the specified hash algorithm (default is SHA-256).

# verify_checksum(file_path, expected_checksum, hash_algo='sha256'): Verifies the calculated checksum against the expected checksum.

# Replace github_url with the actual URL of the application you want to download, destination_path with the path where you want to save the downloaded file, and expected_checksum with the actual checksum value you expect.

# Here's a breakdown of the new additions:

# get_latest_release_info(repo): Fetches the latest release information from the GitHub API for the specified repository.

# find_asset_url(release_info, pattern): Finds the download URL for the asset that matches the given pattern.

# Replace repo with the actual repository name (e.g., microsoft/WSL), pattern with a regex pattern that matches the asset name you want to download, and expected_checksum with the actual checksum value you expect.

# Here's a breakdown of the new additions:

# checksum_pattern: A regex pattern to match the checksum file name.

# checksum_path: The path where the checksum file will be saved.

# The script now downloads the checksum file and reads the expected checksum from it before verifying the checksum of the downloaded application.

# Replace repo with the actual repository name (e.g., microsoft/WSL), pattern with a regex pattern that matches the asset name you want to download, and checksum_pattern with a regex pattern that matches the checksum file name.

# This script will download the latest Linux x64 release of the specified application from GitHub, download the corresponding SHA256 checksum file, and verify the checksum.


import hashlib
import requests
import re

def download_file(url, dest_path):
    response = requests.get(url, stream=True)
    response.raise_for_status()
    with open(dest_path, 'wb') as file:
        for chunk in response.iter_content(chunk_size=8192):
            file.write(chunk)
    print(f"Downloaded {dest_path}")

def calculate_checksum(file_path, hash_algo='sha256'):
    hash_func = hashlib.new(hash_algo)
    with open(file_path, 'rb') as file:
        for chunk in iter(lambda: file.read(4096), b""):
            hash_func.update(chunk)
    return hash_func.hexdigest()

def verify_checksum(file_path, expected_checksum, hash_algo='sha256'):
    calculated_checksum = calculate_checksum(file_path, hash_algo)
    if calculated_checksum == expected_checksum:
        print("Checksum verification passed!")
    else:
        print("Checksum verification failed!")
        print(f"Expected: {expected_checksum}")
        print(f"Calculated: {calculated_checksum}")

def get_latest_release_info(repo):
    api_url = f"https://api.github.com/repos/{repo}/releases/latest"
    response = requests.get(api_url)
    response.raise_for_status()
    return response.json()

def find_asset_url(release_info, pattern):
    for asset in release_info['assets']:
        if re.search(pattern, asset['name']):
            return asset['browser_download_url']
    raise ValueError("No matching asset found")

# Example usage
repo = "user/repo"  # Replace with the actual repository
pattern = r"linux.*x64.*\.tar\.gz"  # Adjust the pattern to match the asset name
checksum_pattern = r"sha256sum.*\.txt"  # Pattern to match the checksum file
destination_path = "application.tar.gz"
checksum_path = "checksum.txt"

# Get the latest release info
release_info = get_latest_release_info(repo)

# Download the application
download_url = find_asset_url(release_info, pattern)
download_file(download_url, destination_path)

# Download the checksum file
checksum_url = find_asset_url(release_info, checksum_pattern)
download_file(checksum_url, checksum_path)

# Read the expected checksum from the checksum file
with open(checksum_path, 'r') as file:
    expected_checksum = file.readline().split()[0]

# Verify the checksum
verify_checksum(destination_path, expected_checksum)
