package com.ibm.security.appscan.altoromutual.api;

import com.ibm.security.appscan.altoromutual.model.StockData;
import com.ibm.security.appscan.altoromutual.util.ConnectYahooFinance;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.DateAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.xy.XYDotRenderer;
import org.jfree.chart.renderer.xy.XYItemRenderer;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.chart.ui.ApplicationFrame;
import org.jfree.chart.ui.RectangleInsets;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.time.*;
import org.jfree.data.xy.*;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.IntStream;

public class ChartAPI extends ApplicationFrame {

    public ChartAPI(String title) {
        super(title);
    }

    /**
     * calculate ror
     * @param stockSymbol stock symbol
     * @return an arraylist of date + an arraylist of rate of return
     */
    public static ArrayList<ArrayList<Double>> Calculate_ROR(String stockSymbol){
        ArrayList<Double> stockPrice = new ArrayList<>();
        ArrayList<Double> stockDate = new ArrayList<>();
        ArrayList<Double> stockROR = new ArrayList<>();
        ArrayList<ArrayList<Double>> stockRorWithDate = new ArrayList<>();
        ArrayList<StockData> stockData = ConnectYahooFinance.getHistoryData(stockSymbol,null,null);
        assert stockData != null;
        for(StockData item: stockData) {
            double adj_close_price = item.getAdj_close();
            stockPrice.add(adj_close_price);
        }
        for(int i = 0; i < stockPrice.size()-1;i++){
            double ror = (stockPrice.get(i+1)-stockPrice.get(i))/stockPrice.get(i);
            stockROR.add(ror);
        }
//        for(int i = 1; i < stockData.size();i++){
//            double date = ConnectYahooFinance.StringtoTimestamp(stockData.get(i).getDate()) * 1000;
//            stockDate.add(date);
//        }
        IntStream.range(1, stockData.size()).mapToDouble(i -> ConnectYahooFinance.StringtoTimestamp(stockData.get(i).getDate()) * 1000).forEach(stockDate::add);
        stockRorWithDate.add(stockDate);
        stockRorWithDate.add(stockROR);
        return stockRorWithDate;
    }


    /**
     * Convert date String to Regular Time Period for XYDataSet
     * @param dateString the String format of date
     * @return regular time period format
     * @throws ParseException for parse
     */
    public static RegularTimePeriod convertDate2RTP(String dateString) throws ParseException {
        SimpleDateFormat sdf2 = new SimpleDateFormat("yy-MM-dd");
        Date myDate = sdf2.parse(dateString);
        return new Day(myDate);
    }


    /**
     * creat DateAxis as DomainAxis
     * @return DateAxis for time series scatter
     */
    public static DateAxis setDateAxis(){
        DateAxis dateAxis = new DateAxis();
        dateAxis.setDateFormatOverride(new SimpleDateFormat("dd-MM-yyyy"));
        return dateAxis;
    }


    /**
     * load the Time Series dataset for one stock
     * @param stockSymbol stock symbol
     * @return XY dataset
     * @throws ParseException for parse in convertDate2RTP
     */
    public static XYDataset loadStockPriceData(String stockSymbol) throws ParseException {
        ArrayList<StockData> list = ConnectYahooFinance.getHistoryData(stockSymbol, null, null);
        String Y_name = stockSymbol + " Adjusted Closed Price";
        TimeSeries s = new TimeSeries(Y_name);
        assert list != null;
        for(StockData item: list) {
            s.addOrUpdate(convertDate2RTP(item.getDate()), item.getAdj_close());
        }
        return new TimeSeriesCollection(s);
    }


    /**
     * Create XY Series for stock return
     * @param stockSymbol stock symbol
     * @return XY dataset
     */
    public static XYSeries loadStockReturnData(String stockSymbol) throws ParseException {
        ArrayList<ArrayList<Double>> ror_list = Calculate_ROR(stockSymbol);
        int size = ror_list.get(1).size();
        ArrayList<Double> ror_date = ror_list.get(0);
        ArrayList<Double> ror = ror_list.get(1);
        String Y_name = stockSymbol + " Return";
        XYSeries s = new XYSeries(Y_name);
        for(int i = 0; i < size;i++){
            s.add(ror_date.get(i),ror.get(i));
        }

        return s;
    }


