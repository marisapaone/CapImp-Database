DROP TABLE Position, Supervisor, Project_Manager,Employee,Tenant,Building_Manager,
Building, Employee_Building, Building_Manager_Position, Assistant_Building_Manager,Building_Engineer,
Office, Retail, Residential, Issue_name, Building_issue,Contractor, Contractor_issue,
Manufacturer, Building_issue_equipment, Equipment, equipment_type, Location, cooling_type,
heating_type; 


DROP SEQUENCE position_seq,employee_seq,building_seq,buildingmanager_seq,tenant_seq,issue_seq,
contractor_seq, manufacturer_seq, equipment_seq, cooling_seq, heating_seq, location_seq, equipment_type_seq;



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
  Location VARCHAR(64) NOT NULL
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
CREATE SEQUENCE location_seq START WITH 1;
CREATE SEQUENCE Equipment_type_seq START WITH 1;
CREATE SEQUENCE Heating_seq START WITH 1;
CREATE SEQUENCE Cooling_seq START WITH 1;


--PROCEDURES--
--*******************************************--

CREATE OR REPLACE PROCEDURE AddPosition (position_name in VARCHAR, is_projectmanager_flag in BOOLEAN)
AS
$reusableproc$
BEGIN
	INSERT INTO Position (position_id, position_name, is_projectmanager_flag)
	VALUES (nextval('position_seq'), position_name, is_projectmanager_flag);
END;
$reusableproc$ LANGUAGE plpgsql

START TRANSACTION;
DO
	$$BEGIN
	CALL AddPosition ('project manager', TRUE);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$BEGIN
	CALL AddPosition ('supervisor', FALSE);
	END$$;
COMMIT TRANSACTION;

--********************************************--

CREATE OR REPLACE PROCEDURE AddEmployee (position_id IN DECIMAL, first_name in VARCHAR, last_name in VARCHAR, email in VARCHAR,
										 password in VARCHAR, phone_number in DECIMAL)
AS
$reusableproc$
BEGIN
	INSERT INTO Employee (employee_id, position_id, first_name, last_name, email, password, phone_number)
	VALUES (nextval('employee_seq'), position_id, first_name, last_name, email, password, phone_number);
END;
$reusableproc$ LANGUAGE plpgsql

START TRANSACTION;
DO
	$$BEGIN
	CALL AddEmployee (1, 'Marisa', 'Paone', 'marisa.paone@tfc.com', 'Sdke29!', 2129018089);
	END$$;
COMMIT TRANSACTION;
COMMIT;

CALL AddEmployee (1, 'Jordan', 'Siegal', 'jordan.siegal@tfc.com', 'Dajen@1', 2129012156);
CALL AddEmployee (1, 'Amina', 'Oshodi', 'amina.oshodi@tfc.com', 'Kamsbj*', 2129014552);
CALL AddEmployee (2, 'Jon', 'Sanneman', 'jon.sannema@tfc.com', 'Plsbnwn%22', 2129018954);
CALL AddEmployee (2, 'Kevin', 'Singleton', 'kevin.singleton@tfc.com', 'IRskn!', 2129014612);
CALL AddEmployee (1, 'Eli', 'Caulkins', 'eli.caulkins@tfc.com', 'AJdk#12', 2129013645);

--**************************************************--

--This procedure is to add the building and the building manager
CREATE OR REPLACE PROCEDURE AddBuildingANDManager (first_name in VARCHAR, last_name in VARCHAR, phone_number in DECIMAL, salary IN DECIMAL, 
												   Manager_type in VARCHAR, Building_Address IN VARCHAR, Building_type IN VARCHAR, Front_Desk_Phone IN DECIMAL, 
												   Year_built IN DECIMAL, Floor_Amt IN DECIMAL)
AS
$reusableproc$
BEGIN
	INSERT INTO Building_Manager (buildingmanager_id, first_name, last_name, phone_number, salary, manager_type)
	VALUES (nextval('buildingmanager_seq'), first_name, last_name, phone_number, salary, manager_type);
	
	INSERT INTO Building(Building_id, Building_Address, Building_type, Front_Desk_phone, Year_built, Floor_amt, building_manager_id)
	VALUES (nextval('building_seq'), Building_Address, Building_type, Front_Desk_phone, Year_built, Floor_amt, currval('buildingmanager_seq'));
END;
$reusableproc$ LANGUAGE plpgsql

START TRANSACTION;
DO
	$$BEGIN
	CALL AddBuildingANDManager ('Ronald', 'Comeau', 9172958198, 120000, 'E', '340 E 34th St', 'Residential', 2126895022, 1962, 17);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$BEGIN
	CALL AddBuildingANDManager ('Mark', 'Skidelsky', 7184408559, 98000, 'M', '45 Wall St', 'Residential', 2122693003, 1958, 28);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$BEGIN
	CALL AddBuildingANDManager ('Brandon', 'Ramroop', 3473080203, 90000, 'M', '46-15 Center Blvd', 'Residential & Retail', 7186066375, 2012, 40);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$BEGIN
	CALL AddBuildingANDManager ('Lyuben', 'Antonov', 6466605735, 110000, 'M', '47-20 Center Blvd', 'Residential', 7186069400, 2006, 32);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$BEGIN
	CALL AddBuildingANDManager ('Gjon', 'Uljic', 5165672182, 130000, 'E', '95 Horatio St', 'Residential & Retail', 2122427322, 1930, 10);
	END$$;
