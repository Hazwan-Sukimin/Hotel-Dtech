
<%@page import="dao.StaffDao"%>
<%@page import="bean.MyConnection"%>
<%@page import="bean.Staff"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>

<% 
    // get parameter from form
    String fullname = request.getParameter("fullname");
    out.println(fullname + "Update Staff");
    
//    
//    // JSON Declaration
    
//
    // Bean Object
    Staff st = new Staff();
    st.setId(id);
    st.setFullname(fullname);

    // Dao
    StaffDao sd = new StaffDao(MyConnection.getConnection());

    sd.updateStaff(st);
    request.setAttribute("errorMsgs", "Successfully Saved");

    // JSON 
    
%>