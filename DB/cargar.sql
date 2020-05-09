DELETE FROM ROLE WHERE role_id in (1,2,3);

insert into role values(1, 'SuperUsuario');
insert into role values(2, 'Administrador');
insert into role values(3, 'Ciudadano');

delete from person where person_id in (116740597,374993233,231232123);
insert into person values (116740597,'Leiner','Castro','González','lcastro@msph.com','70197110');
insert into person values (374993233,'Antony','Oviedo','Alfaro','aoviedo@msph.com','70197110');
insert into person values (231232123,'John','Richmond','Solis','jrichmond@msph.com','70197110');

delete from department where Department_Id in (1,2,3);
INSERT INTO `smartmsph`.`department` (`Department_Id`, `DepartmentName`, `Person_Id`) VALUES ('2', 'Informatica', '116740597');
INSERT INTO `smartmsph`.`department` (`Department_Id`, `DepartmentName`, `Person_Id`) VALUES ('1', 'Recursos Humanos', '231232123');
INSERT INTO `smartmsph`.`department` (`Department_Id`, `DepartmentName`, `Person_Id`) VALUES ('3', 'Gestion Ambiental', '374993233');


delete from user where user_id in (1,2,3);
insert into user values (1,'lcastro','123456',116740597,1,1);
insert into user values (2,'aoviedo','123456',374993233,1,2);
insert into user values (3,'jrichmond','123456',231232123,1,1);


