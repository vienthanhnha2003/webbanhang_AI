<?php
require "db.php";

$user_id = $_POST['user_id'] ?? 0;
$fullname = $_POST['fullname'] ?? '';
$role_id  = $_POST['role_id'] ?? 2;
$status   = $_POST['status'] ?? 1;

if ($user_id == 0) {
    http_response_code(400);
    echo json_encode(["error" => "Thiếu user_id"]);
    exit;
}

$sql = "UPDATE users 
        SET full_name=?, role_id=?, status=? 
        WHERE user_id=?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("siii", $fullname, $role_id, $status, $user_id);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    http_response_code(500);
    echo json_encode(["error" => "Không thể cập nhật"]);
}
