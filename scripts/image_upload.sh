# Check if an argument is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <source_file>"
  exit 1
fi

# Define variables for source and target directories
source_file="$1"
target_directory="s3://std-017-042-dumpling-images/"

# Check if the source file exists
if [ ! -f "$source_file" ]; then
  echo "Source directory '$source_file' does not exist."
  exit 1
fi

# Copy links code to a directory
cp -r "$source_file" ./links
echo "The links code is copied..."

# Run the Python script
python image_download.py

# Check if the images directory exists
if [ -d "images" ]; then
  # Upload images to S3
  aws s3 cp --endpoint-url=https://storage.yandexcloud.net --recursive images/ "$target_directory"
  echo "Images uploaded to $target_directory"

  # Remove the local images directory
  rm -rf images
  echo "Images directory is removed"
else
  echo "Images directory does not exist."
fi

# Remove the links code directory
rm -rf ./links
echo "The links code is removed"