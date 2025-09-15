<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>All Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #F7F4EA;
            margin: 0;
            padding: 0;
        }

        .content {
            padding: 15px 180px;
            margin-top: -210px;
        }

        .head-space {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    gap: 15px;
                }

        h1 {
            text-align: center;
            color: #2F3E2F;
            margin-bottom: 30px;
        }

        table {
            width: 85%;
            margin: 0 auto 30px auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 14px;
            font-size: 15px;
        }

        th {
            background-color: #A8BBA3;
            color: #2F3E2F;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #EFF5D2;
        }

        tr:hover {
            background-color: #FFF0CE;
            transition: background 0.3s ease;
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

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            gap: 25px;
        }

        .add-button {
            display: flex;
            align-items: center;
            justify-content: center;
            color: #2F3E2F;
            font-weight: bold;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 36px;
            transition: 0.3s;
            text-decoration: none;
        }

        .add-button:hover {
            background-color: #FFF0CE;
        }

        .icon-btn {
            background: none;
            border: none;
            padding: 0;
            cursor: pointer;
        }

        .archive-btn{
            all: unset;
        }

        .actions {
            display: flex;
            direction: column;
            gap: 35px;
            padding-right: 0px;
            margin-right: 0px;
        }

        /* Toast animation */
        .toast .progress-bar {
            width: 100%;
            animation: shrink 3s linear forwards; /* triggers shrink animation */
        }

        @keyframes shrink {
            from { width: 100%; }
            to { width: 0%; }
        }

    </style>
