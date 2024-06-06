package API;

import DatabaseManage.Database;
import Wifi.WifiDetail;
import Wifi.WifiInform;
import com.google.gson.Gson;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class APICall {

    public static void main(String[] args) throws IOException {
        BufferedReader rd = null;
        HttpURLConnection conn = null;
        try {
            int totalCount = getTotalCount(); // 전체 데이터 개수 가져오기
            int pageSize = 1000; // 한 페이지당 가져올 데이터 개수
            int totalPages = (int) Math.ceil((double) totalCount / pageSize); // 총 페이지 수 계산

            List<WifiDetail> allWifiDetails = new ArrayList<>();

            // 각 페이지마다 데이터 가져오기
            for (int page = 1; page <= totalPages; page++) {
                StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088/5366537a566477673537567443557a/json/TbPublicWifiInfo/");
                urlBuilder.append(page).append("/").append(pageSize).append("/");

                URL url = new URL(urlBuilder.toString());
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Content-type", "application/json");
                int responseCode = conn.getResponseCode();

                if (responseCode >= 200 && responseCode <= 300) {
                    rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                } else {
                    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
                    throw new IOException("HTTP error code : " + responseCode);
                }

                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = rd.readLine()) != null) {
                    sb.append(line);
                }

                Gson gson = new Gson();
                WifiInform wifiInform = gson.fromJson(sb.toString(), WifiInform.class);

                if (wifiInform != null && wifiInform.getTbPublicWifiInfo().getRow() != null) {
                    allWifiDetails.addAll(wifiInform.getTbPublicWifiInfo().getRow());
                } else {
                    System.err.println("API에서 정보 가져오기 실패 ");
                }
            }

            // 모든 데이터를 DB에 저장
            Database.insertWifiData(allWifiDetails);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rd != null) {
                rd.close();
            }
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    public static int getTotalCount() throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088/5366537a566477673537567443557a/json/TbPublicWifiInfo/1/1/");
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");

        BufferedReader rd = null;
        try {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }

            Gson gson = new Gson();
            WifiInform wifiInform = gson.fromJson(sb.toString(), WifiInform.class);

            if (wifiInform != null) {
                return wifiInform.getTbPublicWifiInfo().getList_total_count();
            } else {
                throw new IOException("API에서 전체 데이터 개수 가져오기 실패");
            }
        } finally {
            if (rd != null) {
                rd.close();
            }
            conn.disconnect();
        }
    }
}