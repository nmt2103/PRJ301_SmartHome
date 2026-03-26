package dto;

import java.sql.Time;

public class HomeModeDTO {

    private int id;
    private String name;
    private Time act_fr;
    private Time act_to;
    private boolean status;
    private HomeDTO homeId;

    public HomeModeDTO() {
    }

    public HomeModeDTO(int id, String name, Time act_fr, Time act_to, boolean status, HomeDTO homeId) {
        this.id = id;
        this.name = name;
        this.act_fr = act_fr;
        this.act_to = act_to;
        this.status = status;
        this.homeId = homeId;
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

    public Time getAct_fr() {
        return act_fr;
    }

    public void setAct_fr(Time act_fr) {
        this.act_fr = act_fr;
    }

    public Time getAct_to() {
        return act_to;
    }

    public void setAct_to(Time act_to) {
        this.act_to = act_to;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public HomeDTO getHomeId() {
        return homeId;
    }

    public void setHomeId(HomeDTO homeId) {
        this.homeId = homeId;
    }
}
