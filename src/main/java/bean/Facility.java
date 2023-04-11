package bean;

public class Facility {
    private int id;
    private String name;
    private String type;
    private String icon;

    public Facility() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    @Override
    public String toString() {
        String pass =   "Facility ID: " + id + 
                        "<br>Facility Name: " + name +
                        "<br>Facility Type: " + type + 
                        "<br>Facility Icon: " + icon;
        return pass;
    }
    
    
    
}
