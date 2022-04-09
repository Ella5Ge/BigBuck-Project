package com.ibm.security.appscan.altoromutual.util;

import com.ibm.security.appscan.altoromutual.model.Account;
import com.ibm.security.appscan.altoromutual.model.Holding;
import com.ibm.security.appscan.altoromutual.model.StockData;
import org.json.*;

import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import static java.lang.Math.abs;


public class ConnectYahooFinance{

    public static final String YAHOO_FINANCE_URL_START = "https://query1.finance.yahoo.com/v7/finance/download/";
    public static final String YAHOO_FINANCE_URL_END = "&interval=1d&events=history&includeAdjustedClose=true";

    public static final String YAHOO_FINANCE_SPIDER_URL = "https://yfapi.net/v6/finance/quote?symbols=";
    // signup up https://www.yahoofinanceapi.com and then get a api key
    public static final String api_key = "qXwOWzwPzfaHErHKci44H1z87uGUZw8c7VP9wgOQ";  // limit 100 times
    // Amber's api-key: qXwOWzwPzfaHErHKci44H1z87uGUZw8c7VP9wgOQ
    // Freda's api-key: 1CSow6sSst2l6pE9WicGLaZFGEsyKrQE6Lb9j8ko


    /**
     * Get previous 5-year data
     */
    public static long GenerateEndTimestamp(){
        //get timestamp
        Date current_date = new Date();
        //long end_date_timestamp = System.currentTimeMillis()/1000;

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(current_date);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //calendar.add(Calendar.DAY_OF_MONTH,1);
        String end_date_format = sdf.format(current_date);
        return (Timestamp.valueOf(end_date_format).getTime())/1000;
    }

    public static long GenerateStartTimestamp(){
        Date current_date = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(current_date);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        calendar.add(Calendar.YEAR,-5);
        //calendar.add(Calendar.DAY_OF_MONTH,-1);
        Date start_date = calendar.getTime();
        String start_date_format = sdf.format(start_date);
        return (Timestamp.valueOf(start_date_format).getTime())/1000;
    }

    public static long StringtoTimestamp(String Datestr){
        //get timestamp
        String Datestr1 = Datestr + " 00:00:00";
        return (Timestamp.valueOf(Datestr1).getTime())/1000;
    }

