package dto;

import java.sql.Time;

public class HomeModeDTO {

    private int id;
    private String name;
    private Time act_fr;
    private Time act_to;
    private boolean is_act;
    private HomeDTO homeId;

    public HomeModeDTO() {
    }

    public HomeModeDTO(int id, String name, Time act_fr, Time act_to, boolean is_act, HomeDTO homeId) {
        this.id = id;
        this.name = name;
        this.act_fr = act_fr;
        this.act_to = act_to;
        this.is_act = is_act;
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

    public boolean isIs_act() {
        return is_act;
    }

    public void setIs_act(boolean is_act) {
        this.is_act = is_act;
    }

    public HomeDTO getHomeId() {
        return homeId;
    }

    public void setHomeId(HomeDTO homeId) {
        this.homeId = homeId;
    }
}
