package dto;

import java.sql.Timestamp;

public class RuleDTO {

  private int id;
  private int homeId;
  private String name;
  private String triggerType;
  private int priority;
  private boolean status;
  private Timestamp createdAt;

  public RuleDTO() {
  }

  public RuleDTO(String name, int id, String trigger_type, int priority, boolean status) {
    this.name = name;
    this.id = id;
    this.triggerType = trigger_type;
    this.priority = priority;
    this.status = status;
  }

  public RuleDTO(int home_id, String name, String trigger_type, int priority, boolean status) {
    this.homeId = home_id;
    this.name = name;
    this.triggerType = trigger_type;
    this.priority = priority;
    this.status = status;
  }

  public RuleDTO(int id, int home_id, String name, String trigger_type, int priority, boolean status) {
    this.id = id;
    this.homeId = home_id;
    this.name = name;
    this.triggerType = trigger_type;
    this.priority = priority;
    this.status = status;
  }

  public RuleDTO(int id, int home_id, String name, String trigger_type, int priority, boolean status, Timestamp createdAt) {
    this.id = id;
    this.homeId = home_id;
    this.name = name;
    this.triggerType = trigger_type;
    this.priority = priority;
    this.status = status;
    this.createdAt = createdAt;
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

  public boolean getStatus() {
    return status;
  }

  public void setStatus(boolean status) {
    this.status = status;
  }

  public Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Timestamp createdAt) {
    this.createdAt = createdAt;
  }
}
