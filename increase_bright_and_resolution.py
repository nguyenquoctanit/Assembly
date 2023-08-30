import cv2
import numpy as np
from PIL import Image
import glob,os
import cv2
import numpy as np
import skimage.exposure,shutil
from TOAN import Test
dir_path = Test.getPath1()  + '*jpg'
save_path = Test.getPath2()
c = len(dir_path)
for path in glob.glob(dir_path):
    img = Image.open(path)
    img = cv2.imread(path)  
    out1 = skimage.exposure.rescale_intensity(img, in_range=(0,130), out_range=(0,255))
    name = os.path.basename(path)           
    cv2.imwrite(save_path + name ,out1)
    if os.path.exists(path[:-3] + 'txt'):
        shutil.copy(path[:-3] + 'txt', save_path)
    c-=1
    print(c)


# def get_brightness(img):
#     img_cv2 = cv2.imread(img)
#     gray_img = cv2.cvtColor(img_cv2, cv2.COLOR_BGR2GRAY)
#     brightness = cv2.mean(gray_img)[0]
#     return brightness
# img = '//d9140522/CHIA/X75/X73/DU_LIEU_LINE_73/DE_DEN/COMPOUND/TC/FILE_DATA/20230717/bc/2023-06-23_17-32-26-778004-1TC.jpg'

# print(get_brightness(img))