
CREATE TABLE dim_patient_partition_sexe(
    id_patient int,
    age int
)
PARTITIONED BY (sexe string)
CLUSTERED BY (age) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;
INSERT OVERWRITE TABLE dim_patient_partition_sexe PARTITION (sexe)
SELECT id_patient, age, sexe FROM dim_patient;

CREATE TABLE fact_hosco_bucket_id_patient (
    id_patient int,
    nb_consultation int,
    nb_hospitalisation int
)
CLUSTERED BY (id_patient) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE;
INSERT OVERWRITE TABLE fact_hosco_bucket_id_patient
SELECT id_patient, nb_consultation, nb_hospitalisation from fact_hosco

CREATE TABLE dim_professionnel_sante_bucket_id_professionnel(
    id_professionnel_sante string,
    nom string,
    prenom string
)
CLUSTERED BY (id_professionnel_sante) INTO 4 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
INSERT OVERWRITE TABLE dim_professionnel_sante_bucket_id_professionnel
SELECT id_professionnel_sante, nom, prenom FROM projet_chu.dim_professionnel_sante

CREATE TABLE fact_consultation_bucket_id_consultation_id_professionnel(
    num_consultation int,
    id_professionnel_sante string
    )
CLUSTERED BY (num_consultation, id_professionnel_sante) into 4 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
INSERT OVERWRITE TABLE fact_consultation_bucket_id_consultation_id_professionnel
SELECT num_consultation, id_professionnel_sante from fact_consultation

CREATE TABLE fact_hospitalisation_bucket_diagnostic(
    num_hospitalisation int,
    code_diagnostic string
)
CLUSTERED BY (num_hospitalisation, code_diagnostic) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE

INSERT OVERWRITE TABLE fact_hospitalisation_bucket_diagnostic
SELECT num_hospitalisation, code_diagnostic
FROM fact_hospitalisation

CREATE TABLE dim_visite_bucket_date(
    num_hospitalisation int,
    date_visite date,
    nb_jours int
)
CLUSTERED BY (num_hospitalisation, date_visite) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
INSERT OVERWRITE TABLE dim_visite_bucket_date
SELECT num_hospitalisation, date_visite, nb_jours
From dim_visite

CREATE TABLE dim_diagnostic_bucket_code_diagnostic(
    code_diagnostic STRING,
    diagnostic string
)
CLUSTERED BY (code_diagnostic) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE

INSERT OVERWRITE TABLE dim_diagnostic_bucket_code_diagnostic
SELECT code_diagnostic, diagnostic
FROM dim_diagnostic

CREATE TABLE dim_rdv_bucket_date(
    num_consultation int,
    date_rdv date,
    heure_debut string,
    heure_fin string
)
CLUSTERED BY (num_consultation, date_rdv) into 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
INSERT OVERWRITE TABLE dim_rdv_bucket_date
SELECT num_consultation, date_rdv, heure_debut, heure_fin
from dim_rdv

CREATE TABLE fact_consultation_bucket_code_diagnostic(
    num_consultation int,
    code_diagnostic string
)
CLUSTERED BY (num_consultation, code_diagnostic) INTO 8 BUCKETS
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE

INSERT OVERWRITE TABLE fact_consultation_bucket_code_diagnostic
SELECT num_consultation, code_diagnostic
From fact_consultation

CREATE TABLE dim_etablissement_bucket_cedex(
    id_organisation string,
    cedex string
)
CLUSTERED BY (id_organisation, cedex) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
INSERT OVERWRITE TABLE dim_etablissement_bucket_cedex
SELECT id_organisation, cedex
from dim_etablissement

CREATE TABLE fact_consultation_bucket_id_organisation(
    num_consultation int,
    id_organisation string
)
CLUSTERED BY (num_consultation, id_organisation) INTO 8 BUCKETS
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE


INSERT OVERWRITE TABLE fact_consultation_bucket_id_organisation
SELECT num_consultation, id_organisation
From fact_consultation


CREATE TABLE dim_etablissement_bucket_score(
    id_organisation string,
    score_all_rea_ajust FLOAT
)
CLUSTERED BY (id_organisation, score_all_rea_ajust) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
INSERT OVERWRITE TABLE dim_etablissement_bucket_score
SELECT id_organisation, score_all_rea_ajust
from dim_etablissement


CREATE TABLE fact_satisfaction_partition_region(
    id_organisation string
)
PARTITIONED BY (id_region int)
CLUSTERED BY (id_organisation) INTO 4 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE

INSERT OVERWRITE TABLE fact_satisfaction_partition_region PARTITION (id_region)
SELECT id_organisation, id_region from fact_satisfaction



CREATE TABLE fact_consultation_bucket_id_professionnel(
    num_consultation int,
    id_professionnel_sante string)
CLUSTERED BY (num_consultation, id_professionnel_sante) into 4 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE

INSERT OVERWRITE TABLE fact_consultation_bucket_id_professionnel
SELECT num_consultation, id_professionnel_sante from fact_consultation
