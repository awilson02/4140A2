<?php
if (strpos($_SERVER['REQUEST_URI'], "displayTable.php") !== false) {
    header("Location: ../index.php");
    die();

}

function displayPo543($dataBase)
{
    $client = $_POST["cliendId"];
    echo "  <form id='submit' class='mt-5' method='post'> 
              <label id='clientLabel'> Client Id </label><input  value='$client' id='cliendId' class='textField' type='text' name='cliendId'><button id='ordersSubbmit' name='ViewOrders'>Search</button>
              </form>";
    $query = $dataBase->query(
        "Select * from pos543 WHERE clientId543 = '$client';  ");

    echo "<table id='results'>";
    echo "<tr> 
            <th>PONumber</th>
            <th>Date</th>
            <th>Status</th>
            <th>Client</th>
           </tr>";
    while($row = $query->fetch_row()) {
        echo "<tr> ";
        foreach($row as $x)
        {
            echo "<th> $x</th>";
        }
        echo "</tr> ";

    }

    echo "</table>";
}
function displayParts543($dataBase)
{

    $query = $dataBase->query(
        "Select * from parts543;  ");

    echo "<table id='results'>";
    echo "<tr> 
            <th>PartNumber</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
           </tr>";
    while($row = $query->fetch_row()) {
        echo "<tr> ";

        echo "<th> $row[0]</th>
                  <th> $row[1]</th>
                  <th> $row[2]</th>
                  <th> $row[4]</th>";

        echo "</tr> ";

    }

    echo "</table>";
}

function displayOrder543($dataBase)
{
    $poID = $_POST["PoID"];
    echo "  <form id='submit' class='mt-5' method='post'> 
     <label id='poLabel'> PoID </label><input id='PoID' class='textField' type='text' name='PoID' value='$poID'><button id='vosubmit' name='ViewOrder'>Search</button>
     </form>";
    $query = $dataBase->query(
        "Select * from lines543 WHERE poNo543 = '$poID';  ");

    echo "<table id='results'>";
    echo "<tr> 
            <th>partNumber</th>
            <th>LineNumber</th>
            <th>PONumber</th>
            <th>Price</th>
            <th>Quantity</th>
           </tr>";
    while($row = $query->fetch_row()) {
        echo "<tr> ";
        foreach($row as $x)
        {
            echo "<th> $x</th>";
        }
        echo "</tr> ";

    }

    echo "</table>";
}
?>