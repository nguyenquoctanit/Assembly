import pyautogui
import PySimpleGUI as sg

def tim_va_click_vitri_hinh_giong(duong_dan_hinh_anh):
    # Tìm vị trí của hình giống trên màn hình
    vung_hinh_giong = pyautogui.locateOnScreen(duong_dan_hinh_anh, confidence=0.8)
    
    if vung_hinh_giong is not None:
        # Lấy tọa độ tâm của vị trí hình giống
        toa_do_tam = pyautogui.center(vung_hinh_giong)
        
        # Click chuột vào tọa độ tâm
        pyautogui.click(toa_do_tam.x, toa_do_tam.y-10)         
    else:
        pyautogui.keyDown('pagedown')
        print("Không tìm thấy hình giống trên màn hình.")
        pyautogui.keyUp('pagedown')

def getFile(noidung):
        fl = ''
        while fl=='':
            fl = sg.PopupGetFile(noidung, no_window=True, file_types=(("PNG Files","*.png"),("All Files","*.*")))
            if fl != '' and fl != None:
                fl = fl.replace('\\','/')
            elif fl =='':
                sg.popup_error('Bạn chưa chon file')
            else:
                sg.popup('Cancel')
        return fl
    
# Đường dẫn đến hình ảnh bạn muốn tìm
duong_dan_hinh_anh = getFile('Chon file hinh anh mau')

# Gọi hàm để tìm và click vào vị trí có hình giống
while True:
    tim_va_click_vitri_hinh_giong(duong_dan_hinh_anh)
