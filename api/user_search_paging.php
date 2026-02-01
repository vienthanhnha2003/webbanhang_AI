<?php
require_once "db.php";

$keyword = $_GET['keyword'] ?? "";
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$limit = 5; // số dòng mỗi trang
$offset = ($page - 1) * $limit;

$search = "%$keyword%";

/* =====================
   ĐẾM TỔNG DÒNG
===================== */
$countSql = "
SELECT COUNT(*) AS total
FROM users u
JOIN roles r ON u.role_id = r.role_id
WHERE u.username LIKE ?
   OR u.full_name LIKE ?
   OR r.role_name LIKE ?
";

$stmt = $conn->prepare($countSql);
$stmt->bind_param("sss", $search, $search, $search);
$stmt->execute();
$total = $stmt->get_result()->fetch_assoc()['total'];
$totalPages = ceil($total / $limit);

/* =====================
   LẤY DỮ LIỆU PHÂN TRANG
===================== */
$sql = "
SELECT u.user_id, u.username, u.full_name, r.role_name, u.status
FROM users u
JOIN roles r ON u.role_id = r.role_id
WHERE u.username LIKE ?
   OR u.full_name LIKE ?
   OR r.role_name LIKE ?
ORDER BY u.user_id DESC
LIMIT ? OFFSET ?
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("sssii", $search, $search, $search, $limit, $offset);
$stmt->execute();

$data = [];
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode([
    "data" => $data,
    "total" => $total,
    "page" => $page,
    "totalPages" => $totalPages
]);
