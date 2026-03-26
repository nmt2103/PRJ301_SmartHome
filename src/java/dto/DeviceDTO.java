package dto;

import java.sql.Timestamp;

public class DeviceDTO {

    private int id;
    private String type;
    private String serial;
    private String vendor;
    private boolean status;
    private Timestamp lastSeen;
    private RoomDTO roomId;

    public DeviceDTO() {
    }

    public DeviceDTO(int id, String type, String serial, String vendor, boolean status, Timestamp lastSeen, RoomDTO roomId) {
        this.id = id;
        this.type = type;
        this.serial = serial;
        this.vendor = vendor;
        this.status = status;
        this.lastSeen = lastSeen;
        this.roomId = roomId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public String getVendor() {
        return vendor;
    }

    public void setVendor(String vendor) {
        this.vendor = vendor;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Timestamp getLastSeen() {
        return lastSeen;
    }

    public void setLastSeen(Timestamp lastSeen) {
        this.lastSeen = lastSeen;
    }

    public RoomDTO getRoomId() {
        return roomId;
    }

    public void setRoomId(RoomDTO roomId) {
        this.roomId = roomId;
    }
}
