
document.addEventListener("DOMContentLoaded", function () {
    let xhr = new XMLHttpRequest();
    xhr.onload = function () {
        let h5Elem = document.getElementById('json-response')
        let nameElem = document.getElementById('json-name');
        let idElem = document.getElementById('json-userid');
        let data = JSON.parse(xhr.responseText);

        // Process our return data
        if (xhr.status >= 200 && xhr.status < 300) {
            // Runs when the request is successful

            nameElem.textContent = data.user_name;
            idElem.textContent = data.user_id;

        } else {
            h5Elem.innerHTML = "Received HTTP status " + xhr.status + " from the backend!";
            backend_message = document.createElement("p");
            backend_message.textContent = data.message;
            h5Elem.appendChild(backend_message)
        }

    };
    xhr.open('GET', '/data/json');
    xhr.send();
});