import pyodbc
import mysql.connector

# Kết nối đến SQL Server
sql_server_connection_string = 'DRIVER={SQL Server};SERVER=VDM-INTRAMARTDA;DATABASE=vdm;UID=toan;PWD=Mabuchi0707'
sql_server_connection = pyodbc.connect(sql_server_connection_string)
sql_server_cursor = sql_server_connection.cursor()

# Kết nối đến MySQL
mysql_connection = mysql.connector.connect(
    host='192.168.40.94',
    database='vdm',
    user='toan',
    password='9ksa@KRzH'
)
mysql_cursor = mysql_connection.cursor()

# Truy vấn dữ liệu từ bảng trong SQL Server
sql_server_cursor.execute("SELECT * FROM V_HR_IN_OUT WHERE ChucVu=117")
rows = sql_server_cursor.fetchall()

# Chèn dữ liệu vào bảng của MySQL
mysql_insert_query = "INSERT INTO TEST (Ma_NV, Ten, Ho_Lot, ChucVu, PhongBan, TinhTrang, ID_HoSo_NhanSu, PhongBanTyLeDiLam, LoaiNhanVien, ID_ChiTiet_VaoRa, ThoiGian, VaoRa, TacNhan_Cham, ChuThich, KhongHopLe, ID_Device) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

for row in rows:
    mysql_cursor.execute(mysql_insert_query, (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12], row[13], row[14], row[15]))
    mysql_connection.commit()
# Lưu các thay đổi và đóng kết nối
mysql_connection.close()
sql_server_connection.close()
