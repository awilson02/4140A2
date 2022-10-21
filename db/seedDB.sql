use mydb;
-- filling tables
insert into parts543
    value( "p1", "wrench", "wrenches", 3.85, 60);

insert into parts543
    value( "p2", "beam", "Steal beam", 15, 75);

insert into parts543
    value( "p3", "screw", "long screw", 1, 300);

insert into clients543
    value( "c1", "Alex", "Halifax", "password", 0.0, "ready");
insert into clients543
    value( "c2", "Dal", "Halifax", "password", 0.0, "ready");
insert into clients543
    value( "c3", "MIT", "Boston", "password", 0.0, "ready");




-- doing Orders
insert into pos543
values("po1", curdate(), "processing", "c1");
insert into pos543
values("po2", curdate(), "processing", "c3");



insert into lines543
values("p1","l1","po1", NULL, 20);
insert into lines543
values("p2","l2","po1", NULL, 2);
insert into lines543
values("p3","l3","po1", NULL, 4);
insert into lines543
values("p2","l2","po2", NULL, 2);



-- selecting all tables
select * from clients543;
select * from pos543;
select * from parts543;
select * from lines543;