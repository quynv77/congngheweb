<?php
// Bước 1: Nhận dữ liệu từ form
include '../DB_connection.php';
$id_lophoc = $_POST['id_lophoc'];
$ngay = $_POST['ngay'];
$trangthai = $_POST['trangthai']; // Mảng: masinhvien => trạng thái
$ghichu = $_POST['ghichu'];       // Mảng: masinhvien => ghi chú

// Bước 2: Xử lý dữ liệu
foreach ($trangthai as $masinhvien => $tt) {
    $note = $ghichu[$masinhvien];

    // Kiểm tra đã có điểm danh chưa
    $sql_check = "SELECT id_diemdanh FROM diemdanh WHERE id_lophoc=? AND masinhvien=? AND ngay=?";
    $stmt = $conn->prepare($sql_check);
    $stmt->execute([$id_lophoc, $masinhvien, $ngay]);
    $exists = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($exists) {
        // Đã có, cập nhật
        $sql_update = "UPDATE diemdanh SET trangthai=?, ghichu=? WHERE id_lophoc=? AND masinhvien=? AND ngay=?";
        $stmt_update = $conn->prepare($sql_update);
        $stmt_update->execute([$tt, $note, $id_lophoc, $masinhvien, $ngay]);
    } else {
        // Chưa có, thêm mới
        $sql_insert = "INSERT INTO diemdanh (id_lophoc, masinhvien, ngay, trangthai, ghichu) VALUES (?, ?, ?, ?, ?)";
        $stmt_insert = $conn->prepare($sql_insert);
        $stmt_insert->execute([$id_lophoc, $masinhvien, $ngay, $tt, $note]);
    }
}

// Bước 3: Xuất kết quả
// chuyển hướng về trang điểm danh và thông báo thành công
header("Location: diemdanh.php?id_lophoc=$id_lophoc&thanhcong=1");
exit;
/*
Mục đích: Lưu dữ liệu điểm danh vào database, đảm bảo không bị trùng dữ liệu.
Lý do: Nếu đã điểm danh ngày đó thì cập nhật, chưa có thì thêm mới.
*/ 