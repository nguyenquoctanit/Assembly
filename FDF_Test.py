import os
import PySimpleGUI as sg
from pdfrw import PdfReader, PdfWriter

def extract_single_page_from_fdf(input_fdf_path, page_number):
    fdf_file = open(input_fdf_path, 'rb')
    pdf_writer = PdfWriter()
    fdf_reader = PdfReader(fdf_file)
    
    if page_number >= 1 and page_number <= len(fdf_reader.pages):
        page = fdf_reader.pages[page_number - 1]
        pdf_writer.add_page(page)
        
        input_directory = os.path.dirname(input_fdf_path)
        input_file_name = os.path.basename(input_fdf_path)
        output_file_name = "new_" + input_file_name
        output_fdf_path = os.path.join(input_directory, output_file_name)

        with open(output_fdf_path, 'wb') as output_fdf_file:
            pdf_writer.write(output_fdf_file)
        
        print("Đã xuất ra tệp FDF mới với trang số", page_number, "tại", output_fdf_path)
    else:
        print("Số trang không hợp lệ.")
    
    fdf_file.close()
    

def getFile(noidung):
    fl = ''
    while fl=='':
        fl = sg.PopupGetFile(noidung, no_window=True, file_types=(("FDF Files","*.fdf"),("All Files","*.*")))
        if fl != '' and fl != None:
            fl = fl.replace('\\','/')
        elif fl =='':
            sg.popup_error('Bạn chưa chon file')
        else:
            sg.popup('Cancel')
    return fl

# Sử dụng hàm để chuyển đổi
input_fdf_path = getFile('duong_dan_den_file_goc_fdf')
page_number = sg.PopupGetText("Nhập số trang:")
if page_number:
    page_number = int(page_number)

extract_single_page_from_fdf(input_fdf_path, page_number)
