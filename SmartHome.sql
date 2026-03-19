CREATE DATABASE SmartHome

USE SmartHome

CREATE TABLE HOME (
  ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
  CODE VARCHAR(20) UNIQUE,
  NAME NVARCHAR(50),
  ADDRESS NVARCHAR(200),
  STATUS NVARCHAR(20),
  CREATE_AT DATETIME
)

INSERT INTO HOME (CODE, NAME, ADDRESS, STATUS, CREATE_AT) VALUES
('H001', N'Nha Chinh', N'123 Le Loi, Quan 1, TP.HCM', N'ACTIVE', GETDATE()),
('H002', N'Nha Nghi Duong', N'45 Tran Phu, Nha Trang', N'ACTIVE', GETDATE()),
('H003', N'Nha Tro Sinh Vien', N'12 Vo Van Kiet, Can Tho', N'ACTIVE', GETDATE()),
('H004', N'Chung Cu Mini', N'78 Nguyen Hue, Đa Nang', N'INACTIVE', GETDATE());

CREATE TABLE USERS (
  ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
  USERNAME NVARCHAR(100) UNIQUE,
  PASSWORD VARCHAR(100),
  FULL_NAME NVARCHAR(100),
  EMAIL NVARCHAR(100),
  ROLE NVARCHAR(50),
  CREATE_AT DATETIME
)

INSERT INTO USERS (USERNAME, PASSWORD, FULL_NAME, EMAIL, ROLE, CREATE_AT) VALUES
(N'admin', '123456', N'Le Van Thanh Nhan', 'Nhan@gmail.com', N'Admin', GETDATE()),
(N'user01', '123456', N'Tran Thi A', 'A@gmail.com', N'Viewer', GETDATE()),
(N'user02', '123456', N'Nguyen Van B', 'B@gmail.com', N'Home Owner', GETDATE()),
(N'manager01', '123456', N'Pham Thi C', 'C@gmail.com', N'Techinician', GETDATE());

CREATE TABLE HOMEMODE (
  ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
  NAME NVARCHAR(100),
  ACTIVE_FROM TIME,
  ACTIVE_TO TIME,
  IS_ACTIVE BIT,
  HOME_ID INT,
  CONSTRAINT FK_HOME_MODE FOREIGN KEY (HOME_ID) REFERENCES HOME(ID)
)

INSERT INTO HOMEMODE (NAME, ACTIVE_FROM, ACTIVE_TO, IS_ACTIVE, HOME_ID) VALUES
(N'Morning Mode', '06:00:00', '09:00:00', 1, 1),
(N'Night Mode', '22:00:00', '06:00:00', 0, 2),
(N'Work Mode', '08:00:00', '17:00:00', 0, 3),
(N'Sleep Mode', '23:00:00', '07:00:00', 1, 4),
(N'Party Mode', '18:00:00', '23:59:00', 1, 4);

CREATE TABLE ROOM (
  ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
  NAME NVARCHAR(100),
  FLOOR INT,
  TYPE NVARCHAR(50),
  STATUS NVARCHAR(20),
  HOME_ID INT,
  CONSTRAINT FK_HOME_ROOM FOREIGN KEY (HOME_ID) REFERENCES HOME(ID)
)

INSERT INTO ROOM(NAME, FLOOR, TYPE, STATUS, HOME_ID) VALUES
('Phong Ngu', 1, 'BedRoom', 'Dang Hoat Dong', 1),
('Phong Ngu', 1, 'BedRoom', 'Ngung Hoat Dong', 1),
('Phong Khach', 0, 'Living Room', 'Dang Hoat Dong', 2), 
('Phong An', 0, 'Kitchen', 'Ngung Hoat Dong', 4);

CREATE TABLE DEVICE (
  ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
  TYPE NVARCHAR(50),
  SERIAL_NO VARCHAR(50),
  VENDOR NVARCHAR(100),
  STATUS NVARCHAR(20),
  LAST_SEEN_ST DATETIME,
  ROOM_ID INT,
  CONSTRAINT FK_ROOM_DEVICE FOREIGN KEY (ROOM_ID) REFERENCES ROOM(ID)
)

