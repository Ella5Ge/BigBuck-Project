import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Comparator;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;


public class TestSignup {
//    public static String COURSE_CREATE="CREATE TABLE course (name VARCHAR(50),  credits INT)";
//
//    public static String SCHEDULE_CREATE="""
//                                     CREATE TABLE schedule
//                                     (name VARCHAR(100),  offeringId INT)
//                                  """;
//
//    public static String OFFERING_CREATE="""
//                                         CREATE TABLE offering
//                                         (id INT,   name VARCHAR(50),  daysTimes VARCHAR(100))
//                                  """;
//
//    public static void initializeDatabase() {
//        Path pathToBeDeleted = Path.of("reggie");
//
//        try {
//            Files.walk(pathToBeDeleted)
//                    .sorted(Comparator.reverseOrder())
//                    .map(Path::toFile)
//                    .forEach(File::delete);
//        } catch (IOException e) {
//            if (!(e instanceof java.nio.file.NoSuchFileException)) {
//                fail("Unable to delete existing database: "+e);
//            }
//        }
//
//
//        String driver = "org.apache.derby.jdbc.EmbeddedDriver";
//        String dbName="reggie";
//        String connectionURL = "jdbc:derby:" + dbName + ";create=true";
//        try {
//            Connection conn = DriverManager.getConnection(connectionURL);
//            Statement stmt = conn.createStatement();
//            stmt.execute(COURSE_CREATE);
//            stmt.execute(SCHEDULE_CREATE);
//            stmt.execute(OFFERING_CREATE);
//        }
//        catch (SQLException e) {
//            fail("Error initialization database: "+e);
//        }
//    }


    @Test
    public void testSelenium() throws Exception {
        WebDriver driver = new FirefoxDriver();
        driver.get("https://www.google.com");
        String title = driver.getTitle();
        driver.close();
        assertEquals("Google", title);
    }
}