</head>
<body>
<jsp:include page="home.jsp"/>

    <div class="content">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="header">
                <h1>Products List</h1>
                <button id="archiveBtn" class="btn btn-warning"><i class="bi bi-archive"></i> Archive Selected</button>
            </div>
            <div class="head-space">
                <!--sort by-->
                <!-- <button class="sort-btn" id="sort-btn"><i class="bi bi-filter-circle-fill fs-3"><small>Sort By</small></i></button> -->
                <!-- search bar -->
                <form action="${pageContext.request.contextPath}/api/product/search" method="get">
                    <div class="input-group mb-3">
                        <input type="text" name="keyword" class="form-control" placeholder="Search products..." value="${keyword}">
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>
                <!--add button-->
                <button type="button" data-bs-toggle="modal" class="btn btn-outline-secondary btn-lg" data-bs-target="#productModal" data-action="add" style="padding: 0 0; margin: 0;">
                    <i class="bi bi-plus" style="font-size: 3rem;"></i>
                </button>
                <!--archived icon-->
                <button type="button" id="toggleArchiveBtn" class="btn btn-outline-secondary">
                    <i class="bi bi-archive-fill fs-3"></i>
                </button>
            </div>
        </div>
        <table>
            <thead>
                <tr>
                    <th> </th>
                    <th>ID</th>
                    <th>
                        <div class="d-flex justify-content-between align-items-center">
                            Name
                            <form method="get" action="/api/readP" style="display:inline;">
                                <input type="hidden" name="sortField" value="name"/>
                                <input type="hidden" name="sortDir" value="asc"/>
                                <button type="button" class="btn btn-secondary btn-sm sort-button">
                                  <i class="bi bi-sort-up-alt"></i>
                                </button>
                            </form>
                        </div>
                    </th>
                    <th>Description</th>
                    <th>
                        <div class="d-flex justify-content-between align-items-center">
                            Price
                            <form method="get" action="/api/readP" style="display:inline;">
                                <input type="hidden" name="sortField" value="price"/>
                                <input type="hidden" name="sortDir" value="asc"/>
                                <button type="button" class="btn btn-secondary btn-sm sort-button">
                                  <i class="bi bi-sort-up-alt"></i>
                                </button>
                            </form>
                        </div>
                    </th>
                    <th>
                        <div class="d-flex justify-content-between align-items-center">
                            Stock Quantity
                            <form method="get" action="/api/readP" style="display:inline;">
                                <input type="hidden" name="sortField" value="stockQuantity"/>
                                <input type="hidden" name="sortDir" value="asc"/>
                                <button type="button" class="btn btn-secondary btn-sm sort-button">
                                  <i class="bi bi-sort-up-alt"></i>
                                </button>
                            </form>
                        </div>
                    </th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="prod" items="${products}" varStatus="status">
                    <tr>
                        <td><input type="checkbox" class="customer-checkbox" data-id="${prod.productId}"
                            <c:if test="${prod.archived}">disabled</c:if> />
                        </td>
                        <td>${status.index + 1}</td>
                        <td>${prod.name}</td>
                        <td>${prod.description}</td>
                        <td>${prod.price}</td>
                        <td>${prod.stockQuantity}</td>
                        <td class="actions">
                            <!-- update button-->
                            <button type="button"
                                    class="btn btn-link p-0"
                                    data-bs-toggle="modal"
                                    data-bs-target="#productModal"
                                    data-action="update"
                                    data-id="${prod.productId}"
                                    data-name="${prod.name}"
                                    data-description="${prod.description}"
                                    data-price="${prod.price}"
                                    data-stock="${prod.stockQuantity}">
                                <i class="bi bi-pencil-square fs-3 text-dark"></i>
                            </button>
                            <!--archive button-->
                            <button class="archive-btn" data-id="${prod.productId}" data-archived="${prod.archived}">
                                <i class="bi ${prod.archived ? 'bi-box-arrow-up text-secondary fs-3 text-dark' : 'bi-archive fs-3 text-dark'}"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Add and Update Products Modal -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="productModalTitle">Add Products</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <jsp:include page="productForm.jsp"/>
          </div>
        </div>
      </div>
    </div>

    <!-- Toast for adding product -->
    <div id="addToast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">Product System</strong>
          <small>Just now</small>
          <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
          Product Added Successfully!
          <div class="progress mt-2" style="height: 5px;">
            <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 100%"></div>
          </div>
        </div>
      </div>
    </div>

    <!-- Toast for updating product -->
    <div id="updateToast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">Product System</strong>
          <small>Just now</small>
          <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
          Product Updated Successfully!
          <div class="progress mt-2" style="height: 5px;">
            <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 100%"></div>
          </div>
        </div>
      </div>
    </div>

    <!-- Toast for archiving -->
    <div id="archiveToast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">Product System</strong>
          <small>Just now</small>
          <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
          <span class="toast-message">Archived Successfully!</span>
          <div class="progress mt-2" style="height: 5px;">
            <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 100%"></div>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        const productModal = document.getElementById('productModal');
        const productForm = document.getElementById('productForm');
        const modalTitle = document.getElementById('productModalTitle');
        const submitBtn = document.getElementById('formSubmitBtn');

        productForm.addEventListener('submit', function () {
            if (submitBtn.textContent === "Add Product") {
                localStorage.setItem("StatusAdd", "added");
            } else if (submitBtn.textContent === "Update Product") {
                localStorage.setItem("StatusUpdate", "updated");
            }
        });

        productModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const action = button.getAttribute('data-action');

            if (action === 'add') {
                modalTitle.textContent = 'Add Product';
                productForm.action = '/api/createP';
                submitBtn.textContent = 'Add Product';

                // Clear fields
                productForm.reset();
                document.getElementById('productId').value = '';
            } else if (action === 'update') {
                modalTitle.textContent = 'Update Product';
                productForm.action = '/api/updateP';
                submitBtn.textContent = 'Update Product';

                // Fill fields from button data attributes
                document.getElementById('productId').value = button.getAttribute('data-id');
                document.getElementById('productName').value = button.getAttribute('data-name');
                document.getElementById('productDescription').value = button.getAttribute('data-description');
                document.getElementById('productPrice').value = button.getAttribute('data-price');
                document.getElementById('productStock').value = button.getAttribute('data-stock');
            }
        });

        // Multiple archive button
        document.getElementById('archiveBtn').addEventListener('click', function() {
            const selectedCheckboxes = document.querySelectorAll('.customer-checkbox:checked');
            const selectedIds = Array.from(selectedCheckboxes).map(cb => Number(cb.getAttribute('data-id')));

            if(selectedIds.length === 0) {
                const toastEl = document.querySelector('#archiveToast .toast');
                const messageEl = toastEl.querySelector('.toast-message');
                const progressBar = toastEl.querySelector('.progress-bar');
                messageEl.textContent = "Please select at least one customer to archive.";
                const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
                toast.show();
                progressBar.style.animation = 'none';
                progressBar.offsetHeight; // trigger reflow
                progressBar.style.animation = 'shrink 3s linear forwards';
                return;
            }

            fetch('/api/product/archive', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(selectedIds)
            })
            .then(response => response.text()) // get message from backend
            .then(message => {
                // Update icons immediately
                selectedCheckboxes.forEach(cb => {
                    cb.disabled = true; // disable archived rows
                    const btn = cb.closest('tr').querySelector('.archive-btn i');
                    btn.className = 'bi bi-box-arrow-up text-secondary fs-3 text-dark';
                });

                // Show toast
                const toastEl = document.querySelector('#archiveToast .toast');
                const messageEl = toastEl.querySelector('.toast-message');
                const progressBar = toastEl.querySelector('.progress-bar');
                messageEl.textContent = message || 'Archived Successfully!';
                const toast = new bootstrap.Toast(toastEl, { delay: 2000 });
                toast.show();
                progressBar.style.animation = 'none';
                progressBar.offsetHeight;
                progressBar.style.animation = 'shrink 2s linear forwards';

                // Reload page after toast
                setTimeout(() => location.reload(), 2200);
            })
            .catch(err => {
                console.error(err);
                const toastEl = document.querySelector('#archiveToast .toast');
                toastEl.querySelector('.toast-message').textContent = 'Action failed';
                const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
                toast.show();
            });
        });

        //for individual archive

        document.querySelectorAll('.archive-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();

                const customerId = Number(btn.getAttribute('data-id'));
                const isArchived = btn.getAttribute('data-archived') === 'true';
                const url = isArchived ? '/api/product/unarchive' : '/api/product/archive'; // full path

                fetch(url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify([customerId])
                })
                .then(response => response.text())
                .then(data => {
                    // Show toast
                    const toastEl = document.querySelector('#archiveToast .toast');
                    const messageEl = toastEl.querySelector('.toast-message');
                    const progressBar = toastEl.querySelector('.progress-bar');

                    messageEl.textContent = data;
                    const toast = new bootstrap.Toast(toastEl, { delay: 2000 });
                    toast.show();
                    progressBar.style.animation = 'none';
                    progressBar.offsetHeight;
                    progressBar.style.animation = 'shrink 2s linear forwards';

                    // Optional: update icon immediately
                    if(isArchived){
                        btn.setAttribute('data-archived', 'false');
                        btn.querySelector('i').className = 'bi bi-archive fs-3 text-dark';
                    } else {
                        btn.setAttribute('data-archived', 'true');
                        btn.querySelector('i').className = 'bi bi-box-arrow-up text-secondary fs-3 text-dark';
                    }

                    // Reload page after toast shows (slightly after 2s)
                    setTimeout(() => {
                        location.reload();
                    }, 2200); // give 200ms buffer after toast finishes
                })
                .catch(err => {
                    console.error(err);
                    const toastEl = document.querySelector('#archiveToast .toast');
                    toastEl.querySelector('.toast-message').textContent = 'Action failed';
                    const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
                    toast.show();
                });
            });
        });

        //toggle of sort button
        document.querySelectorAll('.sort-button').forEach(button => {
            button.addEventListener('click', function() {
                const icon = button.querySelector('i');

                if (button.classList.contains('btn-secondary')) {
                    // Secondary -> Primary, change icon to sort-down
                    button.classList.remove('btn-secondary');
                    button.classList.add('btn-primary');
                    icon.className = 'bi bi-sort-down';
                } else {
                    // Primary -> Secondary, change icon back to sort-up-alt
                    button.classList.remove('btn-primary');
                    button.classList.add('btn-secondary');
                    icon.className = 'bi bi-sort-up-alt';
                }
            });
        });

        //submitting sorting
        document.querySelectorAll('.sort-button').forEach(button => {
            button.addEventListener('click', function() {
                const form = button.closest('form');
                const icon = button.querySelector('i');
                const hiddenDir = form.querySelector('input[name="sortDir"]');

                if (button.classList.contains('btn-secondary')) {
                    // Secondary -> Primary, change icon to sort-down
                    button.classList.remove('btn-secondary');
                    button.classList.add('btn-primary');
                    icon.className = 'bi bi-sort-down';
                    hiddenDir.value = 'desc';
                } else {
                    // Primary -> Secondary, change icon back to sort-up-alt
                    button.classList.remove('btn-primary');
                    button.classList.add('btn-secondary');
                    icon.className = 'bi bi-sort-up-alt';
                    hiddenDir.value = 'asc';
                }

                // Submit the form to trigger controller sorting
                form.submit();
            });
        });

        //toggle between archive and unarchive
        let showArchived = localStorage.getItem("showArchived") === "true";

        // Update the URL when clicking toggle
        document.getElementById("toggleArchiveBtn").addEventListener("click", function (e) {
            e.preventDefault();

            // flip the state
            showArchived = !showArchived;

            // save it to localStorage
            localStorage.setItem("showArchived", showArchived);

            // reload with new param
            window.location.href = "/api/readP?showArchived=" + showArchived;
        });

        //to change the state of archive icon above table
        document.addEventListener("DOMContentLoaded", function () {
            const toggleBtn = document.getElementById("toggleArchiveBtn");

            // restore state on reload
            let archiveState = localStorage.getItem("archiveState") || "secondary";
            setButtonState(toggleBtn, archiveState);

            toggleBtn.addEventListener("click", function () {
                // flip state
                archiveState = (archiveState === "secondary") ? "primary" : "secondary";

                // apply UI change
                setButtonState(toggleBtn, archiveState);

                // save state
                localStorage.setItem("archiveState", archiveState);

                // send state via AJAX to backend
                fetch("/api/product/archive/state", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ state: archiveState })
                })
                .then(res => res.text())
                .then(msg => console.log("Server saved state:", msg))
                .catch(err => console.error(err));
            });

            function setButtonState(btn, state) {
                btn.classList.remove("btn-outline-secondary", "btn-primary");
                if (state === "secondary") {
                    btn.classList.add("btn-outline-secondary");
                    btn.querySelector("i").className = "bi bi-archive-fill fs-3";
                } else {
                    btn.classList.add("btn-primary");
                    btn.querySelector("i").className = "bi bi-archive-fill fs-3";
                }
            }
        });

        window.addEventListener("DOMContentLoaded", function () {
        const status = localStorage.getItem("Status");

        const statusAdd = localStorage.getItem("StatusAdd");
        if (statusAdd === "added") {
            const toastEl = document.querySelector('#addToast .toast');
            const progressBar = toastEl.querySelector('.progress-bar');
            const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
            toast.show();
            progressBar.style.animation = 'none';
            progressBar.offsetHeight; /* trigger reflow */
            progressBar.style.animation = 'shrink 3s linear forwards';
            localStorage.removeItem("StatusAdd");
        }

        const statusUpdate = localStorage.getItem("StatusUpdate");
        if (statusUpdate === "updated") {
            const toastEl = document.querySelector('#updateToast .toast');
            const progressBar = toastEl.querySelector('.progress-bar');
            const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
            toast.show();
            progressBar.style.animation = 'none';
            progressBar.offsetHeight; /* trigger reflow */
            progressBar.style.animation = 'shrink 3s linear forwards';
            localStorage.removeItem("StatusUpdate");
        }

    });
    </script>
</body>
</html>
