USE master;
GO

IF DB_ID('SmartHome') IS NOT NULL
BEGIN
    ALTER DATABASE SmartHome SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SmartHome;
END
GO

CREATE DATABASE SmartHome;
GO

USE SmartHome;
GO

-- =========================================================
-- 1. TẠO CÁC BẢNG (TABLES)
-- =========================================================

CREATE TABLE USERS (
    ID INT PRIMARY KEY IDENTITY(1, 1),
    USERNAME NVARCHAR(100) UNIQUE NOT NULL,
    PASSWORD VARCHAR(100) NOT NULL,
    FULL_NAME NVARCHAR(100) NOT NULL,
    EMAIL NVARCHAR(100) NOT NULL,
    ROLE NVARCHAR(50) NOT NULL,
    CREATE_AT DATETIME NOT NULL
);
GO

CREATE TABLE HOME (
    ID INT PRIMARY KEY IDENTITY(1, 1),
    CODE VARCHAR(20) UNIQUE NOT NULL,
    NAME NVARCHAR(50) NOT NULL,
    ADDRESS NVARCHAR(200) NOT NULL,
    STATUS BIT NOT NULL,
    CREATE_AT DATETIME NOT NULL
);
GO

CREATE TABLE HOMEMODE (
    ID INT PRIMARY KEY IDENTITY(1, 1),
    NAME NVARCHAR(100) NOT NULL,
    ACTIVE_FROM TIME NOT NULL,
    ACTIVE_TO TIME NOT NULL,
    STATUS BIT NOT NULL,
    HOME_ID INT NOT NULL,
    CONSTRAINT FK_HOME_MODE FOREIGN KEY (HOME_ID) REFERENCES HOME(ID)
);
GO

CREATE TABLE ROOM (
    ID INT PRIMARY KEY IDENTITY(1, 1),
    NAME NVARCHAR(100) NOT NULL,
    FLOOR INT NOT NULL,
    TYPE NVARCHAR(50) NOT NULL,
    STATUS BIT NOT NULL,
    HOME_ID INT NOT NULL,
    CONSTRAINT FK_HOME_ROOM FOREIGN KEY (HOME_ID) REFERENCES HOME(ID)
);
GO

CREATE TABLE DEVICE (
    ID INT PRIMARY KEY IDENTITY(1, 1),
    TYPE NVARCHAR(50) NOT NULL,
    SERIAL_NO VARCHAR(50) NOT NULL,
    VENDOR NVARCHAR(100) NOT NULL,
    STATUS BIT NOT NULL,
    LAST_SEEN_ST DATETIME NOT NULL,
    ROOM_ID INT NOT NULL,
    CONSTRAINT FK_ROOM_DEVICE FOREIGN KEY (ROOM_ID) REFERENCES ROOM(ID)
);
GO

CREATE TABLE RULES (
    ID INT PRIMARY KEY IDENTITY(1, 1),
    NAME NVARCHAR(100) NOT NULL,
    TRIGGER_TYPE VARCHAR(50) NOT NULL,
    CONDITION_JSON NVARCHAR(MAX),
    ACTION_JSON NVARCHAR(MAX),
    PRIORITY INT NOT NULL,
    STATUS BIT NOT NULL,
    CREATED_AT DATETIME NOT NULL,
    HOME_ID INT NOT NULL,
    CONSTRAINT FK_HOME_RULE FOREIGN KEY (HOME_ID) REFERENCES HOME(ID)
);
GO

CREATE TABLE ALERT (
    ID INT PRIMARY KEY IDENTITY(1, 1),
    TYPE NVARCHAR(50) NOT NULL,
    SEVERITY NVARCHAR(50) NOT NULL,
    STATUS NVARCHAR(20) NOT NULL,
    START_TS DATETIME NOT NULL,
    END_TS DATETIME NOT NULL,
    MESSAGE NVARCHAR(500) NOT NULL,
    CREATE_AT DATETIME NOT NULL,
    USER_ID INT,
    HOME_ID INT NOT NULL,
    DEVICE_ID INT NOT NULL,
    ROOM_ID INT NOT NULL,
    RULE_ID INT NOT NULL,
    CONSTRAINT FK_USER_ALERT FOREIGN KEY (USER_ID) REFERENCES USERS(ID),
    CONSTRAINT FK_HOME_ALERT FOREIGN KEY (HOME_ID) REFERENCES HOME(ID),
    CONSTRAINT FK_DEVICE_ALERT FOREIGN KEY (DEVICE_ID) REFERENCES DEVICE(ID),
    CONSTRAINT FK_ROOM_ALERT FOREIGN KEY (ROOM_ID) REFERENCES ROOM(ID),
    CONSTRAINT FK_RULE_ALERT FOREIGN KEY (RULE_ID) REFERENCES RULES(ID)
);
GO

