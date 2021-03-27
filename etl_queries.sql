drop table if exists income;
drop table if exists diversity;
drop table if exists unemployment;

create table income (
	county varchar(100),
	state varchar(2),
	population int,
	median_household_income int,
	primary key (county, state)
);

create table diversity (
	diversity_index decimal(10, 10),
	black float,
	native_am float,
	asian float,
	hawaiian float,
	mixed float,
	latinx float,
	white float,
	county varchar(100),
	state varchar(10),
	primary key (county, state)
);

create table unemployment (
	county varchar(100),
	state varchar(2),
	rate float,
	primary key (county, state)
);

