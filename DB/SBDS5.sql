-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema smartmsph
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `smartmsph` ;

-- -----------------------------------------------------
-- Schema smartmsph
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `smartmsph` DEFAULT CHARACTER SET utf8 ;
USE `smartmsph` ;

-- -----------------------------------------------------
-- Table `smartmsph`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smartmsph`.`person` ;

CREATE TABLE IF NOT EXISTS `smartmsph`.`person` (
  `Person_Id` BIGINT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `LastName1` VARCHAR(50) NOT NULL,
  `LastName2` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(50) NULL DEFAULT NULL,
  `phoneNumber` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`Person_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_UNIQUE` ON `smartmsph`.`person` (`Person_Id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `smartmsph`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smartmsph`.`department` ;

CREATE TABLE IF NOT EXISTS `smartmsph`.`department` (
  `Department_Id` SMALLINT NOT NULL,
  `DepartmentName` VARCHAR(45) NOT NULL,
  `Person_Id` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`Department_Id`),
  CONSTRAINT `fk_Department_Person1`
    FOREIGN KEY (`Person_Id`)
    REFERENCES `smartmsph`.`person` (`Person_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_UNIQUE` ON `smartmsph`.`department` (`Department_Id` ASC) VISIBLE;

CREATE UNIQUE INDEX `DepartmentName_UNIQUE` ON `smartmsph`.`department` (`DepartmentName` ASC) VISIBLE;

CREATE INDEX `fk_Department_Person1_idx` ON `smartmsph`.`department` (`Person_Id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `smartmsph`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smartmsph`.`role` ;

CREATE TABLE IF NOT EXISTS `smartmsph`.`role` (
  `Role_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Role_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `smartmsph`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smartmsph`.`user` ;

CREATE TABLE IF NOT EXISTS `smartmsph`.`user` (
  `User_Id` SMALLINT NOT NULL,
  `UserName` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Person_id` BIGINT NULL DEFAULT NULL,
  `Role_id` SMALLINT NOT NULL,
  `department_id` SMALLINT NULL DEFAULT NULL,
  `photo` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`User_Id`),
  CONSTRAINT `fk_department_user_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `smartmsph`.`department` (`Department_Id`),
  CONSTRAINT `fk_person_user_Person`
    FOREIGN KEY (`Person_id`)
    REFERENCES `smartmsph`.`person` (`Person_Id`),
  CONSTRAINT `fk_User_Role1`
    FOREIGN KEY (`Role_id`)
    REFERENCES `smartmsph`.`role` (`Role_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_UNIQUE` ON `smartmsph`.`user` (`User_Id` ASC) VISIBLE;

CREATE UNIQUE INDEX `UserName_UNIQUE` ON `smartmsph`.`user` (`UserName` ASC) VISIBLE;

CREATE INDEX `fk_citizen_user_citizen1_idx` ON `smartmsph`.`user` (`Person_id` ASC) VISIBLE;

CREATE INDEX `fk_User_Role1_idx` ON `smartmsph`.`user` (`Role_id` ASC) VISIBLE;

CREATE INDEX `fk_department_user_department_idx` ON `smartmsph`.`user` (`department_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `smartmsph`.`complain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smartmsph`.`complain` ;

