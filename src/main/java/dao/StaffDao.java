package dao;

import bean.Staff;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class StaffDao {
    Connection con;
    PreparedStatement pstmt;
    ResultSet rs;

    public StaffDao(Connection con) {
        this.con = con;
    }
    
    public Staff logStaff(Staff st){
        Staff sent = new Staff();
        try {
            String sql = "SELECT * FROM staffs WHERE staffid = ? AND password = ?";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setInt(1, st.getId());
            pstmt.setString(2, st.getPassword());
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                sent.setId(rs.getInt("STAFFID"));
                sent.setFullname(rs.getString("FULLNAME"));
                sent.setPassword(rs.getString("PASSWORD"));
                sent.setEmail(rs.getString("EMAIL"));
                sent.setPhone(rs.getString("PHONE"));
                sent.setAddress(rs.getString("ADDRESS"));
                sent.setPosition(rs.getString("POSITION"));
                sent.setStatus(rs.getString("STATUS"));
                sent.setManager(rs.getInt("MANAGER"));
                return sent;
            }

            
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            close(con,pstmt,rs);
        }
        
        return null;
    }
    
    // Change staff password
    public boolean changePassword(String pass1, int staffid){
        
        // if ic is null gender and age will be null
        try {
            String sql = "UPDATE staffs SET password = ? WHERE staffid = ?";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, pass1);
            pstmt.setInt(2, staffid);
            
            ResultSet rs = pstmt.executeQuery();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return false;
    }
    
    // add new user to database
    public boolean addStaff(Staff st){
        try {
            String sql = "INSERT INTO staffs(fullname,password,email,phone,address,position,status,manager) VALUES(?,?,?,?,?,?,?,?)";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, st.getFullname());
            pstmt.setString(2, st.getPassword());
            pstmt.setString(3, st.getEmail());
            pstmt.setString(4, st.getPhone());
            pstmt.setString(5, st.getAddress());
            pstmt.setString(6, st.getPosition());
            pstmt.setString(7, st.getStatus());
            pstmt.setInt(8, st.getManager());
            
            ResultSet rs = pstmt.executeQuery();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return false;
    }
    
    // add new user to database
    public boolean updateStaff(Staff st){
        try {
            String sql = "UPDATE staffs SET fullname = ?, email = ?, phone = ?, address = ?, position = ?, manager = ? WHERE staffid = ?";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, st.getFullname());
            pstmt.setString(2, st.getEmail());
            pstmt.setString(3, st.getPhone());
            pstmt.setString(4, st.getAddress());
            pstmt.setString(5, st.getPosition());
            pstmt.setInt(6, st.getManager());
            pstmt.setInt(7, st.getId());
            
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
    public boolean deleteStaff(String id){
        int staffid = Integer.parseInt(id);
        
        try {
            String sql = "DELETE FROM staffs WHERE staffid = ?";
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            pstmt.setInt(1, staffid);
            pstmt.executeUpdate();
            return true;
            
        } catch (Exception e) {
        }
        return false;
    }
    
    
    
    public List isNull(Staff st){
        List error = new ArrayList();
        
        if (st.getFullname().equals("")) {
            error.add("<b>Fullname</b> is null");
        }
        
        if (st.getEmail().equals("")) {
            error.add("<b>Email</b> is null");
        }
        
        if (st.getAddress().equals("")) {
            error.add("<b>Address</b> is null");
        }
        
        if (st.getPhone().equals("")) {
            error.add("<b>Phone</b> is null");
        }
        
        return error;
    }
    
    //check format | address, phone
    public List isFormat(Staff st){
        List error = new ArrayList();
        
        if (!(st.getPhone().length() > 9 && st.getPhone().length() < 12)) {
            error.add("<b>Phone</b> in wrong format");
        }
        return error;
    }
    
    // check Duplicate | email, phone
    public List isDuplicate(Staff st){
        List error = new ArrayList();
        try {
            String sql = "SELECT * FROM staffs WHERE email = ? OR phone = ?";
        
            pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, st.getEmail());
            pstmt.setString(2, st.getPhone());
            
            rs = pstmt.executeQuery();
            
            while(rs.next()){ 
                if (st.getEmail().equals(rs.getString("EMAIL"))) {
                    error.add("<b>Email</b> already Exist in database");
                }
                if (st.getPhone().equals(rs.getString("PHONE"))) {
                    error.add("<b>Phone</b> already Exist in database");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return error;
    }
    
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