    public static ArrayList<StockData> getHistoryData(String symbol, String startdate, String enddate){
        ArrayList<StockData> history_data = new ArrayList<>();
        long start_date_timestamp;
        long end_date_timestamp;

        if(startdate == null && enddate == null){
            start_date_timestamp = GenerateStartTimestamp();
            end_date_timestamp = GenerateEndTimestamp();
        }
        else if(startdate == null && enddate != null){
            start_date_timestamp = GenerateStartTimestamp();
            end_date_timestamp = StringtoTimestamp(enddate);
        }
        else if(startdate != null && enddate == null){
            start_date_timestamp = StringtoTimestamp(startdate);
            end_date_timestamp = GenerateEndTimestamp();
        }
        else{
            start_date_timestamp = StringtoTimestamp(startdate);
            end_date_timestamp = StringtoTimestamp(startdate);
        }

        //get URL string
        String time_params = "?period1=" + start_date_timestamp + "&period2=" + end_date_timestamp;
        String url = YAHOO_FINANCE_URL_START + symbol + time_params + YAHOO_FINANCE_URL_END;

        URL MyURL;
        URLConnection con;
        InputStreamReader ins;
        BufferedReader in = null;

        try{
            MyURL = new URL(url);
            con = MyURL.openConnection();
            ins = new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8);
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
        try {
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("x-api-key", api_key);

            conn.setRequestMethod("GET");
            conn.setConnectTimeout(5000);
            conn.connect();

            StringBuffer msg = new StringBuffer();
            InputStream ins = conn.getInputStream();

            if (ins != null) {
                BufferedReader br = new BufferedReader(new InputStreamReader(ins, "UTF-8"));
                String text = null;
                while ((text = br.readLine()) != null) {
                    msg.append(text);
                }
            }

            JSONObject object = new JSONObject(msg.toString()).getJSONObject("quoteResponse").getJSONArray("result").getJSONObject(0);
            return object;
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }


    public static ArrayList<Double> getROR(String stockSymbol, String startDate) throws SQLException {
        ArrayList<Double> ROR = new ArrayList<>();
        ArrayList<StockData> stock = DBUtil.getStockDataFromSQL(stockSymbol, startDate, null);
        int n = stock.size();
        for(int i=1; i<n; i++){
            double day1 = stock.get(i-1).getAdj_close();
            double day2 = stock.get(i).getAdj_close();
            double ror = (day2 - day1) / day1;
            ROR.add(ror);
        }
        return ROR;
    }

    public static ArrayList<Double> getWeight(Holding[] holdings) {
        double totalValue = 0.0;
        ArrayList<Double> weight = new ArrayList<>();
        for(Holding holding: holdings){
            double value = holding.getCostPrice() * holding.getHoldingAmount();
            totalValue += value;
        }

        for(Holding holding: holdings){
            double value = holding.getCostPrice() * holding.getHoldingAmount();
            weight.add(value/totalValue);
        }
        return weight;
    }


    public static double getVolatility(ArrayList<Double> averages) throws IOException {
        double volatility = 0.0;
        ArrayList<Double> excess_ret = new ArrayList<>();

        for(int i=0; i<averages.size(); i++){ //get rp-rf
            double rp = averages.get(i);
            excess_ret.add(rp);
        }

        double tot_excess_ret = 0.0; // get volatility: stdev of rp-rf
        for(int i=0; i<excess_ret.size(); i++){
            tot_excess_ret += excess_ret.get(i);
        }

        double avg_excess_ret = tot_excess_ret / excess_ret.size();
        double sum_diff_mean = 0.0;
        for(int i=0; i<excess_ret.size(); i++){
            sum_diff_mean += (excess_ret.get(i) - avg_excess_ret) * (excess_ret.get(i) - avg_excess_ret);
        }
        volatility = Math.sqrt(sum_diff_mean / excess_ret.size());

        return volatility;
    }


    // if no stock ==> Sharpe ratio is nan
    // if today is the first day to trade ==> Sharpe ratio is 0
    public static double getSharpeRatio(Account[] accounts) throws SQLException, IOException {
        //for one account!
        double SharpeRatio = 0.0;

        // calculate weight
        Holding[] holdings = DBUtil.getHolding(accounts);
        ArrayList<Double> weight = getWeight(holdings);

        // calculate risk free rate
        ArrayList<StockData> treasury_data = getHistoryData("%5ETNX","2022-04-05", null);
        double rf = treasury_data.get(treasury_data.size()-1).getAdj_close() / 100;

        // calculate portfolio's rate of return
        ArrayList<Double> averages = new ArrayList<Double>(); //avg return for all stocks
        for(Holding holding: holdings){
            String startDate = DBUtil.getStartDate(holding.getAccountId(), holding.getStockSymbol());
            ArrayList<Double> ror = getROR(holding.getStockSymbol(), startDate);
            double ror_sum = 0.0;
            for (int i=0; i<ror.size(); i++){
                ror_sum += ror.get(i);
            }
            double ror_avg = ror_sum / ror.size(); //for one stock
            averages.add(ror_avg);
        }

        double rp = 0; //expected portfolio return
        for(int i=0; i<weight.size(); i++){
            if (Double.isNaN(averages.get(i))) {
                averages.set(i, 0.0);
            }
            rp += weight.get(i) * averages.get(i);
        }


        // calculate volatility
        if (abs(rp) > 0.0000000001 && averages.size() == 1) {
            averages = getROR(holdings[0].getStockSymbol(),null);
        }
        double volatility = getVolatility(averages);

        // calculate sharpe ratio
        SharpeRatio = (rp - rf) / volatility;
        return SharpeRatio;
    }


    public static void main(String[] args) throws Exception {
//        JSONObject msg = getLiveObjects("AAPL");
//        System.out.println(msg);

        Account[] accounts = new Account[]{DBUtil.getAccount(800000)};
        Holding[] holdings = DBUtil.getHolding(accounts);
        ArrayList<StockData> list = null;
        ArrayList<Double> ror = new ArrayList<Double>();
        //ror = getROR("AAPL", "2022-03-01");
        //System.out.println(ror);
        //System.out.println(ror.size());
        double sharpe = getSharpeRatio(accounts);
        System.out.println(sharpe);
    }
}

