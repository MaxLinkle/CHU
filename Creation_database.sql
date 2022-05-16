-- Creating database
create database if not exists projet_chu;
use projet_chu;

-- Creating fact table HosCo
create table if not exists fact_hosco(
    id_patient int,
    nb_consultation int,
    nb_hospitalisation int
)
comment 'Fact table HosCo'
row format delimited 
fields terminated by ';'
stored as textfile
location '/user/cloudera/CHU/Fact_HosCo'

-- 