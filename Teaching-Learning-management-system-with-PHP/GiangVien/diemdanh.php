<?php
session_start();
if (isset($_SESSION['magiangvien']) && isset($_SESSION['tucach']) && isset($_GET['id_lophoc'])) {
    if ($_SESSION['tucach'] == 'GiangVien') {
        include "../controllers/includer.php";
        $magiangvien = $_SESSION['magiangvien'];
        $id_lophoc = $_GET['id_lophoc'];
        $giangvien = getGiangVienTheoId($magiangvien, $conn);
        $lophoc = getLopTheoId($id_lophoc, $conn);
        $truycap = gvKiemTraQuyenVaoLop($magiangvien, $id_lophoc, $conn);
        $ngay_diemdanh = date('Y-m-d');
        $usrname = "Giảng viên " . $giangvien['ho_tenlot'] . " " . $giangvien['ten'];
        $real_title = ($lophoc != 0) ? ($lophoc['tenkhoahoc'] . " - " . $lophoc['malophoc'] . " - Điểm danh") : "Điểm danh";
        // Lấy danh sách sinh viên trong lớp
        $sql = "SELECT sv.masinhvien, sv.ho_tenlot, sv.ten
                FROM lop_rec lr ,sinhvien sv WHERE lr.masinhvien = sv.masinhvien
                AND lr.id_lophoc = ?";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$id_lophoc]);
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Xử lý xem lại điểm danh theo ngày
        $ngay_xem = isset($_GET['ngay_xem']) ? $_GET['ngay_xem'] : $ngay_diemdanh;
        $sql_dd = "SELECT a.*,b.* FROM diemdanh a, sinhvien b WHERE a.masinhvien = b.masinhvien AND id_lophoc=? AND ngay=?";
        $stmt_dd = $conn->prepare($sql_dd);
        $stmt_dd->execute([$id_lophoc, $ngay_xem]);
        $ds_diemdanh = $stmt_dd->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php $title = $real_title; include "../header.php"; ?></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="icon" href="../imgs/logo1.png">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<?php include "comp/navbar.php"; ?>
<div class="container mt-5">

    <a class="btn btn-primary" href="<?php echo themBaiGiang($id_lophoc); ?>">Thêm bài giảng</a>
    <a class="btn btn-primary" href="<?php echo themBaiTap($id_lophoc); ?>">Thêm bài tập</a>
    <a class="btn btn-primary" href="<?php echo themBaiKT($id_lophoc); ?>">Thêm bài kiểm tra</a>
    <!-- <button class="btn btn-primary">Thêm bài tập</button>
    <button class="btn btn-primary">Thêm bài kiểm tra</button> -->
    <a class="btn btn-primary" href="<?php echo "./danhsachsv.php?lopid=$id_lophoc"; ?>">
        Xem danh sách sinh viên
    </a>
    <a class="btn btn-primary" href="<?php echo "./diemdanh.php?id_lophoc=$id_lophoc"; ?>">
        Điểm danh
    </a>
    <h1><?php echo $real_title; ?></h1>
    <?php if (isset($_GET['thanhcong']) && $_GET['thanhcong'] == 1): ?>
        <div class="alert alert-success">Điểm danh thành công!</div>
    <?php endif; ?>
    <?php if ($truycap != false) { ?>
        <form method="POST" action="luu_diemdanh.php">
            <input type="hidden" name="id_lophoc" value="<?php echo htmlspecialchars($id_lophoc); ?>">
            <div class="mb-3">
                <label for="ngay" class="form-label">Ngày điểm danh:</label>
                <input type="date" class="form-control" id="ngay" name="ngay" value="<?php echo $ngay_diemdanh; ?>">
            </div>
            <table class="table table-sm table-bordered mt-3 n-table table-hover">
                <thead>
                    <tr><th>Mã SV</th><th>Họ tên</th><th>Trạng thái</th><th>Ghi chú</th></tr>
                </thead>
                <tbody>
                <?php foreach ($result as $row): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($row['masinhvien']); ?></td>
                        <td><?php echo htmlspecialchars($row['ho_tenlot'] . ' ' . $row['ten']); ?></td>
                        <td>
                            <select name="trangthai[<?php echo htmlspecialchars($row['masinhvien']); ?>]" class="form-select">
                                <option value="co_mat">Có mặt</option>
                                <option value="vang">Vắng</option>
                                <option value="muon">Muộn</option>
                            </select>
                        </td>
                        <td><input type="text" class="form-control" name="ghichu[<?php echo htmlspecialchars($row['masinhvien']); ?>]" placeholder="Ghi chú"></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
            <button type="submit" class="btn btn-success fw-bold px-4 py-2">Điểm danh</button>
        </form>
        <hr/>
        <h4>Xem lại điểm danh theo ngày</h4>
        <form method="get" class="row g-3 mb-3">
            <input type="hidden" name="id_lophoc" value="<?php echo htmlspecialchars($id_lophoc); ?>">
            <div class="col-auto">
                <input type="date" name="ngay_xem" class="form-control" value="<?php echo htmlspecialchars($ngay_xem); ?>">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary">Xem điểm danh</button>
            </div>
            <div class="col-auto">
                <a href="xuat_diemdanh_excel.php?id_lophoc=<?php echo $id_lophoc; ?>&ngay=<?php echo $ngay_xem; ?>" class="btn btn-success">Xuất Excel</a>
            </div>
        </form>
        <table class="table table-bordered">
            <thead>
                <tr><th>Mã SV</th><th>Họ tên</th><th>Trạng thái</th><th>Ghi chú</th></tr>
            </thead>
            <tbody>
            <?php foreach ($ds_diemdanh as $row): 
                $tt_hienthi = '';
                if ($row['trangthai'] === 'co_mat') $tt_hienthi = 'Có mặt';
                else if ($row['trangthai'] === 'vang') $tt_hienthi = 'Vắng';
                else if ($row['trangthai'] === 'muon') $tt_hienthi = 'Muộn';
            ?>
                <tr>
                    <td><?php echo htmlspecialchars($row['masinhvien']); ?></td>
                    <td><?php echo htmlspecialchars($row['ho_tenlot'] . ' ' . $row['ten']); ?></td>
                    <td><?php echo htmlspecialchars($tt_hienthi); ?></td>
                    <td><?php echo htmlspecialchars($row['ghichu']); ?></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    <?php } else { ?>
        <div class="alert alert-info" role="alert">
            Bạn không có quyền truy cập vào lớp này hoặc lớp không tồn tại.
        </div>
    <?php } ?>
</div>
<footer class="bg-dark py-3 mt-5">
    <?php include "../footer.php"; ?>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<?php
    } 
} 
/*
Mục đích: Thêm thông báo thành công, chức năng xem lại điểm danh theo ngày, xuất Excel.
Lý do: Giúp giảng viên kiểm tra lại và xuất dữ liệu dễ dàng.
*/ 