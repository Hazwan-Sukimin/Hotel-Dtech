package bean;

public class Staff {
    private int id;
    private String fullname;
    private String email;
    private String password;
    private String phone;
    private String address;
    private String position;
    private String status;
    private int manager;

    public Staff() {
    }

    public Staff(int id, String fullname, String email, String password, String phone, String address, String position, String status, int manager) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.position = position;
        this.status = status;
        this.manager = manager;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getManager() {
        return manager;
    }

    public void setManager(int manager) {
        this.manager = manager;
    }

    @Override
    public String toString() {
        return "Staff{" + "id=" + id + ", fullname=" + fullname + ", email=" + email + ", password=" + password + ", phone=" + phone + ", address=" + address + ", position=" + position + ", status=" + status + ", manager=" + manager + '}';
    }
    
    
    
    
}