COMMIT TRANSACTION;


START TRANSACTION;
DO
	$$BEGIN
	CALL AddBuildingANDManager ('Marcin', 'Kaminski', 3474134655, 150000, 'E', '45-45 Center Blvd', 'Residential & Retail', 7186060570, 2013, 40);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$BEGIN
	CALL AddBuildingANDManager ('Jesus', 'Carlo', 3478026614, 80000, 'A', '46-10 Center Blvd', 'Residential', 7184408667, 2013, 25);
	END$$;
COMMIT TRANSACTION;

SELECT * FROM Building;

--**********************************************************************--

--for rollbacks
COMMIT;

CREATE OR REPLACE PROCEDURE AddBuildingIssue (building_id IN DECIMAL, name in VARCHAR, location in VARCHAR, 
											  description in VARCHAR, date_of_issue in DATE)
AS
$reusableproc$
BEGIN
	INSERT INTO Issue_name (issue_id, name)
	VALUES (nextval('issue_seq'), name);
	
	INSERT INTO Location(location_id, location)
	VALUES (nextval('location_seq'), location);
	
	INSERT INTO Building_Issue (Issue_id, building_id, location_id, description, date_of_issue)
	VALUES (currval('issue_seq'), building_id, currval('location_seq'), description, date_of_issue);
END;
$reusableproc$ LANGUAGE plpgsql


