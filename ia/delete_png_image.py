import os
from PIL import Image

folder_path = '../ia/data_clean/data_dividir/'


image_paths = []
large_image_path = []

for root, dirs, files in os.walk(folder_path):
    for file in files:
        image_path = os.path.join(root, file)

        try:
            img = Image.open(image_path)
        except:
            large_image_path.append(image_path)

        if file.lower().endswith('.png'):
            image_paths.append(image_path)

print(image_paths)
print(large_image_path)

for each in image_paths:
    os.remove(each)
for each in large_image_path:
    os.remove(each)
