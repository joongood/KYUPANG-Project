
function toggleSalebox() {
    var salecheck = document.getElementById("salecheck");
    var div = document.getElementById("salebox");

    if (salecheck.checked) {
    	div.style.display = "block";
    } else {
    	div.style.display = "none";
    }
}