INSERT INTO DEVICE(TYPE, SERIAL_NO, VENDOR, STATUS, LAST_SEEN_ST, ROOM_ID) VALUES
('Smart Lock', 'SL-LL-6767ABC', 'Lock n Lock', 'Active', '2026-02-24 13:45:39', 2),
('Door Sensor', 'DS-LL-1234ABC', 'Lock n Lock', 'Active', '2026-02-24 06:32:22', 3),
('Smart Light', 'SL-DQ-QD6767', 'Dien Quang', 'Inactive', '2026-02-24 04:28:05', 4);

CREATE TABLE ALERT (
   ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
   TYPE NVARCHAR(50),
   SEVERITY NVARCHAR(50),
   STATUS NVARCHAR(20),
   START_TS DATETIME,
   END_TS DATETIME,
   MESSAGE NVARCHAR(500),
   CREATE_AT DATETIME,
   USER_ID INT,
   HOME_ID INT,
   DEVICE_ID INT,
   ROOM_ID INT,
   CONSTRAINT FK_USER_ALERT FOREIGN KEY (USER_ID) REFERENCES USERS(ID),
   CONSTRAINT FK_HOME_ALERT FOREIGN KEY (HOME_ID) REFERENCES HOME(ID),
   CONSTRAINT FK_DEVICE_ALERT FOREIGN KEY (DEVICE_ID) REFERENCES DEVICE(ID),
   CONSTRAINT FK_ROOM_ALERT FOREIGN KEY (ROOM_ID) REFERENCES ROOM(ID),
)

INSERT INTO ALERT (TYPE, SEVERITY , STATUS, START_TS, END_TS, MESSAGE, CREATE_AT, USER_ID, HOME_ID, DEVICE_ID, ROOM_ID) VALUES
('Security', 'High', 'Open', '2026-02-24 04:18:02','2026-02-24 04:18:02','Canh bao: Phat hien cua mo trai phep trong che do Night', GETDATE(), 1, 1, 1, 3),
('Security', 'High', 'Lock', '2026-02-24 04:10:23','2026-02-24 04:16:57','Canh bao: Thu mo hoa that bai nhieu lan', GETDATE() , 1, 1, 2, 3);

CREATE TABLE RULES (
  ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
  NAME NVARCHAR(100),
  TRIGGER_TYPE VARCHAR(50),
  CONDITION_JSON NVARCHAR(MAX),
  ACTION_JSON NVARCHAR(MAX),
  PRIORITY INT,
  ACTIVE BIT,
  CREATED_AT DATETIME,
  HOME_ID INT,
  ALERT_ID INT,
  CONSTRAINT FK_HOME_RULE FOREIGN KEY (HOME_ID) REFERENCES HOME(ID),
  CONSTRAINT FK_ALERT_RULE FOREIGN KEY (ALERT_ID) REFERENCES ALERT(ID),
)

INSERT INTO RULES (HOME_ID, ALERT_ID, NAME, TRIGGER_TYPE, CONDITION_JSON, ACTION_JSON, PRIORITY, ACTIVE, CREATED_AT) VALUES 
  (1, 1, N'Door left open', 'Duration', 
     N'{"event_type": "DoorOpen", "duration_minutes": 15}', 
     N'{"alert_type": "Security", "severity": "Medium", "message": "Door left opened more than 15 minutes"}', 
     2, 1, GETDATE()),
  (1, 1, N'Door open in Away/Night', 'ModeViolation', 
     N'{"event_type": "DoorOpen", "forbidden_modes": ["Away", "Night"]}', 
     N'{"alert_type": "Security", "severity": "High", "message": "Door opened at night or away"}', 
     1, 1, GETDATE()),
  (1, 2, N'Light on too long', 'Duration', 
     N'{"event_type": "LightOn", "duration_minutes": 120}', 
     N'{"alert_type": "Operation", "severity": "Low", "message": "Light on for more than 2 hours"}', 
     3, 1, GETDATE()),
  (1, 2, N'Device disconnected', 'HealthCheck', 
     N'{"max_offline_minutes": 60}', 
     N'{"alert_type": "Operation", "severity": "Medium", "message": "Device unsignal for more than an hour"}', 
     2, 1, GETDATE()),
  (1, 1, N'Repeated unlock failures', 'Frequency', 
     N'{"event_type": "UnlockFailed", "count_threshold": 3, "time_window_minutes": 5}', 
     N'{"alert_type": "Security", "severity": "High", "message": "Detected multiple failed unlock attempts"}', 
     1, 1, GETDATE());

