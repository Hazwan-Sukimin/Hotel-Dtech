package dao;

import bean.Room;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDao {
    Connection con;
    PreparedStatement pstmt;
    ResultSet rs;
    
    public RoomDao(Connection con) {
        this.con = con;
    }
    
    // add room
    public boolean addRoom(Room r){
        try {
            String sql = "INSERT INTO rooms(roomno,status,categoryid) VALUES(?,?,?)";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, r.getRoomno());
            pstmt.setString(2, r.getStatus());
            pstmt.setInt(3, r.getDetailid());
            
            ResultSet rs = pstmt.executeQuery();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return false;
    }
    
    // Update room to database
    public boolean updateRoom(Room r){
        try {
            String sql = "UPDATE rooms SET roomno = ?, status = ?, categoryid = ? WHERE roomid = ?";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, r.getRoomno());
            pstmt.setString(2, r.getStatus());
            pstmt.setInt(3, r.getDetailid());
            pstmt.setInt(4, r.getId());
            
            pstmt.executeUpdate();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return false;
    }
    
    // delete staff information
    public boolean deleteRoom(String id){
        int roomid = Integer.parseInt(id);
        
        try {
            String sql = "DELETE FROM rooms WHERE roomid = ?";
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            pstmt.setInt(1, roomid);
            pstmt.executeUpdate();
            return true;
            
        } catch (Exception e) {
        }
        return false;
    }
    
    // check Duplicate
    public List isDuplicate(Room r){
        List error = new ArrayList();
        try {
            String sql = "SELECT * FROM rooms WHERE roomno = ? AND detailid = ?";
        
            pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, r.getRoomno());
            pstmt.setInt(2, r.getDetailid());
            
            rs = pstmt.executeQuery();
            
            while(rs.next()){ 
                if (r.getRoomno().toLowerCase().equals(rs.getString("ROOMNO").toLowerCase()) && r.getDetailid() == rs.getInt("DETAILID")) {
                    error.add("<b>Room</b> already Exist in database");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return error;
    }
    
    // check null
    public List isNull(Room r){
        List error = new ArrayList();
        
        if (r.getRoomno().equals("")) {
            error.add("<b>Room no</b> is null");
        }
        if (r.getStatus().equals("")) {
            error.add("<b>Status</b> is null");
        }
        if (r.getDetailid()==0) {
            error.add("<b>Detail</b> is null");
        }
        
        return error;
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
