# ~/.bashrc.d/functions.sh

# Function to edit config
edit_editor() {
    hx ~/.config/wezterm/.wezterm.lua ~/AppData/Roaming/helix/config.toml ~/AppData/Roaming/helix/languages.toml 
}

edit_bashrc() {
  hx ~/.bashrc ~/.bashrc.d/aliases.sh ~/.bashrc.d/env.sh ~/.bashrc.d/functions.sh
} 

gcom() {
	git add .
	git commit -m "$1"
}

lazyg() {
	git add .
	git commit -m "$1"
        git pull
	git push
}

#Function to rename the vtt to Français
rename_vtt() {  
  fd -e vtt -x mv {} {//}/Français.vtt
}
  
extract_cc() { 
  unzip "$1"*.zip 
  for folder in */; do
    folder_name=$(basename "$folder")
    new_name=$(echo "$folder_name" | cut -d' ' -f1)
    if [ "$folder_name" != "$new_name" ]; then
      mv "$folder" "$new_name"
    fi
  done
  rm "$1"*.zip
  rename_vtt
}
    
# Function to get the txt from a text file
get_desc() {
    nvim -c 'normal ggVG"+y' -c 'q!' "$1"*.txt
}

# # Function to crop the image to the closest 16:9 resolution
# crop_image() {
#     local img="$1"
#     # Get the original dimensions of the image using identify
#     dimensions=$(magick identify -format "%wx%h" "$img")
#     width=$(echo $dimensions | cut -d'x' -f1)
#     height=$(echo $dimensions | cut -d'x' -f2)

#     # Calculate the closest 16:9 resolution
#     new_width=$(python3 -c "print(int($height * 16 / 9))")
#     new_height=$(python3 -c "print(int($width * 9 / 16))")

#     # Determine whether to use the new width or height based on the closest match
#     if [ "$new_width" -ge "$width" ]; then
#         final_width=$new_width
#         final_height=$height
#     else
#         final_width=$width
#         final_height=$new_height
#     fi

#     # Resize and crop the image to the calculated 16:9 resolution
#     cropped_img="cropped_$img"
#     magick "$img" -resize ${final_width}x${final_height}^ -gravity center -extent ${final_width}x${final_height} "$cropped_img"
#     echo "$cropped_img"
# }

# # Function to compress/tinify the image using Tinify API
# tinify_image() {
#     local img="$1"

#     # Use Python to interact with the Tinify API
#     python3 - <<EOF
# import tinify
# import os

# tinify.key = os.getenv("TINIFY_API_KEY")

# source = tinify.from_file("${img}")
# source.to_file("${img}")
# EOF
# }

# # Function to run both cropping and tinifying in one go
# optimize_image() {
#     local img="$1"
    
#     # First, crop the image
#     cropped_img=$(crop_image "$img")
    
#     # Then, tinify the cropped image
#     tinify_image "$cropped_img"
# }

# # Iterate over all images found by fd with specific extensions
# fd -e jpg -e jpeg -e svg -e png | while read img; do
#     # Optimize (crop + tinify)
#     optimize_image "$img"
# done