    /**
     * Create XY dateset for stock return and index return
     * @param stockSymbol stock symbol
     * @param indexSymbol index symbol
     * @return XY dataset
     * @throws ParseException for parse
     */
    public static XYDataset createStockIndexReturnDataset(String stockSymbol, String indexSymbol) throws ParseException {
        XYSeriesCollection dataset = new XYSeriesCollection();
        dataset.addSeries(loadStockReturnData(stockSymbol));
        dataset.addSeries(loadStockReturnData(indexSymbol));
        return dataset;
    }


    /**
     * Create XY dataset for stock's today return and yesterday return
     * @param stockSymbol stock symbol
     * @return XY dataset: x is yesterday's return, y is today's return
     */
    public static XYDataset loadReturnVSYesterday(String stockSymbol){
        ArrayList<ArrayList<Double>> ror_list = Calculate_ROR(stockSymbol);   // <Double> date + <Double> ror
        ArrayList<Double> ror = ror_list.get(1);
        String Y_name = stockSymbol + " Return";
        XYSeries s = new XYSeries(Y_name);
        for(int i = 1; i < ror.size();i++){
            s.add(ror.get(i-1),ror.get(i));
        }
        return new XYSeriesCollection(s);
    }


    /**
     * Create Frequency
     * @param stockSymbol stock symbol
     * @return Frequency, key is bar, value is number of ror in bar
     */
    private static HashMap<Double, Integer> getFrequency(String stockSymbol) {
        ArrayList<ArrayList<Double>> ror_list = Calculate_ROR(stockSymbol);
        ArrayList<Double> ror = ror_list.get(1);
        ror.sort(Comparator.naturalOrder());

        double min = Math.round(ror.get(0) * 100);
        double max = Math.floor(ror.get(ror.size()-1) * 100);
        int count = (int) (max-min) * 2 / 5;
        HashMap<Double, Integer> frequencymap = new HashMap<>();
        frequencymap.put(min, 0);
        for(double i = min; i <= max; i += 2.5){
            frequencymap.put(i , 0);
        }

        for (Double aROR: ror) {
            int floor = (int) Math.floor((aROR * 100 - min) / (max - min) * count);
            Double f = floor * 2.5 + min;
            if (frequencymap.containsKey(f)) {
                int con = frequencymap.get(f);
                frequencymap.put(f, con + 1);
            }
        }

        return frequencymap;
    }

    public static CategoryDataset loadFrequencyDataset(String stockSymbol){
        HashMap<Double, Integer> frequencymap = getFrequency(stockSymbol);
        TreeMap<Double, Integer> frequencymap4chart = new TreeMap<>();
        DefaultCategoryDataset defaultCategoryDataset = new DefaultCategoryDataset();
        //sort frequency map
        ArrayList<Double> list = new ArrayList<>(frequencymap.keySet());
        Collections.sort(list);
        for (Double aDouble : list) {
            frequencymap4chart.put(aDouble, null);
        }

        for(Double item:frequencymap.keySet()){
            int con = frequencymap.get(item);
            frequencymap4chart.replace(item,con);
        }

        for(Double bin: frequencymap4chart.keySet()){
            defaultCategoryDataset.addValue(frequencymap4chart.get(bin),"Class",bin.toString());
        }
        return defaultCategoryDataset;
    }


    /**
     * load cumulative return for stock
     * @param stockSymbol stock symbol
     * @return XY dataset: x is date, y is cumulative return
     * @throws ParseException for parse
     */
    public static TimeSeries loadStockCumReturn(String stockSymbol) throws ParseException{
        ArrayList<ArrayList<Double>> list1 = Calculate_ROR(stockSymbol);
        ArrayList<Double> date = list1.get(0);

        ArrayList<Double> ror = list1.get(1);
        ArrayList<Double> cum_return_list = new ArrayList<>();
        double cum_return = 1;
        for(Double item: ror){
            cum_return *= (item + 1);
            cum_return_list.add(cum_return);
        }
        String Y_name = stockSymbol + " Cumulative Return";
        TimeSeries s = new TimeSeries(Y_name);
        for(int i = 0; i < date.size(); i++) {
            Timestamp dateTmp = new Timestamp(date.get(i).longValue());
            s.addOrUpdate(convertDate2RTP(dateTmp.toString()),cum_return_list.get(i));
        }
        return s;
    }


