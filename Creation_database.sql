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

-- Creating dimension table RDV
CREATE TABLE IF NOT EXISTS dim_rdv(

    num_consultation INT,

    date_rdv date,

    heure_debut date,

    heure_fin date

)

COMMENT 'Dim table RDV'

ROW FORMAT DELIMITED

FIELDS TERMINATED BY ';'

STORED AS TEXTFILE

LOCATION '/user/cloudera/CHU/Dim_RDV'