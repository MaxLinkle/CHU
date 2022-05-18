
CREATE TABLE dim_patient_partition_sexe
(id_patient int,
age int)
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
    id_professionnel_sante string)
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


--besoin

CREATE view view_besoin_1 as
SELECT e.cedex, cr.date_rdv, cr.heure_debut, cr.heure_fin
FROM dim_etablissement_bucket_cedex e
JOIN (
    SELECT r.date_rdv, r.heure_debut, r.heure_fin, c.id_organisation
    From fact_consultation_bucket_id_organisation c
    JOIN dim_rdv_bucket_date r
    on c.num_consultation=r.num_consultation
) as cr
on e.id_organisation=cr.id_organisation

CREATE view view_besoin_2 as
SELECT d.diagnostic, cr.date_rdv, cr.heure_debut, cr.heure_fin
FROM dim_diagnostic_bucket_code_diagnostic d
JOIN (
    SELECT r.date_rdv, r.heure_debut, r.heure_fin, c.code_diagnostic
    From fact_consultation_bucket_code_diagnostic c
    JOIN dim_rdv_bucket_date r
    on c.num_consultation=r.num_consultation
) as cr
on d.code_diagnostic=cr.code_diagnostic
CREATE view view_besoin_3 as
SELECT num_hospitalisation, date_visite, nb_jours
FROM dim_visite_bucket_date
CREATE view view_besoin_4 as
SELECT d.diagnostic, hv.date_visite, hv.nb_jours
FROM dim_diagnostic_bucket_code_diagnostic d
JOIN (
    SELECT v.date_visite, v.nb_jours, h.code_diagnostic
    from fact_hospitalisation_bucket_diagnostic h
    JOIN dim_visite_bucket_date v
    On h.num_hospitalisation=v.num_hospitalisation
) as hv
ON d.code_diagnostic=hv.code_diagnostic

CREATE view view_besoin_5 as
SELECT sum(h.nb_hospitalisation)/sum(h.nb_consultation) as taux, p.sexe, p.age
from fact_hosco_bucket_id_patient h
Join dim_patient_partition_sexe p
On h.id_patient=p.id_patient
GROUP BY p.sexe, p.age
CREATE view view_besoin_6 as
SELECT nom, prenom, res
FROM dim_professionnel_sante_bucket_id_professionnel p
JOIN (
    SELECT id_professionnel_sante, pro.value/total.tot as res
    FROM (
        SELECT id_professionnel_sante, count(num_consultation) as value
        FROM fact_consultation_bucket_id_professionnel
        GROUP BY id_professionnel_sante
    ) as pro
    JOIN (
        SELECT count(num_consultation) as tot
        From fact_consultation_bucket_id_professionnel
    ) as total
    On (1=1)
) final
On (final.id_professionnel_sante=p.id_professionnel_sante)
CREATE View view_besoin_7 as
SELECT r.nom_region, d.nb_deces
From fact_deces d
Join dim_region r
On d.id_region=r.id_region
CREATE view view_besoin_8 as
SELECT avg(se.score_all_rea_ajust) as score_global, r.nom_region
From dim_region r
Join (
    SELECT e.score_all_rea_ajust, s.id_region
    FROM fact_satisfaction_partition_region s
    JOIN dim_etablissement_bucket_score e
    On s.id_organisation=e.id_organisation
) as se
On r.id_region=se.id_region
GROUP BY r.nom_region

