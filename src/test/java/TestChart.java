import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;


public class TestChart {
    WebDriver driver = new FirefoxDriver();
    String baseUrl = "http://meowth.colab.duke.edu:8080/altoroj/chartdisplay.jsp";

    @Test
    public void testSelenium() {
        driver.get("https://www.google.com");
        String title = driver.getTitle();
        driver.close();
        assertEquals("Google", title);
    }


    @Test
    public void testLoginIN() throws InterruptedException {
        System.out.println("111111");
        driver.get(baseUrl);
        Thread.sleep(15000);
        System.out.println("222222");
        WebElement symbol = driver.findElement(By.id("symbol"));
        System.out.println("333333");
        WebElement graphType = driver.findElement(By.id("graphType"));
        System.out.println("444444");
        symbol.sendKeys("value","AAPL");
        Thread.sleep(5000);
        System.out.println("555555");
        graphType.sendKeys("chart1");
        Thread.sleep(5000);

        WebElement chartButton = driver.findElement(By.name("submit"));
        chartButton.click();

    }


    public static void main(String[] args) {
        // declaration and instantiation of objects/variables
//        System.setProperty("webdriver.gecko.driver","C:\\geckodriver.exe");
        WebDriver driver = new FirefoxDriver();
        //comment the above 2 lines and uncomment below 2 lines to use Chrome
        //System.setProperty("webdriver.chrome.driver","G:\\chromedriver.exe");
        //WebDriver driver = new ChromeDriver();

        String baseUrl = "http://localhost:8080/fintech512_altoroj_war_exploded/";
        String expectedTitle = "Altoro Mutual";
        String actualTitle = "";

        // launch Fire fox and direct it to the Base URL
        driver.get(baseUrl);


        // get the actual value of the title
        actualTitle = driver.getTitle();
        System.out.println("Actual Title: " + actualTitle);

        /*
         * compare the actual title of the page with the expected one and print
         * the result as "Passed" or "Failed"
         */
        if (actualTitle.contentEquals(expectedTitle)){
            System.out.println("Test Passed!");
        } else {
            System.out.println("Test Failed");
        }

        //close Fire fox
        driver.close();
    }
}
