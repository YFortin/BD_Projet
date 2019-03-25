use memeber
drop table IF EXISTS memes;

create table memes(	
	name varchar(100),
	url varchar(100),
	fid numeric(3,0) primary key
	);

