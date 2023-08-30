from glob import glob                                                           
import shutil, os, cv2
from TOAN import Test
 
TM = Test.getPath1()
os.makedirs(TM + '/TEMP',exist_ok=True)
img = glob(TM +'*.jpg')
cnt=0
for i in img:
    tenf  = os.path.basename(i)
    image = cv2.imread(i, 1)
    # ROI = image[0:1200, 310:1345]
    ROI = image[250:1000, 0:1600]
    cv2.imwrite(TM + 'TEMP/' + tenf, ROI)



    
#     out = open(TM + 'TEMP/' + tenf[:-3]+'txt','w')
#     with open(i[:-3]+'txt', 'r') as f:
#         while True:
#             line = f.readline()
#             if not line:
#                 break
#             tmp = line.split()
#             x = round(float(tmp[1])*1600/1035 - 310/1035,6)
#             w = round(float(tmp[3])*1600/1035,6)
#             # y = round(float(tmp[2])*1200/750- 250/750,6)
#             # h = round(float(tmp[4])*1200/750,6)
#             # out.writelines(tmp[0] + ' ' + tmp[1] + ' ' + str(y) + ' ' + tmp[3] + ' ' + str(h) + '\n') 
#             out.writelines(tmp[0] + ' ' + str(x) + ' ' + tmp[2] + ' ' + str(w)+ ' ' + tmp[4] + '\n') 

#     f.close()
#     out.close()
#     os.replace(TM + 'TEMP/' + tenf, i)
#     os.replace(TM + 'TEMP/' + tenf[:-3]+'txt',i[:-3]+'txt')
#     cnt += 1
#     print(cnt)
# shutil.rmtree(TM + 'TEMP/' )
# print('Completed!')

