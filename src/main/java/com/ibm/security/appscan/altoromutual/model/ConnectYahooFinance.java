package com.ibm.security.appscan.altoromutual.model;

import java.io.*;
import java.net.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;


public class ConnectYahooFinance{
       /*ConnectYahooFinance HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://yfapi.net/v6/finance/qu/AAPL"))
                .header("x-api-key", "YOUR-PERSONAL-API-KEY")
                .method("GET", HttpRequest.BodyPublishers.noBody())
                .build();
       // HttpResponse<String> response = HttpClient.newHttpClient();*/

    public static final String YAHOO_FINANCE_URL_START = "https://query1.finance.yahoo.com/v7/finance/download/";
    public static final String YAHOO_FINANCE_URL_END = "&interval=1d&events=history&includeAdjustedClose=true";

    public static ArrayList<StockData> getHistoryData(String symbol){
        ArrayList<StockData> history_data = new ArrayList<StockData>();
        //get timestamp
        Date current_date = new Date();
        //long end_date_timestamp = System.currentTimeMillis()/1000;

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(current_date);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //calendar.add(Calendar.DAY_OF_MONTH,1);
        String end_date_format = sdf.format(current_date);
        long end_date_timestamp = (long) (Timestamp.valueOf(end_date_format).getTime())/1000;

        calendar.add(Calendar.YEAR,-5);
        //calendar.add(Calendar.DAY_OF_MONTH,-1);
        Date start_date = calendar.getTime();
        String start_date_format = sdf.format(start_date);
        long start_date_timestamp = (long) (Timestamp.valueOf(start_date_format).getTime())/1000;


        //get URL string
        String time_params = "?period1=" + start_date_timestamp + "&period2=" + end_date_timestamp;
        String url = YAHOO_FINANCE_URL_START + symbol + time_params + YAHOO_FINANCE_URL_END;

        URL MyURL = null;
        URLConnection con = null;
        InputStreamReader ins = null;
        BufferedReader in = null;

        try{
            MyURL = new URL(url);
            con = MyURL.openConnection();
            ins = new InputStreamReader(con.getInputStream(), "UTF-8");
            in = new BufferedReader(ins);
            String newLine = in.readLine();

            while((newLine = in.readLine()) != null){
                String stockInfo[] = newLine.trim().split(",");
                StockData hisdata_5years = new StockData();
                hisdata_5years.setSymbol(symbol);
                hisdata_5years.setDate(stockInfo[0]);
                hisdata_5years.setOpen(Float.valueOf(stockInfo[1]));
                hisdata_5years.setHigh(Float.valueOf(stockInfo[2]));
                hisdata_5years.setLow(Float.valueOf(stockInfo[3]));
                hisdata_5years.setClose(Float.valueOf(stockInfo[4]));
                hisdata_5years.setAdj_close(Float.valueOf(stockInfo[5]));
                hisdata_5years.setVolume(Float.valueOf(stockInfo[6]));
                history_data.add(hisdata_5years);

            }
        } catch (Exception e) {
            return null;
        } finally {
            if(in != null){
                try{
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return history_data;

    }


    public static String getAAPL() {
        URL url = null;
        try {
            url = new URL("https://yfapi.net/v6/finance/quote?symbols=AAPL");
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setRequestProperty("x-api-key", "Tq9rY48hUn8yBMNoZyxfZ3OyIiNJx44l9PKqKCMN");

            conn.setRequestMethod("GET");
            conn.setConnectTimeout(5000);
            conn.connect();
            StringBuffer msg = new StringBuffer();
            //System.out.println("msg:" + msg);

            InputStream ins  = conn.getInputStream();
            if (ins != null) {
                BufferedReader br = new BufferedReader(new InputStreamReader(ins, "UTF-8"));
                String text = null;
                while((text = br.readLine()) != null){
            msg.append(text);

                }
            }
            return msg.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }



    public static void main(String[] args) {
                String msg = getAAPL();
        System.out.println("msg:" + msg);

        ArrayList<StockData> list = getHistoryData("AAPL");

    }


}

