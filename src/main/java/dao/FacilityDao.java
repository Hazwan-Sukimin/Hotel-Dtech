package dao;

import bean.Facility;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FacilityDao {
    Connection con;
    PreparedStatement pstmt;
    ResultSet rs;
    
    public FacilityDao(Connection con) {
        this.con = con;
    }
    
    public boolean addFacility(Facility f){
        try {
            String sql = "INSERT INTO facilities(name,type,icon) VALUES(?,?,?)";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, f.getName());
            pstmt.setString(2, f.getType());
            pstmt.setString(3, f.getIcon());
            
            ResultSet rs = pstmt.executeQuery();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return false;
    }
    
    // Update facility to database
    public boolean updateFacility(Facility f){
        try {
            String sql = "UPDATE facilities SET name = ?, type = ?, icon = ? WHERE facilityid = ?";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, f.getName());
            pstmt.setString(2, f.getType());
            pstmt.setString(3, f.getIcon());
            pstmt.setInt(4, f.getId());
            
            pstmt.executeUpdate();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return false;
    }
    
    // Update facility to database
    public boolean deleteFacility(String id){
        
        int facilityid = Integer.parseInt(id);
        try {
            String sql = "DELETE FROM facilities WHERE facilityid = ?";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setInt(1, facilityid);
            
            pstmt.executeUpdate();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return false;
    }
    
    // check Duplicate | email, phone
    public List isDuplicate(Facility f){
        List error = new ArrayList();
        try {
            String sql = "SELECT * FROM facilities WHERE name like %?%";
        
            pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, f.getName());
            
            rs = pstmt.executeQuery();
            
            while(rs.next()){ 
                if (f.getName().toLowerCase().equals(rs.getString("NAME").toLowerCase())) {
                    error.add("<b>Name</b> already Exist in database");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return error;
    }
    
    // check null
    public List isNull(Facility f){
        List error = new ArrayList();
        
        if (f.getName().equals("")) {
            error.add("<b>Name</b> is null");
        }
        if (f.getType().equals("")) {
            error.add("<b>Type</b> is null");
        }
        if (f.getIcon().equals("")) {
            error.add("<b>Icon</b> is null");
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