CREATE TABLE EVENTLOG (
    ID INT PRIMARY KEY IDENTITY(1, 1),
    TYPE NVARCHAR(50) NOT NULL,
    VALUE NVARCHAR(255) NULL, 
    TS DATETIME NOT NULL,
    SOURCE VARCHAR(50) NOT NULL,
    CREATE_AT DATETIME NOT NULL,
    USER_ID INT NULL, 
    DEVICE_ID INT NOT NULL,
    CONSTRAINT FK_USER_LOG FOREIGN KEY (USER_ID) REFERENCES USERS(ID),
    CONSTRAINT FK_DEVICE_LOG FOREIGN KEY (DEVICE_ID) REFERENCES DEVICE(ID)
);
GO

CREATE TABLE ALERTACTION (
    ID INT PRIMARY KEY IDENTITY(1, 1),
    TYPE NVARCHAR(50) NOT NULL,
    NOTE NVARCHAR(MAX) NOT NULL,
    ACTION_TS DATETIME NOT NULL,
    USER_ID INT NOT NULL,
    ALERT_ID INT NOT NULL,
    CONSTRAINT FK_USER_ACTION FOREIGN KEY (USER_ID) REFERENCES USERS(ID),
    CONSTRAINT FK_ALERT_ACTION FOREIGN KEY (ALERT_ID) REFERENCES ALERT(ID)
);
GO

-- =========================================================
-- 2. INSERT DỮ LIỆU MẪU (SEED DATA)
-- =========================================================

INSERT INTO USERS (USERNAME, PASSWORD, FULL_NAME, EMAIL, ROLE, CREATE_AT) VALUES
(N'admin', '1', N'Le Van Thanh Nhan', 'Nhan@gmail.com', N'Admin', GETDATE()),
(N'viewer', '1', N'Ngo Minh Thuan', 'thuan@gmail.com', N'Viewer', GETDATE()),
(N'owner', '1', N'Huynh Nguyen Bao Khang', 'khang@gmail.com', N'Home Owner', GETDATE()),
(N'tech', '1', N'Pham Thi C', 'C@gmail.com', N'Technician', GETDATE());
GO

INSERT INTO HOME (CODE, NAME, ADDRESS, STATUS, CREATE_AT) VALUES
('H001', N'Nha Chinh', N'123 Le Loi, Quan 1, TP.HCM', 1, GETDATE()),
('H002', N'Nha Nghi Duong', N'45 Tran Phu, Nha Trang', 1, GETDATE()),
('H003', N'Nha Tro Sinh Vien', N'12 Vo Van Kiet, Can Tho', 1, GETDATE()),
('H004', N'Chung Cu Mini', N'78 Nguyen Hue, Đa Nang', 0, GETDATE());
GO

INSERT INTO HOMEMODE (NAME, ACTIVE_FROM, ACTIVE_TO, STATUS, HOME_ID) VALUES
(N'Morning Mode', '06:00:00', '09:00:00', 1, 1),
(N'Night Mode', '22:00:00', '06:00:00', 0, 2),
(N'Work Mode', '08:00:00', '17:00:00', 0, 3),
(N'Sleep Mode', '23:00:00', '07:00:00', 1, 4),
(N'Party Mode', '18:00:00', '23:59:00', 1, 4);
GO

INSERT INTO ROOM(NAME, FLOOR, TYPE, STATUS, HOME_ID) VALUES
('Bed room 1', 1, 'Bedroom', 1, 1),
('Bed room 2', 1, 'Bedroom', 0, 1),
('Living room', 0, 'Living room', 1, 2),
('Dining room', 0, 'Dining room', 0, 4);
GO

