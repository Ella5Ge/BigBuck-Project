package com.ibm.security.appscan.altoromutual.model;

public class StockData {
    private String symbol;
    private String date;
    private double open = 0.0;
    private double close = 0.0;
    private double high = 0.0;
    private double low = 0.0;
    private double adj_close = 0.0;
    private double volume =0.0;

    public StockData(){
        String symbol = null;
        String date = null;
        double open = 0.0;
        double close = 0.0;
        double high = 0.0;
        double low = 0.0;
        double adj_close = 0.0;
        double volume = 0.0;
    }

    public StockData(String symbol, String date, double open, double close, double high, double low, double adj_close, double volume){
        this.symbol = symbol;
        this.date = date;
        this. open = open;
        this.close = close;
        this.high = high;
        this.low = low;
        this.adj_close =adj_close;
        this.volume = volume;
    }

    public String getSymbol(){
        return symbol;
    }
    public void setSymbol(String symbol){
        this.symbol = symbol;
    }
    public String getDate() {return date;}
    public void setDate(String date) {this.date = date;}
    public double getOpen(){
        return open;
    }
    public void setOpen(double open){
        this.open = open;
    }
    public double getClose(){
        return close;
    }
    public void setClose(double close){
        this.close = close;
    }
    public double getHigh(){
        return high;
    }
    public void setHigh(double high){
        this.high = high;
    }
    public double getLow(){
        return low;
    }
    public void setLow(double low){
        this.low = low;
    }
    public double getAdj_close(){
        return adj_close;
    }
    public void setAdj_close(double adj_close){
        this.adj_close = adj_close;
    }
    public double getVolume(){
        return volume;
    }
    public void setVolume(double volume){
        this.volume = volume;
    }
}
