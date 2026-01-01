<?php
// Bước 1: Nhập dữ liệu
include '../DB_connection.php';
$id_lophoc = $_GET['id_lophoc'];
$ngay = $_GET['ngay'];

// Lấy danh sách sinh viên và điểm danh
// $sql = "SELECT sv.masinhvien, sv.ho_tenlot, sv.ten, dd.trangthai, dd.ghichu
//         FROM lop_rec lr
//         JOIN sinhvien sv ON lr.masinhvien = sv.masinhvien
//         LEFT JOIN diemdanh dd ON dd.masinhvien = sv.masinhvien AND dd.id_lophoc = lr.id_lophoc AND dd.ngay = ?
//         WHERE lr.id_lophoc = ?";
$sql = "SELECT dd.*,sv.masinhvien,sv.ho_tenlot,sv.ten FROM diemdanh dd, sinhvien sv WHERE dd.masinhvien = sv.masinhvien
        AND dd.ngay = ?
        AND dd.id_lophoc = ?";
$stmt = $conn->prepare($sql);
$stmt->execute([$ngay, $id_lophoc]);
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Bước 2: Xuất file CSV (Excel đọc được)
header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename="diemdanh_lop_' . $id_lophoc . '_' . $ngay . '.csv"');
$output = fopen('php://output', 'w');
// Thêm BOM UTF-8 để Excel nhận đúng font tiếng Việt
fwrite($output, chr(0xEF) . chr(0xBB) . chr(0xBF));
fputcsv($output, ['Mã sinh viên', 'Họ tên', 'Trạng thái', 'Ghi chú']);
foreach ($data as $row) {
    $hoten = $row['ho_tenlot'] . ' ' . $row['ten'];
    // Chuyển trạng thái sang tiếng Việt
    $tt = $row['trangthai'];
    $tt_hienthi = '';
    if ($tt === 'co_mat') $tt_hienthi = 'Có mặt';
    else if ($tt === 'vang') $tt_hienthi = 'Vắng';
    else if ($tt === 'muon') $tt_hienthi = 'Muộn';
    fputcsv($output, [
        $row['masinhvien'],
        $hoten,
        $tt_hienthi,
        $row['ghichu']
    ]);
}
fclose($output);
// Bước 3: Kết thúc
exit;
/*
Mục đích: Xuất dữ liệu điểm danh ra file Excel (CSV) cho 1 lớp, 1 ngày.
Lý do: Giảng viên dễ dàng lưu trữ, in ấn, tổng hợp.
Tình huống đặc biệt: Nếu chưa có điểm danh sẽ xuất file trống trạng thái.
*/ 