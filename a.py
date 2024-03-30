import os
from pathlib import Path

# Base directory where you want to create the folders
base_dir = Path.cwd()

# Range of days for folder creation
start_day = 1
end_day = 30

for day in range(start_day, end_day + 1):
    folder_name = f"Day_{day}"
    folder_path = base_dir / folder_name
    
    # Create the folder if it doesn't exist
    folder_path.mkdir(parents=True, exist_ok=True)
    
    # Create the .txt file inside the corresponding folder
    file_path = folder_path / f"{folder_name}.txt"
    with open(file_path, 'w') as file:
        file.write(f"Contents of {folder_name}")

print("Folders and files created successfully.")
