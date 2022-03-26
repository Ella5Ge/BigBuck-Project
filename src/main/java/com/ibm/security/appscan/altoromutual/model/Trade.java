package com.ibm.security.appscan.altoromutual.model;

import java.util.Date;

public class Trade {
    private int tradeId;
    private long accountId;
    private String tradeType;
    private int amount;
    private double price;
    private Date date;
    private String stockSymbol;
    private double volume;

    public Trade(int tradeId, long accountId, Date date, String tradeType, int amount, double price, String stockSymbol) {
        this.accountId = accountId;
        this.amount = amount;
        this.price = price;
        this.tradeId = tradeId;
        this.tradeType = tradeType;
        this.date = date;
        this.stockSymbol = stockSymbol;
        this.volume = price * amount;
    }

    public int getTradeId() {return tradeId;}

    public long getAccountId() {
        return accountId;
    }

    public String getTradeType() {
        return tradeType;
    }

    public int getAmount() {
        return amount;
    }

    public double getPrice() {
        return price;
    }

    public Date getDate() {
        return date;
    }

    public String getStockSymbol() {return stockSymbol; }

    public double getVolume() { return volume; }

}
