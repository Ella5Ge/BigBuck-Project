package com.ibm.security.appscan.altoromutual.util;

import com.ibm.security.appscan.altoromutual.model.StockData;
import org.json.*;

import java.io.*;
import java.net.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;


public class ConnectYahooFinance{

    public static final String YAHOO_FINANCE_URL_START = "https://query1.finance.yahoo.com/v7/finance/download/";
    public static final String YAHOO_FINANCE_URL_END = "&interval=1d&events=history&includeAdjustedClose=true";

    public static final String YAHOO_FINANCE_SPIDER_URL = "https://yfapi.net/v6/finance/quote?symbols=";
    // signup up https://www.yahoofinanceapi.com and then get a api key
    public static final String api_key = "1CSow6sSst2l6pE9WicGLaZFGEsyKrQE6Lb9j8ko";
    // Amber's api-key: Tq9rY48hUn8yBMNoZyxfZ3OyIiNJx44l9PKqKCMN


    /**
     * Get previous 5-year data
     * @param symbol
     * @return
     */
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

    /**
     * @param stockSymbol
     * @return
     */
    public static JSONObject getLiveObjects(String stockSymbol) throws IOException {
        URL url = new URL(YAHOO_FINANCE_SPIDER_URL + stockSymbol);
        HttpURLConnection conn = (HttpURLConnection)url.openConnection();
        conn.setRequestProperty("x-api-key", api_key);

        conn.setRequestMethod("GET");
        conn.setConnectTimeout(5000);
        conn.connect();

        StringBuffer msg = new StringBuffer();
        InputStream ins  = conn.getInputStream();

        if (ins != null) {
            BufferedReader br = new BufferedReader(new InputStreamReader(ins, "UTF-8"));
            String text = null;
            while((text = br.readLine()) != null){
                msg.append(text);
            }
        }

        JSONObject object = new JSONObject(msg.toString()).getJSONObject("quoteResponse").getJSONArray("result").getJSONObject(0);
        return object;
    }


    public static void main(String[] args) throws Exception {
        JSONObject msg = getLiveObjects("AAPL");
        System.out.println(msg.getDouble("regularMarketPrice"));

        ArrayList<StockData> list = getHistoryData("AAPL");
    }
}

