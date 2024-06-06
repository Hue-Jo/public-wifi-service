<%@ page import="Wifi.WifiDetail" %>
<%@ page import="DatabaseManage.Database" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 사용자 위치 정보 초기화
    double userLat = 0.0; // 기본값 설정
    double userLnt = 0.0; // 기본값 설정

    // 사용자의 위치 정보 받아오기
    String latParameter = request.getParameter("mylat");
    String lntParameter = request.getParameter("mylnt");

    // 받아온 파라미터 값이 null이 아닌 경우에만
    if (latParameter != null && lntParameter != null) {
        userLat = Double.parseDouble(latParameter);
        userLnt = Double.parseDouble(lntParameter);

        Timestamp searchTime = new Timestamp(System.currentTimeMillis());
        Database.insertHistory(userLat, userLnt, searchTime);
    }
    List<WifiDetail> nearbyWifiList = Database.getNearbyWifi(userLat, userLnt);
%>
<html>
<head>
    <title>나랑 가까운 와이파이 정보</title>
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
    <form id="locationForm" method="get" action="WifiNearby.jsp">
        <label for="mylat">LAT</label>
        <input id="mylat" name="mylat"/>
        <label for="mylnt">LNT</label>
        <input id="mylnt" name="mylnt"/>
        <button type="button" onclick="getLocation()">내 위치 가져오기</button>
        <button type="submit">근처 WIFI 정보 보기 (20개)</button>
    </form>
    <table>
        <thead>
        <tr>
            <th>거리(km)</th>
            <th>관리번호</th>
            <th>자치구</th>
            <th>와이파이명</th>
            <th>도로명 주소</th>
            <th>상세주소</th>
            <th>설치위치(층)</th>
            <th>설치유형</th>
            <th>설치기관</th>
            <th>서비스구분</th>
            <th>망종류</th>
            <th>설치연도</th>
            <th>실내외구분</th>
            <th>WIFI 접속환경</th>
            <th>X좌표</th>
            <th>Y좌표</th>
            <th>작업일자</th>
        </tr>
        </thead>
        <tbody>
        <% for (WifiDetail wifiDetail : nearbyWifiList) { %>
        <tr>
            <td><%= wifiDetail.formatDistance(userLat, userLnt) %></td>
            <td><%= wifiDetail.getX_SWIFI_MGR_NO() %></td>
            <td><%= wifiDetail.getX_SWIFI_WRDOFC() %></td>
            <td><%= wifiDetail.getX_SWIFI_MAIN_NM() %></td>
            <td><%= wifiDetail.getX_SWIFI_ADRES1() %></td>
            <td><%= wifiDetail.getX_SWIFI_ADRES2() %></td>
            <td><%= wifiDetail.getX_SWIFI_INSTL_FLOOR() %></td>
            <td><%= wifiDetail.getX_SWIFI_INSTL_TY() %></td>
            <td><%= wifiDetail.getX_SWIFI_INSTL_MBY() %></td>
            <td><%= wifiDetail.getX_SWIFI_SVC_SE() %></td>
            <td><%= wifiDetail.getX_SWIFI_CMCWR() %></td>
            <td><%= wifiDetail.getX_SWIFI_CNSTC_YEAR() %></td>
            <td><%= wifiDetail.getX_SWIFI_INOUT_DOOR() %></td>
            <td><%= wifiDetail.getX_SWIFI_REMARS3() %></td>
            <td><%= wifiDetail.getLAT() %></td>
            <td><%= wifiDetail.getLNT() %></td>
            <td><%= wifiDetail.getWORK_DTTM() %></td>
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
