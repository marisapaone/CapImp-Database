DROP TABLE Position, Supervisor, Project_Manager,Employee,Tenant,Building_Manager,
Building,Employee_Building,Building_Manager_Position,Assistant_Building_Manager,Building_Engineer,
Office, Retail, Residential, Issue_name, Building_issue,Contractor, Contractor_issue,
Manufacturer, Building_issue_equipment, Equipment, equipment_type, Location, cooling_type,
heating_type; 

DROP SEQUENCE position_seq,employee_seq,building_seq,buildingmanager_seq,tenant_seq,issue_seq,
contractor_seq, manufacturer_seq, equipment_seq;


CREATE TABLE Position (
  position_id DECIMAL(12)PRIMARY KEY,
  position_name VARCHAR(15) NOT NULL,
  is_projectmanager_flag BOOLEAN NOT NULL
);
  
CREATE TABLE Supervisor (
  position_id DECIMAL(12) PRIMARY KEY,
  viewing_privileges BOOLEAN NOT NULL,
FOREIGN KEY (position_id) REFERENCES Position
);

CREATE TABLE Project_Manager (
  position_id DECIMAL(12) PRIMARY KEY,
  editing_privileges BOOLEAN NOT NULL,
FOREIGN KEY (position_id) REFERENCES Position
);
  
CREATE TABLE Employee (
  employee_id DECIMAL(12) NOT NULL,
  position_id DECIMAL(12) NOT NULL,
  first_name VARCHAR(64) NOT NULL,
  last_name VARCHAR(64) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255)NOT NULL,
  phone_number DECIMAL(10) NOT NULL,
PRIMARY KEY (employee_id),
FOREIGN KEY (position_id) REFERENCES Position);


CREATE TABLE Building_Manager (
  BuildingManager_id DECIMAL(12),
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  phone_number DECIMAL(10) NOT NULL,
  salary DECIMAL(6) NOT NULL,
  manager_type VARCHAR(1) NOT NULL,
PRIMARY KEY (BuildingManager_id)
);


CREATE TABLE Building (
  Building_id DECIMAL(12),
  Building_Address VARCHAR(255) NOT NULL,
  Building_type VARCHAR(33) NOT NULL,
  Front_Desk_Phone DECIMAL(10) NOT NULL,
  Year_Built DECIMAL(4),
  Floor_Amt DECIMAL(3),
  Building_manager_id DECIMAL(12) NOT NULL,
PRIMARY KEY (Building_id),
FOREIGN KEY (Building_manager_id) REFERENCES Building_Manager
);

CREATE TABLE Heating_type(
  heating_id DECIMAL(12) PRIMARY KEY,
  heating_type VARCHAR(255),
  building_id DECIMAL(12),
FOREIGN KEY (building_id) REFERENCES Building
);

CREATE TABLE Cooling_type(
  cooling_id DECIMAL(12) PRIMARY KEY,
  cooling_type VARCHAR(255),
  building_id DECIMAL(12),
FOREIGN KEY (building_id) REFERENCES Building
);

CREATE TABLE Tenant (
  Tenant_id DECIMAL(12) PRIMARY KEY,
  Tenant_name VARCHAR(255) NOT NULL,
  building_id DECIMAL(12) NOT NULL,
FOREIGN KEY (building_id) REFERENCES Building
);


CREATE TABLE Employee_building (
  employee_ID DECIMAL(12),
  Building_ID DECIMAL(12),
CONSTRAINT PK_Employee_building PRIMARY KEY (Employee_id, building_id),	
FOREIGN KEY (employee_ID) REFERENCES Employee,
FOREIGN KEY (building_ID) REFERENCES Building);
  
CREATE TABLE Assistant_Building_Manager (
  BuildingManager_id DECIMAL(12) PRIMARY KEY,
  HighSchool_degree BOOLEAN NOT NULL,
FOREIGN KEY (BuildingManager_id) REFERENCES Building_Manager
);

CREATE TABLE Building_Manager_Position (
  BuildingManager_id DECIMAL(12) PRIMARY KEY,
  Undergrad_degree BOOLEAN NOT NULL,
FOREIGN KEY (BuildingManager_id) REFERENCES Building_Manager
);

CREATE TABLE Building_Engineer (
  BuildingManager_id DECIMAL(12) PRIMARY KEY,
  Masters_degree BOOLEAN NOT NULL,
FOREIGN KEY (BuildingManager_id) REFERENCES Building_Manager
);



