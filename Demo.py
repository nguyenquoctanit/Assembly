import mysql.connector

# Thiết lập kết nối
mydb = mysql.connector.connect(
  host="localhost",
  port = "3306"
  user="toan",
  password="9ksa@KRzH",
  database="vdm"
)

# Kiểm tra kết nối
if mydb.is_connected():
    print("Đã kết nối thành công đến MySQL Server!")

# Tạo đối tượng cursor
cursor = mydb.cursor()
while True:
    # Thực hiện truy vấn SELECT
    cursor.execute("SELECT * FROM bf_wo")

    # Lấy tất cả các dòng từ kết quả truy vấn
    rows = cursor.fetchall()

    # Kiểm tra nếu có dữ liệu trong bảng
    if rows:
        # In từng dòng dữ liệu
        for row in rows:
            print(row)
    else:
        print("Bảng bf_wo không có dữ liệu.")

# Đóng kết nối
mydb.close()
