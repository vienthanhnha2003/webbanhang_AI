<?php
require "db.php";

$username = $_POST['username'] ?? '';
$password = $_POST['password'] ?? '';
$fullname = $_POST['fullname'] ?? '';
$role_id  = $_POST['role_id'] ?? 2;
$status   = $_POST['status'] ?? 1;

if ($username == '' || $password == '') {
    http_response_code(400);
    echo json_encode(["error" => "Thiếu dữ liệu"]);
    exit;
}

$hash = password_hash($password, PASSWORD_DEFAULT);

$sql = "INSERT INTO users(username,password,full_name,role_id,status)
        VALUES (?,?,?,?,?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param("sssii", $username, $hash, $fullname, $role_id, $status);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    http_response_code(500);
    echo json_encode(["error" => "Không thể thêm user"]);
}
