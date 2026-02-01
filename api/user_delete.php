<?php
require "db.php";

$user_id = $_POST['user_id'] ?? 0;

if ($user_id == 0) {
    http_response_code(400);
    echo json_encode(["error" => "Thiếu user_id"]);
    exit;
}

$sql = "DELETE FROM users WHERE user_id=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    http_response_code(500);
    echo json_encode(["error" => "Không thể xóa"]);
}
