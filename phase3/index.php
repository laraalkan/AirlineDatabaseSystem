<!DOCTYPE html>
<html>
<head>
    <title>Real-Time Support (PHP Version)</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Support Page</h1>
    <form method="post" action="submit_message.php">
        <div class="input-area">
            <label for="userName">Your Name:</label>
            <input type="text" id="userName" name="userName" placeholder="Your Name" required>
        </div>

        <div class="input-area">
            <label for="issueSubject">Subject:</label>
            <select id="issueSubject" name="issueSubject">
                <option value="Defected Product">Defected Product</option>
                <option value="Late Order">Late Order</option>
                <option value="Lost Product">Lost Product</option>
                <option value="Suggestion">Suggestion</option>
            </select>
        </div>

        <div class="input-area">
            <label for="messageInput">Your Message:</label>
            <textarea id="messageInput" name="messageInput" placeholder="Enter your message" required></textarea>
        </div>

        <button type="submit">Send Message</button>
    </form>

    <form method="get" action="view_messages.php">
        <input type="hidden" name="action" value="view">
        <label for="viewName">Enter Your Name to View Messages:</label>
        <input type="text" id="viewName" name="userName" placeholder="Your Name" required>
        <button type="submit">View Your Messages</button>
    </form>

    <h2>Your Messages:</h2>
    <div id="messages">
        <?php
            // Messages will be displayed here by view_messages.php if accessed directly
            if (isset($_GET['action']) && $_GET['action'] == 'view' && isset($_GET['userName'])) {
                require_once 'view_messages.php';
            }
        ?>
    </div>
</body>
</html>