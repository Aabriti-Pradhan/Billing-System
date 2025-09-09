<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

        h1 {
            color: #2F3E2F;
            margin: 0;
        }

        .add-button {
            color: #2F3E2F;
            font-weight: bold;
            border: none;
            padding: 10px 20px;
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
        }

        .delete-btn {
            background-color: #FF6B6B;
            color: white;
        }

        .delete-btn:hover {
            background-color: #E63946;
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
        <h1>Invoices List</h1>
        <a href="/addInvoice" class="add-button"><i class="bi bi-file-plus-fill fs-1"></i></a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Date</th>
                <th>Total Amount</th>
                <th>Discount</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="inv" items="${invoices}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${inv.invoiceDate}</td>
                    <td>${inv.totalAmount}</td>
                    <td>${inv.discount}</td>
                    <td>
                        <form action="/invoice/update/${inv.invoiceId}" method="get" style="display:inline;">
                            <a href="/api/invoice/view/${inv.invoiceId}" class="action-btn update-btn">View</a>
                        </form>
                        <!--delete button-->
                        <form action="/invoice/delete/${inv.invoiceId}" method="post" style="display:inline;">
                            <button type="button" class="btn btn-link p-0" data-bs-toggle="modal" data-bs-target="#exampleModal"  data-id="${inv.invoiceId}">
                                <i class="bi bi-trash3-fill fs-3 text-dark"></i>
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
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

</div>
<script>

const deleteForm = document.getElementById('deleteForm');
const deleteButtons = document.querySelectorAll('.delete-btn');

deleteButtons.forEach(button => {
    button.addEventListener('click', function() {
        const invoiceId = this.getAttribute('data-id');
        localStorage.setItem("Status", "deleted");
        deleteForm.action = '/api/invoice/delete/' + invoiceId;
    });
});

window.addEventListener("DOMContentLoaded", function () {
    const status = localStorage.getItem("Status");
    if (status === "deleted") {
        const toastEl = document.querySelector('#deleteToast .toast');
        const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
        toast.show();

        // clear the flag so it doesn't show every reload
        localStorage.removeItem("Status");
    }
});

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
