package bean;

import java.util.Calendar;

public class Account {
    private int id;
    private String fullname;
    private String email;
    private String password;
    private String phone;
    private String username;
    private String ic;
    private String citizen;
    private String gender;
    private int age;

    public Account() {
    }

    public Account(int id, String fullname, String email, String password, String phone, String username, String ic, String citizen, String gender, int age) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.username = username;
        this.ic = ic;
        this.citizen = citizen;
        this.gender = gender;
        this.age = age;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getIc() {
        return ic;
    }

    public void setIc(String ic) {
        this.ic = ic;
    }
    
    // manipulate from ic
    public String getCitizen() {
        String ic = this.ic;
        
        if (ic == null || ic.trim().length() == 0) {
            return "no";
        }else{
            return "yes";
        }
    }

    public void setCitizen(String citizen) {
        this.citizen = citizen;
    }

    

    public void setGender(String gender) {
        this.gender = gender;
    }
    
    // manipulate from ic
    public int getAge() {
        
        if (this.ic.equals("")) {
            return 0;
        }
        // get ic 2 initial digits
        int first_two = Integer.parseInt(this.ic.substring(0,2));
        int year = Calendar.getInstance().get(Calendar.YEAR);
        int result = year - first_two;
        
        // change int to string
        String age = result+"";
        int ageSent = 0;
        if (age.substring(2,3).equals("0")) {
            ageSent = Integer.parseInt(age.substring(3));
        }
        
        ageSent = Integer.parseInt(age.substring(2));
        
        return ageSent;
    }
    
    // manipulate from ic
    public String getGender() {
        // get ic 2 initial digits
        
        if (this.ic.equals("")) {
            return "";
        }
        int last = Integer.parseInt(this.ic.substring(11));
        String gender = "";
        
        if (last%2==0) {
            gender = "female";
        } else {
            gender = "male";
        }
        
        return gender;
    }
    
    public String getGenderC() {
        return gender;
    }
    
    public int getAgeC() {
        return age;
    }
    
    public String getCitizenC() {
        return citizen;
    }
    
    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "Account{" + "id=" + id + ", fullname=" + fullname + ", email=" + email + ", password=" + password + ", phone=" + phone + ", username=" + username + ", ic=" + ic + ", citizen=" + citizen + ", gender=" + gender + ", age=" + age + '}';
    }
    
    
}
