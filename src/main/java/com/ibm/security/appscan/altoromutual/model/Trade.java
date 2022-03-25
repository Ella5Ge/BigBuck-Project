package com.ibm.security.appscan.altoromutual.model;

import java.util.Date;

public class Trade {
    private int tradeId;
    private long accountId;
    private String tradeType;
    private double amount;
    private Date date;
    private String stockSymbol;

    public Trade(int transactionId, long accountId, Date date, String transactionType, double amount, String stockSymbol) {
        this.accountId = accountId;
        this.amount = amount;
        this.tradeId = transactionId;
        this.tradeType = transactionType;
        this.date = date;
        this.stockSymbol = stockSymbol;
    }

    public int getTradeId() {return tradeId;}

    public long getAccountId() {
        return accountId;
    }

    public String getTradeType() {
        return tradeType;
    }

    public double getAmount() {
        return amount;
    }

    public Date getDate() {
        return date;
    }

    public String getstockSymbol(){return stockSymbol; }
}
