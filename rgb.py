
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image, ImageDraw
import colorsys
import cv2
from PIL import Image, ImageDraw
import glob,os,shutil

# class ONCLICK:
#     def on_click(event):
#         image_path = "D:/share/test/TEST/1.jpg"
#         if event.xdata is not None and event.ydata is not None:
#             x = int(event.xdata)
#             y = int(event.ydata)
#             # rgb = (image[y, x] * 255).astype(int)

#             img = Image.open(image_path)
#             # Convert image to HSV color space
#             img2 = cv2.imread(image_path)
#             hsv_img = cv2.cvtColor(img2, cv2.COLOR_BGR2HSV)
#             h, s, v = hsv_img[y, x]

#             # img = Image.open(image_path).convert("RGBA")
#             r, g, b = img.getpixel((x, y))
#             # h, s, v = colorsys.rgb_to_hsv(r / 255.0, g / 255.0, b / 255.0)
#             # print(f"Selected point (x, y): ({x}, {y})")
#             print(f"RGB value: {r ,g ,b, h,s,v}")

#     image_path = "D:/share/test/TEST/1.jpg" # Thay thế bằng đường dẫn thực tế đến bức ảnh
#     image = plt.imread(image_path)

#     fig, ax = plt.subplots()
#     ax.imshow(image)
#     ax.set_title('Click a point to get RGB value')

#     cid = fig.canvas.mpl_connect('button_press_event', on_click)
#     plt.show()

def check_condition(r, g, b, h, s, v, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax):
    return (rmin <= r <= rmax and
            gmin <= g <= gmax and
            bmin <= b <= bmax and
            hmin <= h <= hmax and
            smin <= s <= smax and
            vmin <= v <= vmax)


