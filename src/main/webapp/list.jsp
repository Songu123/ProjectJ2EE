
<%@ page import="java.util.List" %>
<%@ page import="com.son.Impl.UserDAOImpl" %>
<%@ page import="com.son.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách Users</title>
    <style>
        table { border-collapse: collapse; width: 60%; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 8px 12px; text-align: left; }
        th { background: #f2f2f2; }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Danh sách Users</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên đăng nhập</th>
            <th>Email</th>
        </tr>
        <%
            try {
                UserDAOImpl userDAO = new UserDAOImpl();
                List<User> listUser = userDAO.getAll();
                for (User user : listUser) {
        %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
        %>
        <tr>
            <td colspan="3" style="color:red;">Lỗi: <%= e.getMessage() %></td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