CREATE TABLE IF NOT EXISTS `smartmsph`.`complain` (
  `Complain_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(10000) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `Person_Id` BIGINT NULL DEFAULT NULL,
  `User_id` SMALLINT NULL DEFAULT NULL,
  `employee` VARCHAR(200) NOT NULL,
  `employee_name` VARCHAR(200) NULL DEFAULT NULL,
  `Department_Id` SMALLINT NULL DEFAULT NULL,
  `fecha` DATETIME NOT NULL,
  `Answer` VARCHAR(10000) NULL DEFAULT NULL,
  `Departmet_idR` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`Complain_id`),
  CONSTRAINT `fk_complain_department1`
    FOREIGN KEY (`Department_Id`)
    REFERENCES `smartmsph`.`department` (`Department_Id`),
  CONSTRAINT `fk_complain_Person`
    FOREIGN KEY (`Person_Id`)
    REFERENCES `smartmsph`.`person` (`Person_Id`),
  CONSTRAINT `fk_Deparmetr`
    FOREIGN KEY (`Departmet_idR`)
    REFERENCES `smartmsph`.`department` (`Department_Id`),
  CONSTRAINT `fk_User_complain1`
    FOREIGN KEY (`User_id`)
    REFERENCES `smartmsph`.`user` (`User_Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 35
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_complain_citizen1_idx` ON `smartmsph`.`complain` (`Person_Id` ASC) VISIBLE;

CREATE INDEX `fk_complain_department1_idx` ON `smartmsph`.`complain` (`Department_Id` ASC) VISIBLE;

CREATE INDEX `fk_User_complain1_idx` ON `smartmsph`.`complain` (`User_id` ASC) VISIBLE;

CREATE INDEX `fk_Deparmetr_idx` ON `smartmsph`.`complain` (`Departmet_idR` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `smartmsph`.`denounces`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smartmsph`.`denounces` ;

CREATE TABLE IF NOT EXISTS `smartmsph`.`denounces` (
  `Denounces_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(10000) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `Person_id` BIGINT NULL DEFAULT NULL,
  `User_id` SMALLINT NULL DEFAULT NULL,
  `Department_id` SMALLINT NULL DEFAULT NULL,
  `Photo` MEDIUMTEXT NULL DEFAULT NULL,
  `Latitud` VARCHAR(100) NULL DEFAULT NULL,
  `Longitud` VARCHAR(100) NULL DEFAULT NULL,
  `Date` DATETIME NULL DEFAULT NULL,
  `Answer` VARCHAR(10000) NULL DEFAULT NULL,
  PRIMARY KEY (`Denounces_id`),
  CONSTRAINT `fk_denounces_department1`
    FOREIGN KEY (`Department_id`)
    REFERENCES `smartmsph`.`department` (`Department_Id`),
  CONSTRAINT `fk_denounces_person`
    FOREIGN KEY (`Person_id`)
    REFERENCES `smartmsph`.`person` (`Person_Id`),
  CONSTRAINT `fk_User_Denounces`
    FOREIGN KEY (`User_id`)
    REFERENCES `smartmsph`.`user` (`User_Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 45
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_denounces_citizen1_idx` ON `smartmsph`.`denounces` (`Person_id` ASC) VISIBLE;

CREATE INDEX `fk_User_denounces_idx` ON `smartmsph`.`denounces` (`User_id` ASC) VISIBLE;

CREATE INDEX `fk_Department_denounces_idx` ON `smartmsph`.`denounces` (`Department_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `smartmsph`.`news`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smartmsph`.`news` ;

CREATE TABLE IF NOT EXISTS `smartmsph`.`news` (
  `News_Id` SMALLINT NOT NULL AUTO_INCREMENT,
  `descri` VARCHAR(1000) NOT NULL,
  `photo` MEDIUMTEXT NOT NULL,
  `titulo` VARCHAR(200) NULL DEFAULT NULL,
  `Date` DATETIME NULL DEFAULT NULL,
  `Active` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`News_Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 46
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `smartmsph`.`ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smartmsph`.`ticket` ;

CREATE TABLE IF NOT EXISTS `smartmsph`.`ticket` (
  `Ticket_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `Department_id` SMALLINT NULL DEFAULT NULL,
  `Ticketcol` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Ticket_id`),
  CONSTRAINT `fk_ticket_department1`
    FOREIGN KEY (`Department_id`)
    REFERENCES `smartmsph`.`department` (`Department_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_ticket_department1_idx` ON `smartmsph`.`ticket` (`Department_id` ASC) VISIBLE;

USE `smartmsph` ;

-- -----------------------------------------------------
-- procedure AllComplains
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`AllComplains`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AllComplains`(pstate varchar(20),pfrom varchar(20),pto varchar(20))
BEGIN



if pfrom  = '' or pto = '' then begin 

SELECT  c.Complain_id, c.employee_name, c.employee, c.state, c.Description, c.Answer,c.Person_Id,c.fecha, d.DepartmentName FROM smartmsph.complain c, smartmsph.department d 
where
c.state like concat('%',pstate,'%') 
AND d.Department_Id=c.Department_Id;

 
 end; else begin 
 
SELECT  c.Complain_id, c.employee_name, c.employee, c.state, c.Description, c.Answer,c.Person_Id,c.fecha, d.DepartmentName FROM smartmsph.complain c, smartmsph.department d 
where c.fecha >= pfrom and c.fecha <= pto 
AND c.state like concat('%',pstate,'%') 
AND d.Department_Id=c.Department_Id;
 
 end;
 end if;
 
SELECT COUNT(*)  newcomplaints  FROM complain where  state = 'Pendiente';

SELECT COUNT(*)  attendedcomplaints  FROM complain where  state= 'Procesada';

SELECT COUNT(*)  complaintsinprocess from complain where  state = 'En Proceso';


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CardData
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`CardData`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CardData`(user_id varchar(20))
BEGIN

SELECT COUNT(*) outstandingcomplaints  FROM complain where User_id = user_id and state = 'Pendiente';
SELECT COUNT(*)  attendedcomplaints FROM complain where User_id = user_id and state = 'Aceptada';

SELECT COUNT(*) outstandingdenounces from denounces where User_id = user_id and State = 'Pendiente';
SELECT COUNT(*) attendeddenounces from denounces where User_id = user_id and State = 'Aceptada';


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CardDataAdminDenounce
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`CardDataAdminDenounce`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CardDataAdminDenounce`(pDepartment_Id int)
BEGIN

SELECT COUNT(*)  newdenounces  FROM denounces where Department_Id = pDepartment_Id and State = 'Pendiente';
SELECT COUNT(*)  attendeddenounces  FROM denounces where Department_Id = pDepartment_Id and State = 'Procesada';
SELECT COUNT(*)  denouncesinprocess from denounces where Department_Id = pDepartment_Id and State = 'En Proceso';


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ComplainInsert
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`ComplainInsert`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ComplainInsert`(PDescription varchar(10000), Pstate varchar(45), PPerson_Id bigint,PUser_id smallint,Pemployee varchar(45),Pemployee_name varchar(45),PDepartment_Id smallint,Pfecha VARCHAR(200) )
BEGIN
INSERT INTO complain 
(Description
, state
, Person_Id
, User_id
, employee
, employee_name
, Department_Id
,fecha
,Departmet_idR
,Answer) VALUES (
PDescription
, Pstate
, PPerson_Id
, PUser_id
, Pemployee
, Pemployee_name
, PDepartment_Id
,CURDATE()
,1
,'');
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Complain_listfilter
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`Complain_listfilter`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Complain_listfilter`(Pdesde varchar(100),Phasta varchar(100),Pstate varchar(100),Pdepartment varchar(100), PUser_id SMALLINT)
BEGIN
if Pdesde  = '' or Phasta = '' then begin 
 select a.*,b.DepartmentName  from  smartmsph.complain a
 join department b ON a.Department_Id =b.department_Id
 where a.state like concat('%',Pstate,'%') and b.DepartmentName like concat('%',Pdepartment,'%')  and   a.User_id=PUser_id 
 ORDER BY a.Fecha desc;
 
 end; else begin 
  select a.*,b.DepartmentName  from  smartmsph.complain a
 join department b ON a.Department_Id =b.department_Id
 where a.fecha >= Pdesde and a.fecha<=Phasta and
 a.state like concat('%',Pstate,'%') and b.DepartmentName like concat('%', Pdepartment,'%')  and   a.User_id=PUser_id 
 ORDER BY a.Fecha desc;
 
 end;
 end if;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteComplain
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`DeleteComplain`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteComplain`(in PComplain_id smallint)
BEGIN
DELETE FROM complain
WHERE Complain_id =PComplain_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteComplains
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`DeleteComplains`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteComplains`(in PComplain_id smallint)
BEGIN
DELETE FROM complain
WHERE Complain_id =PComplain_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteDenounce
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`DeleteDenounce`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDenounce`(in PDenounce_id smallint)
BEGIN
DELETE FROM denounces
WHERE Denounces_id =PDenounce_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteDepartment
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`DeleteDepartment`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDepartment`(in PDepartment_Id smallint)
BEGIN
DELETE FROM department
WHERE Department_Id =PDepartment_Id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteNews
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`DeleteNews`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteNews`(IN PNews_Id smallint(20))
BEGIN
DELETE FROM news
WHERE News_Id =PNews_Id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DeleteUser
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`DeleteUser`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser`(in PUser_Id smallint)
BEGIN
DELETE FROM user
WHERE  User_Id=PUser_Id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Denounces_list
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`Denounces_list`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Denounces_list`(in PUser_id smallint)
BEGIN
SELECT a.Denounces_id,a.Description,a.Department_id ,a.State,a.Photo,a.Latitud,a.Longitud,b.DepartmentName FROM denounces a 
JOIN department b ON a.Department_Id = b.Department_Id
where User_id=PUser_id 
ORDER BY a.Date desc
;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure DepartmentList
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`DepartmentList`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DepartmentList`(pFilter varchar(200))
BEGIN
SELECT a.*,b.Name FROM smartmsph.department a
JOIN person b 
ON a.Person_Id=b.Person_Id
where a.DepartmentName like concat('%',pFilter,'%');

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure FuncioXDeparta
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`FuncioXDeparta`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `FuncioXDeparta`( IN Pdepa SMALLINT)
BEGIN
SELECT p.Name , p.LastName1, p.LastName2, p.Person_Id
FROM smartmsph.user u
INNER JOIN  smartmsph.person p
where u.department_id=Pdepa and p.Person_Id=u.Person_id ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ListDenouncesbyDepartment
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`ListDenouncesbyDepartment`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListDenouncesbyDepartment`(PDepartment_id smallint,pstate varchar(20),pfrom varchar(20),pto varchar(20))
BEGIN

if pfrom  = '' or pto = '' then begin 

SELECT * FROM smartmsph.denounces d, smartmsph.person p 
where d.Person_id=p.Person_Id and d.Department_id=PDepartment_id 
and d.State like concat('%',pstate,'%') ;
 
 end; else begin 
 
SELECT * FROM smartmsph.denounces d, smartmsph.person p 
where d.Date >= pfrom and d.Date <= pto 
AND d.Person_id=p.Person_Id and d.Department_id=PDepartment_id 
and d.State like concat('%',pstate,'%')  ;
 
 end;
 end if;

SELECT COUNT(*)  newdenounces  FROM denounces where Department_Id = pDepartment_Id and State = 'Pendiente';
SELECT COUNT(*)  attendeddenounces  FROM denounces where Department_Id = pDepartment_Id and State = 'Procesada';
SELECT COUNT(*)  denouncesinprocess from denounces where Department_Id = pDepartment_Id and State = 'En Proceso';










END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure NewInsert
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`NewInsert`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `NewInsert`(Pnew_Id smallint ,Pdescripcion varchar(10000), Pphoto MEDIUMTEXT, Ptitulo varchar(10000),Pexpired  varchar(20),pActive bit)
BEGIN
	IF Pnew_Id = 0 then
    begin 
    select Pexpired;
    insert into  news(descri,photo,titulo,Date,Active) values(Pdescripcion,Pphoto,Ptitulo,Pexpired,pActive);

    end ;
    else  begin 
		UPDATE news SET descri = Pdescripcion, photo = 		Pphoto, titulo = Ptitulo , Date = Pexpired, Active = pActive
        where News_Id = Pnew_Id;
    end;
end if;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ObtainComplainXid
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`ObtainComplainXid`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtainComplainXid`(PUser_id SMALLINT)
BEGIN
 select a.*,b.DepartmentName  from  smartmsph.complain a
 join department b ON a.Department_Id =b.department_Id
 where User_id=PUser_id 
 ORDER BY a.Fecha desc;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ObtainNews
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`ObtainNews`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtainNews`()
BEGIN
SELECT * FROM smartmsph.news where Active = 1 and  Date >= curdate()
order by Date;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ObtainRole
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`ObtainRole`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtainRole`()
BEGIN
SELECT * FROM smartmsph.role;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ObtainTicket
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`ObtainTicket`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtainTicket`(IN PDepartment_id SMALLINT,PTicketcol varchar(45))
BEGIN
INSERT INTO ticket (Department_id,Ticketcol) VALUES (PDepartment_id,PTicketcol);
SELECT * FROM smartmsph.ticket WHERE Ticket_id = (SELECT MAX(Ticket_id) FROM smartmsph.ticket);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure PersonbyId
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`PersonbyId`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PersonbyId`(Ppersonid bigint)
BEGIN
select * from smartmsph.person where Person_Id=Ppersonid;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SaveDenounce
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`SaveDenounce`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveDenounce`(pDenouce_id smallint ,PDescription varchar(10000), Pstate varchar(45),PPerson_id bigint,PUser_id smallint,PDepartment_id smallint,PPhoto MEDIUMTEXT,PLatitud varchar(100),PLongitud varchar(100))
BEGIN

if pDenouce_id = 0  then begin 
INSERT INTO denounces (
Description, 
State,
 Person_id, 
 User_id, 
 Department_id, 
 Photo,
 Latitud, 
 Longitud,
 Date,
 Answer) VALUES (PDescription
 ,Pstate
 ,PPerson_id
 ,PUser_id
 ,PDepartment_id
 ,PPhoto
 ,PLatitud
 ,PLongitud
 ,CURDATE()
 ,'');

end;
	else begin 
    update  denounces set Description=PDescription, Department_id=PDepartment_id, Photo=PPhoto, Latitud=PLatitud, Longitud=PLongitud,Date=CURDATE()  where Denounces_Id = pDenouce_id;
    
    end; 
 end if;



END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SaveDepartment
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`SaveDepartment`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SaveDepartment`(pDepartmet_Id smallint, pDepartmentName varchar(100),pPerson_Id INT)
BEGIN

if pDepartmet_Id = -1  then begin 



INSERT into department select  ifnull(max(Department_id),0) + 1
 ,pDepartmentName
 ,pPerson_Id
from department;

end;
	else begin 
    update  department set DepartmentName=pDepartmentName,
 Person_Id =  pPerson_Id  
    where Department_Id = pDepartmet_Id;
    
    end; 
 end if;



END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure TodoDepartamento
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`TodoDepartamento`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `TodoDepartamento`()
BEGIN
SELECT a.*,b.Name FROM smartmsph.department a JOIN person b ON a.Person_Id=b.Person_Id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateComplainbyAdmin
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`UpdateComplainbyAdmin`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateComplainbyAdmin`(PComplain_id smallint, PState varchar(45),PAnswer varchar(10000))
BEGIN
UPDATE complain
SET
state = PState,
Answer = PAnswer
WHERE Complain_id = PComplain_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateDenouncebyAdmin
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`UpdateDenouncebyAdmin`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDenouncebyAdmin`(PDenounces_id smallint,PState varchar(45),PDepartment_id smallint,PAnswer varchar(10000),pACT varchar(1))
BEGIN

if pACT = 'R' then begin 
UPDATE denounces 
SET
Department_id = PDepartment_id
WHERE Denounces_id = PDenounces_id;
end;
else begin 
UPDATE denounces 
SET
State = PState,
Answer = PAnswer
WHERE Denounces_id = PDenounces_id;
end;
end if;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure User_ChangePassword
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`User_ChangePassword`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `User_ChangePassword`(Puser_id varchar(100),Pnewpassword varchar(200),PCurrentPassword varchar(200))
BEGIN 

declare currentpassword varchar(200);

SELECT Password
INTO currentpassword
from user where User_id = Puser_id;

if  PCurrentPassword = currentpassword then begin 
	update user set Password = Pnewpassword where 
    User_Id = Puser_id;
end; else
 SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'La contraseña actual no coincide';
 begin
 end; 
end if;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UsersWithAll
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`UsersWithAll`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UsersWithAll`(pFilter varchar(200))
BEGIN
SELECT a.*,b.Name,b.LastName1,b.LastName2,b.Email,b.phoneNumber,c.DepartmentName
FROM user a 
JOIN person b ON a.Person_Id=b.Person_Id
LEFT JOIN department c ON a.department_id = c.Department_Id
WHERE a.Role_id <> 3 and b.Name like concat('%',pFilter,'%') 
or b.Person_Id like concat('%',pFilter,'%') 
;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UsuarioRegistro
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`UsuarioRegistro`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UsuarioRegistro`(Ppersona_id bigint, Pnombre varchar(100), Papellido1 varchar(100),
Papellido2 varchar(100),Pcorreo varchar(100), Ptelefono varchar(100), Pusuario_Id smallint, PnombreUsuario varchar(100),
Ppassword varchar(100), Prole smallint,  PDepartment smallint
)
BEGIN

insert into person values(Ppersona_id,Pnombre,Papellido1,Papellido2,Pcorreo,Ptelefono);

insert into user SELECT ifnull(MAX(User_Id),0) + 1
,PnombreUsuario
,Ppassword
,Ppersona_id
,Prole
,PDepartment,
null  
FROM user;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure VerifyCredentials
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`VerifyCredentials`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `VerifyCredentials`( IN Puser varchar(45), IN Ppassword varchar(45))
BEGIN
SELECT a.*,b.Name,b.LastName1,b.LastName2,b.Email,b.phoneNumber,c.DepartmentName
FROM user a 
JOIN person b ON a.Person_Id=b.Person_Id
LEFT JOIN department c ON a.department_id = c.Department_Id
 where a.UserName=Puser and a.Password = Ppassword;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure allUsers
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`allUsers`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `allUsers`()
BEGIN
select * from  smartmsph.user;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure funcionaryall
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`funcionaryall`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `funcionaryall`()
BEGIN
SELECT p.Name , p.LastName1, p.LastName2, p.Person_Id
FROM smartmsph.user u
, smartmsph.person p where u.Role_id=2 and   p.Person_Id=u.Person_Id; 
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getNewsFilter
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`getNewsFilter`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNewsFilter`(pExpired varchar(100),pfilter varchar(100))
BEGIN

if pExpired = '' then begin 
SELECT * FROM smartmsph.news where titulo like concat('%',pfilter,'%') order by Date; 
end; else begin 
SELECT * FROM smartmsph.news 
where Date = pExpired and titulo like concat('%',pfilter,'%') order by Date; 

end ;
end if;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure saveFuncionary
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`saveFuncionary`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveFuncionary`(puser_Id int,Ppersona_id bigint, Pnombre varchar(100), Papellido1 varchar(100),
Papellido2 varchar(100),Pcorreo varchar(100), Ptelefono varchar(100), Pusuario_Id smallint, PnombreUsuario varchar(100),
Ppassword varchar(100), Prole smallint,  PDepartment smallint
)
BEGIN

if puser_Id = -1 then begin

insert into person values(Ppersona_id,Pnombre,Papellido1,Papellido2,Pcorreo,Ptelefono);

insert into user SELECT ifnull(MAX(User_Id),0) + 1
,PnombreUsuario
,Ppassword
,Ppersona_id
,Prole
,PDepartment,
null  
FROM user;

 end; else begin 
 update Person set Name =  Pnombre 
                   ,LastName1 = Papellido1
                   ,LastName2 = Papellido2
                   ,Email	  =	Pcorreo
				   ,phoneNumber	= Ptelefono
                   where Person_Id = Ppersona_id;
                   
				update user set UserName  = PnombreUsuario
								,Password = Ppassword
                                ,Role_Id  = Prole
                                ,department_id = PDepartment
                                where Person_id = Ppersona_id
                                and User_Id = puser_Id;
 
 
  end; end if;



END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateComplain
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`updateComplain`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateComplain`( 
IN PComplain_id smallint(20),
IN PDescription varchar(200),
IN Pemployee varchar(45),
IN Pemployee_name varchar(45),
IN PDepartment_Id smallint,
IN Pfecha varchar(200)
)
BEGIN
UPDATE complain 
SET
Description = PDescription,
employee = Pemployee,
employee_name = Pemployee_name,
Department_Id=PDepartment_Id,
fecha= Pfecha

WHERE Complain_id = PComplain_id ;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateDepartment
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`updateDepartment`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateDepartment`( 
IN PDepartment_Id SMALLINT(20),
IN PDepartmentName VARCHAR(45),
IN PPerson_Id BIGINT(20) 
)
BEGIN

UPDATE department 
SET
DepartmentName = PDepartmentName,
Person_Id = PPerson_Id
WHERE Department_Id = PDepartment_Id ;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure user_savePhoto
-- -----------------------------------------------------

USE `smartmsph`;
DROP procedure IF EXISTS `smartmsph`.`user_savePhoto`;

DELIMITER $$
USE `smartmsph`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_savePhoto`(puser_id varchar(100),Pphoto MEDIUMTEXT)
BEGIN
update user set photo = Pphoto where user_id = puser_id;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
