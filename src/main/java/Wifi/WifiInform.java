package Wifi;

import java.util.ArrayList;
import java.util.List;

public class WifiInform {

    private TbPublicWifiInfo TbPublicWifiInfo;

    public TbPublicWifiInfo getTbPublicWifiInfo() {
        return TbPublicWifiInfo;
    }

    public static class TbPublicWifiInfo {
        private int list_total_count;
        private Result RESULT;
        private List<WifiDetail> row;

        public int getList_total_count() {
            return list_total_count;
        }

        public void setList_total_count(int list_total_count) {
            this.list_total_count = list_total_count;
        }

        public Result getRESULT() {
            return RESULT;
        }

        public void setRESULT(Result RESULT) {
            this.RESULT = RESULT;
        }

        public List<WifiDetail> getRow() {
            if (row == null) {
                return new ArrayList<>();
            }
            return row;        }

        public void setRow(List<WifiDetail> row) {
            this.row = row;
        }

        public static class Result {
            private String CODE;
            private String MESSAGE;

            public String getCODE() {
                return CODE;
            }

            public void setCODE(String CODE) {
                this.CODE = CODE;
            }

            public String getMESSAGE() {
                return MESSAGE;
            }

            public void setMESSAGE(String MESSAGE) {
                this.MESSAGE = MESSAGE;
            }
        }
    }
}