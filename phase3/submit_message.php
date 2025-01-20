<?php
require_once 'firebase_config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userName = isset($_POST['userName']) ? trim($_POST['userName']) : '';
    $issueSubject = isset($_POST['issueSubject']) ? $_POST['issueSubject'] : '';
    $messageInput = isset($_POST['messageInput']) ? trim($_POST['messageInput']) : '';
    $timestamp = date('Y-m-d H:i:s'); // Format the timestamp

    if (!empty($userName) && !empty($messageInput)) {
        $nameBasedId = hash('sha256', $userName);

        // Check if the ID exists (no need to store names separately for this simplified version)

        $messagesRef = $database->getReference("messages/{$nameBasedId}");
        $messageData = [
            'name' => htmlspecialchars($userName), // Sanitize output
            'subject' => htmlspecialchars($issueSubject),
            'message' => htmlspecialchars($messageInput),
            'timestamp' => $timestamp
        ];

        $messagesRef->push($messageData);

        // Redirect back to the main page or a confirmation page
        header("Location: index.php");
        exit();
    } else {
        echo "Please fill in all required fields.";
    }
} else {
    // If accessed directly without submitting the form
    header("Location: index.php");
    exit();
}
?>