    /**
     * Create cumulative return for stock and index for chart 5
     * @param stockSymbol stock symbol
     * @param indexSymbol index symbol
     * @return a time series of stock return and a time series of index return
     * @throws ParseException for parse (date)
     */
    public static XYDataset createStockIndexCumReturn(String stockSymbol, String indexSymbol) throws ParseException {
        TimeSeriesCollection dataset = new TimeSeriesCollection();
        dataset.addSeries(loadStockCumReturn(stockSymbol));
        dataset.addSeries(loadStockCumReturn(indexSymbol));
        return dataset;
    }


    /**
     * Calculate OLS for regression line
     * @param stock_ror stock's rate of return
     * @param index_ror index's rate of return
     * @return estimations of regression
     */
    public static ArrayList<Double> calculateOLS(ArrayList<Double> stock_ror, ArrayList<Double> index_ror){
        double size = stock_ror.size();
        double sigma_xi_yi = 0;

        double sigma_xi2 = 0;
        for(int i = 0; i < size; i++){
            double m = stock_ror.get(i) * index_ror.get(i);
            sigma_xi_yi += m;
        }
        double sigma_xi = 0;
        double sigma_yi = 0;
        for(int i =0; i < size;i++){
            double n = stock_ror.get(i);
            sigma_yi += n;
            double p = index_ror.get(i);
            sigma_xi += p;
        }
        double sigma_xi_sigma_yi = sigma_xi * sigma_yi;
        for(int i = 0; i < size; i ++){
            sigma_xi2 += Math.pow(index_ror.get(i),2);
        }
        double beta_hat = (size * sigma_xi_yi - sigma_xi_sigma_yi)/(size * sigma_xi2 - Math.pow(sigma_xi,2));
        double stock_ror_bar = sigma_yi / size;
        double index_ror_bar = sigma_xi / size;
        double alpha_hat = stock_ror_bar - beta_hat * index_ror_bar;
        ArrayList<Double> ols_estimate = new ArrayList<>();
        ols_estimate.add(beta_hat);
        ols_estimate.add(alpha_hat);
        return ols_estimate;
    }


    /**
     * create OLS data for regression chart
     * @param stockSymbol stock symbol
     * @return XY dataset
     * @throws ParseException for parse
     */
    public static XYDataset createOLSDataset(String stockSymbol, String indexSymbol) throws ParseException {
        ArrayList<ArrayList<Double>> list1 = Calculate_ROR(stockSymbol);
        ArrayList<Double> stock_ror = list1.get(1);
        ArrayList<ArrayList<Double>> list2 = Calculate_ROR(indexSymbol);
        ArrayList<Double> index_ror = list2.get(1);
        ArrayList<Double> ols_est = calculateOLS(stock_ror,index_ror);
        int size = stock_ror.size();
        double beta_hat = ols_est.get(0);
        double alpha_hat = ols_est.get(1);
        index_ror.sort(Comparator.naturalOrder());
        double x0 = index_ror.get(0);
        double y0_hat = alpha_hat + beta_hat * index_ror.get(0);
        ArrayList<Double> point1 = new ArrayList<>();
        point1.add(x0);
        point1.add(y0_hat);
        double xn = index_ror.get(size-1);
        double yn_hat = alpha_hat + beta_hat * index_ror.get(size-1);
        ArrayList<Double> pointn = new ArrayList<>();
        pointn.add(xn);
        pointn.add(yn_hat);
        ArrayList<ArrayList<Double>> point = new ArrayList<>();
        point.add(point1);
        point.add(pointn);
        String Y_name = stockSymbol + " OLS";
        XYSeries s = new XYSeries(Y_name);
        s.add(x0,y0_hat);
        s.add(xn,yn_hat);
        return new XYSeriesCollection(s);
    }


    /**
     * This Dataset: x is index return, y is stock return
     * @param stockSymbol stock symbol
     * @return x is index's rate of return, y is stock's rate of return
     */
    public static XYDataset createStockVsIndexReturn(String stockSymbol, String indexSymbol){
        ArrayList<ArrayList<Double>> list1 = Calculate_ROR(stockSymbol);
        ArrayList<Double> stock_ror = list1.get(1);
        ArrayList<ArrayList<Double>> list2 = Calculate_ROR(indexSymbol);
        ArrayList<Double> index_ror = list2.get(1);
        String Y_name = stockSymbol + " Return";
        XYSeries s = new XYSeries(Y_name);
        for(int i = 0; i < stock_ror.size();i++){
            s.add(index_ror.get(i),stock_ror.get(i));
        }
        return new XYSeriesCollection(s);
    }