class DRAW():



    def draw_points(image_path):
        xall = []
        yall = []
        l1 = 0
        l2 = 0
        l3 = 0
        l4 = 0 
        # Load the image
        img = Image.open(image_path)
        width, height = img.size

        # img = img[:,0:int(width/2)]
        img2 = cv2.imread(image_path)
        # img2 = img2[:,0:int(width/2)]
        hsv_img = cv2.cvtColor(img2, cv2.COLOR_BGR2HSV)

        
        # Create a new image to draw the points on
        draw = ImageDraw.Draw(img)


        rmax = 53 + 10
        rmin = 53 - 10 
        gmax = 53 + 10
        gmin = 53 - 10 
        bmax = 53 + 10 
        bmin = 53 - 10 
        hmax = 0
        hmin = 0
        smax = 0
        smin = 0
        vmax = 53 + 10
        vmin = 53 - 10

        # Loop through all pixels
        # for y in range(int(height/4),int(height/3)):
        #     for x in range(int(width/5),int(width/4)):
        for y in range(0,int(height/2)):
            for x in range(0,int(width/4)):
                r, g, b = img.getpixel((x, y))
                h, s, v = hsv_img[y, x]
                    
                r1, g1, b1 = img.getpixel((x+1, y))
                h1, s1, v1 = hsv_img[y, x+1]

                r2, g2, b2 = img.getpixel((x, y+1))
                h2, s2, v2 = hsv_img[y+1, x]

                r3, g3, b3 = img.getpixel((x+1, y+1))
                h3, s3, v3 = hsv_img[y+1, x+1] 

                r4, g4, b4 = img.getpixel((x+2, y))
                h4, s4, v4 = hsv_img[y, x+2]

                r5, g5, b5 = img.getpixel((x+2, y+1))
                h5, s5, v5 = hsv_img[y+1, x+2]


                if (check_condition(r, g, b, h, s, v, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r1, g1, b1, h1, s1, v1, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r2, g2, b2, h2, s2, v2, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r3, g3, b3, h3, s3, v3, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r4, g4, b4, h4, s4, v4, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r5, g5, b5, h5, s5, v5, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax)):
                    # Thực hiện hành động khi tất cả điều kiện đều đúng
                    # draw.point((x, y), fill=(255, 0, 0)) 
                    # return x-25,y
                    xall.append(x-20)
                    yall.append(y)
                    l1 = 1
                    break
            if l1 == 1:
                break
                


        for y in range(int(height-3), int(height/2), -1):
            for x in range(int(width-3), int(width* 3/4), -1):
                r, g, b = img.getpixel((x, y))
                h, s, v = hsv_img[y, x]
                    
                r1, g1, b1 = img.getpixel((x+1, y))
                h1, s1, v1 = hsv_img[y, x+1]

                r2, g2, b2 = img.getpixel((x, y+1))
                h2, s2, v2 = hsv_img[y+1, x]

                r3, g3, b3 = img.getpixel((x+1, y+1))
                h3, s3, v3 = hsv_img[y+1, x+1] 

                r4, g4, b4 = img.getpixel((x+2, y))
                h4, s4, v4 = hsv_img[y, x+2]

                r5, g5, b5 = img.getpixel((x+2, y+1))
                h5, s5, v5 = hsv_img[y+1, x+2]


                if (check_condition(r, g, b, h, s, v, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r1, g1, b1, h1, s1, v1, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r2, g2, b2, h2, s2, v2, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r3, g3, b3, h3, s3, v3, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r4, g4, b4, h4, s4, v4, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r5, g5, b5, h5, s5, v5, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax)):
                    # Thực hiện hành động khi tất cả điều kiện đều đúng
                    # draw.point((x, y), fill=(255, 0, 0)) 
                    # return x+20,y
                    xall.append(x+20)
                    yall.append(y)
                    l2 = 1
                    break
            if l2 == 1:
                break


        rmax = 75 + 20
        rmin = 75 - 20 
        gmax = 75 + 20
        gmin = 75 - 20 
        bmax = 75 + 20 
        bmin = 75 - 20 
        hmax = 0
        hmin = 0
        smax = 0
        smin = 0
        vmax = 75 + 20
        vmin = 75 - 20
        for y in range(int(height/4),int(height*1/3)):
            for x in range(int(width/4),int(width*1/3)):
                r, g, b = img.getpixel((x, y))
                h, s, v = hsv_img[y, x]
                    
                r1, g1, b1 = img.getpixel((x+1, y))
                h1, s1, v1 = hsv_img[y, x+1]

                r2, g2, b2 = img.getpixel((x, y+1))
                h2, s2, v2 = hsv_img[y+1, x]

                r3, g3, b3 = img.getpixel((x+1, y+1))
                h3, s3, v3 = hsv_img[y+1, x+1] 

                r4, g4, b4 = img.getpixel((x+2, y))
                h4, s4, v4 = hsv_img[y, x+2]

                r5, g5, b5 = img.getpixel((x+2, y+1))
                h5, s5, v5 = hsv_img[y+1, x+2]


                if (check_condition(r, g, b, h, s, v, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r1, g1, b1, h1, s1, v1, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r2, g2, b2, h2, s2, v2, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r3, g3, b3, h3, s3, v3, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r4, g4, b4, h4, s4, v4, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r5, g5, b5, h5, s5, v5, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax)):
                    # Thực hiện hành động khi tất cả điều kiện đều đúng
                    # draw.point((x, y), fill=(255, 0, 0)) 
                    # return x-5,y+20
                    xall.append(x-5)
                    yall.append(y+20)
                    l3 = 1
                    break
            if l3 == 1:
                break

        for y in range(int(height*3/4),int(height*2/3),-1):
            for x in range(int(width*3/4),int(width*2/3),-1):
                r, g, b = img.getpixel((x, y))
                h, s, v = hsv_img[y, x]
                    
                r1, g1, b1 = img.getpixel((x+1, y))
                h1, s1, v1 = hsv_img[y, x+1]

                r2, g2, b2 = img.getpixel((x, y+1))
                h2, s2, v2 = hsv_img[y+1, x]

                r3, g3, b3 = img.getpixel((x+1, y+1))
                h3, s3, v3 = hsv_img[y+1, x+1] 

                r4, g4, b4 = img.getpixel((x+2, y))
                h4, s4, v4 = hsv_img[y, x+2]

                r5, g5, b5 = img.getpixel((x+2, y+1))
                h5, s5, v5 = hsv_img[y+1, x+2]


                if (check_condition(r, g, b, h, s, v, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r1, g1, b1, h1, s1, v1, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r2, g2, b2, h2, s2, v2, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r3, g3, b3, h3, s3, v3, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r4, g4, b4, h4, s4, v4, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax) and
                    check_condition(r5, g5, b5, h5, s5, v5, rmin, rmax, gmin, gmax, bmin, bmax, hmin, hmax, smin, smax, vmin, vmax)):
                    # Thực hiện hành động khi tất cả điều kiện đều đúng
                    # draw.point((x, y), fill=(255, 0, 0)) 
                    # return x+5,y-20
                    xall.append(x+5)
                    yall.append(y-20)
                    l4 = 1
                    break
            if l4 == 1:
                break

        # img.show()
        return xall, yall


    def draw_points_0(image_path):
        img = Image.open(image_path)
        width, height = img.size
        img2 = cv2.imread(image_path)
        hsv_img = cv2.cvtColor(img2, cv2.COLOR_BGR2HSV)
        for y in range(int(height/4),int(height/3)):
            for x in range(int(width/5),int(width/4)):
                r, g, b = img.getpixel((x, y))
                h, s, v = hsv_img[y, x]
                
                r1, g1, b1 = img.getpixel((x+1, y))
                h1, s1, v1 = hsv_img[y, x+1]

                r2, g2, b2 = img.getpixel((x, y+1))
                h2, s2, v2 = hsv_img[y+1, x]
                    
                # chuan khong dc xoa
                if 125 - 5 <= r <= 135 +5  and 120 - 5 <= g <= 130 + 5 and 100 - 5 <= b <= 110 + 5  and 20 - 5 <= h <= 28 + 5 and 40 - 5 <= s <= 50 + 5 and 125 - 5  <= v <= 145 + 5:
                    if 125 - 5 <= r1 <= 135 +5  and 120 - 5 <= g1 <= 130 + 5 and 100 - 5 <= b1 <= 110 + 5  and 20 - 5 <= h1 <= 28 + 5 and 40 - 5 <= s1 <= 50 + 5 and 125 - 5  <= v1 <= 145 + 5:
                        if 125 - 5 <= r2 <= 135 +5  and 120 - 5 <= g2 <= 130 + 5 and 100 - 5 <= b2 <= 110 + 5  and 20 - 5 <= h2 <= 28 + 5 and 40 - 5 <= s2 <= 50 + 5 and 125 - 5  <= v2 <= 145 + 5:
                            return x-5,y-5
    def draw_points_1(image_path):
        img = Image.open(image_path)
        width, height = img.size
        img2 = cv2.imread(image_path)
        hsv_img = cv2.cvtColor(img2, cv2.COLOR_BGR2HSV)
        for y in range(int(height*1/3),int(height*2/3)):
            for x in range(int(width*0.5),int(width*2/3)):
                r, g, b = img.getpixel((x, y))
                h, s, v = hsv_img[y, x]
                    
                r1, g1, b1 = img.getpixel((x+1, y))
                h1, s1, v1 = hsv_img[y, x+1]

                r2, g2, b2 = img.getpixel((x, y+1))
                h2, s2, v2 = hsv_img[y+1, x]
                    
                # Check if RGB values are within the specified range
                if 250 <= r <= 255 and 250 <= g <= 255 and 250 <= b <= 255 and 0 <= h <= 30 and 0 <= s <= 2 and 250 <= v <= 255:
                    if 250 <= r1 <= 255 and 250 <= g1 <= 255 and 250 <= b1 <= 255 and 0 <= h1 <= 30 and 0 <= s1 <= 2 and 250 <= v1 <= 255:
                        if 250 <= r2 <= 255 and 250 <= g2 <= 255 and 250 <= b2 <= 255 and 0 <= h2 <= 30 and 0 <= s2 <= 2 and 250 <= v2 <= 255:
                            # draw.point((x, y), fill=(255, 0, 0)) 
                            return x,y
                        
    def draw_points_2(image_path):
        img = Image.open(image_path)
        width, height = img.size
        img2 = cv2.imread(image_path)
        hsv_img = cv2.cvtColor(img2, cv2.COLOR_BGR2HSV)
        for y in range(int(height*3/4),int(height-1)):
            for x in range(int(width*2/4),int(width*3/4)):
                r, g, b = img.getpixel((x, y))
                h, s, v = hsv_img[y, x]
                    
                r1, g1, b1 = img.getpixel((x+1, y))
                h1, s1, v1 = hsv_img[y, x+1]

                r2, g2, b2 = img.getpixel((x, y+1))
                h2, s2, v2 = hsv_img[y+1, x]
                    
                # Check if RGB values are within the specified range
                if 70 <= r <= 75 and 65 <= g <= 75 and 60 <= b <= 70 and 10 <= h <= 25 and 15 <= s <= 20 and 70 <= v <= 80:
                    if 70 <= r1 <= 75 and 65 <= g1 <= 75 and 60 <= b1 <= 70 and 10 <= h1 <= 25 and 15 <= s1 <= 20 and 70 <= v1 <= 80:
                        if 70 <= r2 <= 75 and 65 <= g2 <= 75 and 60 <= b2 <= 70 and 10 <= h2 <= 25 and 15 <= s2 <= 20 and 70 <= v2 <= 80:
                            # draw.point((x, y), fill=(255, 0, 0)) 
                            return x,y
                                              
    path = 'D:/A84/C5/TRAIN/TEXT/'
    images_path = path + '*.jpg'
    try :
        os.makedirs(path + 'TEMP', exist_ok=True)
    except :
        pass 
    out_dir = path + 'TEMP/'
    for image_path in glob.glob(images_path):
        img = Image.open(image_path)
        width, height = img.size
        draw = ImageDraw.Draw(img) 
        # try:   
            # x, y = draw_points_2(image_path)
        xall, yall = draw_points(image_path)
        index = 0
        out = open(image_path[:-3]+'txt','a')

        for x,y in zip(xall,yall):
            index +=1
            print(x/1600 ,y/1200)
            xo = x/1600
            yo = y/1200
    
            tenf = os.path.basename(image_path)
            # out = open(out_dir + tenf[:-3]+'txt','w')
            with open(image_path[:-3]+'txt', 'r') as f:
                # while True:
                #     line = f.readline()
                #     if not line:
                #         break
                #     out.writelines(line)
                try:
                    if index ==1:
                        we = 0.0675
                        he = 0.225
                        x1 = x/1600 + we/2
                        y1 = y/1200 + he/2  
                        out.writelines('5' + ' ' + str(float(x1))+ ' ' + str(y1)+ ' 0.0675 0.225\n')
                    if index ==2:
                        we = 0.0675
                        he = 0.225
                        x1 = x/1600 + we/2
                        y1 = y/1200 + he/2  
                        out.writelines('5' + ' ' + str(float(x1-0.0675))+ ' ' + str(y1-0.225)+ ' 0.0675 0.225\n')
                    if index ==3:
                        we = 0.17
                        he = 0.16
                        x1 = x/1600 + we/2
                        y1 = y/1200 + he/2  
                        out.writelines('6' + ' ' + str(float(x1))+ ' ' + str(y1)+ ' 0.17 0.16\n')
                    if index ==4:
                        we = 0.17
                        he = 0.16
                        x1 = x/1600 + we/2
                        y1 = y/1200 + he/2  
                        out.writelines('6' + ' ' + str(float(x1-0.17))+ ' ' + str(y1-0.16)+ ' 0.17 0.16\n')
                except:
                    pass
        out.close()
            # os.replace(out_dir + tenf, image_path) 
        #     txt_file = os.path.splitext(image_path)[0] + '.txt'
        #     with open(txt_file, 'w') as file:
        #         file.write('0' + ' ' + str(x1)+ ' ' + str(y1)+ ' 0.173750 0.149167/n')

        
    # shutil.rmtree(out_dir)
    print('compelted')

# ONCLICK()
DRAW()