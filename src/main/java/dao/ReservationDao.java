package dao;

import bean.Reservation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReservationDao {
    Connection con;
    PreparedStatement pstmt;
    ResultSet rs;
    
    public ReservationDao(Connection con) {
        this.con = con;
    }
    
    public List disableDate(String roomid){
        // list all date using list
        List disableDate = new ArrayList();
        
        // Object to generate date list
        Reservation r = new Reservation();
        
        int id = Integer.parseInt(roomid);
        
        try {
            String sql = "SELECT * FROM reservations WHERE roomid = ?";
        
            pstmt = this.con.prepareStatement(sql);
            
            pstmt.setInt(1, id);
            
            rs = pstmt.executeQuery();
            
            while(rs.next()){
                r.setDateStart(rs.getString("DATESTART").substring(0,10));
                r.setDateEnd(rs.getString("DATEEND").substring(0,10));
                r.setTotalDay(rs.getInt("TOTAL_DAY"));
                
                List listDisableDates = r.dateList();
                for (int i = 0; i < listDisableDates.size(); i++) {
                    disableDate.add(listDisableDates.get(i));
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return disableDate;
    }
    
    public boolean deleteReservation(String id){
        try{
            // convert student id to int
            int reservationid = Integer.parseInt(id);
            
            // create sql to delete student
            String sql = "DELETE FROM reservations WHERE reservationid=?";
            
            // prepared statement
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            // pass
            pstmt.setInt(1, reservationid);
            
            // execute
            pstmt.executeUpdate();
            
            return true;
        } catch(Exception e){ 
            e.printStackTrace();
        } finally{
            close(con, pstmt, null);
        }
        return false;
    }
    
    public boolean addStaff(String sid, String rid){
        try{
            // convert student id to int
            int reservationid = Integer.parseInt(rid);
            int staffid = Integer.parseInt(sid);
            
            // create sql to delete student
            String sql = "UPDATE reservations SET staffid = ? WHERE reservationid = ?";
            
            // prepared statement
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            // pass
            pstmt.setInt(1, staffid);
            pstmt.setInt(2, reservationid);
            
            // execute
            pstmt.executeUpdate();
            
            return true;
        } catch(Exception e){ 
            e.printStackTrace();
        } finally{
            close(con, pstmt, null);
        }
        return false;
    }
    
    public boolean addReservation(Reservation r){
        // if ic is null gender and age will be null
        try {
            String sql = "INSERT INTO reservations(datestart,dateend,accountid,roomid,total_adult,total_child,total_day,total_price) VALUES(STR_TO_DATE(?, '%d/%m/%Y'),STR_TO_DATE(?, '%d/%m/%Y'),?,?,?,?,?,?)";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, r.getDateStart());
            pstmt.setString(2, r.getDateEnd());
            pstmt.setInt(3, r.getAccId());
            pstmt.setInt(4, r.getRoomId());
            pstmt.setInt(5, r.getTotalAdult());
            pstmt.setInt(6, r.getTotalChild());
            pstmt.setInt(7, r.getTotalDay());
            pstmt.setDouble(8, r.getTotalPrice());
            
            
            int rs = pstmt.executeUpdate();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        
        return false;
    }
    
    
    
    // close connection
    private void close(Connection conn, PreparedStatement stmt, ResultSet rs){
        try {
            if (rs != null) {
                rs.close();
            }
            
            if (stmt != null) {
                stmt.close();
            }
            
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {e.printStackTrace();}
    }
    
}
