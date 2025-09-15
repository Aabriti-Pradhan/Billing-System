<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Customer</title>
    <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #F7F4EA;
                margin: 0;
                padding: 0;
            }

            .content {
                padding: 15px 180px;
                margin-top: -250px;
            }

            h1 {
                text-align: center;
                color: #2F3E2F;
                margin-bottom: 30px;
            }

            .add-product-form {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding-top: 250px;
            }

            .add-product-form input {
                width: 320px;
                padding: 14px;
                border-radius: 8px;
                border: 1px solid #ccc;
                font-size: 16px;
                outline: none;
                transition: 0.3s ease;
            }

            .add-product-form input:focus {
                border-color: #A8BBA3;
                box-shadow: 0 0 5px rgba(168,187,163,0.6);
            }

            .add-product-form button {
                background-color: #A8BBA3;
                color: #2F3E2F;
                font-weight: bold;
                border: none;
                padding: 14px 100px;
                border-radius: 10px;
                font-size: 16px;
                cursor: pointer;
                transition: 0.3s;
            }

            .add-product-form button:hover {
                background-color: #FFF0CE;
            }

            .back-link {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 18px;
                background-color: #A8BBA3;
                color: #2F3E2F;
                text-decoration: none;
                border-radius: 8px;
                font-weight: bold;
                transition: 0.3s;
            }

            .back-link:hover {
                background-color: #FFF0CE;
            }

            #liveToast {
                position: fixed !important;
                top: 20px !important;
                left: 20px !important;
                z-index: 3000 !important;
            }

        </style>
</head>
<body>

<div class="content">
    <form class="add-product-form" id="customerForm" action="/api/create" method="post" onsubmit="localStorage.setItem('StatusAdd', 'added');">
        <input type="hidden" name="id" id="customerId" />
        <input type="text" name="name" id="customerName" placeholder="Name" required /><br>
        <input type="email" name="email" id="customerEmail" placeholder="Email" required /><br>
        <input type="text" name="phone" id="customerPhone" placeholder="Phone" required /><br>
        <input type="text" name="address" id="customerAddress" placeholder="Address" required /><br>
        <button type="submit" id="formSubmitBtn">Save</button>
    </form>
</div>

<script>
    const form = document.getElementById("customerForm");
    const emailInput = document.getElementById("customerEmail");
    const phoneInput = document.getElementById("customerPhone");

    // Error messages
    const emailError = document.createElement("small");
    emailError.style.color = "red";
    emailError.style.display = "none";
    emailError.textContent = "Invalid email format";
    emailInput.parentNode.insertBefore(emailError, emailInput.nextSibling);

    const phoneError = document.createElement("small");
    phoneError.style.color = "red";
    phoneError.style.display = "none";
    phoneError.textContent = "Phone must be 10 digits";
    phoneInput.parentNode.insertBefore(phoneError, phoneInput.nextSibling);

    // Email validation
    emailInput.addEventListener("input", async () => {
        const email = emailInput.value.trim();
        if (!(email.includes("@") && email.endsWith(".com"))) {
            emailInput.style.border = "2px solid red";
            emailError.textContent = "Email must contain @ and .com";
            emailError.style.display = "block";
            return;
        }

        // Check in DB
        const response = await fetch('/api/customer/check-email?email=' + encodeURIComponent(email));
        const exists = await response.json();
        if (exists) {
            emailInput.style.border = "2px solid red";
            emailError.textContent = "Email already used";
            emailError.style.display = "block";
        } else {
            emailInput.style.border = "2px solid green";
            emailError.style.display = "none";
        }
    });

    // Phone validation
    phoneInput.addEventListener("input", async () => {
        const phone = phoneInput.value.trim();

        // Check format first
        if (!/^\d{10}$/.test(phone)) {
            phoneInput.style.border = "2px solid red";
            phoneError.textContent = "Phone must be 10 digits";
            phoneError.style.display = "block";
            return;
        }

        // Format is correct, hide error
        phoneInput.style.border = "2px solid green";
        phoneError.style.display = "none";

        // Check in DB
        const response = await fetch('/api/customer/check-phone?phone=' + encodeURIComponent(phone));
        const exists = await response.json();

        if (exists) {
            phoneInput.style.border = "2px solid red";
            phoneError.textContent = "Phone number already used";
            phoneError.style.display = "block";
        }
    });


    // Final form validation before submit
    form.addEventListener("submit", (e) => {
        if (emailError.style.display === "block" || phoneError.style.display === "block") {
            e.preventDefault();
            alert("Please fix the errors before submitting");
        }
    });
</script>


</body>
</html>