CREATE TABLE Office (
  Building_id DECIMAL(12) PRIMARY KEY,
  Office_sqft DECIMAL(12) NOT NULL,
FOREIGN KEY (Building_id) REFERENCES Building
);

CREATE TABLE Retail (
  Building_id DECIMAL(12) PRIMARY KEY,
  Retail_description VARCHAR(255) NOT NULL,
FOREIGN KEY (Building_id) REFERENCES Building
);

CREATE TABLE Residential (
  Building_id DECIMAL(12) PRIMARY KEY,
  Number_of_apts DECIMAL (4) NOT NULL,
FOREIGN KEY (Building_id) REFERENCES Building
);

CREATE TABLE Issue_name (
  Issue_id DECIMAL(12) PRIMARY KEY,
  name VARCHAR(64) NOT NULL
);

--May need to change FK 
CREATE TABLE Location (
  location_id DECIMAL(12) PRIMARY KEY,
  Location VARCHAR(64) NOT NULL,
FOREIGN KEY (location_id) REFERENCES (building_issue)
);



CREATE TABLE Building_Issue (
  Issue_id DECIMAL(12),
  Building_ID DECIMAL(12),
  description VARCHAR(255) NOT NULL,
  location_id DECIMAL(12) NOT NULL,
  Date_of_issue DATE NOT NULL,
  Date_resolved DATE,
CONSTRAINT PK_Building_Issue PRIMARY KEY (Issue_id, Building_id),
FOREIGN KEY (Issue_id) REFERENCES Issue_name,
FOREIGN KEY (building_id) REFERENCES Building,
FOREIGN KEY (location_id) REFERENCES Location
);


CREATE TABLE Contractor (
  contractor_id DECIMAL(12) PRIMARY KEY,
  conractor_name VARCHAR(64) NOT NULL,
  phone_number DECIMAL(10) NOT NULL
);

CREATE TABLE Contractor_Issue (
  contractor_id DECIMAL(12),
  issue_id DECIMAL(12),
  building_id DECIMAL(12),
CONSTRAINT PK_Contractor_Issue PRIMARY KEY (contractor_id, issue_id, building_id),
FOREIGN KEY (contractor_id) REFERENCES Contractor,
CONSTRAINT FK_Contractor_issue FOREIGN KEY (issue_id, building_id) REFERENCES Building_issue
);


CREATE TABLE Manufacturer (
  manufacturer_id DECIMAL(12) PRIMARY KEY,
  Manufacturer_name VARCHAR(64) NOT NULL,
  phone_number DECIMAL(10) NOT NULL
);

CREATE TABLE Equipment_Type(
  equipment_type_id DECIMAL(12) PRIMARY KEY,
  equipment_type VARCHAR(64)
);

CREATE TABLE Equipment (
  equipment_id DECIMAL(12) PRIMARY KEY,
  equipment_type_id DECIMAL(12) NOT NULL,
  equipment_abbrev VARCHAR(10),
  model_number VARCHAR(32),
  manufacturer_id DECIMAL(12),
FOREIGN KEY (manufacturer_id) REFERENCES Manufacturer,
FOREIGN KEY (equipment_type_id) REFERENCES Equipment_type
);


CREATE TABLE Building_Issue_Equipment (
  building_id DECIMAL(12),
  issue_id DECIMAL(12),
  equipment_id DECIMAL(12),
CONSTRAINT PK_Building_Issue_Equipment PRIMARY KEY (building_id, issue_id, equipment_id),
CONSTRAINT FK_Building_Issue_Equipment FOREIGN KEY (building_id, issue_id) REFERENCES Building_issue,
FOREIGN KEY (equipment_id) REFERENCES Equipment
);


CREATE SEQUENCE position_seq START WITH 1;
CREATE SEQUENCE employee_seq START WITH 1;
CREATE SEQUENCE building_seq START WITH 1;
CREATE SEQUENCE buildingmanager_seq START WITH 1;
CREATE SEQUENCE tenant_seq START WITH 1;
CREATE SEQUENCE issue_seq START WITH 1;
CREATE SEQUENCE contractor_seq START WITH 1;
CREATE SEQUENCE manufacturer_seq START WITH 1;
CREATE SEQUENCE equipment_seq START WITH 1;


