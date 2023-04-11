package bean;

public class Room {
    
    private int id;
    private String roomno;
    private String status;
    private int detailid;

    public Room() {
    }

    public String getRoomno() {
        return roomno;
    }

    public void setRoomno(String roomno) {
        this.roomno = roomno;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDetailid() {
        return detailid;
    }

    public void setDetailid(int detailid) {
        this.detailid = detailid;
    }

    @Override
    public String toString() {
        return "Room{" + "id=" + id + ", roomno=" + roomno + ", status=" + status + ", detailid=" + detailid + '}';
    }
    
}
