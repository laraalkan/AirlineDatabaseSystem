<?php
// Include the database connection file
include "config.php";

// Check if the form has been submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the input values from the form
    $departure_airport = $_POST['departure_airport'];
    $arrival_airport = $_POST['arrival_airport'];
    $flight_date = $_POST['flight_date'];

    // Prepare the SQL statement to call the stored procedure
    $sql = "CALL SearchFlights(?, ?, ?)";

    // Prepare the statement using mysqli
    if ($stmt = mysqli_prepare($db, $sql)) {
        // Bind the input parameters to the statement
        mysqli_stmt_bind_param($stmt, "sss", $departure_airport, $arrival_airport, $flight_date);

        // Execute the stored procedure
        mysqli_stmt_execute($stmt);

        // Get the result of the query
        $result = mysqli_stmt_get_result($stmt);

        // Check if any flights are found
        if (mysqli_num_rows($result) > 0) {
            // Display the results in a table
            echo "<h3>Available Flights:</h3>";
            echo "<table border='1'>
                    <tr>
                        <th>Flight ID</th>
                        <th>Flight Date</th>
                        <th>Gate</th>
                        <th>Departure Airport</th>
                        <th>Arrival Airport</th>
                        <th>Duration</th>
                    </tr>";

            // Loop through the results and display each flight
            while ($row = mysqli_fetch_assoc($result)) {
                echo "<tr>
                        <td>" . $row['f_id'] . "</td>
                        <td>" . $row['flight_date'] . "</td>
                        <td>" . $row['gate_no'] . "</td>
                        <td>" . $row['departure_airport'] . "</td>
                        <td>" . $row['arrival_airport'] . "</td>
                        <td>" . $row['duration'] . "</td>
                    </tr>";
            }
            echo "</table>";
        } else {
            echo "<p>No flights found for the selected criteria.</p>";
        }

        // Close the statement and connection
        mysqli_stmt_close($stmt);
        mysqli_close($db);
    } else {
        echo "<p>Error preparing the query: " . mysqli_error($db) . "</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Search</title>
</head>
<body>
    <h2>Search Flights</h2>
    <form method="POST" action="search_flights.php">
        <label for="departure_airport">Departure Airport:</label>
        <input type="text" id="departure_airport" name="departure_airport" required>
        <br><br>
        
        <label for="arrival_airport">Arrival Airport:</label>
        <input type="text" id="arrival_airport" name="arrival_airport" required>
        <br><br>
        
        <label for="flight_date">Flight Date:</label>
        <input type="date" id="flight_date" name="flight_date" required>
        <br><br>
        
        <button type="submit">Search Flights</button>
    </form>
</body>
</html>
