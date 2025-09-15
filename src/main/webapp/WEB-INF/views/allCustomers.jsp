<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
    <title>All Customers</title>
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
            padding: 15px 200px;
            margin-top: -220px;
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
            width: 100%;
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

        .add-button {
            color: #2F3E2F;
            font-weight: bold;
            border: none;
            padding: 10px 10px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
        }

        .add-button:hover {
            background-color: #FFF0CE;
        }

        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .archive-btn{
            all: unset;
        }

        .sort-btn{
            all: unset;
        }

        .update-btn {
            background-color: #FFD580;
            color: #2F3E2F;
        }

        .update-btn:hover {
            background-color: #FFC04C;
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
        <div class="head-space">
            <h1>Customers List</h1>
            <button id="archiveBtn" class="btn btn-warning"><i class="bi bi-archive"></i> Archive Selected</button>
        </div>
        <div class="head-space">
            <!--sort by-->
            <!-- <button class="sort-btn" id="sort-btn"><i class="bi bi-filter-circle-fill fs-3"><small>Sort By</small></i></button> -->
            <!-- search bar -->
            <form action="${pageContext.request.contextPath}/api/customer/search" method="get">
                <div class="input-group mb-3">
                    <input type="text" name="keyword" class="form-control" placeholder="Search customers..." value="${keyword}">
                    <button class="btn btn-outline-secondary" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </form>
            <!--add button-->
            <button type="button" data-bs-toggle="modal" class="btn btn-outline-secondary btn-lg" data-bs-target="#customerModal" data-action="add" style="padding: 0 0; margin: 0;">
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
                    <form method="get" action="/api/read" style="display:inline;">
                        <input type="hidden" name="sortField" value="name"/>
                        <input type="hidden" name="sortDir"
                               value="${sortField == 'name' && sortDir == 'asc' ? 'desc' : 'asc'}"/>
                        <button type="button"
                                class="btn ${sortField == 'name' ? (sortDir == 'asc' ? 'btn-secondary' : 'btn-primary') : 'btn-secondary'} btn-sm sort-button">
                            <i class="bi ${sortField == 'name' ? (sortDir == 'asc' ? 'bi-sort-up-alt' : 'bi-sort-down') : 'bi-sort-up-alt'}"></i>
                        </button>
                    </form>
                </div>
            </th>
            <th>
                <div class="d-flex justify-content-between align-items-center">
                    Email
                    <form method="get" action="/api/read" style="display:inline;">
                        <input type="hidden" name="sortField" value="email"/>
                        <input type="hidden" name="sortDir" value="asc"/>
                        <button type="button" class="btn btn-secondary btn-sm sort-button">
                          <i class="bi bi-sort-up-alt"></i>
                        </button>
                    </form>
                </div>
            </th>
            <th>Phone</th>
            <th>
                <div class="d-flex justify-content-between align-items-center">
                    Address
                    <form method="get" action="/api/read" style="display:inline;">
                        <input type="hidden" name="sortField" value="address"/>
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
        <c:forEach var="cust" items="${customers}" varStatus="status">
            <tr>
                <td><input type="checkbox" class="customer-checkbox" data-id="${cust.customerId}"
                    <c:if test="${cust.archived}">disabled</c:if> />
                </td>
                <td>${status.index + 1}</td>
                <td>${cust.name}</td>
                <td>${cust.email}</td>
                <td>${cust.phone}</td>
                <td>${cust.address}</td>
                <td class="actions">
                    <!-- update button-->
                    <button type="button"
                            class="btn btn-link p-0"
                            data-bs-toggle="modal"
                            data-bs-target="#customerModal"
                            data-id="${cust.customerId}"
                            data-name="${cust.name}"
                            data-email="${cust.email}"
                            data-phone="${cust.phone}"
                            data-address="${cust.address}"
                            data-action="update">
                        <i class="bi bi-pencil-square fs-3 text-dark"></i>
                    </button>
                    <!--archive button-->
                    <button class="archive-btn" data-id="${cust.customerId}" data-archived="${cust.archived}">
                        <i class="bi ${cust.archived ? 'bi-box-arrow-up text-secondary fs-3 text-dark' : 'bi-archive fs-3 text-dark'}"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Add and Update Customer Modal -->
    <div class="modal fade" id="customerModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="customerModalTitle">Add Customer</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <jsp:include page="customerForm.jsp"/>
          </div>
        </div>
      </div>
    </div>


    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Customer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this Customer?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <form id="deleteForm" method="post">
                        <button type="submit" class="btn btn-danger">Delete Customer</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Sort Modal -->
    <div class="modal fade" id="sortModal" tabindex="-1" aria-labelledby="sortModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="sortModalLabel">Sort Customers</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form method="get" action="/api/read">
              <label for="sortField">Sort by:</label>
              <select name="sortField" id="sortField" class="form-select">
                <option value="name" ${sortField == 'name' ? 'selected' : ''}>Name</option>
                <option value="email" ${sortField == 'email' ? 'selected' : ''}>Email</option>
                <option value="address" ${sortField == 'address' ? 'selected' : ''}>Address</option>
              </select>

              <label for="sortDir" class="mt-3">Direction:</label>
              <select name="sortDir" id="sortDir" class="form-select">
                <option value="asc" ${sortDir == 'asc' ? 'selected' : ''}>Ascending</option>
                <option value="desc" ${sortDir == 'desc' ? 'selected' : ''}>Descending</option>
              </select>

              <div class="mt-3 text-end">
                <button type="submit" class="btn btn-success">Apply</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>


    <!-- Toast for deletion -->
    <div id="deleteToast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">Customer System</strong>
          <small>Just now</small>
          <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
          Customer Deleted Successfully!
          <div class="progress mt-2" style="height: 5px;">
            <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 100%"></div>
          </div>
        </div>
      </div>
    </div>

    <!-- Toast for adding customer -->
    <div id="addToast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">Customer System</strong>
          <small>Just now</small>
          <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
          Customer Added Successfully!
          <div class="progress mt-2" style="height: 5px;">
            <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 100%"></div>
          </div>
        </div>
      </div>
    </div>

    <!-- Toast for updating customer -->
    <div id="updateToast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">Customer System</strong>
          <small>Just now</small>
          <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
          Customer Updated Successfully!
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
              <strong class="me-auto">Customer System</strong>
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

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>

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



    const deleteModal = document.getElementById('deleteModal');
    const deleteForm = document.getElementById('deleteForm');

    //customerModal
    const customerModal = document.getElementById('customerModal');
    const customerForm = document.getElementById('customerForm');
    const modalTitle = document.getElementById('customerModalTitle');
    const submitBtn = document.getElementById('formSubmitBtn');

    deleteModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const customerId = button.getAttribute('data-id');
        deleteForm.action = '/api/delete/' + customerId;
    });

    deleteForm.addEventListener('submit', function () {
        localStorage.setItem("Status", "deleted");
    });

    customerForm.addEventListener('submit', function () {
        if (submitBtn.textContent === "Add Customer") {
            localStorage.setItem("StatusAdd", "added");
        } else if (submitBtn.textContent === "Update Customer") {
            localStorage.setItem("StatusUpdate", "updated");
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

        fetch('/api/customer/archive', {
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
            const url = isArchived ? '/api/customer/unarchive' : '/api/customer/archive'; // full path

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
        window.location.href = "/api/read?showArchived=" + showArchived;
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
            fetch("/api/archive/state", {
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


    //to open modal of sorting
    //document.getElementById("sort-btn").addEventListener("click", function (e) {
        //e.preventDefault();
        //const modal = new bootstrap.Modal(document.getElementById("sortModal"));
        //modal.show();
    //});


    window.addEventListener("DOMContentLoaded", function () {
        const status = localStorage.getItem("Status");
        if (status === "deleted") {
            const toastEl = document.querySelector('#deleteToast .toast');
            const progressBar = toastEl.querySelector('.progress-bar');
            const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
            toast.show();
            progressBar.style.animation = 'none';
            progressBar.offsetHeight; /* trigger reflow */
            progressBar.style.animation = 'shrink 3s linear forwards';
            localStorage.removeItem("Status");
        }

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

    //add customer modal
    customerModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const action = button.getAttribute('data-action');

        if (action === 'add') {
            modalTitle.textContent = 'Add Customer';
            customerForm.action = '/api/create';
            submitBtn.textContent = 'Add Customer';

            // clear fields
            document.getElementById('customerId').value = '';
            document.getElementById('customerName').value = '';
            document.getElementById('customerEmail').value = '';
            document.getElementById('customerPhone').value = '';
            document.getElementById('customerAddress').value = '';
        } else if (action === 'update') {
            modalTitle.textContent = 'Update Customer';
            customerForm.action = '/api/update';
            submitBtn.textContent = 'Update Customer';

            // fill fields
            document.getElementById('customerId').value = button.getAttribute('data-id');
            document.getElementById('customerName').value = button.getAttribute('data-name');
            document.getElementById('customerEmail').value = button.getAttribute('data-email');
            document.getElementById('customerPhone').value = button.getAttribute('data-phone');
            document.getElementById('customerAddress').value = button.getAttribute('data-address');
        }
    });
</script>


</body>
</html>
