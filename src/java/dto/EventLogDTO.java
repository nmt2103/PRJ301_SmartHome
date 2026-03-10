/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 *
 * @author DELL
 */
public class EventLogDTO {
    private int id;
    private String type;
    private String value;
    private LocalTime TS;
    private String source;
    private LocalDate createAt;
    private UserDTO userId;
    private DeviceDTO deviceId;

    public EventLogDTO() {
    }

    public EventLogDTO(int id, String type, String value, LocalTime TS, String source, LocalDate createAt, UserDTO userId, DeviceDTO deviceId) {
        this.id = id;
        this.type = type;
        this.value = value;
        this.TS = TS;
        this.source = source;
        this.createAt = createAt;
        this.userId = userId;
        this.deviceId = deviceId;
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

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public LocalTime getTS() {
        return TS;
    }

    public void setTS(LocalTime TS) {
        this.TS = TS;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public LocalDate getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDate createAt) {
        this.createAt = createAt;
    }

    public UserDTO getUserId() {
        return userId;
    }

    public void setUserId(UserDTO userId) {
        this.userId = userId;
    }

    public DeviceDTO getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(DeviceDTO deviceId) {
        this.deviceId = deviceId;
    }
    
    
}
