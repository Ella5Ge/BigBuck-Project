import com.ibm.security.appscan.altoromutual.util.DBUtil;
import com.ibm.security.appscan.altoromutual.util.ServletUtil;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Comparator;

import static org.junit.jupiter.api.Assertions.fail;

public class TestHoldingDB {
    public static String TRADE_CREATE="CREATE TABLE TRADE (TRADE_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 3970, INCREMENT BY 1), " +
            "ACCOUNTID BIGINT NOT NULL, DATE TIMESTAMP NOT NULL, TYPE VARCHAR(100) NOT NULL, STOCKSYMBOL VARCHAR(50) NOT NULL, " +
            "TRADEAMOUNT INTEGER NOT NULL, TRADEPRICE DOUBLE NOT NULL, PRIMARY KEY (TRADE_ID))";


    public static String HOLDINGS_CREATE="CREATE TABLE HOLDINGS (ACCOUNTID BIGINT NOT NULL, STOCKSYMBOL VARCHAR(50) NOT NULL, HOLDINGAMOUNT INTEGER NOT NULL)";


    @Test
    public void test() throws SQLException {
        DBUtil.updateBalance(100, 800002);
    }
}
