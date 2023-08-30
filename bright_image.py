# import cv2
# import numpy as np
# import glob

# def brighten_dark_region(image, threshold=50, factor=1.5):
#     gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
#     dark_mask = gray_image < threshold
#     brightened_image = image.copy()
#     brightened_image[dark_mask] = np.clip(image[dark_mask] * factor, 0, 255)
#     return brightened_image

# # Đường dẫn thư mục chứa các tệp ảnh
# image_folder = 'D:/image/2308/'

# # Sử dụng glob để lấy danh sách đường dẫn tới các tệp ảnh trong thư mục
# image_files = glob.glob(image_folder + '*.jpg')  # Có thể thay '*.jpg' bằng đuôi tệp ảnh khác

# for file_name in image_files:
#     input_image = cv2.imread(file_name)
#     if input_image is None:
#         print(f"Could not read {file_name}")
#         continue
    
#     brightened_image = brighten_dark_region(input_image)
    
#     cv2.imshow('Original Image', input_image)
#     cv2.imshow('Brightened Image', brightened_image)
    
#     key = cv2.waitKey(0)
#     if key == 27:  # Nhấn phím Esc để thoát
#         break

# cv2.destroyAllWindows()


import cv2
import numpy as np
import glob

def brighten_dark_regions(image, strength=0.5):
    # Chuyển đổi ảnh sang không gian màu dạng float để tránh quá tràn giá trị
    float_image = image.astype(np.float32) / 255.0
    
    # Áp dụng phép toán log để làm sáng vùng tối
    brightened_image = cv2.pow(float_image, strength)
    
    # Chuyển đổi trở lại về miền [0, 255]
    brightened_image = np.clip(brightened_image * 255, 0, 255).astype(np.uint8)
    
    return brightened_image

# Đường dẫn thư mục chứa các tệp ảnh
# image_folder = 'path/to/your/image/folder/'
image_folder = 'D:/NQCOMI_RS656_A18/FULL/SANG/C1/'
# Sử dụng glob để lấy danh sách đường dẫn tới các tệp ảnh trong thư mục
image_files = glob.glob(image_folder + '*.jpg')
import time
for file_name in image_files:
    input_image = cv2.imread(file_name)
    if input_image is None:
        print(f"Could not read {file_name}")
        continue
    # t1 = time.time()
    brightened_image = brighten_dark_regions(input_image)
    # print(time.time() - t1)
    # input_image = cv2.resize(input_image,(600,1000))
    # brightened_image = cv2.resize(brightened_image,(600,1000))
    cv2.imwrite(file_name, brightened_image)
    # cv2.imshow('Original Image', input_image)
    # cv2.imshow('Brightened Image', brightened_image)
    
    # key = cv2.waitKey(0)
    # if key == 27:  # Nhấn phím Esc để thoát
    #     break

cv2.destroyAllWindows()