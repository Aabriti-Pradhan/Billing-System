<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Service Entry</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background-color: #F7F4EA; margin:0; padding:0; }
        .content { padding: 20px 180px; margin-top: -250px }
        h1 { text-align:center; color:#2F3E2F; margin-bottom:30px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #A8BBA3; color: #2F3E2F; }
        .add-btn { margin-top: 10px; background-color: #A8BBA3; color: #2F3E2F; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer; }
        .add-btn:hover { background-color: #FFF0CE; }
        input { padding: 6px; border-radius: 4px; border:1px solid #ccc; width: 90%; }
        select { padding: 6px; border-radius: 4px; border:1px solid #ccc; width: 100%; }
    </style>
</head>
<body>
<jsp:include page="home.jsp"/>

<div class="content">
    <h1>Service Entry</h1>

    <form method="post" action="/serviceApi/save">
        <label>Select Customer:</label>
        <select name="customerId" id="customerDropdown" required>
            <option value="">--Select Customer--</option>
            <c:forEach var="cust" items="${customers}">
                <option value="${cust.customerId}">${cust.name}</option>
            </c:forEach>
        </select>

        <table id="serviceTable">
            <thead>
                <tr>
                    <th>Service Name</th>
                    <th>Amount</th>
                    <th>VAT (%)</th>
                </tr>
            </thead>
            <tbody id="serviceBody">
                <tr>
                    <td><input type="text" name="serviceName[]" required></td>
                    <td><input type="number" name="serviceAmount[]" min="0" step="0.01" required></td>
                    <td><input type="number" name="serviceVat[]" min="0" step="0.01" required></td>
                </tr>
            </tbody>
        </table>

        <button type="button" onclick="addServiceRow()">+ Add Service</button>
        <button type="submit">Save</button>
    </form>

</div>

<script>
    function addServiceRow() {
        const tbody = document.getElementById('serviceBody');
        const newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td><input type="text" name="serviceName[]" required></td>
            <td><input type="number" name="serviceAmount[]" min="0" step="0.01"></td>
            <td><input type="number" name="serviceVat[]" min="0" step="0.01" required></td>
        `;
        tbody.appendChild(newRow);
    }
    </script>
</body>
</html>
