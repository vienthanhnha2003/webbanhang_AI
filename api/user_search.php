<?php
require "db.php"; // file kết nối CSDL

$keyword = $_GET['keyword'] ?? "";

$sql = "
SELECT u.user_id, u.username, u.full_name, r.role_name, u.status
FROM users u
JOIN roles r ON u.role_id = r.role_id
WHERE u.username LIKE ?
   OR u.full_name LIKE ?
   OR r.role_name LIKE ?
ORDER BY u.user_id DESC
";

$stmt = $conn->prepare($sql);
$search = "%$keyword%";
$stmt->bind_param("sss", $search, $search, $search);
$stmt->execute();

$result = $stmt->get_result();
$data = [];

while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);
