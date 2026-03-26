package dto;

public class RoomDTO {

  private int id;
  private int homeId;
  private String name;
  private int floor;
  private String type;
  private boolean status;

  public RoomDTO() {
  }

  public RoomDTO(int id, String name, int floor, String type, boolean status) {
    this.id = id;
    this.name = name;
    this.floor = floor;
    this.type = type;
    this.status = status;
  }

  public RoomDTO(int homeId, int floor, String name, String type, boolean status) {
    this.homeId = homeId;
    this.name = name;
    this.floor = floor;
    this.type = type;
    this.status = status;
  }

  public RoomDTO(String name, int floor, String type, boolean status) {
    this.name = name;
    this.floor = floor;
    this.type = type;
    this.status = status;
  }

  public RoomDTO(int id, int homeId, String name, int floor, String type, boolean status) {
    this.id = id;
    this.homeId = homeId;
    this.name = name;
    this.floor = floor;
    this.type = type;
    this.status = status;
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

  public int getFloor() {
    return floor;
  }

  public void setFloor(int floor) {
    this.floor = floor;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public boolean isStatus() {
    return status;
  }

  public void setStatus(boolean status) {
    this.status = status;
  }
}
