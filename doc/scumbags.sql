
CREATE TABLE scumbags ( 
    zip         	varchar(5) NOT NULL,
    full_name   	varchar(254) NOT NULL,
    first_name  	varchar(254) NULL,
    last_name   	varchar(254) NULL,
    address_1   	varchar(254) NULL,
    address_2   	varchar(254) NULL,
    city        	varchar(254) NULL,
    state       	varchar(254) NULL,
    tn          	varchar(10) NULL,
    lat         	float NULL,
    long        	float NULL,
    image_url   	varchar(254) NULL,
    date_updated	date NOT NULL DEFAULT '0000-00-00',
    data_status 	varchar(25) NULL,
    PRIMARY KEY(zip,full_name,date_updated)
)
;
