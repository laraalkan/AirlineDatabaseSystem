<?php
require_once 'firebase_config.php';

$messagesRef = $database->getReference('messages');
$snapshot = $messagesRef->getSnapshot();

if ($snapshot->exists()) {
    $allUserMessages = $snapshot->getValue();
    foreach ($allUserMessages as $nameBasedId => $userMessages) {
        foreach ($userMessages as $messageKey => $message) {
            echo "<div class='message admin-view'>";
            echo "<p><strong>" . htmlspecialchars($message['name']) . "</strong> (" . htmlspecialchars($message['subject']) . ") - " . $message['timestamp'] . "</p>";
            echo "<p>" . htmlspecialchars($message['message']) . "</p>";

            // Reply Form
            echo "<form method='post' action='admin_send_reply.php'>";
            echo "<textarea name='replyText' placeholder='Reply to this message' required></textarea>";
            echo "<input type='hidden' name='nameBasedId' value='" . $nameBasedId . "'>";
            echo "<input type='hidden' name='messageKey' value='" . $messageKey . "'>";
            echo "<button type='submit'>Send Reply</button>";
            echo "</form>";

            // Load Replies
            $repliesRef = $database->getReference("messages/{$nameBasedId}/{$messageKey}/replies")->orderByChild('timestamp');
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
    }
} else {
    echo "<p>No messages to display.</p>";
}
?>