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

        .update-btn {
            background-color: #FFD580;
            color: #2F3E2F;
        }

        .update-btn:hover {
            background-color: #FFC04C;
        }<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>


        /* Toast animation */
        .toast .progress-bar {
            animation: shrink 3s linear forwards;
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
        <h1>Customers List</h1>
        <a href="#" class="add-button" data-bs-toggle="modal" data-bs-target="#customerModal"><i class="bi bi-file-plus-fill fs-1"></i></a>
    </div>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cust" items="${customers}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${cust.name}</td>
                <td>${cust.email}</td>
                <td>${cust.phone}</td>
                <td>${cust.address}</td>
                <td>
                    <!-- update button-->
                    <button type="button"
                            class="btn btn-link p-0"
                            data-bs-toggle="modal"
                            data-bs-target="#customerModal"
                            data-id="${cust.customerId}"
                            data-name="${cust.name}"
                            data-email="${cust.email}"
                            data-phone="${cust.phone}"
                            data-address="${cust.address}">
                        <i class="bi bi-pencil-square fs-3 text-dark"></i>
                    </button>
                    <!-- delete button-->
                    <button type="button"
                            class="btn btn-link p-0"
                            data-bs-toggle="modal"
                            data-bs-target="#deleteModal"
                            data-id="${cust.customerId}">
                        <i class="bi bi-trash3-fill fs-3 text-dark"></i>
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
            <jsp:include page="addCustomers.jsp"/>
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

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const deleteModal = document.getElementById('deleteModal');
    const deleteForm = document.getElementById('deleteForm');

    deleteModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const customerId = button.getAttribute('data-id');
        deleteForm.action = '/api/delete/' + customerId;
    });

    deleteForm.addEventListener('submit', function () {
        localStorage.setItem("Status", "deleted");
    });

    window.addEventListener("DOMContentLoaded", function () {
        const status = localStorage.getItem("Status");
        if (status === "deleted") {
            const toastEl = document.querySelector('#deleteToast .toast');
            const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
            toast.show();
            localStorage.removeItem("Status");
        }

        const statusAdd = localStorage.getItem("StatusAdd");
        if (statusAdd === "added") {
            const toastEl = document.querySelector('#addToast .toast');
            const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
            toast.show();
            localStorage.removeItem("StatusAdd");
        }
    });
    const customerModal = document.getElementById('customerModal');
    const customerForm = document.getElementById('customerForm');
    const modalTitle = document.getElementById('customerModalTitle');
    const submitBtn = document.getElementById('formSubmitBtn');

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
