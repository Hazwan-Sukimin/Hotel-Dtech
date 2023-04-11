package dao;

import bean.Detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DetailDao {
    Connection con;
    PreparedStatement pstmt;
    ResultSet rs;
    
    public DetailDao(Connection con) {
        this.con = con;
    }
    
    // add
    public boolean addDetail(Detail d){
        String suit = "";
        for (int i = 0; i < d.getSuitable().size(); i++) {
            suit += d.getSuitable().get(i) + ",";
        }
        try {
            String sql1 = "INSERT INTO categories(name,description,sqft,suitable,price,deposit,image) VALUES(?,?,?,?,?,?,?)";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql1);
            
            pstmt.setString(1, d.getName());
            pstmt.setString(2, d.getDescription());
            pstmt.setString(3, d.getSize());
            pstmt.setString(4, suit);
            pstmt.setString(5, d.getPrice());
            pstmt.setString(6, d.getDeposit());
            pstmt.setString(7, d.getImage());
            
            ResultSet rs = pstmt.executeQuery();
            
            String sql2 = "SELECT * FROM ( SELECT * FROM categories ORDER BY categoryid DESC ) WHERE ROWNUM <= 1";
            pstmt = this.con.prepareStatement(sql2);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                d.setId(rs.getInt("CATEGORYID"));
            }
            
            // insert facility id
            for (int i = 0; i < d.getFacility().size(); i++) {
                // converting string to int
                String sql3 = "INSERT INTO categoryfacilities(categoryid,facilityid) VALUES(?,?)";
                pstmt = this.con.prepareStatement(sql3);
                pstmt.setInt(1, d.getId());
                pstmt.setInt(2, (int) d.getFacility().get(i));
                
                rs = pstmt.executeQuery();
            }
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return false;
    }
    
    // update category
    public boolean updateCategory(Detail d){
        // check if suitable or facility is null
        
        try {
            String sql = "DELETE FROM categories WHERE categoryid = ?";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
//            pstmt.setInt(1, categoryid);
            
            pstmt.executeUpdate();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return false;
    }
    
    // Delete category to database
    public boolean deleteCategory(String id){
        
        int categoryid = Integer.parseInt(id);
        try {
            String sql = "DELETE FROM categories WHERE categoryid = ?";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setInt(1, categoryid);
            
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
    public List isDuplicate(Detail d){
        List error = new ArrayList();
        try {
            String sql = "SELECT * FROM details WHERE name = ?";
        
            pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, d.getName());
            
            rs = pstmt.executeQuery();
            
            while(rs.next()){ 
                if (d.getName().toLowerCase().equals(rs.getString("NAME").toLowerCase())) {
                    error.add("<b>Name</b> already Exist in database");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return error;
    }
    
    //check null
    public List isNull(Detail d){
        List error = new ArrayList();
        
        if (d.getName().equals("")) {
            error.add("<b>Name</b> is null");
        }
        if (d.getDescription().equals("")) {
            error.add("<b>Description</b> is null");
        }
        if (d.getSize().equals("")) {
            error.add("<b>Size</b> is null");
        }
        if (d.getPrice().equals("")) {
            error.add("<b>Price</b> is null");
        }
        if (d.getDeposit().equals("")) {
            error.add("<b>Deposit</b> is null");
        }
        if (d.getImage().equals("")) {
            error.add("<b>Image</b> is null");
        }
        if (d.getFacility().isEmpty()) {
            error.add("<b>Facility</b> at least 1");
        }
        if (d.getSuitable().isEmpty()) {
            error.add("<b>Suitable</b> at least 1");
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