INSERT INTO DEVICE(TYPE, SERIAL_NO, VENDOR, STATUS, LAST_SEEN_ST, ROOM_ID) VALUES
('Smart Lock', 'SL-LL-6767ABC', 'LocknLock', 1, '2026-02-24 13:45:39', 2),
('Door Sensor', 'DS-LL-1234ABC', 'LocknLock', 1, '2026-02-24 06:32:22', 3),
('Smart Light', 'SL-DQ-QD6767', 'Lighter', 0, '2026-02-24 04:28:05', 4);
GO

INSERT INTO RULES (HOME_ID, NAME, TRIGGER_TYPE, CONDITION_JSON, ACTION_JSON, PRIORITY, STATUS, CREATED_AT) VALUES
(1, N'Door left open', 'Duration', N'{"event_type": "DoorOpen", "duration_minutes": 15}', N'{"alert_type": "Security", "severity": "Medium", "message": "Door left opened more than 15 minutes"}', 2, 1, GETDATE()),
(1, N'Door open in Away/Night', 'ModeViolation', N'{"event_type": "DoorOpen", "forbidden_modes": ["Away", "Night"]}', N'{"alert_type": "Security", "severity": "High", "message": "Door opened at night or away"}', 1, 1, GETDATE()),
(1, N'Light on too long', 'Duration', N'{"event_type": "LightOn", "duration_minutes": 120}', N'{"alert_type": "Operation", "severity": "Low", "message": "Light on for more than 2 hours"}', 3, 1, GETDATE()),
(1, N'Device disconnected', 'HealthCheck', N'{"max_offline_minutes": 60}', N'{"alert_type": "Operation", "severity": "Medium", "message": "Device unsignal for more than an hour"}', 2, 1, GETDATE()),
(1, N'Repeated unlock failures', 'Frequency', N'{"event_type": "UnlockFailed", "count_threshold": 3, "time_window_minutes": 5}', N'{"alert_type": "Security", "severity": "High", "message": "Detected multiple failed unlock attempts"}', 1, 1, GETDATE());
GO

INSERT INTO ALERT (TYPE, SEVERITY , STATUS, START_TS, END_TS, MESSAGE, CREATE_AT, USER_ID, HOME_ID, DEVICE_ID, ROOM_ID, RULE_ID) VALUES
('Security', 'High', 'Open', '2026-02-24 04:18:02','2026-02-24 04:18:02', N'Canh bao: Phat hien cua mo trai phep trong che do Night', GETDATE(), 1, 1, 1, 3, 2),
('Security', 'High', 'Lock', '2026-02-24 04:10:23','2026-02-24 04:16:57', N'Canh bao: Thu mo hoa that bai nhieu lan', GETDATE(), 1, 1, 2, 3, 5);
GO

INSERT INTO EVENTLOG (DEVICE_ID, TYPE, VALUE, TS, USER_ID, SOURCE, CREATE_AT) VALUES
(1, 'DoorOpen', NULL, '2023-10-26 07:30:00', NULL, 'Sensor', GETDATE()),
(1, 'DoorClose', NULL, '2023-10-26 07:35:00', NULL, 'Sensor', GETDATE()),
(2, 'LightOn', 'Brightness: 100%', '2023-10-26 18:00:00', 2, 'Manual', GETDATE()),
(2, 'Heartbeat', 'Battery: 85%', '2023-10-26 18:15:00', NULL, 'Sensor', GETDATE()),
(3, 'Unlock', 'Failed - Wrong PIN', '2023-10-26 22:30:00', NULL, 'Sensor', GETDATE()),
(2, 'LightOff', NULL, '2023-10-26 23:00:00', NULL, 'Schedule', GETDATE());
GO

INSERT INTO ALERTACTION(ALERT_ID, USER_ID, TYPE, NOTE, ACTION_TS) VALUES
(1, 2, 'Ack', N'Notification read, checking camera.', '2023-10-26 08:00:00'),
(1, 2, 'Comment', N'Door left open on purpose, no security problem.', '2023-10-26 08:05:00'),
(1, 2, 'Close', N'Door safely closed.', '2023-10-26 08:10:00'),
(2, 3, 'Ack', N'Notification read, checking device battery.', '2023-10-27 09:00:00'),
(2, 3, 'Close', N'New battery changed.', '2023-10-27 15:30:00');
GO