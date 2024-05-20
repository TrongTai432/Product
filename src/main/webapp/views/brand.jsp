<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Brand List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<h2>Brand List</h2>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Logo</th>
        <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="brand" items="${brands}">
        <tr>
            <td>${brand.brandId}</td>
            <td>${brand.brandName}</td>
            <td>
                <img src="${brand.logo}" alt="${brand.brandName}" width="50" height="50">
            </td>
            <td>${brand.description}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