START TRANSACTION;
DO
	$$BEGIN
	CALL AddBuildingIssue (1, 'Roof Leak', '17th Floor Hallway by Stairwell', 'Slow drip only while raining, small 
						   possibility leak is coming from a drain pipe', CAST('06-MAY-2021' AS DATE));
	END$$;
COMMIT TRANSACTION;


CALL AddbuildingIssue(2, 'Cooling Tower Replacement', 'Roof', 'Exisiting cooling towers are 15 years old and are leaking by the basin. 
					  They need to be replaced or repaired.', CAST ('03-APR-2022' AS DATE));
					  
CALL AddBuildingIssue(3, 'Boiler Room Ventilation', 'Boiler Room', 'Boiler room temperature is exceeding 112 on summer days. Ventilation 
					  is needed to the room. Exhaust fan discharge is blocked by steam pipe.', CAST ('26-JUL-2022'AS DATE));
					  
CALL AddBuildingIssue(4, 'Electric BBQ Grills', 'Backyard', 'Owner would like to install electric bbq grills in the backyard for tenants
					  to use. Power is needed to this area as well as pavers.', CAST('15-MAY-2022' AS DATE));

CALL AddBuildingIssue(6, 'Hot Water Heater Flue Replacement', 'Penthouse MER', 'Penthouse hot water heaters have a flue going up the building 
					  that needs to be replaced due to corrosion.', CAST ('02-OCT-2022' AS DATE));
					  
CALL AddBuildingIssue(1, 'Roof Leak', 'Apartment 17D', 'Paint is chipping, wall is wet.', CAST('03-APR-2022' AS DATE));

SELECT * FROM Building_Issue;

-- PROCEDURE -- 

CREATE OR REPLACE PROCEDURE AddResolvedBuildingIssue (building_id IN DECIMAL, name in VARCHAR, location in VARCHAR, 
											  description in VARCHAR, date_of_issue in DATE, date_resolved in DATE)
AS
$reusableproc$
BEGIN
	INSERT INTO Issue_name (issue_id, name)
	VALUES (nextval('issue_seq'), name);
	
	INSERT INTO Location(location_id, location)
	VALUES (nextval('location_seq'), location);
	
	INSERT INTO Building_Issue (Issue_id, building_id, location_id, description, date_of_issue, date_resolved)
	VALUES (currval('issue_seq'), building_id, currval('location_seq'), description, date_of_issue, date_resolved);
END;
$reusableproc$ LANGUAGE plpgsql

-- INSERT STATEMENTS -- 

CALL AddResolvedBuildingIssue (1, 'Vacuum Pump Replacement', 'Basement MER', 'The vacuum pump has been leaking and 
							   needs to be replaced.', CAST ('02-APR-2022' AS DATE), CAST ('22-AUG-2022'AS DATE));

INSERT INTO assistant_building_manager (buildingmanager_id, highschool_degree)
VALUES (7, TRUE);

INSERT INTO building_manager_position (buildingmanager_id, undergrad_degree)
VALUES (2, TRUE), (3, FALSE), (4, FALSE);

INSERT INTO  building_engineer (buildingmanager_id, masters_degree)
VALUES (5, TRUE), (6, TRUE), (1, FALSE);



--QUERIES

-- tells us which building id has more than one issue
SELECT building.building_id
FROM Issue_name
JOIN Building_issue ON building_issue.issue_id = issue_name.issue_id
JOIN Building ON Building.building_id = Building_issue.building_id
GROUP BY building.building_id
HAVING COUNT (Building.building_id) > 1;


-- Tells us the issue names of the building with more than 1 issue.
SELECT name
FROM Issue_name
JOIN building_issue ON building_issue.issue_id = Issue_name.issue_id
WHERE (building_id) IN (SELECT building.building_id
						FROM Building_issue
						JOIN Building ON Building.building_id = Building_issue.building_id
						GROUP BY building.building_id
						HAVING COUNT (Building.building_id) > 1);


-- What is the building manager’s name of the buildings with more than 1 issue, and what are those issues?

SELECT issue_name.name, first_name, last_name
FROM Building_Manager
JOIN Building ON Building.building_manager_id = Building_Manager.buildingmanager_id
JOIN Building_Issue ON Building_Issue.building_id = Building.building_id
JOIN Issue_name ON Issue_name.issue_id = Building_issue.issue_id
WHERE (building_issue.building_id) IN (SELECT building.building_id
						FROM Building_issue
						JOIN Building ON Building.building_id = Building_issue.building_id
						GROUP BY building.building_id
						HAVING COUNT (Building.building_id) > 1);
						
-- How many roof leaks have their been at all of the buildings? 

SELECT *
FROM Building_Issue
JOIN Issue_name ON Issue_name.issue_id = building_issue.issue_id
WHERE name = 'Roof Leak';


-- What are the names of the building managers that have their undergrad or masters degrees and what is their salary?

SELECT first_name, last_name, manager_type, Salary, undergrad_degree, masters_degree
FROM Building_Manager
LEFT JOIN Building_Engineer ON Building_Engineer.buildingmanager_id = building_manager.buildingmanager_id
LEFT JOIN Building_Manager_Position ON Building_Manager_Position.buildingmanager_id = building_manager.buildingmanager_id
LEFT JOIN Assistant_Building_Manager ON Assistant_Building_Manager.buildingmanager_id = building_manager.buildingmanager_id
WHERE (undergrad_degree = TRUE) OR (masters_degree = TRUE);


-- what kind of building manager is ronald? 
SELECT Manager_type
FROM Building_manager
WHERE first_name = 'Ronald';


--What are the emails of all of the project managers?

CREATE OR REPLACE VIEW ProjectManagers AS
SELECT first_name, last_name, email, phone_number
FROM Employee
JOIN Position ON Position.position_id = Employee.position_id
WHERE position_name = 'project manager';

SELECT email 
FROM ProjectManagers;

--What are the phone numbers of the essential building managers that have either graduated highschool, college, or a masters program?

CREATE OR REPLACE VIEW EssentialBuildingManagers AS
SELECT first_name, last_name, manager_type, phone_number, highschool_degree, undergrad_degree, masters_degree
FROM Building_Manager
LEFT JOIN Building_Engineer ON Building_Engineer.buildingmanager_id = building_manager.buildingmanager_id
LEFT JOIN Building_Manager_Position ON Building_Manager_Position.buildingmanager_id = building_manager.buildingmanager_id
LEFT JOIN Assistant_Building_Manager ON Assistant_Building_Manager.buildingmanager_id = building_manager.buildingmanager_id
WHERE (highschool_degree = TRUE) OR (undergrad_degree = TRUE) OR (masters_degree = TRUE);

SELECT phone_number, first_name 
FROM EssentialBuildingManagers;

--**************************************--

--INDEXES--

CREATE INDEX EmployeePositionIdx
ON Employee(position_id);

CREATE INDEX BuildingBldgManagerIdx
ON Building(Building_Manager_id);

CREATE INDEX BuildingIssueLocationIdx
ON Building_Issue(location_id);

CREATE INDEX EquipmentEquipTypeIdx
ON Equipment(Equipment_Type_id);

CREATE INDEX EquipmentManufacturerIdx
ON Equipment(Manufacturer_id);

CREATE INDEX HeatingBuildingIdx
ON Heating_type(building_id);

CREATE INDEX CoolingBuildingIdx
ON Cooling_type(building_id);

CREATE INDEX TenantBuildingIdx
ON Tenant(building_id);

CREATE INDEX IssueNameNameIdx
ON Issue_name(name);

CREATE UNIQUE INDEX BuildingManagerPhoneIdx
ON Building_Manager(phone_number);

CREATE UNIQUE INDEX EmployeeEmailIdx
ON Employee(email);

CREATE UNIQUE INDEX BuildingIssueDateResolvedIdx
ON Building_Issue (Date_resolved);
