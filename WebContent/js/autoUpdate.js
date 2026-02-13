// Auto update water usage every 5 seconds

function loadUsageData() {

    fetch('usage')   // URL pattern from WaterUsageServlet
    .then(response => {
        if (!response.ok) {
            throw new Error("Network response was not ok");
        }
        return response.text();
    })
    .then(data => {
        document.getElementById("liveData").innerHTML = data;
    })
    .catch(error => {
        console.error("Error fetching usage data:", error);
        document.getElementById("liveData").innerHTML =
            "Unable to load data. Please try again later.";
    });
}

// Run when page loads
window.onload = function() {
    loadUsageData();
    setInterval(loadUsageData, 5000); // refresh every 5 seconds
};
