<?php
require_once 'firebase_config.php';

if (isset($_GET['userName'])) {
    $userNameToView = trim($_GET['userName']);
    $nameBasedIdToView = hash('sha256', $userNameToView);

    $messagesRef = $database->getReference("messages/{$nameBasedIdToView}")->orderByChild('timestamp');
    $snapshot = $messagesRef->getSnapshot();

    if ($snapshot->exists()) {
        $messages = $snapshot->getValue();
        echo "<h2>Messages for " . htmlspecialchars($userNameToView) . ":</h2>";
        echo "<div id='messages'>";
        foreach ($messages as $messageKey => $message) {
            echo "<div class='message-item'>";
            echo "<p><strong>" . $message['name'] . "</strong> (" . $message['subject'] . ") - " . $message['timestamp'] . "</p>";
            echo "<p>" . $message['message'] . "</p>";

            // Load Replies
            $repliesRef = $database->getReference("messages/{$nameBasedIdToView}/{$messageKey}/replies")->orderByChild('timestamp');
            $repliesSnapshot = $repliesRef->getSnapshot();
            if ($repliesSnapshot->exists()) {
                echo "<div class='replies'>";
                foreach ($repliesSnapshot->getValue() as $reply) {
                    echo "<div class='reply " . htmlspecialchars($reply['sender']) . "'>";
                    echo "<p><strong>" . htmlspecialchars($reply['sender']) . ":</strong> " . htmlspecialchars($reply['text']) . " - " . $reply['timestamp'] . "</p>";
                    echo "</div>";
                }
                echo "</div>";
            }
            echo "</div>";
        }
        echo "</div>";
    } else {
        echo "<p>No messages found for " . htmlspecialchars($userNameToView) . ".</p>";
    }
} else {
    echo "<p>Please enter your name to view messages.</p>";
}
?>