    /**
     * Create plot format
     * @param plot chart plot
     * @param inset x-axis
     */
    public static void createPlot(XYPlot plot, double inset) {
        plot.setBackgroundPaint(Color.LIGHT_GRAY);
        plot.setDomainGridlinePaint(Color.WHITE);
        plot.setRangeGridlinePaint(Color.WHITE);
        plot.setAxisOffset(new RectangleInsets(inset, inset, inset, inset));
        plot.setDomainCrosshairVisible(true);
        plot.setRangeCrosshairVisible(true);

        XYItemRenderer r = plot.getRenderer();
        if (r instanceof XYLineAndShapeRenderer renderer) {
            renderer.setDrawSeriesLineAsPath(true);
        }
    }


    public static JFreeChart createOLSLineChart(String stockSymbol, String indexSymbol) throws ParseException {
        String subtitle = "Scatter graph of " + stockSymbol + " return vs. market return, with regression line";
        XYPlot plot = new XYPlot();
        XYLineAndShapeRenderer lineRenderer = new XYLineAndShapeRenderer(true, false);
        plot.setDataset(0, createOLSDataset(stockSymbol, indexSymbol));
        plot.setRenderer(0,lineRenderer);

        XYDotRenderer dotRenderer = new XYDotRenderer();
        plot.setDataset(1,createStockVsIndexReturn(stockSymbol, indexSymbol));
        plot.setRenderer(1,dotRenderer);
        dotRenderer.setDotWidth(5);
        dotRenderer.setDotHeight(5);

        //Axis
        plot.setDomainAxis(new NumberAxis(indexSymbol + " return"));
        plot.setRangeAxis(new NumberAxis(stockSymbol + " return"));

        JFreeChart chart = new JFreeChart(plot);
        chart.setTitle(subtitle);
        return chart;
    }


    /**
     * Create Line Chart
     * @param dataset XYDataset
     * @param subtitle title of chart shown on the png
     * @param y_label depends on different stock symbol
     * @return a line chart
     * @throws IOException for saveChartASPNG
     */
    public static JFreeChart createLineChart(XYDataset dataset, String subtitle, String x_label, String y_label) throws IOException {
        JFreeChart chart = ChartFactory.createTimeSeriesChart(subtitle, x_label, y_label, dataset);

        chart.setBackgroundPaint(Color.WHITE);

        XYPlot plot = (XYPlot) chart.getPlot();
        createPlot(plot, 5.0);

        DateAxis axis = (DateAxis) plot.getDomainAxis();
        SimpleDateFormat sdf3 = new SimpleDateFormat("MMM-yyyy");
        axis.setDateFormatOverride(sdf3);
        return chart;
    }


    /**
     * Create Scatter Chart for Time Series Data
     * @param dataset time series dataset
     * @param stockSymbol stock symbol
     * @return a scatter chart
     * @throws IOException for save chart
     */
    public static JFreeChart createTimeSeriesScatterChart(XYDataset dataset, String stockSymbol) throws IOException {
        String subtitle = "Simple return of " + stockSymbol;
        String x_label = "Date";
        String y_label = "Rate of Return";
        JFreeChart chart = ChartFactory.createScatterPlot(subtitle, x_label, y_label, dataset);
        chart.setBackgroundPaint(Color.WHITE);

        XYPlot plot = (XYPlot) chart.getPlot();
        DateAxis dateAxis = setDateAxis();
        plot.setDomainAxis(dateAxis);
        createPlot(plot, 0.1);

        DateAxis axis = (DateAxis) plot.getDomainAxis();

        SimpleDateFormat sdf3 = new SimpleDateFormat("dd-MM-yyyy");
        axis.setDateFormatOverride(sdf3);

        return chart;
    }


    /**
     * Create normal scatter chart for two continuous data
     * @param dataset normal continuous dataset
     * @param stockSymbol stock symbol
     * @return a normal scatter chart
     * @throws IOException for save chart
     */
    public static JFreeChart createScatterChart(XYDataset dataset, String stockSymbol) throws IOException {
        String subtitle = stockSymbol + " Today's Return vs. Yesterday's";
        String x_label = "Rate of Return (-1)";
        String y_label = "Rate of Return";
        JFreeChart chart = ChartFactory.createScatterPlot(subtitle, x_label, y_label, dataset);
        chart.setBackgroundPaint(Color.WHITE);

        XYPlot plot = (XYPlot) chart.getPlot();
        createPlot(plot, 0.1);

        return chart;
    }


