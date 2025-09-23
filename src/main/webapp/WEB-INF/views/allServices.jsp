<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>All Services</title>
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
                <h1>Services List</h1>
                <button id="archiveBtn" class="btn btn-warning"><i class="bi bi-archive"></i> Archive Selected</button>
            </div>
            <div class="head-space">
                <!--sort by-->
                <!-- <button class="sort-btn" id="sort-btn"><i class="bi bi-filter-circle-fill fs-3"><small>Sort By</small></i></button> -->
                <!-- search bar -->
                <form action="${pageContext.request.contextPath}/api/service/search" method="get">
                    <div class="input-group mb-3">
                        <input type="text" name="keyword" class="form-control" placeholder="Search products..." value="${keyword}">
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>
                <!--add button-->
                <button type="button" data-bs-toggle="modal" class="btn btn-outline-secondary btn-lg" data-bs-target="#serviceModal" data-action="add" style="padding: 0 0; margin: 0;">
                    <i class="bi bi-plus h1"></i>
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
                            <form method="get" action="/api/readS" style="display:inline;">
                                <input type="hidden" name="sortField" value="name"/>
                                <input type="hidden" name="sortDir" value="asc"/>
                                <button type="button" class="btn btn-secondary btn-sm sort-button">
                                  <i class="bi bi-sort-up-alt"></i>
                                </button>
                            </form>
                        </div>
                    </th>
                    <th>
                        <div class="d-flex justify-content-between align-items-center">
                            Amount
                            <form method="get" action="/api/readS" style="display:inline;">
                                <input type="hidden" name="sortField" value="amount"/>
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
                <c:forEach var="serv" items="${services}" varStatus="status">
                    <tr>
                        <td><input type="checkbox" class="customer-checkbox" data-id="${serv.serviceId}"
                            <c:if test="${serv.archived}">disabled</c:if> />
                        </td>
                        <td>${status.index + 1}</td>
                        <td>${serv.serviceName}</td>
                        <td>${serv.amount}</td>
                        <td class="actions">
                            <!-- update button-->
                            <button type="button"
                                    class="btn btn-link p-0"
                                    data-bs-toggle="modal"
                                    data-bs-target="#serviceModal"
                                    data-id="${serv.serviceId}"
                                    data-action="update">
                                <i class="bi bi-pencil-square fs-3 text-dark"></i>
                            </button>
                            <!--archive button-->
                            <button class="archive-btn" data-id="${serv.serviceId}" data-archived="${serv.archived}">
                                <i class="bi ${serv.archived ? 'bi-box-arrow-up text-secondary fs-3 text-dark' : 'bi-archive fs-3 text-dark'}"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>


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

    <!-- Add and Update Products Modal -->
    <div class="modal fade" id="serviceModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="serviceModalTitle">Add Services</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <jsp:include page="serviceForm.jsp"/>
          </div>
        </div>
      </div>
    </div>

    <!-- Toast for adding service -->
    <div id="addToast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">Service System</strong>
          <small>Just now</small>
          <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
          Service Added Successfully!
          <div class="progress mt-2" style="height: 5px;">
            <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 100%"></div>
          </div>
        </div>
      </div>
    </div>

    <!-- Toast for updating service -->
    <div id="updateToast" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">Service System</strong>
          <small>Just now</small>
          <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
          Service Updated Successfully!
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
        const serviceModal = document.getElementById('serviceModal');
        const serviceForm = document.getElementById('serviceForm');
        const modalTitle = document.getElementById('serviceModalTitle');
        const submitBtn = document.getElementById('formSubmitBtn');

        serviceForm.addEventListener('submit', function () {
            if (submitBtn.textContent === "Add Service") {
                localStorage.setItem("StatusAdd", "added");
            } else if (submitBtn.textContent === "Update Service") {
                localStorage.setItem("StatusUpdate", "updated");
            }
        });

        serviceModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const action = button.getAttribute('data-action');

            if (action === 'add') {
                modalTitle.textContent = 'Add Service';
                serviceForm.action = '/api/createS';
                submitBtn.textContent = 'Add Service';

                // Clear fields
                serviceForm.reset();
                document.getElementById('serviceId').value = '';
            } else if (action === 'update') {
                modalTitle.textContent = 'Update Service';
                serviceForm.action = '/api/updateS';
                submitBtn.textContent = 'Update Service';

                const serviceId = button.getAttribute('data-id');

                // Fetch service data from server
                  fetch('/api/service/' + serviceId)
                  .then(res => {
                      if(!res.ok) throw new Error('Service not found');
                      return res.json();
                  })
                  .then(data => {
                      document.getElementById('serviceId').value = serviceId;
                      document.getElementById('serviceName').value = data.serviceName;
                      document.getElementById('serviceAmount').value = data.amount;
                  })
                  .catch(err => {
                      console.error(err);
                      alert('Failed to load service data');
                  });
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

            fetch('/api/service/archive', {
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

                const serviceId = Number(btn.getAttribute('data-id'));
                const isArchived = btn.getAttribute('data-archived') === 'true';
                const url = isArchived ? '/api/service/unarchive' : '/api/service/archive'; // full path

                fetch(url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify([serviceId])
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
            window.location.href = "/api/readS?showArchived=" + showArchived;
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
                fetch("/api/service/archive/state", {
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
