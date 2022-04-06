package com.ibm.security.appscan.altoromutual.api;

import com.ibm.security.appscan.altoromutual.model.StockData;
import com.ibm.security.appscan.altoromutual.util.ConnectYahooFinance;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.DateAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.chart.renderer.xy.XYDotRenderer;
import org.jfree.chart.renderer.xy.XYItemRenderer;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.chart.ui.ApplicationFrame;
import org.jfree.chart.ui.RectangleInsets;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.time.*;
import org.jfree.data.xy.*;

import javax.swing.*;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class ChartAPI extends ApplicationFrame {

    private String subtitle;
    private String x_label;
    private String y_label;


    public ChartAPI(String title, String stockSymbol, String subtitle, String x_label, String y_label) throws ParseException {
        super(title);
//        this.subtitle = subtitle;
//        this.x_label = x_label;
//        this.y_label = y_label;
//        ChartPanel chartPanel = (ChartPanel) createDemoPanel(stockSymbol);
//        chartPanel.setPreferredSize(new java.awt.Dimension(500, 270));
//        setContentPane(chartPanel);
    }

    public static ArrayList<ArrayList<Double>> Calculate_ROR(String StockSymbol){
        ArrayList<Double> stockprice = new ArrayList<Double>();
        ArrayList<Double> stockdate = new ArrayList<Double>();
        ArrayList<Double> stockror = new ArrayList<Double>();
        ArrayList<ArrayList<Double>> stockrorwithdate = new ArrayList<ArrayList<Double>>();
        ArrayList<StockData> stockdata = ConnectYahooFinance.getHistoryData(StockSymbol,null,null);
        System.out.println(stockdata.size());
        for(StockData item: stockdata) {
            double adj_close_price = item.getAdj_close();
            stockprice.add(adj_close_price);
        }
        for(int i = 0; i < stockprice.size()-1;i++){
            double ror = (stockprice.get(i+1)-stockprice.get(i))/stockprice.get(i);
            stockror.add(ror);
        }
        for(int i = 1; i < stockdata.size();i++){
            double date = ConnectYahooFinance.StringtoTimestamp(stockdata.get(i).getDate()) * 1000;
            stockdate.add(date);
            //System.out.println("date" + i + "=" + date);
        }
        stockrorwithdate.add(stockdate);
        stockrorwithdate.add(stockror);
        //System.out.println("共有 " + stockror.size() + " 个数据");
        return stockrorwithdate;
    }



    public static RegularTimePeriod convertDate2RTP(String dateString) throws ParseException {
        SimpleDateFormat sdf2 = new SimpleDateFormat("yy-MM-dd");
        Date myDate = sdf2.parse(dateString);
        return new Day(myDate);
    }

    /*public static Number convertTimestamp2RPT(Double timestamp) throws ParseException{
        SimpleDateFormat sdf3 = new SimpleDateFormat("yy-MM-dd");
        Date myDate = sdf3.parse(timestamp.toString());
        return new Number(myDate);
    }*/



    // create dataset:
    // first chart, parameter: stockSymbol
    // Dataset: stock adj closed priced; Date
    // 这里这里已完成
    public static TimeSeries loadPriceData(String stockSymbol) throws ParseException {
        ArrayList<StockData> list = ConnectYahooFinance.getHistoryData(stockSymbol, null, null);
        String Y_name = stockSymbol + " Adjusted Closed Price";
        TimeSeries s = new TimeSeries(Y_name);
        assert list != null;
        for(StockData item: list) {
            s.addOrUpdate(convertDate2RTP(item.getDate()), item.getAdj_close());
        }
        return s;
    }

    public static TimeSeriesCollection loadStockPriceData(String stockSymbol) throws ParseException {
        TimeSeries s = loadPriceData(stockSymbol);
        return new TimeSeriesCollection(s);
    }

    public static XYDataset creatPriceDataset(String stockSymbol, String indexSymbol) throws ParseException {
        TimeSeriesCollection dataset = new TimeSeriesCollection();
        if(indexSymbol != null){
            TimeSeries series1 = new TimeSeries("Stock Price");
            TimeSeries series2 = new TimeSeries("Index Price");
            series1 = loadPriceData(stockSymbol);
            series2 = loadPriceData(indexSymbol);
            dataset.addSeries(series1);
            dataset.addSeries(series2);
            return dataset;
        }
        else{
            TimeSeriesCollection seriesColletion;
            seriesColletion = loadStockPriceData(stockSymbol);
            return seriesColletion;
        }
    }


    // Second chart, parameter: stockSymbol
    // Dataset: stock return, Date  p
    // 此处注意! 从网上down的数据有没有直接的rate of return
    // 这里这里！！没完成呢
    public static XYSeries loadReturnData(String stockSymbol) throws ParseException {
        ArrayList<ArrayList<Double>> ror_list = Calculate_ROR(stockSymbol);
        int size = ror_list.get(1).size();
        ArrayList<Double> ror_date = ror_list.get(0);
        //System.out.println("时间共" + ror_date.size());
        ArrayList<Double> ror = ror_list.get(1);
        //System.out.println((double) ror_date.get(size-1));
        String Y_name = stockSymbol + " Return";
        XYSeries s = new XYSeries(Y_name);
        assert ror_list != null;
        for(int i = 0; i < size;i++){
            //System.out.println(ror_date.get(i));
            s.addOrUpdate(ror_date.get(i),ror.get(i));
        }

        return s;
    }

    public static XYSeriesCollection loadStockReturnData(String stockSymbol) throws ParseException {
        XYSeries s = loadReturnData(stockSymbol);
        return new XYSeriesCollection(s);
    }

    public static XYDataset createReturnDataset(String stockSymbol, String indexSymbol) throws ParseException {
        XYSeriesCollection dataset = new XYSeriesCollection();
        if(indexSymbol != null){
            XYSeries series1 = new XYSeries("Stock Return");
            XYSeries series2 = new XYSeries("Index Return");
            series1 = loadReturnData(stockSymbol);
            series2 = loadReturnData(indexSymbol);
            dataset.addSeries(series1);
            dataset.addSeries(series2);
            return dataset;
        }
        else{
            XYSeriesCollection seriesColletion;
            seriesColletion = loadStockReturnData(stockSymbol);
            return seriesColletion;
        }
    }

    public static XYDataset loadReturnDataset_yesterday(String stockSymbol){
        ArrayList<ArrayList<Double>> ror_list = Calculate_ROR(stockSymbol);
        ArrayList<Double> ror = ror_list.get(1);
        String Y_name = stockSymbol + " Return";
        XYSeries s = new XYSeries(Y_name);
        assert ror_list != null;
        for(int i = 1; i < ror.size();i++){
            //System.out.println(ror_date.get(i));
            s.addOrUpdate(ror.get(i-1),ror.get(i));
        }
        return new XYSeriesCollection(s);
    }



    private static HashMap<Double, Integer> getFrequency(String stockSymbol) {
        ArrayList<ArrayList<Double>> ror_list = Calculate_ROR(stockSymbol);
        System.out.println(ror_list);
        ArrayList<Double> ror = ror_list.get(1);
        double max = 0;
        double min = 0;
        ror.sort(Comparator.naturalOrder());
        min = Math.floor(ror.get(0) * 100);
        max = Math.round(ror.get(ror.size()-1) * 100);
        int count = (int) (max-min) * 2;
        HashMap<Double, Integer> frequencymap = new HashMap<Double,Integer>();
        frequencymap.put(min, 0);
        for(double i = min; i <= max; i += 0.5){
            frequencymap.put(i , 0);
        }
        for(Double bin:frequencymap.keySet()){
            for (int i = 0; i < ror.size(); i++) {
                int floor = (int) Math.floor((ror.get(i)*100 - min) / (max - min) * count);
                Double f = floor * 0.5 + min;
                if (frequencymap.containsKey(f)) {
                    //System.out.println("f:" +f.toString());
                    int con = frequencymap.get(f);
                    frequencymap.put(f, con +1);
                }
            }
        }
        System.out.println("Frequency Hashmap" + frequencymap);
        return frequencymap;
    }

    public static CategoryDataset loadFrequencyDataset(String stockSymbol){
        HashMap<Double, Integer> frequencymap = getFrequency(stockSymbol);
        TreeMap<Double, Integer> frequencymap4chart = new TreeMap<>();
        DefaultCategoryDataset defaultCategoryDataset = new DefaultCategoryDataset();
        //sort frequency map
        ArrayList<Double> list = new ArrayList<Double>(frequencymap.keySet());
        Collections.sort(list);
        for(int i = 0; i < list.size();i++){
            frequencymap4chart.put(list.get(i),null);
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


    //creat DateAxis as DomainAxis
    public static DateAxis setDateAxis(){
        DateAxis dateAxis = new DateAxis();
        dateAxis.setDateFormatOverride(new SimpleDateFormat("dd-MM-yyyy"));
        return dateAxis;
    }

    public static ArrayList<Double> Calculate_Cum_Return(String stockSymbol){
        ArrayList<ArrayList<Double>> list1 = Calculate_ROR(stockSymbol);
        ArrayList<Double> ror = list1.get(1);
        ArrayList<Double> cum_return_list = new ArrayList<>();
        double cum_return = 1;
        for(Double item:ror){
            cum_return *= (item + 1);
            cum_return_list.add(cum_return);
        }
        return cum_return_list;
    }

    public static TimeSeries loadCumReturnData(String stockSymbol) throws ParseException{
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
        System.out.println(s);
        return s;
    }



    public static XYDataset createCumReturnDataset(String stockSymbol, String indexSymbol) throws ParseException {
        TimeSeriesCollection dataset = new TimeSeriesCollection();
        if(indexSymbol != null){
            TimeSeries series1 = new TimeSeries("Stock Cumulative Return");
            TimeSeries series2 = new TimeSeries("Index Cumulative Return");
            series1 = loadCumReturnData(stockSymbol);
            series2 = loadCumReturnData(indexSymbol);
            dataset.addSeries(series1);
            dataset.addSeries(series2);
            return dataset;
        }
        else{
            TimeSeriesCollection seriesColletion;
            seriesColletion = loadStockPriceData(stockSymbol);
            return seriesColletion;
        }
    }
    public static ArrayList<Double> Calculate_OLS(ArrayList<Double> stock_ror, ArrayList<Double> index_ror){
        double size = stock_ror.size();
        double sigma_xi_yi = 0;

        double sigma_xi2 = 0;
        double sigma_xi_2 = 0;
        for(int i = 0; i < size; i++){
            double m = stock_ror.get(i) * index_ror.get(i);
            sigma_xi_yi += m;
        }
        double sigma_xi_sigma_yi = 0;
        double sigma_xi = 0;
        double sigma_yi = 0;
        for(int i =0; i < size;i++){
            double n = stock_ror.get(i);
            sigma_yi += n;
            double p = index_ror.get(i);
            sigma_xi += p;
        }
        sigma_xi_sigma_yi = sigma_xi * sigma_yi;
        for(int i = 0; i < size; i ++){
            sigma_xi2 += Math.pow(index_ror.get(i),2);
        }
        double beta_hat = (size * sigma_xi_yi - sigma_xi_sigma_yi)/(size * sigma_xi2 - Math.pow(sigma_xi,2));
        double stock_ror_bar = sigma_yi / size;
        double index_ror_bar = sigma_xi / size;
        double alpha_hat = stock_ror_bar - beta_hat * index_ror_bar;
        ArrayList<Double> ols_estimate = new ArrayList<Double>();
        ols_estimate.add(beta_hat);
        ols_estimate.add(alpha_hat);
        return ols_estimate;
    }

    public static XYDataset createOLSDataset(String stockSymbol, String indexSymbol) throws ParseException {
        ArrayList<ArrayList<Double>> list1 = Calculate_ROR(stockSymbol);
        ArrayList<Double> stock_ror = list1.get(1);
        ArrayList<ArrayList<Double>> list2 = Calculate_ROR(stockSymbol);
        ArrayList<Double> index_ror = list2.get(1);
        ArrayList<Double> ols_est = Calculate_OLS(stock_ror,index_ror);
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
        ArrayList<ArrayList<Double>> point = new ArrayList<ArrayList<Double>>();
        point.add(point1);
        point.add(pointn);
        String Y_name = stockSymbol + " OLS";
        XYSeries s = new XYSeries(Y_name);
        s.addOrUpdate(x0,y0_hat);
        s.addOrUpdate(xn,yn_hat);
//        XYSeries stock_return_series = loadReturnData(stockSymbol);
//        XYSeries index_return_series = loadReturnData(indexSymbol);
//
//        XYSeriesCollection OLSDataset = new XYSeriesCollection();
//        OLSDataset.addSeries(s);
//        OLSDataset.addSeries(stock_return_series);
//        OLSDataset.addSeries(index_return_series);
        return new XYSeriesCollection(s);
    }

    public static XYDataset createReturnDataset_stock_index(String stockSymbol, String indexSymbol){
        ArrayList<ArrayList<Double>> list1 = Calculate_ROR(stockSymbol);
        ArrayList<Double> stock_ror = list1.get(1);
        ArrayList<ArrayList<Double>> list2 = Calculate_ROR(stockSymbol);
        ArrayList<Double> index_ror = list2.get(1);
        String Y_name = stockSymbol + " Return";
        XYSeries s = new XYSeries(Y_name);
        for(int i = 1; i < stock_ror.size();i++){
            //System.out.println(ror_date.get(i));
            s.addOrUpdate(stock_ror.get(i-1),stock_ror.get(i));
        }
        return new XYSeriesCollection(s);
    }


    public static JFreeChart createOLSLineChart(String stockSymbol, String indexSymbol) throws ParseException, IOException {
        String subtitle = "Scatter graph of " + stockSymbol + " return vs. market return, with regression line";
        XYPlot plot = new XYPlot();
        XYLineAndShapeRenderer lineRenderer = new XYLineAndShapeRenderer(true, false);
        plot.setDataset(0, createOLSDataset(stockSymbol,indexSymbol));
        plot.setRenderer(0,lineRenderer);

        XYDotRenderer dotRenderer = new XYDotRenderer();
        plot.setDataset(1,createReturnDataset_stock_index(stockSymbol,indexSymbol));
        plot.setRenderer(1,dotRenderer);
        dotRenderer.setDotWidth(5);
        dotRenderer.setDotHeight(5);

        //Axis
        plot.setDomainAxis(new NumberAxis(indexSymbol + " return"));
        plot.setRangeAxis(new NumberAxis(stockSymbol + " return"));

        JFreeChart chart = new JFreeChart(plot);
        chart.setTitle("Scatter Chart with OLS Line");

//        ChartPanel panel = new ChartPanel(chart);
//        setContentPane(panel);
        ChartUtils.saveChartAsPNG(new File("chart7.png"), chart, 800,600);
        return chart;
    }


    //时间序列折线图！！！！！
    public static JFreeChart createLineChart(XYDataset dataset, String stockSymbol, String chartname,String subtitle, String x_label, String y_label) throws IOException {
        JFreeChart chart = ChartFactory.createTimeSeriesChart(subtitle, x_label, y_label, dataset);

        chart.setBackgroundPaint(Color.WHITE);

        XYPlot plot = (XYPlot) chart.getPlot();
        plot.setBackgroundPaint(Color.LIGHT_GRAY);
        plot.setDomainGridlinePaint(Color.WHITE);
        plot.setRangeGridlinePaint(Color.WHITE);
        plot.setAxisOffset(new RectangleInsets(5.0, 5.0, 5.0, 5.0));
        plot.setDomainCrosshairVisible(true);
        plot.setRangeCrosshairVisible(true);

        XYItemRenderer r = plot.getRenderer();
        if (r instanceof XYLineAndShapeRenderer renderer) {
            renderer.setDrawSeriesLineAsPath(true);
        }

        DateAxis axis = (DateAxis) plot.getDomainAxis();
        SimpleDateFormat sdf3 = new SimpleDateFormat("MMM-yyyy");
        axis.setDateFormatOverride(sdf3);
        ChartUtils.saveChartAsPNG(new File(chartname + ".png"), chart, 800, 300);
        return chart;
    }



    //时间序列散点用⬇️（只要带时间戳！！！！！！）
    public static JFreeChart createTimeSeriesScatterChart(XYDataset dataset, String stockSymbol) throws IOException {
        String subtitle = "Simple return of " + stockSymbol;
        String x_label = "Date";
        String y_label = "Rate of Return";
        JFreeChart chart = ChartFactory.createScatterPlot(subtitle, x_label, y_label, dataset);
        chart.setBackgroundPaint(Color.WHITE);

        XYPlot plot = (XYPlot) chart.getPlot();
        DateAxis dateAxis = setDateAxis();
        plot.setDomainAxis(dateAxis);
        plot.setBackgroundPaint(Color.LIGHT_GRAY);
        plot.setDomainGridlinePaint(Color.WHITE);
        plot.setRangeGridlinePaint(Color.WHITE);
        plot.setAxisOffset(new RectangleInsets(0.1, 0.1, 0.1, 0.1));
        plot.setDomainCrosshairVisible(true);
        plot.setRangeCrosshairVisible(true);

        XYItemRenderer r = plot.getRenderer();
        if (r instanceof XYLineAndShapeRenderer renderer) {
            renderer.setDrawSeriesLineAsPath(true);
        }

        DateAxis axis = (DateAxis) plot.getDomainAxis();
        //ValueAxis axis = plot.getDomainAxis();
        SimpleDateFormat sdf3 = new SimpleDateFormat("dd-MM-yyyy");
        axis.setDateFormatOverride(sdf3);
        ChartUtils.saveChartAsPNG(new File("chart2.png"), chart, 800, 300);

        return chart;
    }

    //今天-昨天 收益对比用⬇️
    public static JFreeChart createScatterChart(XYDataset dataset, String stockSymbol) throws IOException {
        String subtitle = stockSymbol + " Today's Return vs. Yeterday's";
        String x_label = "Rate of Return (-1)";
        String y_label = "Rate of Return";
        JFreeChart chart = ChartFactory.createScatterPlot(subtitle, x_label, y_label, dataset);
        chart.setBackgroundPaint(Color.WHITE);

        XYPlot plot = (XYPlot) chart.getPlot();
        plot.setBackgroundPaint(Color.LIGHT_GRAY);
        plot.setDomainGridlinePaint(Color.WHITE);
        plot.setRangeGridlinePaint(Color.WHITE);
        plot.setAxisOffset(new RectangleInsets(0.1, 0.1, 0.1, 0.1));
        plot.setDomainCrosshairVisible(true);
        plot.setRangeCrosshairVisible(true);

        XYItemRenderer r = plot.getRenderer();
        if (r instanceof XYLineAndShapeRenderer renderer) {
            renderer.setDrawSeriesLineAsPath(true);
        }

        ValueAxis axis = plot.getDomainAxis();
        ChartUtils.saveChartAsPNG(new File("chart3.png"), chart, 600, 600);
        return chart;
    }


    public static JFreeChart createHistogram(CategoryDataset dataset, String stockSymbol) throws IOException {
        String subtitle = stockSymbol + " Histogram of Rate of Return";
        String x_label = "Bin";
        String y_label = "Frequency";
        JFreeChart chart = ChartFactory.createBarChart(subtitle, x_label, y_label,dataset);
        chart.setBackgroundPaint(Color.WHITE);
        CategoryPlot categoryplot = (CategoryPlot) chart.getCategoryPlot();
        categoryplot.setBackgroundPaint(Color.lightGray);
        categoryplot.setRangeGridlinePaint(Color.WHITE);
        categoryplot.setAxisOffset(new RectangleInsets(5.0, 5.0, 5.0, 5.0));
        categoryplot.setDomainCrosshairVisible(true);
        categoryplot.setRangeCrosshairVisible(true);

        BarRenderer renderer1 = (BarRenderer) chart.getCategoryPlot().getRenderer();
        renderer1.setMaximumBarWidth(0.015);
        renderer1.setItemMargin(0.0);
        ChartUtils.saveChartAsPNG(new File("chart4.png"), chart, 800, 300);
        return chart;
    }



    // Notice: We have 7 charts

    // Notice! Find the Name of chart!! 要合适的名字
    //createLineChart--14.1
    //createTimeSeriesScatterChart--14.2
    //createScatterChart--14.3

//    public JPanel createDemoPanel(String stockSymbol) throws ParseException {
//        String stockSymbol2 = "SPY";
//        JFreeChart chart = createOLSLineChart(stockSymbol,stockSymbol2);// change here
//        //SetHistogramView(chart);
//        //JFreeChart chart1 = createLineChart(loadStockPriceData(stockSymbol2));
//        ChartPanel panel = new ChartPanel(chart, false);
//        panel.setFillZoomRectangle(true);
//        panel.setMouseWheelEnabled(true);
//        return panel;
//    }


    public static void main(String[] args) throws ParseException, IOException {
        String stockSymbol = "FB";   // Here stockSymbol is gotten from the UI
        String indexSymbol = "SPY";
        String title = "Chart";

        JFreeChart chart1 = ChartAPI.createLineChart(loadStockPriceData(stockSymbol),stockSymbol,"chart1",stockSymbol + " Adjusted Close Price", "Date", "Adjusted Close Price");
        JFreeChart chart2 = ChartAPI.createTimeSeriesScatterChart(loadStockReturnData(stockSymbol), stockSymbol);
        JFreeChart chart3 = ChartAPI.createScatterChart(loadReturnDataset_yesterday(stockSymbol), stockSymbol);
        JFreeChart chart4 = ChartAPI.createHistogram(loadFrequencyDataset(stockSymbol),stockSymbol);
        JFreeChart chart5 = ChartAPI.createLineChart(createCumReturnDataset(stockSymbol,indexSymbol),stockSymbol,"chart5", stockSymbol + " and " + indexSymbol + " Cumulative Returns", "Date", "Relative Price");
        JFreeChart chart6 = ChartAPI.createLineChart(createReturnDataset(stockSymbol,indexSymbol),stockSymbol,"chart6", "Daily Return of " + stockSymbol + " and " + indexSymbol, "Date", "Daily Returns");
        JFreeChart chart7 = ChartAPI.createOLSLineChart(stockSymbol,indexSymbol);
        //demo.pack();
        //UIUtilities.centerFrameOnScreen(demo);
        //demo.setVisible(true);
    }
}