CREATE TABLE EVENTLOG (
  ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
  TYPE NVARCHAR(20),
  VALUE VARCHAR(20),
  TS DATETIME,
  SOURCE VARCHAR(50),
  CREATE_AT DATETIME,
  USER_ID INT,
  DEVICE_ID INT,
  CONSTRAINT FK_USER_LOG FOREIGN KEY (USER_ID) REFERENCES USERS(ID),
  CONSTRAINT FK_DEVICE_LOG FOREIGN KEY (DEVICE_ID) REFERENCES DEVICE(ID)
)

INSERT INTO EVENTLOG (DEVICE_ID, TYPE, VALUE, TS, USER_ID, SOURCE, CREATE_AT) VALUES
  (1, 'DoorOpen', NULL, '2023-10-26 07:30:00', NULL, 'Sensor', GETDATE()),
  (1, 'DoorClose', NULL, '2023-10-26 07:35:00', NULL, 'Sensor', GETDATE()),
  (2, 'LightOn', 'Brightness: 100%', '2023-10-26 18:00:00', 2, 'Manual', GETDATE()),
  (2, 'Heartbeat', 'Battery: 85%', '2023-10-26 18:15:00', NULL, 'Sensor', GETDATE()),
  (3, 'Unlock', 'Failed - Wrong PIN', '2023-10-26 22:30:00', NULL, 'Sensor', GETDATE()),
  (2, 'LightOff', NULL, '2023-10-26 23:00:00', NULL, 'Schedule', GETDATE());

CREATE TABLE ALERTACTION (
  ID INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
  TYPE NVARCHAR(20),
  NOTE NVARCHAR(MAX),
  ACTION_TS DATETIME,
  USER_ID INT,
  ALERT_ID INT,
  CONSTRAINT FK_USER_ACTION FOREIGN KEY (USER_ID) REFERENCES USERS(ID),
  CONSTRAINT FK_ALERT_ACTION FOREIGN KEY (ALERT_ID) REFERENCES ALERT(ID)
)

INSERT INTO ALERTACTION(ALERT_ID, USER_ID, TYPE, NOTE, ACTION_TS) VALUES
  -- 1. Người dùng (VD: Home Owner - user_id = 2) ghi nhận (Ack) một cảnh báo an ninh (VD: alert_id = 1 là cửa mở quá lâu)
  (1, 2, 'Ack', N'Notification read, checking camera.', '2023-10-26 08:00:00'),
  -- 2. Người dùng thêm bình luận (Comment) để cập nhật tình trạng xử lý cho cảnh báo đó
  (1, 2, 'Comment', N'Door left open on purpose, no security problem.', '2023-10-26 08:05:00'),
  -- 3. Người dùng đóng cảnh báo (Close) sau khi vấn đề đã được giải quyết
  (1, 2, 'Close', N'Door safely closed.', '2023-10-26 08:10:00'),
  -- 4. Kỹ thuật viên (VD: Technician - user_id = 3) ghi nhận một cảnh báo vận hành (VD: alert_id = 2 là thiết bị offline)
  (2, 3, 'Ack', N'Notification read, checking device battery.', '2023-10-27 09:00:00'),
  -- 5. Kỹ thuật viên đóng cảnh báo sau khi đã khắc phục xong lỗi thiết bị
  (2, 3, 'Close', N'New battery changed.', '2023-10-27 15:30:00');