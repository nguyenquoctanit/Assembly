import mysql.connector

# Thiết lập kết nối MySQL
mydb = mysql.connector.connect(
    host="192.168.40.94",
    port="3306",
    user="toan",
    password="9ksa@KRzH",
    database="vdm"
)

if mydb.is_connected():
    # Tạo đối tượng cursor
    cursor = mydb.cursor()

    # Truy vấn SQL để lấy tên bảng
    table_query = "SELECT table_name FROM information_schema.tables WHERE table_schema = %s"
    cursor.execute(table_query, (mydb.database,))

    # Lặp qua từng bảng và xuất thông tin mô tả
    for table in cursor:
        table_name = table[0]
        describe_query = f"DESCRIBE {table_name}"
        cursor.execute(describe_query)

        # In ra tên bảng
        print(f"Thông tin mô tả của bảng '{table_name}':")

        # Lấy tất cả các hàng kết quả từ truy vấn DESCRIBE
        describe_result = cursor.fetchall()

        # In ra các thông tin mô tả của các cột
        for column_info in describe_result:
            column_name = column_info[0]
            column_type = column_info[1]
            is_nullable = column_info[2]
            column_key = column_info[3]
            column_extra = column_info[4]
            print(f"- Tên cột: {column_name}")
            print(f"  Kiểu dữ liệu: {column_type}")
            print(f"  Có thể null: {is_nullable}")
            print(f"  Khóa chính: {column_key}")
            print(f"  Thông tin bổ sung: {column_extra}")
            print()

    # Đóng kết nối MySQL
    mydb.close()
