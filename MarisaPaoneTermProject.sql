--DROP TABLE


CREATE TABLE Position (
  position_id DECIMAL(12),
  position_name VARCHAR(15),
  is_projectmanager_flag BOOLEAN,
PRIMARY KEY (position_id));
  
  
CREATE TABLE Employee (
  employee_id DECIMAL(12),
  position_id DECIMAL(12),
  first_name VARCHAR(64),
  last_name VARCHAR(64),
  email VARCHAR(255),
  password VARCHAR(255),
  phone_number DECIMAL(10),
PRIMARY KEY (employee_id),
FOREIGN KEY (position_id) REFERENCES Position);





CREATE TABLE Building (
  Building_id DECIMAL(12),
  Building_Address VARCHAR(255),
  Building_type VARCHAR(33),
  Front_Desk_Phone DECIMAL(10),
  Year_Built DECIMAL(4),
  Floor_Amt DECIMAL(3),
  Heating_Type VARCHAR(255),
  Cooling_Type VARCHAR(255),
  Building_manager_id DECIMAL(12),
  Tenant_id DECIMAL(12),
PRIMARY KEY (Building_id));


CREATE TABLE Building_Manager (
  BuildingManager_id DECIMAL(12),
  Building_id DECIMAL(12),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  phone_number DECIMAL(10),
  salary DECIMAL(6),
  is_assistant_flag BOOLEAN,
  Is_buildingMAN_flag BOOLEAN,
  Is_buildingENG_flag BOOLEAN,
  PRIMARY KEY (BuildingManager_id));


CREATE TABLE Employee_building (
  employee_ID DECIMAL(12),
  Building_ID DECIMAL(12),
FOREIGN KEY (employee_ID) REFERENCES Employee,
FOREIGN KEY (building_ID) REFERENCES Building);
  
CREATE TABLE Assistant_Building_Manager (
  BuildingManager_id DECIMAL(12) PRIMARY KEY,
  HighSchool_degree BOOLEAN,
FOREIGN KEY (BuildingManager_id) REFERENCES Building_Manager
);

CREATE TABLE Building_Manager_Position (
  BuildingManager_id DECIMAL(12) PRIMARY KEY,
  Undergrad_major VARCHAR(128),
FOREIGN KEY (BuildingManager_id) REFERENCES Building_Manager
);

CREATE TABLE `Building_Engineer` (
  BuildingManager_id DECIMAL(12) PRIMARY KEY,
  Masters_major VARCHAR(128),
FOREIGN KEY (BuildingManager_id) REFERENCES Building_Manager
);





CREATE TABLE Building_Manager (
  BuildingManager_id DECIMAL(12),
  Building_id DECIMAL(12),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  phone_number DECIMAL(10),
  salary DECIMAL(6),
  is_assistant_flag BOOLEAN,
  is_buildingMAN_flag BOOLEAN,
  Is_buildingENG_flag BOOLEAN,
  PRIMARY KEY (BuildingManager_id)
);