    /**
     * Create Histogram
     * @param dataset category data
     * @param stockSymbol stock symbol
     * @return a histogram
     * @throws IOException for save chart
     */
    public static JFreeChart createHistogram(CategoryDataset dataset, String stockSymbol) throws IOException {
        String subtitle = stockSymbol + " Histogram of Rate of Return";
        String x_label = "Return Bin (%)";
        String y_label = "Frequency";
        JFreeChart chart = ChartFactory.createBarChart(subtitle, x_label, y_label,dataset);
        chart.setBackgroundPaint(Color.WHITE);
        CategoryPlot categoryplot = chart.getCategoryPlot();
        categoryplot.setBackgroundPaint(Color.lightGray);
        categoryplot.setRangeGridlinePaint(Color.WHITE);
        categoryplot.setAxisOffset(new RectangleInsets(5.0, 5.0, 5.0, 5.0));
        categoryplot.setDomainCrosshairVisible(true);
        categoryplot.setRangeCrosshairVisible(true);

        BarRenderer renderer1 = (BarRenderer) chart.getCategoryPlot().getRenderer();
        renderer1.setMaximumBarWidth(3);
        renderer1.setItemMargin(0.0);

        return chart;
    }

    // 14.1 chart 1
    public static JFreeChart getStockPriceChart(String stockSymbol) throws ParseException, IOException {
        return ChartAPI.createLineChart(loadStockPriceData(stockSymbol), stockSymbol + " Adjusted Close Price", "Date", "Adjusted Close Price");
    }

    // 14.2 chart 2
    public static JFreeChart getStockReturnChart(String stockSymbol) throws ParseException, IOException {
        return ChartAPI.createTimeSeriesScatterChart(new XYSeriesCollection(loadStockReturnData((stockSymbol))), stockSymbol);
    }

    // 14.3 chart 3
    public static JFreeChart getStockAutoCorrChart(String stockSymbol) throws IOException {
        return ChartAPI.createScatterChart(loadReturnVSYesterday(stockSymbol), stockSymbol);
    }

    // 14.4 chart 4
    public static JFreeChart getFreqHistogram(String stockSymbol) throws IOException {
        return ChartAPI.createHistogram(loadFrequencyDataset(stockSymbol),stockSymbol);
    }

    // 7.1 chart 5
    public static JFreeChart getCumReturnChart(String stockSymbol, String indexSymbol) throws ParseException, IOException {
        return ChartAPI.createLineChart(createStockIndexCumReturn(stockSymbol,indexSymbol), stockSymbol + " and " + indexSymbol + " Cumulative Returns", "Date", "Relative Price");
    }

    // 7.2 chart 6
    public static JFreeChart getStockVSIndexDailyReturn(String stockSymbol, String indexSymbol) throws ParseException, IOException {
        return ChartAPI.createLineChart(createStockIndexReturnDataset(stockSymbol,indexSymbol), "Daily Return of " + stockSymbol + " and " + indexSymbol, "Date", "Daily Returns");
    }

    // 7.3 chart 7
    public static JFreeChart getCAPM(String stockSymbol, String indexSymbol) throws ParseException, IOException {
        return ChartAPI.createOLSLineChart(stockSymbol, indexSymbol);
    }



    public static void main(String[] args) throws ParseException, IOException {
        String stockSymbol = "AAPL";   // Here stockSymbol is gotten from the UI
        String indexSymbol = "SPY";

        ChartUtils.saveChartAsPNG(new File("chart/chart1.png"), getStockPriceChart(stockSymbol), 800, 500);
        ChartUtils.saveChartAsPNG(new File("chart/chart2.png"), getStockReturnChart(stockSymbol), 800, 500);
        ChartUtils.saveChartAsPNG(new File("chart/chart3.png"), getStockAutoCorrChart(stockSymbol), 500, 500);
        ChartUtils.saveChartAsPNG(new File("chart/chart4.png"), getFreqHistogram(stockSymbol), 900, 500);
        ChartUtils.saveChartAsPNG(new File("chart/chart5.png"), getCumReturnChart(stockSymbol,indexSymbol), 800, 500);
        ChartUtils.saveChartAsPNG(new File("chart/chart6.png"), getStockVSIndexDailyReturn(stockSymbol, indexSymbol), 800, 500);
        ChartUtils.saveChartAsPNG(new File("chart/chart7.png"), getCAPM(stockSymbol, indexSymbol), 800, 500);
    }
}