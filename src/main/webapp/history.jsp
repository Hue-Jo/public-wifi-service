<%@ page import="java.util.List" %>
<%@ page import="DatabaseManage.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>조회 히스토리</title>
    <style>
        table {
            width: 100%;
        }

        thead:first-child {
            background-color: wheat;
        }

        td {
            text-align: center;
        }
    </style>
</head>
<body>
<header>
    <h1>와이파이 정보 구하기</h1>
</header>
<main>
    <div class="option">
        <a href="indexPage.jsp"><span>홈</span></a>
        <span> | </span>
        <a href="history.jsp"> <span>위치 히스토리 목록</span> </a>
        <span> | </span>
        <a href="WifiCount.jsp">
            <span>Open API 와이파이 정보 가져오기</span></a>
    </div>

    <table>
        <thead>
        <tr>
            <th>번호</th>
            <th>X 좌표</th>
            <th>Y 좌표</th>
            <th>조회일자</th>
            <th>비고</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Object[]> historyList = Database.getHistory();
            int num = 1;
            for (Object[] history : historyList) {
        %>
        <tr>
            <td><%= num++ %></td>
            <td><%= history[0] %></td>
            <td><%= history[1] %></td>
            <td><%= history[2] %></td>
            <td><button>delete</button></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</main>
<script>
    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition);
        } else {
            alert("이 브라우저에서는 안 나와용");
        }
    }

    function showPosition(position) {
        document.getElementById('mylat').value = position.coords.latitude;
        document.getElementById('mylnt').value = position.coords.longitude;

    }
</script>
</body>
</html>
