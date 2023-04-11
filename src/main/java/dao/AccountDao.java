package dao;

import bean.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AccountDao {
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    public AccountDao(Connection con) {
        this.con = con;
    }
    
    public Account logAccount(String username, String password){
        Account sent = new Account();
        
        try {
            String sql = "SELECT * FROM accounts WHERE username = ? AND password = ?";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                sent.setId(rs.getInt("ACCOUNTID"));
                sent.setEmail(rs.getString("EMAIL"));
                sent.setFullname(rs.getString("FULLNAME"));
                sent.setUsername(rs.getString("USERNAME"));
                sent.setPassword(rs.getString("PASSWORD"));
                sent.setPhone(rs.getString("PHONE"));
                sent.setIc(rs.getString("IC"));
                sent.setGender(rs.getString("GENDER"));
                sent.setAge(rs.getInt("AGE"));
                return sent;
            }
            
            
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return null;
    }
    
    // add new user to database
    public boolean addAccount(Account ac){
        // if ic is null gender and age will be null
        try {
            String sql = "INSERT INTO accounts(email,fullname,username,password,phone,ic,citizen,gender,age) VALUES(?,?,?,?,?,?,?,?,?)";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, ac.getEmail());
            pstmt.setString(2, ac.getFullname());
            pstmt.setString(3, ac.getUsername());
            pstmt.setString(4, ac.getPassword());
            pstmt.setString(5, ac.getPhone());
            pstmt.setString(6, ac.getIc());
            pstmt.setString(7, ac.getCitizen());
            
            if (ac.getIc().equals("")) {
                ac.setGender("");
                ac.setAge(0);
                pstmt.setString(8, ac.getGender());
                pstmt.setInt(9, ac.getAge());
            } else {
                pstmt.setString(8, ac.getGender());
                pstmt.setInt(9, ac.getAge());
            }
            
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
    public boolean changePassword(String pass1, int accid){
        
        // if ic is null gender and age will be null
        try {
            String sql = "UPDATE accounts SET password = ? WHERE accountid = ?";
        
            PreparedStatement pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, pass1);
            pstmt.setInt(2, accid);
            
            ResultSet rs = pstmt.executeQuery();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(con,pstmt,rs);
        }
        
        return false;
    }
    
    
    
    // check duplication | Email,Username, IC
    public List isDuplicate(String email, String username, String ic){
        List error = new ArrayList();
        try {
            String sql = "SELECT * FROM accounts WHERE email = ? OR username = ? OR ic = ?";
        
            pstmt = this.con.prepareStatement(sql);
            
            pstmt.setString(1, email);
            pstmt.setString(2, username);
            pstmt.setString(3, ic);
            
            rs = pstmt.executeQuery();
            
            while(rs.next()){ 
                if (email.equals(rs.getString("EMAIL"))) {
                    error.add("<b>Email</b> already Exist in database");
                }
                if (username.equals(rs.getString("USERNAME"))) {
                    error.add("<b>Username</b> already Exist in database | Please Use another username");
                }
                if (ic.equals(rs.getString("IC"))) {
                    error.add("<b>IC</b> already Exist in database");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return error;
    }
    
    // checker
    public boolean checkPassword(String password1, String password2){
        if (password1.equals(password2)) {
            return true;
        }
        return false;
    }
    
    public boolean checkPhone(String phone){
        if (phone.length() == 10 || phone.length() == 11) {
            return true;
        }
        return false;
    }
    
    // ic checking
    public boolean checkIc(String ic){
        if (ic.equals("")) {
            return false;
        }
        
        if (ic.length() != 12) {
            return true;
        }
        return false;
    }
    
    public List isNull(String fullname, String email, String username, String phone, String password1, String password2){
        List error = new ArrayList();
        
        if (fullname.equals("")) {
            error.add("<b>Fullname</b> is null");
        }
        if (email.equals("")) {
            error.add("<b>Email</b> is null");
        }
        if (username.equals("")) {
            error.add("<b>Username</b> is null");
        }
        if (phone.equals("")) {
            error.add("<b>Phone</b> is null");
        }
        if (password1.equals("")) {
            error.add("<b>Password</b> is null");
        }
        
        if (!password1.equals(password2)) {
            error.add("<b>Password</b> is not same as previous");
        }
        return error;
    }
    
    public List isNull(Account acc){
        List error = new ArrayList();
        
        if (acc.getFullname().equals("")) {
            error.add("<b>Fullname</b> is null");
        }
        if (acc.getUsername().equals("")) {
            error.add("<b>Username</b> is null");
        }
        if (acc.getEmail().equals("")) {
            error.add("<b>Email</b> is null");
        }
        if (acc.getPhone().equals("")) {
            error.add("<b>Phone</b> is null");
        }
        
        
        return error;
    }
    
    public List isLogNull(String username, String password1){
        List error = new ArrayList();
        
        if (username.equals("")) {
            error.add("<b>Username</b> is null");
        }
        
        if (password1.equals("")) {
            error.add("<b>Password</b> is null");
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
