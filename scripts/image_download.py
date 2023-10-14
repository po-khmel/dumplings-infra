import requests
import os
import re


def download_image(url, folder_path):
    try:
        response = requests.get(url, stream=True)
        if response.status_code == 200:
            filename = os.path.join(folder_path, os.path.basename(url))
            with open(filename, "wb") as file:
                for chunk in response.iter_content(1024):
                    file.write(chunk)
            print(f"Downloaded: {filename}")
        else:
            print(f"Failed to download: {url}")
    except Exception as e:
        print(f"Error while downloading: {url} - {str(e)}")


def download_images_from_file(file_path, folder_path):
    with open(file_path, "r") as file:
        content = file.read()
        image_links = re.findall(r"http[s]?://[^\s]+\.jpg", content)

        if not os.path.exists(folder_path):
            os.makedirs(folder_path)

        for image_link in image_links:
            download_image(image_link, folder_path)


if __name__ == "__main__":
    input_file = "./links"  # Replace with your input file path
    download_folder = (
        "./images"  # Replace with the folder where you want to save the images
    )

    download_images_from_file(input_file, download_folder)
