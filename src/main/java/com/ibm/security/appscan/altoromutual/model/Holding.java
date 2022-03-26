package com.ibm.security.appscan.altoromutual.model;

public class Holding {
    private long accountId;
    private String stockSymbol;
    private String stockName;
    private int holdingAmount;
    private double costPrice;

    public Holding(long accountId, String stockSymbol, String stockName, int holdingAmount, double costPrice) {
        this.accountId = accountId;
        this.stockSymbol = stockSymbol;
        this.stockName = stockName;
        this.holdingAmount = holdingAmount;
        this.costPrice = costPrice;
    }

    public long getAccountId() {
        return accountId;
    }

    public void setAccountId(long accountId) {
        this.accountId = accountId;
    }

    public String getStockSymbol() {
        return stockSymbol;
    }

    public void setStockSymbol(String stockSymbol) {
        this.stockSymbol = stockSymbol;
    }

    public String getStockName() {
        return stockName;
    }

    public void setStockName(String stockName) {
        this.stockName = stockName;
    }

    public int getHoldingAmount() {
        return holdingAmount;
    }

    public void setHoldingAmount(int holdingAmount) {
        this.holdingAmount = holdingAmount;
    }

    public double getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(double costPrice) {
        this.costPrice = costPrice;
    }
}
