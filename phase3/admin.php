<!DOCTYPE html>
<html>
<head>
    <title>Admin Support (PHP Version)</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Admin Support Panel</h1>
    <div id="allMessages">
        <?php
            require_once 'admin_get_messages.php';
        ?>
    </div>
</body>
</html>