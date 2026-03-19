package dto;

import java.sql.Timestamp;

public class RuleDTO {

  private int id;
  private int homeId;
//  private int alert_id;
  private String name;
  private String triggerType;
//  private String condition_json;
//  private String action_json;
  private int priority;
  private int active;
  private Timestamp created_at;

  public RuleDTO() {
  }

  public RuleDTO(String name, int id, String trigger_type, int priority, int active) {
    this.name = name;
    this.id = id;
    this.triggerType = trigger_type;
    this.priority = priority;
    this.active = active;
  }

  public RuleDTO(int home_id, String name, String trigger_type, int priority, int active) {
    this.homeId = home_id;
    this.name = name;
    this.triggerType = trigger_type;
    this.priority = priority;
    this.active = active;
  }

  public RuleDTO(int id, int home_id, String name, String trigger_type, int priority, int active) {
    this.id = id;
    this.homeId = home_id;
    this.name = name;
    this.triggerType = trigger_type;
    this.priority = priority;
    this.active = active;
  }

  public RuleDTO(int id, int home_id, String name, String trigger_type, int priority, int active, Timestamp created_at) {
    this.id = id;
    this.homeId = home_id;
    this.name = name;
    this.triggerType = trigger_type;
    this.priority = priority;
    this.active = active;
    this.created_at = created_at;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getHomeId() {
    return homeId;
  }

  public void setHomeId(int homeId) {
    this.homeId = homeId;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getTriggerType() {
    return triggerType;
  }

  public void setTriggerType(String triggerType) {
    this.triggerType = triggerType;
  }

  public int getPriority() {
    return priority;
  }

  public void setPriority(int priority) {
    this.priority = priority;
  }

  public int getActive() {
    return active;
  }

  public void setActive(int active) {
    this.active = active;
  }

  public Timestamp getCreated_at() {
    return created_at;
  }

  public void setCreated_at(Timestamp created_at) {
    this.created_at = created_at;
  }
}
