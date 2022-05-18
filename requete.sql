-- Besoin 1
CREATE view view_besoin_1 as
SELECT
    e.cedex,
    cr.date_rdv,
    cr.heure_debut,
    cr.heure_fin
FROM dim_etablissement_bucket_cedex e
JOIN (
    SELECT
        r.date_rdv,
        r.heure_debut,
        r.heure_fin,
        c.id_organisation
    From fact_consultation_bucket_id_organisation c
    JOIN dim_rdv_bucket_date r 
    on c.num_consultation = r.num_consultation
) as cr 
on e.id_organisation = cr.id_organisation 

-- Besoin 2
CREATE view view_besoin_2 as
SELECT
    d.diagnostic,
    cr.date_rdv,
    cr.heure_debut,
    cr.heure_fin
FROM dim_diagnostic_bucket_code_diagnostic d
JOIN (
    SELECT
        r.date_rdv,
        r.heure_debut,
        r.heure_fin,
        c.code_diagnostic
    From fact_consultation_bucket_code_diagnostic c
    JOIN dim_rdv_bucket_date r 
    on c.num_consultation = r.num_consultation
) as cr 
on d.code_diagnostic = cr.code_diagnostic 

-- Besoin 3
CREATE view view_besoin_3 as
SELECT
  num_hospitalisation,
  date_visite,
  nb_jours
FROM dim_visite_bucket_date 

-- Besoin 4
CREATE view view_besoin_4 as
SELECT
    d.diagnostic,
    hv.date_visite,
    hv.nb_jours
FROM dim_diagnostic_bucket_code_diagnostic d
JOIN (
    SELECT
        v.date_visite,
        v.nb_jours,
        h.code_diagnostic
    from fact_hospitalisation_bucket_diagnostic h
    JOIN dim_visite_bucket_date v 
    On h.num_hospitalisation = v.num_hospitalisation
) as hv
ON d.code_diagnostic = hv.code_diagnostic 

-- Besoin 5
CREATE view view_besoin_5 as
SELECT
    sum(h.nb_hospitalisation) / sum(h.nb_consultation) as taux,
    p.sexe,
    p.age
from fact_hosco_bucket_id_patient h
Join dim_patient_partition_sexe p 
On h.id_patient = p.id_patient
GROUP BY
    p.sexe,
    p.age 

-- Besoin 6
CREATE view view_besoin_6 as
SELECT
    nom,
    prenom,
    res
FROM dim_professionnel_sante_bucket_id_professionnel p
JOIN (
    SELECT
        id_professionnel_sante,
        pro.value / total.tot as res
    FROM (
        SELECT
            id_professionnel_sante,
            count(num_consultation) as value
        FROM fact_consultation_bucket_id_professionnel
        GROUP BY
            id_professionnel_sante
    ) as pro
    JOIN (
        SELECT
            count(num_consultation) as tot
        From fact_consultation_bucket_id_professionnel
    ) as total 
    On (1 = 1)
) final 
On (
    final.id_professionnel_sante = p.id_professionnel_sante
) 

-- Besoin 7
CREATE View view_besoin_7 as
SELECT
    r.nom_region,
    d.nb_deces
From fact_deces d
Join dim_region r 
On d.id_region = r.id_region 
  
-- Besoin 8
CREATE view view_besoin_8 as
SELECT
    avg(se.score_all_rea_ajust) as score_global,
    r.nom_region
From dim_region r
Join (
    SELECT
        e.score_all_rea_ajust,
        s.id_region
    FROM fact_satisfaction_partition_region s
    JOIN dim_etablissement_bucket_score e 
    On s.id_organisation = e.id_organisation
) as se 
On r.id_region = se.id_region
GROUP BY
    r.nom_region