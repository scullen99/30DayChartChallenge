import os
import json
from pathlib import Path

# Base directory where you want to create the folders
base_dir = Path.cwd()

# Range of days for folder creation
start_day = 1
end_day = 30

# Template for an empty Jupyter notebook
notebook_template = {
    "cells": [
        {
            "cell_type": "markdown",
            "metadata": {},
            "source": [
                "# Notebook for Day X"
            ]
        }
    ],
    "metadata": {
        "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
        },
        "language_info": {
            "codemirror_mode": {
                "name": "ipython",
                "version": 3
            },
            "file_extension": ".py",
            "mimetype": "text/x-python",
            "name": "python",
            "nbconvert_exporter": "python",
            "pygments_lexer": "ipython3",
            "version": "3.x"
        }
    },
    "nbformat": 4,
    "nbformat_minor": 2
}

for day in range(start_day, end_day + 1):
    folder_name = f"{day}_Day_Chart"
    folder_path = base_dir / folder_name
    
    # Create the folder if it doesn't exist
    folder_path.mkdir(parents=True, exist_ok=True)
    
    # Create the .txt file inside the corresponding folder
    txt_file_path = folder_path / f"{folder_name}.txt"
    with open(txt_file_path, 'w') as txt_file:
        txt_file.write(f"Contents of {folder_name}")
    
    # Create the Jupyter notebook file inside the corresponding folder
    notebook_name = f"SergioEstebanTarreroDay{day}.ipynb"
    notebook_path = folder_path / notebook_name
    with open(notebook_path, 'w', encoding='utf-8') as notebook_file:
        json.dump(notebook_template, notebook_file, ensure_ascii=False, indent=4)

print("Folders, files, and notebooks created successfully.")
