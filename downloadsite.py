import requests
from bs4 import BeautifulSoup
import os
import sys
import subprocess
from urllib.parse import urljoin, urlparse
import shutil

def download_file(url, path):
    try:
        response = requests.get(url, stream=True)
        with open(path, 'wb') as file:
            for chunk in response.iter_content(chunk_size=8192):
                if chunk:
                    file.write(chunk)
        print(f"Downloaded {url} to {path}")
    except Exception as e:
        print(f"Error downloading {url}: {e}")

def download_webpage(url, save_dir):
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')

    if not os.path.exists(save_dir):
        os.makedirs(save_dir)

    html_path = os.path.join(save_dir, "index.html")
    download_file(url, html_path)

    for tag in soup.find_all(['link', 'script', 'img']):
        link = tag.get('href') or tag.get('src')
        if link:
            full_url = urljoin(url, link)
            local_path = os.path.join(save_dir, urlparse(link).path.lstrip('/'))
            local_dir = os.path.dirname(local_path)

            if not os.path.exists(local_dir):
                os.makedirs(local_dir)

            download_file(full_url, local_path)

def open_in_vscode(directory):
    subprocess.run(f"code {directory}", shell=True, check=True)

def confirm_redownload(directory):
    response = input(f"The directory {directory} already exists. Would you like to redownload? (yes/no): ")
    return response.lower() == 'yes'

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Please provide a URL as an argument.")
        sys.exit(1)

    webseite_url = sys.argv[1]
    website_name = urlparse(webseite_url).netloc

    documents_folder = os.path.join(os.path.expanduser('~'), 'Documents')
    ziel_verzeichnis = os.path.join(documents_folder, website_name)

    if os.path.exists(ziel_verzeichnis) and confirm_redownload(ziel_verzeichnis):
        shutil.rmtree(ziel_verzeichnis)
        print("Previous download deleted. Starting new download...")

    download_webpage(webseite_url, ziel_verzeichnis)
    open_in_vscode(ziel_verzeichnis)
