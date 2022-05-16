-- Creating database
create database if not exists projet_chu;
use projet_chu;

-- Creating fact table HosCo
CREATE EXTERNAL TABLE IF NOT EXISTS fact_hosco(
    id_patient int,
    nb_consultation int,
    nb_hospitalisation int
)
COMMENT 'Fact table Hosco'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/CHU/Fact_HosCo';

-- Creating dimension table RDV
CREATE EXTERNAL TABLE IF NOT EXISTS dim_rdv(
    num_consultation INT,
    date_rdv date,
    heure_debut string,
    heure_fin string
)
COMMENT 'Dim table RDV'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/CHU/Dim_RDV'

--Creating dimension table Region
create external table if not exists dim_region( 
    id_region int, 
    nom_region string 
) 
comment 'Dim table Régions' 
row format delimited 
fields terminated by '\;' 
stored as textfile 
location '/user/cloudera/CHU/Dim_Region';

--Creating dimension table Etablissement
create external table if not exists dim_etablissement(
    identifiant_organisation string,
    cedex string,
    score_all_rea_ajust float
)
comment 'Dim table Etablissements'
row format delimited
fields terminated by '\;'
stored as textfile
location '/user/cloudera/CHU/Dim_Etablissement';

--Creating fact table Deces
create external table if not exists fact_deces(
    id_region int,
    nombre_deces int
)
comment 'Fact table Deces'
row format delimited
fields terminated by '\;'
stored as textfile
location '/user/cloudera/CHU/Fact_Deces';

--Creating fact table Satisfaction
create external table if not exists fact_satisfaction(
    id_region int,
    identifiant_organisation string
)
comment 'Fact table Satisfactions'
row format delimited
fields terminated by '\;'
stored as textfile
location '/user/cloudera/CHU/Fact_Satisfaction';

--Creating dimension table Patient
create external table if not exists dim_patient(
    id_patient int,
    sexe string,
    age string)
comment 'Dim table Patients'
row format delimited
fields terminated by '\;'
stored as textfile
location '/user/cloudera/CHU/Dim_Patient';

--Creating dimension table Diagnostic
create external table if not exists dim_diagnostic(
    code_diagnostic string,
    diagnostic string
)
comment 'Dim table Diagnostics'
row format delimited
fields terminated by '\;'
stored as textfile
location '/user/cloudera/CHU/Dim_Diagnostic';

-- Creating dimension table Visite
CREATE EXTERNAL TABLE IF NOT EXISTS dim_visite(
    num_hospitalisation INT,
    date_visite date,
    nb_jours int
)
COMMENT 'Dim table RDV'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/CHU/Dim_Visite'