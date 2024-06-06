
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>첫 페이지입니다</title>
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
            <th>거리</th>
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
        <tr>
            <td colspan="17">위치를 입력한 후 조회해 주세요</td>
        </tr>
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
