package bean;

import java.util.ArrayList;
import java.util.List;

public class Detail {
    private int id;
    private String name;
    private String description;
    private String size;
    private ArrayList suitable;
    private String price;
    private String deposit;
    private ArrayList facility;
    private String image;

    public Detail() {
    }

    public ArrayList getFacility() {
        return facility;
    }
    
    public void setFacility(ArrayList facility) {
        this.facility = facility;
    }

    public ArrayList getSuitable() {
        return suitable;
    }

    public void setSuitable(ArrayList suitable) {
        this.suitable = suitable;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDeposit() {
        return deposit;
    }

    public void setDeposit(String deposit) {
        this.deposit = deposit;
    }

    @Override
    public String toString() {
        return "Detail{" + "id=" + id + ", name=" + name + ", description=" + description + ", size=" + size + ", suitable=" + suitable + ", price=" + price + ", deposit=" + deposit + ", facility=" + facility + ", image=" + image + '}';
    }

    
    
    

}
