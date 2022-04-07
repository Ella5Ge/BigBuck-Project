package com.ibm.security.appscan.altoromutual.util;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import java.sql.SQLException;
import java.util.ArrayList;

@SpringBootApplication
@EnableScheduling
public class StockAutoUpdate {

    @Scheduled(cron = "0 0 18 * * ?")
    public void dataTasks() throws SQLException {
        ArrayList<String> stockSymbolList = DBUtil.getAllStockSymbol();
        for (String stockSymbol: stockSymbolList) {
            DBUtil.updateStockData(stockSymbol);
        }
    }
}
