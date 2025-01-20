<?php
require_once 'firebase_config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nameBasedId = isset($_POST['nameBasedId']) ? $_POST['nameBasedId'] : '';
    $messageKey = isset($_POST['messageKey']) ? $_POST['messageKey'] : '';
    $replyText = isset($_POST['replyText']) ? trim($_POST['replyText']) : '';
    $timestamp = date('Y-m-d H:i:s');

    if (!empty($replyText) && !empty($nameBasedId) && !empty($messageKey)) {
        $repliesRef = $database->getReference("messages/{$nameBasedId}/{$messageKey}/replies");
        $replyData = [
            'text' => htmlspecialchars($replyText),
            'timestamp' => $timestamp,
            'sender' => 'admin'
        ];
        $repliesRef->push($replyData);

        // Redirect back to the admin panel
        header("Location: admin.php");
        exit();
    } else {
        echo "Error sending reply.";
    }
} else {
    // If accessed directly
    header("Location: admin.php");
    exit();
}
?>