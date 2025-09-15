<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Add Invoice</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background:#F7F4EA; margin:0; padding:0; }

        form { display:flex; flex-direction:column; gap:15px; max-width:1000px; }

        input[type=text], input[type=number] {
            width:100%; padding:10px; border-radius:6px; border:1px solid #ccc;
        }
        label { font-weight:bold; margin-top:10px; }

        .row { display:flex; gap:10px; margin-bottom:5px; position:relative; }
        .row input[type=text] { flex:2; }
        .row input[type=number] { flex:1; }

        .add-row-btn, button[type=submit] {
            background-color: #A8BBA3; color:#2F3E2F; border:none; padding:10px 15px; border-radius:6px; cursor:pointer;
            width: fit-content;
        }
        .add-row-btn:hover, button[type=submit]:hover { background-color:#FFF0CE; }

        /* CUSTOMER SEARCH */
        .search-box {
            position: relative; /* needed for absolute positioning of result-box */
        }

        .result-box {
            position: absolute;  /* hover over other elements */
            top: 100%;           /* directly below input */
            left: 0;
            right: 0;
            background: #fff;
            border: 1px solid #ccc;
            max-height: 200px;
            overflow-y: auto;
            z-index: 1000;
            display: none;       /* hide by default */
            border-radius: 4px;
        }

        .result-box ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .result-box li {
            padding: 8px 10px;
            cursor: pointer;
            border-bottom: 1px solid #eee;
        }

        .result-box li:hover {
            background: #e9f3ff;
        }

        /* PRODUCT SEARCH */
        .prod-search-box {
            position: relative; /* parent for absolute prod-result-box */
            margin-bottom: 10px;
        }

        .prod-result-box {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: #fff;
            border: 1px solid #ccc;
            max-height: 200px;
            overflow-y: auto;
            z-index: 1000;
            display: none;
            border-radius: 4px;
        }

        .prod-result-box ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .prod-result-box li {
            padding: 8px 10px;
            cursor: pointer;
            border-bottom: 1px solid #eee;
        }

        .prod-result-box li:hover {
            background: #e9f3ff;
        }

        .prod-service{
            display: flex;
            gap: 200px;
        }

        .second-prod-service{
            display:flex;
            flex-direction:column;
            gap:15px;
        }

        /* SERVICE SEARCH */
        .serv-search-box {
            position: relative; /* parent for absolute prod-result-box */
            margin-bottom: 10px;
        }

        .serv-result-box {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: #fff;
            border: 1px solid #ccc;
            max-height: 200px;
            overflow-y: auto;
            z-index: 1000;
            display: none;
            border-radius: 4px;
        }

        .serv-result-box ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .serv-result-box li {
            padding: 8px 10px;
            cursor: pointer;
            border-bottom: 1px solid #eee;
        }

        .serv-result-box li:hover {
            background: #e9f3ff;
        }

        .serv-service{
            display: flex;
            gap: 200px;
        }

        .second-serv-service{
            display:flex;
            flex-direction:column;
            gap:15px;
        }

        .serv-row {
            display: flex;
            gap: 10px;
            margin-bottom: 5px;
            position: relative;
        }

        .serv-row input[type=text] { flex:2; }
        .serv-row input[type=number] { flex:1; }


    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<form action="/api/createIForm" method="post">
    <!-- Customer Search -->
    <label>Customer:</label>
    <div class="search-box">
        <div class="row">
            <input type="text" id="input-box" placeholder="search customers" autocomplete="off">
            <input type="hidden" name="customerId" id="customerId">
        </div>
        <div class="result-box"></div>
    </div>


    <!-- Products -->
    <div class="prod-service">
        <div class="second-prod-service">
            <label>Products and Quantities:</label>
            <div class="prod-search-box-container">
                <div class="prod-search-box">
                        <div class="row">
                            <input type="text" class="prod-input-box" placeholder="search products" autocomplete="off">
                            <input type="hidden" name="productId" id="productId1">
                            <input type="number" name="quantity" placeholder="Quantity" min="1">
                        </div>
                        <div class="prod-result-box">
                        </div>
                </div>
            </div>
            <button type="button" id = "addButton" class="add-row-btn">+ Add Product</button>

            <!-- Discount -->
            <label>Discount(%):</label>
            <input type="number" name="discount" step="0.01">
        </div>

        <!--service-->

        <div class="second-prod-service">
            <label>Services:</label>
            <div class="serv-search-box-container">
                <div class="serv-search-box">
                        <div class="serv-row">
                            <input type="text" class="serv-input-box" placeholder="service name" autocomplete="off">
                            <input type="hidden" name="serviceId" id="serviceId1">
                            <input type="number" name="amount" placeholder="amount" min="1">
                        </div>
                        <div class="serv-result-box">
                        </div>
                </div>
            </div>
            <button type="button" id = "addButtonServ" class="add-row-btn">+ Add Service</button>

            <label>Vat(%):</label>
            <input type="number" name="vat">
        </div>
    </div>

    <div>
        <label>Is Percentage:</label>
        <input type="checkbox" name="isPercentage">
    </div>


    <button type="submit">Create Invoice</button>
</form>


<script>
    function initAddInvoiceJS() {


        //dynamic row

        const mainContainer = document.querySelector(".prod-search-box-container");

        const addButton = document.getElementById("addButton");

        let idNum = 2;

        addButton.addEventListener("click", ()=>{
            const ProductSearchWrapper = document.createElement("div");
            ProductSearchWrapper.classList.add("prod-search-box");

            const wrapper = document.createElement("div");
            wrapper.classList.add("row");

            const newInputProd = document.createElement("input");
            newInputProd.type = "text";
            newInputProd.placeholder = "new item"
            newInputProd.classList.add("prod-input-box")

            let idName = "productId";

            const newInputProdId = document.createElement("input");
            newInputProdId.type = "hidden";
            newInputProdId.id = `${idName}${idNum}`;
            idNum++;
            newInputProdId.name = "productId";

            const newInputQuantity = document.createElement("input");
            newInputQuantity.type = "number";
            newInputQuantity.placeholder = "new quantity"
            newInputQuantity.name = "quantity";

            wrapper.appendChild(newInputProd);
            wrapper.appendChild(newInputProdId);
            wrapper.appendChild(newInputQuantity);

            const wrapperOne = document.createElement("div");
            wrapperOne.classList.add("prod-result-box");

            ProductSearchWrapper.appendChild(wrapper);
            ProductSearchWrapper.appendChild(wrapperOne);

            mainContainer.appendChild(ProductSearchWrapper);

        })

            //dynamic row for service

            const mainContainerServ = document.querySelector(".serv-search-box-container");

            const addButtonServ = document.getElementById("addButtonServ");

            let idNumServ = 2;

            addButtonServ.addEventListener("click", ()=>{
                const ServiceSearchWrapper = document.createElement("div");
                ServiceSearchWrapper.classList.add("serv-search-box");

                const wrapperServ = document.createElement("div");
                wrapperServ.classList.add("serv-row");

                const newInputServ = document.createElement("input");
                newInputServ.type = "text";
                newInputServ.placeholder = "new service"
                newInputServ.classList.add("serv-input-box")

                let idNameServ = "serviceId";

                const newInputServId = document.createElement("input");
                newInputServId.type = "hidden";
                newInputServId.id = `${idNameServ}${idNumServ}`;
                idNumServ++;
                newInputServId.name = "serviceId";

                const newInputAmount = document.createElement("input");
                newInputAmount.type = "number";
                newInputAmount.placeholder = "new amount"
                newInputAmount.name = "amount";

                wrapperServ.appendChild(newInputServ);
                wrapperServ.appendChild(newInputServId);
                wrapperServ.appendChild(newInputAmount);

                const wrapperOneServ = document.createElement("div");
                wrapperOneServ.classList.add("serv-result-box");

                ServiceSearchWrapper.appendChild(wrapperServ);
                ServiceSearchWrapper.appendChild(wrapperOneServ);

                mainContainerServ.appendChild(ServiceSearchWrapper);

            })




        // CUSTOMER SEARCH

        const customers = [
            <c:forEach var="cust" items="${customers}" varStatus="status">
                {
                    id: "${cust.customerId}",
                    name: "${cust.name}",
                    email: "${cust.email}",
                    address: "${cust.address}"
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        const resultsBox = document.querySelector(".result-box");
        const inputBox = document.querySelector("#input-box");

        inputBox.onkeyup = function() {
            let input = inputBox.value;
            let result = [];

            if (input.length > 0) {
                result = customers.filter((cust) =>{
                    return cust.name.toLowerCase().includes(input.toLowerCase());
                });
                console.log(result);
            }
            display(result)
        };


        function display(result){
            resultsBox.innerHTML = ""; // clear old results
            if(result.length === 0){
                resultsBox.style.display = "none";
                return;
            }

            const ul = document.createElement("ul");

            result.forEach(cust => {
                const li = document.createElement("li");
                li.textContent = cust.name;

                li.addEventListener("click", () => {
                    inputBox.value = cust.name;
                    document.getElementById("customerId").value = cust.id;
                    resultsBox.innerHTML = "";
                    resultsBox.style.display = "none";
                });

                ul.appendChild(li);
            });

            resultsBox.appendChild(ul);
            resultsBox.style.display = "block";
        }



        // PRODUCT SEARCH

        const products = [
            <c:forEach var="prod" items="${products}" varStatus="status">
                {
                    id: "${prod.productId}",
                    name: "${prod.name}",
                    description: "${prod.description}",
                    price: "${prod.price}",
                    stockQuantity: "${prod.stockQuantity}"
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        const selectedProducts = [];

        const prodSearchBoxContainer = document.querySelector(".prod-search-box-container");
        prodSearchBoxContainer.addEventListener("keyup", e => {
            if(e.target.matches(".prod-input-box")){

                const prodInputBox = e.target;  // this is the actual input that triggered the event
                const wrapper = prodInputBox.closest(".prod-search-box"); // get the parent .prod-search-box
                const prodResultsBox = wrapper.querySelector(".prod-result-box"); // correct result box for that row

                let prodInput = prodInputBox.value;
                let prodResult = [];

                if (prodInput.length > 0) {
                    prodResult = products.filter((prod) =>{
                        return prod.name.toLowerCase().includes(prodInput.toLowerCase()) && !selectedProducts.includes(prod.name);
                    });
                    console.log(prodResult);
                }
                prodDisplay(prodResult, prodInputBox, prodResultsBox)
            }
        });

        function prodDisplay(prodResult, prodInputBox, prodResultsBox) {
            prodResultsBox.innerHTML = ""; // clear old results

            if (prodResult.length === 0) {
                prodResultsBox.style.display = "none";
                return;
            }

            const ul = document.createElement("ul");

            prodResult.forEach(prod => {
                const li = document.createElement("li");
                li.textContent = prod.name;

                li.addEventListener("click", () => {
                    prodSelectInput(li, prodInputBox, prodResultsBox);
                });

                ul.appendChild(li);
            });

            prodResultsBox.appendChild(ul);
            prodResultsBox.style.display = "block"; // show result box
        }

            let sendProdId = 1
            let sendProdName = "productId"

            function prodSelectInput(li, prodInputBox, prodResultsBox) {
            const productName = li.innerText;
            prodInputBox.value = productName;

            const productObj = products.find(p => p.name === productName);
            if (productObj) {
                // find the hidden input in the same row as the prodInputBox
                const hiddenInput = prodInputBox.closest(".row").querySelector("input[type='hidden']");
                hiddenInput.value = productObj.id;
            }

            prodResultsBox.innerHTML = "";
            prodResultsBox.style.display = "none"; // hide after selection

            if (!selectedProducts.includes(productName)) {
                selectedProducts.push(productName);
            }
        }

            // SERVICE SEARCH

            const services = [
                <c:forEach var="serv" items="${services}" varStatus="status">
                    {
                        serviceId: "${serv.serviceId}",
                        serviceName: "${serv.serviceName}",
                        serviceAmount: "${serv.amount}",
                        serviceBaseAmount: "${serv.baseAmount}",
                        serviceInvoiceItems: "${serv.serviceInvoiceItems}"
                    }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];

            const selectedServices = [];

            const servSearchBoxContainer = document.querySelector(".serv-search-box-container");
            servSearchBoxContainer.addEventListener("keyup", e => {
                if(e.target.matches(".serv-input-box")){

                    const servInputBox = e.target;  // this is the actual input that triggered the event
                    const servWrapper = servInputBox.closest(".serv-search-box"); // get the parent .prod-search-box
                    const servResultsBox = servWrapper.querySelector(".serv-result-box"); // correct result box for that row

                    let servInput = servInputBox.value;
                    let servResult = [];

                    if (servInput.length > 0) {
                        servResult = services.filter((serv) =>{
                            return serv.serviceName.toLowerCase().includes(servInput.toLowerCase()) && !selectedServices.includes(serv.serviceName);
                        });
                        console.log(servResult);
                    }
                    servDisplay(servResult, servInputBox, servResultsBox)
                }
            });

            function servDisplay(servResult, servInputBox, servResultsBox) {
                servResultsBox.innerHTML = ""; // clear old results

                if (servResult.length === 0) {
                    servResultsBox.style.display = "none";
                    return;
                }

                const ul = document.createElement("ul");

                servResult.forEach(serv => {
                    const li = document.createElement("li");
                    li.textContent = serv.serviceName;

                    li.addEventListener("click", () => {
                        servSelectInput(li, servInputBox, servResultsBox);
                    });

                    ul.appendChild(li);
                });

                servResultsBox.appendChild(ul);
                servResultsBox.style.display = "block"; // show result box
            }

            let sendServId = 1
            let sendServName = "serviceId"

            function servSelectInput(li, servInputBox, servResultsBox) {
                const serviceName = li.innerText;
                servInputBox.value = serviceName;

                const serviceObj = services.find(s => s.serviceName === serviceName);
                if (serviceObj) {
                    // find the hidden input in the same row as the servInputBox
                    const servHiddenInput = servInputBox.closest(".serv-row").querySelector("input[type='hidden']");
                    servHiddenInput.value = serviceObj.serviceId;
                }

                servResultsBox.innerHTML = "";
                servResultsBox.style.display = "none"; // hide after selection

                if (!selectedServices.includes(serviceName)) {
                    selectedServices.push(serviceName);
                }
            }
    }

 </script>

</body>
</html>
