<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>All Invoices</title>
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

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .head-space {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        h1 {
            color: #2F3E2F;
            margin: 0;
        }

        .add-button {
            color: #2F3E2F;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: 0.3s;
            text-decoration: none;
        }

        .add-button:hover {
            background-color: #FFF0CE;
        }

        table {
            width: 100%;
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
            text-align: center;
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

        .action-btn {
            margin-top: 10px;
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .update-btn {
            content-align: center;
            padding-top: 15px;
        }

        .update-btn:hover {
            background-color: #FFC04C;
        }

        .delete-btn {
            background-color: #FF6B6B;
            color: white;
        }

        .delete-btn:hover {
            background-color: #E63946;
        }

        .invoice-checkbox:disabled {
            cursor: not-allowed;
            opacity: 0.6;
        }

        .archive-btn{
            all: unset;
        }

        .sort-btn{
            all: unset;
        }

        /* Progress bar animation for toast */
        .toast .progress-bar {
            animation: shrink 3s linear forwards;
        }

        @keyframes shrink {
            from {
                width: 100%;
            }
            to {
                width: 0%;
            }
        }

    </style>
</head>
<body>
<jsp:include page="home.jsp"/>

<div class="content">
    <div class="header">
        <div class="head-space">
            <h1>Invoices List</h1>
            <button id="archiveBtn" class="btn btn-warning"><i class="bi bi-archive"></i> Archive Selected</button>

        </div>
        <div class="head-space">
            <!--sort by-->
            <!-- <button class="sort-btn" id="sort-btn"><i class="bi bi-filter-circle-fill fs-3"><small>Sort By</small></i></button> -->
            <!-- search bar -->
            <form action="${pageContext.request.contextPath}/api/invoices/search" method="get">
                <div class="input-group mb-3">
                    <input type="text" name="keyword" class="form-control" placeholder="Search invoices..." value="${keyword}">
                    <button class="btn btn-outline-secondary" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </form>

            <!--add button-->
            <button type="button" data-bs-toggle="modal" class="btn btn-outline-secondary btn-lg" data-bs-target="#invoiceModal" data-action="add" style="padding: 0;">
                <i class="bi bi-plus h1" ></i>
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
                        Date
                        <form method="get" action="/api/allInvoice" style="display:inline;">
                            <input type="hidden" name="sortField" value="invoiceDate"/>
                            <input type="hidden" name="sortDir"
                                   value="${sortField == 'invoiceDate' && sortDir == 'asc' ? 'desc' : 'asc'}"/>
                            <button type="button"
                                    class="btn ${sortField == 'invoiceDate' ? (sortDir == 'asc' ? 'btn-secondary' : 'btn-primary') : 'btn-secondary'} btn-sm sort-button">
                                <i class="bi ${sortField == 'invoiceDate' ? (sortDir == 'asc' ? 'bi-sort-up-alt' : 'bi-sort-down') : 'bi-sort-up-alt'}"></i>
                            </button>
                        </form>
                    </div>
                </th>
                <th>
                    <div class="d-flex justify-content-between align-items-center">
                        Total Amount
                        <form method="get" action="/api/allInvoice" style="display:inline;">
                            <input type="hidden" name="sortField" value="totalAmount"/>
                            <input type="hidden" name="sortDir"
                                   value="${sortField == 'totalAmount' && sortDir == 'asc' ? 'desc' : 'asc'}"/>
                            <button type="button"
                                    class="btn ${sortField == 'totalAmount' ? (sortDir == 'asc' ? 'btn-secondary' : 'btn-primary') : 'btn-secondary'} btn-sm sort-button">
                                <i class="bi ${sortField == 'totalAmount' ? (sortDir == 'asc' ? 'bi-sort-up-alt' : 'bi-sort-down') : 'bi-sort-up-alt'}"></i>
                            </button>
                        </form>
                    </div>
                </th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="inv" items="${invoices}" varStatus="status">
                <tr>
                    <td><input type="checkbox" class="invoice-checkbox" data-id="${inv.id}"
                            <c:if test="${inv.archived}">disabled</c:if> />
                    </td>
                    <td>${status.index + 1}</td>
                    <td>${inv.formattedInvoiceDate}</td>
                    <td>${inv.totalAmount}</td>
                    <td>
                        <form action="/invoice/update/${inv.id}" method="get" style="display:inline;">
                            <a href="/api/invoice/view/${inv.id}" class="btn btn-link p-0"><i class="bi bi-eye-fill fs-3 text-dark"></i></a>
                        </form>
                        <!--archive button-->
                        <button class="archive-btn" data-id="${inv.id}" data-archived="${inv.archived}">
                            <i class="bi ${inv.archived ? 'bi-box-arrow-up text-secondary fs-3 text-dark' : 'bi-archive fs-3 text-dark'}"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!--checking toast message for redundant id-->
    <c:if test="${not empty toastMessage}">
        <div id="serverToast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
            <div class="toast align-items-center text-bg-${toastType}" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        ${toastMessage}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">Delete Invoice</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to delete this invoice?</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <form id="deleteForm" action="" method="post">
              <button type="submit" class="btn btn-primary" class="btn btn-primary" id="liveToastBtn">Delete Invoice</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Add Invoice Modal -->
    <div class="modal fade" id="invoiceModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="customerModalTitle">Add Invoice</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <jsp:include page="addInvoice.jsp"/>
          </div>
        </div>
      </div>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        // When Add Invoice modal is fully shown
        const invoiceModal = document.getElementById("invoiceModal");
        invoiceModal.addEventListener("shown.bs.modal", function () {
            if (typeof initAddInvoiceJS === "function") {
                initAddInvoiceJS(); // initialize your product/service search & dynamic rows
            }
        });
    });
    </script>


    <!-- Sort Modal -->
        <div class="modal fade" id="sortModal" tabindex="-1" aria-labelledby="sortModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="sortModalLabel">Sort Customers</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <form method="get" action="/api/allInvoice">
                  <label for="sortField">Sort by:</label>
                  <select name="sortField" id="sortField" class="form-select">
                    <option value="invoiceDate" ${sortField == 'invoiceDate' ? 'selected' : ''}>Date</option>
                    <option value="totalAmount" ${sortField == 'totalAmount' ? 'selected' : ''}>Amount</option>
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
          <strong class="me-auto">Invoice System</strong>
          <small>Just now</small>
          <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
          Invoice Deleted Successfully!
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
          <strong class="me-auto">Invoice System</strong>
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

    const deleteForm = document.getElementById('deleteForm');
    const deleteButtons = document.querySelectorAll('.delete-btn');

    deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            localStorage.setItem("Status", "deleted");
            deleteForm.action = '/api/delete/' + id;
        });
    });

    // Multiple archive button
    document.getElementById('archiveBtn').addEventListener('click', function() {
        const selectedCheckboxes = document.querySelectorAll('.invoice-checkbox:checked');
        const selectedIds = Array.from(selectedCheckboxes).map(cb => Number(cb.getAttribute('data-id')));

        if(selectedIds.length === 0) {
            const toastEl = document.querySelector('#archiveToast .toast');
            const messageEl = toastEl.querySelector('.toast-message');
            const progressBar = toastEl.querySelector('.progress-bar');
            messageEl.textContent = "Please select at least one invoice to archive.";
            const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
            toast.show();
            progressBar.style.animation = 'none';
            progressBar.offsetHeight; // trigger reflow
            progressBar.style.animation = 'shrink 3s linear forwards';
            return;
        }

        fetch('/api/archive', {
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

            const invoiceId = Number(btn.getAttribute('data-id'));
            const isArchived = btn.getAttribute('data-archived') === 'true';
            const url = isArchived ? '/api/unarchive' : '/api/archive'; // full path

            fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify([invoiceId])
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
        window.location.href = "/api/allInvoice?showArchived=" + showArchived;
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

    //to show toast message if id is redundant
    document.addEventListener("DOMContentLoaded", function() {
        const toastEl = document.querySelector("#serverToast .toast");
        if (toastEl) {
            const bsToast = new bootstrap.Toast(toastEl, { delay: 3000 });
            bsToast.show();
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
        if (status === "archived") {
            const toastEl = document.querySelector('#archiveToast .toast');
            const progressBar = toastEl.querySelector('.progress-bar');
            const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
            toast.show();
            progressBar.style.animation = 'none';
            progressBar.offsetHeight; /* trigger reflow */
            progressBar.style.animation = 'shrink 3s linear forwards';
            localStorage.removeItem("Status");
        }
    });

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
