import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;


public class TestChart {
    WebDriver driver = new FirefoxDriver();
//    String baseUrl = "http://localhost:8080/fintech512_altoroj_war_exploded/";
    String baseUrl = "http://meowth.colab.duke.edu:8080/altoroj/";
    String chartUrl = baseUrl + "chart.jsp";
    String loginUrl = baseUrl + "login.jsp";
    String uid = "wl239";
    String passw = "1111";


    @Test
    public void testSelenium() {
        driver.get("https://www.google.com");
        String title = driver.getTitle();
        driver.close();
        assertEquals("Google", title);
    }

    @Test
    public void testConnect() {
        driver.get(baseUrl);
        // get the actual value of the title
        String actualTitle = driver.getTitle();
        String expectedTitle = "Welcome Page";

        /*
         * compare the actual title of the page with the expected one and print
         * the result as "Passed" or "Failed"
         */
        if (actualTitle.contentEquals(expectedTitle)){
            System.out.println("Test Passed!");
        } else {
            System.err.println("Test Failed");
        }
        assertEquals(actualTitle, expectedTitle);
        //close Fire fox
        driver.close();
    }


    @Test
    public void testLoginIN() throws InterruptedException {
        System.out.println("111111");
        driver.get(loginUrl);
        Thread.sleep(1000);
        System.out.println("222222");
        WebElement username = driver.findElement(By.id("uid"));
        System.out.println("333333");
        WebElement password = driver.findElement(By.name("passw"));
        System.out.println("444444");
        username.sendKeys(uid);
        Thread.sleep(1000);
        System.out.println("555555");
        password.sendKeys(passw);
        Thread.sleep(1000);

        WebElement loginButton = driver.findElement(By.name("btnSubmit"));
        loginButton.click();

        String expectedTitle = "BigBucks Home Page";

        assertEquals(driver.getTitle(), expectedTitle);

        driver.close();
    }


    @Test
    public void testChart1() throws InterruptedException {
        driver.get(chartUrl);
        Thread.sleep(1000);
        WebElement symbol = driver.findElement(By.id("symbol"));
        Select graph = new Select(driver.findElement(By.id("graphType")));

        String stockSymbol = "AAPL";
        String graphType = "chart1";
        String expectedTitle = stockSymbol + " Price Line Chart";

        symbol.sendKeys(stockSymbol);
        Thread.sleep(1000);
        graph.selectByValue(graphType);
        Thread.sleep(1000);
        WebElement chartButton1 = driver.findElement(By.name("submit"));
        chartButton1.click();
        Thread.sleep(2000);
        assertEquals(driver.findElement(By.xpath("//div/h1")).getText(), expectedTitle);

        driver.close();
    }


    @Test
    public void testChart2() throws InterruptedException {
        driver.get(chartUrl);
        Thread.sleep(1000);

        WebElement symbol = driver.findElement(By.id("symbol"));
        Select graph = new Select(driver.findElement(By.id("graphType")));

        String stockSymbol = "BABA";
        String graphType = "chart2";
        String expectedTitle = stockSymbol + " Return Scatter Chart";

        symbol.sendKeys(stockSymbol);
        Thread.sleep(1000);
        graph.selectByValue(graphType);
        Thread.sleep(1000);
        WebElement chartButton1 = driver.findElement(By.name("submit"));
        chartButton1.click();
        Thread.sleep(5000);
        assertEquals(driver.findElement(By.xpath("//div/h1")).getText(), expectedTitle);
        driver.close();
    }


    @Test
    public void testChart3() throws InterruptedException {
        driver.get(chartUrl);
        Thread.sleep(1000);

        WebElement symbol = driver.findElement(By.id("symbol"));
        Select graph = new Select(driver.findElement(By.id("graphType")));

        String stockSymbol = "FB";
        String graphType = "chart3";
        String expectedTitle = stockSymbol + " Today's Rate of Return vs Yesterday's";

        symbol.sendKeys(stockSymbol);
        Thread.sleep(1000);
        graph.selectByValue(graphType);
        Thread.sleep(1000);
        WebElement chartButton1 = driver.findElement(By.name("submit"));
        chartButton1.click();
        Thread.sleep(5000);
        assertEquals(driver.findElement(By.xpath("//div/h1")).getText(), expectedTitle);
        driver.close();
    }


    @Test
    public void testChart4() throws InterruptedException {
        driver.get(chartUrl);
        Thread.sleep(1000);

        WebElement symbol = driver.findElement(By.id("symbol"));
        Select graph = new Select(driver.findElement(By.id("graphType")));

        String stockSymbol = "AAPL";
        String graphType = "chart4";
        String expectedTitle = stockSymbol + " Return Histogram";

        symbol.sendKeys(stockSymbol);
        Thread.sleep(1000);
        graph.selectByValue(graphType);
        Thread.sleep(1000);
        WebElement chartButton1 = driver.findElement(By.name("submit"));
        chartButton1.click();
        Thread.sleep(5000);
        assertEquals(driver.findElement(By.xpath("//div/h1")).getText(), expectedTitle);

        driver.close();
    }


    @Test
    public void testChart5() throws InterruptedException {
        driver.get(chartUrl);
        Thread.sleep(1000);

        WebElement symbol = driver.findElement(By.id("symbol"));
        Select graph = new Select(driver.findElement(By.id("graphType")));

        String stockSymbol = "AAPL";
        String graphType = "chart5";
        String expectedTitle = stockSymbol + " vs SPY Index Cumulative Return";

        symbol.sendKeys(stockSymbol);
        Thread.sleep(1000);
        graph.selectByValue(graphType);
        Thread.sleep(1000);
        WebElement chartButton1 = driver.findElement(By.name("submit"));
        chartButton1.click();
        Thread.sleep(5000);
        assertEquals(driver.findElement(By.xpath("//div/h1")).getText(), expectedTitle);

        driver.close();
    }


    @Test
    public void testChart6() throws InterruptedException {
        driver.get(chartUrl);
        Thread.sleep(1000);

        WebElement symbol = driver.findElement(By.id("symbol"));
        Select graph = new Select(driver.findElement(By.id("graphType")));

        String stockSymbol = "BABA";
        String graphType = "chart6";
        String expectedTitle = stockSymbol + " vs SPY Index Daily Return";

        symbol.sendKeys(stockSymbol);
        Thread.sleep(1000);
        graph.selectByValue(graphType);
        Thread.sleep(1000);
        WebElement chartButton1 = driver.findElement(By.name("submit"));
        chartButton1.click();
        Thread.sleep(5000);
        assertEquals(driver.findElement(By.xpath("//div/h1")).getText(), expectedTitle);

        driver.close();
    }


    @Test
    public void testChart7() throws InterruptedException {
        driver.get(chartUrl);
        Thread.sleep(1000);

        WebElement symbol = driver.findElement(By.id("symbol"));
        Select graph = new Select(driver.findElement(By.id("graphType")));

        String stockSymbol = "XOM";
        String graphType = "chart7";
        String expectedTitle = stockSymbol + " CAPM Regression Line";

        symbol.sendKeys(stockSymbol);
        Thread.sleep(1000);
        graph.selectByValue(graphType);
        Thread.sleep(1000);
        WebElement chartButton1 = driver.findElement(By.name("submit"));
        chartButton1.click();
        Thread.sleep(5000);
        assertEquals(driver.findElement(By.xpath("//div/h1")).getText(), expectedTitle);

        driver.close();
    }
}
