package bean;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class Reservation {
    private int id;
    private String dateStart;
    private String dateEnd;
    
    private int totalAdult;
    private int totalChild;
    private int totalDay;
    private double totalPrice;
    
    // Foreign Key
    private int accId;
    private int roomId;
    private int paymentId;
    private int staffId;

    public Reservation() {
    }
    
    public long countDay(){
        // make a format of date
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/M/yyyy");
        
        // convert string to localdate
        LocalDate dateStart = LocalDate.parse(this.dateStart,formatter);
        LocalDate dateEnd = LocalDate.parse(this.dateEnd,formatter);
        
        long numOfDaysBetween = ChronoUnit.DAYS.between(dateStart, dateEnd);
        
        return numOfDaysBetween;
    }
    
//    public static void main(String[] args) {
//        Reservation r = new Reservation();
//        r.dateStart = "20/3/2023";
//        r.dateEnd = "22/3/2023";
//        System.out.println(r.countDay());
//    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDateStart() {
        return dateStart;
    }

    public void setDateStart(String dateStart) {
        this.dateStart = dateStart;
    }

    public String getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(String dateEnd) {
        this.dateEnd = dateEnd;
    }

    public int getTotalAdult() {
        return totalAdult;
    }

    public void setTotalAdult(int totalAdult) {
        this.totalAdult = totalAdult;
    }

    public int getTotalChild() {
        return totalChild;
    }

    public void setTotalChild(int totalChild) {
        this.totalChild = totalChild;
    }

    public int getTotalDay() {
        return totalDay;
    }

    public void setTotalDay(int totalDay) {
        this.totalDay = totalDay;
    }

    public int getAccId() {
        return accId;
    }

    public void setAccId(int accId) {
        this.accId = accId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
    
    
    
    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }
    
    // process to list not available date
    public List dateList(){
        List disableDate = new ArrayList();
        
        String[] dateStarts = this.dateStart.split("-");
        String[] dateEnds = this.dateEnd.split("-");
        
        int dayStart = Integer.parseInt(dateStarts[2]);
        int monthStart = Integer.parseInt(dateStarts[1]);
        int yearStart = Integer.parseInt(dateStarts[0]);
        
        int dayEnd = Integer.parseInt(dateEnds[2]);
        int monthEnd = Integer.parseInt(dateEnds[1]);
        int yearEnd = Integer.parseInt(dateEnds[0]);
        
        LocalDate dateStart = LocalDate.of(yearStart,monthStart,dayStart);
        LocalDate dateEnd = LocalDate.of(yearEnd,monthEnd,dayEnd);
        
        
        for (int i = 0; i <= this.totalDay; i++) {
            disableDate.add(dateStart.plusDays(i));
        }
        
        return disableDate;
    }

    @Override
    public String toString() {
        return "Reservation{" + "id=" + id + ", dateStart=" + dateStart + ", dateEnd=" + dateEnd + ", totalAdult=" + totalAdult + ", totalChild=" + totalChild + ", totalDay=" + totalDay + ", totalPrice=" + totalPrice + ", accId=" + accId + ", roomId=" + roomId + ", paymentId=" + paymentId + ", staffId=" + staffId + '}';
    }
    
    
}
