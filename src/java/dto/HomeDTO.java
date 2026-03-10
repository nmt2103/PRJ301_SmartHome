package dto;

import java.sql.Timestamp;

public class HomeDTO {

  private int id;
  private String code;
  private String name;
  private String address;
  private String status;
  private Timestamp created_at;

  public HomeDTO() {
  }

  public HomeDTO(int id, String code, String name, String address, String status, Timestamp created_at) {
    this.id = id;
    this.code = code;
    this.name = name;
    this.address = address;
    this.status = status;
    this.created_at = created_at;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getCode() {
    return code;
  }

  public void setCode(String code) {
    this.code = code;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public Timestamp getCreated_at() {
    return created_at;
  }

  public void setCreated_at(Timestamp created_at) {
    this.created_at = created_at;
  }
}
