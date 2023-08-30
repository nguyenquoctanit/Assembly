import os
import PySimpleGUI as sg
from PIL import Image, ImageEnhance

# Hàm để chuyển đổi và lưu các tệp ảnh trong một thư mục
def transform_and_save_images(input_directory, output_directory, brightness_factor, contrast_factor, sharpness_factor):
    # Tạo thư mục đích (nếu chưa tồn tại)
    os.makedirs(output_directory, exist_ok=True)

    # Lặp qua tất cả các tệp ảnh trong thư mục đầu vào
    for filename in os.listdir(input_directory):
        if filename.lower().endswith((".jpg", ".jpeg", ".png")):
            input_image_path = os.path.join(input_directory, filename)

            # Đọc ảnh gốc
            image = Image.open(input_image_path)

            # Tạo phiên bản mới với tất cả ba đặc tính
            enhanced_image = ImageEnhance.Brightness(image).enhance(brightness_factor)
            enhanced_image = ImageEnhance.Contrast(enhanced_image).enhance(contrast_factor)
            enhanced_image = ImageEnhance.Sharpness(enhanced_image).enhance(sharpness_factor)

            # Lưu ảnh mới sau khi thay đổi
            output_image_path = os.path.join(output_directory, filename)
            enhanced_image.save(output_image_path)

# Layout cho giao diện
layout = [
    [sg.Text("Chọn thư mục chứa ảnh đầu vào:")],
    [sg.InputText(key="-INPUT_DIRECTORY-"), sg.FolderBrowse()],
    [sg.Text("Thư mục đích:")],
    [sg.InputText(key="-OUTPUT_DIRECTORY-"), sg.FolderBrowse()],
    [sg.Text("Ánh sáng"), sg.Slider(range=(0, 2), resolution=0.1, default_value=1, orientation="h", key="-BRIGHTNESS-")],
    [sg.Text("Tương phản"), sg.Slider(range=(0, 2), resolution=0.1, default_value=1, orientation="h", key="-CONTRAST-")],
    [sg.Text("Sắc nét"), sg.Slider(range=(0, 2), resolution=0.1, default_value=1, orientation="h", key="-SHARPNESS-")],
    [sg.Button("Chuyển đổi"), sg.Button("Thoát")]
]

# Tạo cửa sổ giao diện
window = sg.Window("Chuyển đổi ảnh", layout)

while True:
    event, values = window.read()
    if event in (sg.WIN_CLOSED, "Thoát"):
        break
    elif event == "Chuyển đổi":
        input_directory = values["-INPUT_DIRECTORY-"]
        output_directory = values["-OUTPUT_DIRECTORY-"]
        brightness_factor = values["-BRIGHTNESS-"]
        contrast_factor = values["-CONTRAST-"]
        sharpness_factor = values["-SHARPNESS-"]
        transform_and_save_images(input_directory, output_directory, brightness_factor, contrast_factor, sharpness_factor)
        sg.popup("Đã chuyển đổi và lưu các ảnh thành công!")

window.close()
