CREATE TABLE @temp_database_schema.dnfk2x85Codesets  
USING DELTA
 AS
SELECT
CAST(NULL AS int) AS codeset_id,
	CAST(NULL AS bigint) AS concept_id  WHERE 1 = 0;
WITH insertion_temp AS (
(SELECT 5 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (45877171,4059641,4052321,44804220,37079501,36311105,4046991,36308356,36308730,40329714,40299805,40300329,36309786,40545298,40299223,4052157,46285980,3561367,44802044,4019978,4019977,4207170,2618142,2618143)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (45877171,4059641,4052321,44804220,37079501,36311105,4046991,36308356,36308730,40329714,40299805,40300329,36309786,40545298,40299223,4052157,46285980,3561367,44802044,4019978,4019977,4207170,2618142,2618143)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 6 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4053088,4147554,40519180,44794577,40519187,44812921,40329696,21498856,4139934,40299198,3552499,3552820,3552819,3553101,8672,42628011,44788302,44788283,4019973,40299199,4190815,4307308,4192297,4307307,4193277,40299200,4052051,35225199,36309593,36310234,36662349,45765559,44810341,3560142,40329696,3557438,40318572,4091008,4137393,4144274,3557354,40299203,4058157,37079289,44831984,766510,766511,766512,36309067)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (4053088,4147554,40519180,44794577,40519187,44812921,40329696,21498856,4139934,40299198,3552499,3552820,3552819,3553101,8672,42628011,44788302,44788283,4019973,40299199,4190815,4307308,4192297,4307307,4193277,40299200,4052051,35225199,36309593,36310234,36662349,45765559,44810341,3560142,40329696,3557438,40318572,4091008,4137393,4144274,3557354,40299203,4058157,37079289,44831984,766510,766511,766512,36309067)
 and c.invalid_reason is null
) I
) C
) UNION ALL (SELECT codeset_id, concept_id FROM @temp_database_schema.dnfk2x85Codesets ))
INSERT OVERWRITE TABLE @temp_database_schema.dnfk2x85Codesets  SELECT * FROM insertion_temp;
CREATE TABLE @temp_database_schema.dnfk2x85qualified_events
USING DELTA
AS
SELECT
event_id, person_id, start_date, end_date, op_start_date, op_end_date, visit_occurrence_id
FROM
(
 select pe.event_id, pe.person_id, pe.start_date, pe.end_date, pe.op_start_date, pe.op_end_date, row_number() over (partition by pe.person_id order by pe.start_date ASC) as ordinal, cast(pe.visit_occurrence_id as bigint) as visit_occurrence_id
 FROM (-- Begin Primary Events
select P.ordinal as event_id, P.person_id, P.start_date, P.end_date, op_start_date, op_end_date, cast(P.visit_occurrence_id as bigint) as visit_occurrence_id
FROM
(
 select E.person_id, E.start_date, E.end_date,
 row_number() OVER (PARTITION BY E.person_id ORDER BY E.sort_date ASC, E.event_id) ordinal,
 OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date, cast(E.visit_occurrence_id as bigint) as visit_occurrence_id
 FROM 
 (
 -- Begin Visit Occurrence Criteria
select C.person_id, C.visit_occurrence_id as event_id, C.visit_start_date as start_date, C.visit_end_date as end_date,
 C.visit_occurrence_id, C.visit_start_date as sort_date
from 
(
 select vo.* 
 FROM @cdm_database_schema.VISIT_OCCURRENCE vo
) C
-- End Visit Occurrence Criteria
 ) E
 JOIN @cdm_database_schema.observation_period OP on E.person_id = OP.person_id and E.start_date >= OP.observation_period_start_date and E.start_date <= op.observation_period_end_date
 WHERE date_add(OP.OBSERVATION_PERIOD_START_DATE, 0) <= E.START_DATE AND date_add(E.START_DATE, 0) <= OP.OBSERVATION_PERIOD_END_DATE
) P
WHERE P.ordinal = 1
-- End Primary Events
) pe
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
 select E.person_id, E.event_id 
 FROM (-- Begin Primary Events
select P.ordinal as event_id, P.person_id, P.start_date, P.end_date, op_start_date, op_end_date, cast(P.visit_occurrence_id as bigint) as visit_occurrence_id
FROM
(
 select E.person_id, E.start_date, E.end_date,
 row_number() OVER (PARTITION BY E.person_id ORDER BY E.sort_date ASC, E.event_id) ordinal,
 OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date, cast(E.visit_occurrence_id as bigint) as visit_occurrence_id
 FROM 
 (
 -- Begin Visit Occurrence Criteria
select C.person_id, C.visit_occurrence_id as event_id, C.visit_start_date as start_date, C.visit_end_date as end_date,
 C.visit_occurrence_id, C.visit_start_date as sort_date
from 
(
 select vo.* 
 FROM @cdm_database_schema.VISIT_OCCURRENCE vo
) C
-- End Visit Occurrence Criteria
 ) E
 JOIN @cdm_database_schema.observation_period OP on E.person_id = OP.person_id and E.start_date >= OP.observation_period_start_date and E.start_date <= op.observation_period_end_date
 WHERE date_add(OP.OBSERVATION_PERIOD_START_DATE, 0) <= E.START_DATE AND date_add(E.START_DATE, 0) <= OP.OBSERVATION_PERIOD_END_DATE
) P
WHERE P.ordinal = 1
-- End Primary Events
) E
 INNER JOIN
 (
 -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM (-- Begin Primary Events
select P.ordinal as event_id, P.person_id, P.start_date, P.end_date, op_start_date, op_end_date, cast(P.visit_occurrence_id as bigint) as visit_occurrence_id
FROM
(
 select E.person_id, E.start_date, E.end_date,
 row_number() OVER (PARTITION BY E.person_id ORDER BY E.sort_date ASC, E.event_id) ordinal,
 OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date, cast(E.visit_occurrence_id as bigint) as visit_occurrence_id
 FROM 
 (
 -- Begin Visit Occurrence Criteria
select C.person_id, C.visit_occurrence_id as event_id, C.visit_start_date as start_date, C.visit_end_date as end_date,
 C.visit_occurrence_id, C.visit_start_date as sort_date
from 
(
 select vo.* 
 FROM @cdm_database_schema.VISIT_OCCURRENCE vo
) C
-- End Visit Occurrence Criteria
 ) E
 JOIN @cdm_database_schema.observation_period OP on E.person_id = OP.person_id and E.start_date >= OP.observation_period_start_date and E.start_date <= op.observation_period_end_date
 WHERE date_add(OP.OBSERVATION_PERIOD_START_DATE, 0) <= E.START_DATE AND date_add(E.START_DATE, 0) <= OP.OBSERVATION_PERIOD_END_DATE
) P
WHERE P.ordinal = 1
-- End Primary Events
) P
JOIN (
 -- Begin Visit Occurrence Criteria
select C.person_id, C.visit_occurrence_id as event_id, C.visit_start_date as start_date, C.visit_end_date as end_date,
 C.visit_occurrence_id, C.visit_start_date as sort_date
from 
(
 select vo.* 
 FROM @cdm_database_schema.VISIT_OCCURRENCE vo
) C
WHERE C.visit_start_date >= to_date(cast(2020 as string) || '-' || cast(1 as string) || '-' || cast(1 as string))
-- End Visit Occurrence Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria
 ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
 GROUP BY E.person_id, E.event_id
 HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id and AC.event_id = pe.event_id
) QE
WHERE QE.ordinal = 1
;
CREATE TABLE @temp_database_schema.dnfk2x85Inclusion_0
USING DELTA
AS
SELECT
0 as inclusion_rule_id, person_id, event_id
FROM
(
 select pe.person_id, pe.event_id
 FROM @temp_database_schema.dnfk2x85qualified_events pe
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
 select E.person_id, E.event_id 
 FROM @temp_database_schema.dnfk2x85qualified_events E
 INNER JOIN
 (
 -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Visit Occurrence Criteria
select C.person_id, C.visit_occurrence_id as event_id, C.visit_start_date as start_date, C.visit_end_date as end_date,
 C.visit_occurrence_id, C.visit_start_date as sort_date
from 
(
 select vo.* 
 FROM @cdm_database_schema.VISIT_OCCURRENCE vo
) C
-- End Visit Occurrence Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria
 ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
 GROUP BY E.person_id, E.event_id
 HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;
CREATE TABLE @temp_database_schema.dnfk2x85Inclusion_1
USING DELTA
AS
SELECT
1 as inclusion_rule_id, person_id, event_id
FROM
(
 select pe.person_id, pe.event_id
 FROM @temp_database_schema.dnfk2x85qualified_events pe
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
 select E.person_id, E.event_id 
 FROM @temp_database_schema.dnfk2x85qualified_events E
 INNER JOIN
 (
 -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, date_add(C.condition_start_date, 1)) as end_date,
 C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
 SELECT co.* 
 FROM @cdm_database_schema.CONDITION_OCCURRENCE co
 JOIN @temp_database_schema.dnfk2x85Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 5)
) C
-- End Condition Occurrence Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria
UNION ALL
-- Begin Correlated Criteria
select 1 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Measurement Criteria
select C.person_id, C.measurement_id as event_id, C.measurement_date as start_date, date_add(C.measurement_date, 1) as END_DATE,
 C.visit_occurrence_id, C.measurement_date as sort_date
from 
(
 select m.* 
 FROM @cdm_database_schema.MEASUREMENT m
JOIN @temp_database_schema.dnfk2x85Codesets cs on (m.measurement_concept_id = cs.concept_id and cs.codeset_id = 5)
) C
-- End Measurement Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria
UNION ALL
-- Begin Correlated Criteria
select 2 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Observation Criteria
select C.person_id, C.observation_id as event_id, C.observation_date as start_date, date_add(C.observation_date, 1) as END_DATE,
 C.visit_occurrence_id, C.observation_date as sort_date
from 
(
 select o.* 
 FROM @cdm_database_schema.OBSERVATION o
JOIN @temp_database_schema.dnfk2x85Codesets cs on (o.observation_concept_id = cs.concept_id and cs.codeset_id = 5)
) C
-- End Observation Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria
UNION ALL
-- Begin Correlated Criteria
select 3 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Procedure Occurrence Criteria
select C.person_id, C.procedure_occurrence_id as event_id, C.procedure_date as start_date, date_add(C.procedure_date, 1) as END_DATE,
 C.visit_occurrence_id, C.procedure_date as sort_date
from 
(
 select po.* 
 FROM @cdm_database_schema.PROCEDURE_OCCURRENCE po
JOIN @temp_database_schema.dnfk2x85Codesets cs on (po.procedure_concept_id = cs.concept_id and cs.codeset_id = 5)
) C
-- End Procedure Occurrence Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria
UNION ALL
-- Begin Correlated Criteria
select 4 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Visit Occurrence Criteria
select C.person_id, C.visit_occurrence_id as event_id, C.visit_start_date as start_date, C.visit_end_date as end_date,
 C.visit_occurrence_id, C.visit_start_date as sort_date
from 
(
 select vo.* 
 FROM @cdm_database_schema.VISIT_OCCURRENCE vo
JOIN @temp_database_schema.dnfk2x85Codesets cs on (vo.visit_concept_id = cs.concept_id and cs.codeset_id = 5)
) C
-- End Visit Occurrence Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria
 ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
 GROUP BY E.person_id, E.event_id
 HAVING COUNT(index_id) > 0
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;
CREATE TABLE @temp_database_schema.dnfk2x85Inclusion_2
USING DELTA
AS
SELECT
2 as inclusion_rule_id, person_id, event_id
FROM
(
 select pe.person_id, pe.event_id
 FROM @temp_database_schema.dnfk2x85qualified_events pe
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
 select E.person_id, E.event_id 
 FROM @temp_database_schema.dnfk2x85qualified_events E
 INNER JOIN
 (
 -- Begin Correlated Criteria
select 0 as index_id, p.person_id, p.event_id
from @temp_database_schema.dnfk2x85qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, date_add(C.condition_start_date, 1)) as end_date,
 C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
 SELECT co.* 
 FROM @cdm_database_schema.CONDITION_OCCURRENCE co
 JOIN @temp_database_schema.dnfk2x85Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 6)
) C
-- End Condition Occurrence Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria
UNION ALL
-- Begin Correlated Criteria
select 1 as index_id, p.person_id, p.event_id
from @temp_database_schema.dnfk2x85qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Measurement Criteria
select C.person_id, C.measurement_id as event_id, C.measurement_date as start_date, date_add(C.measurement_date, 1) as END_DATE,
 C.visit_occurrence_id, C.measurement_date as sort_date
from 
(
 select m.* 
 FROM @cdm_database_schema.MEASUREMENT m
JOIN @temp_database_schema.dnfk2x85Codesets cs on (m.measurement_concept_id = cs.concept_id and cs.codeset_id = 6)
) C
-- End Measurement Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria
UNION ALL
-- Begin Correlated Criteria
select 2 as index_id, p.person_id, p.event_id
from @temp_database_schema.dnfk2x85qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Observation Criteria
select C.person_id, C.observation_id as event_id, C.observation_date as start_date, date_add(C.observation_date, 1) as END_DATE,
 C.visit_occurrence_id, C.observation_date as sort_date
from 
(
 select o.* 
 FROM @cdm_database_schema.OBSERVATION o
JOIN @temp_database_schema.dnfk2x85Codesets cs on (o.observation_concept_id = cs.concept_id and cs.codeset_id = 6)
) C
-- End Observation Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria
UNION ALL
-- Begin Correlated Criteria
select 3 as index_id, p.person_id, p.event_id
from @temp_database_schema.dnfk2x85qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Procedure Occurrence Criteria
select C.person_id, C.procedure_occurrence_id as event_id, C.procedure_date as start_date, date_add(C.procedure_date, 1) as END_DATE,
 C.visit_occurrence_id, C.procedure_date as sort_date
from 
(
 select po.* 
 FROM @cdm_database_schema.PROCEDURE_OCCURRENCE po
JOIN @temp_database_schema.dnfk2x85Codesets cs on (po.procedure_concept_id = cs.concept_id and cs.codeset_id = 6)
) C
-- End Procedure Occurrence Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria
UNION ALL
-- Begin Correlated Criteria
select 4 as index_id, p.person_id, p.event_id
from @temp_database_schema.dnfk2x85qualified_events p
LEFT JOIN (
SELECT p.person_id, p.event_id 
FROM @temp_database_schema.dnfk2x85qualified_events P
JOIN (
 -- Begin Visit Occurrence Criteria
select C.person_id, C.visit_occurrence_id as event_id, C.visit_start_date as start_date, C.visit_end_date as end_date,
 C.visit_occurrence_id, C.visit_start_date as sort_date
from 
(
 select vo.* 
 FROM @cdm_database_schema.VISIT_OCCURRENCE vo
JOIN @temp_database_schema.dnfk2x85Codesets cs on (vo.visit_concept_id = cs.concept_id and cs.codeset_id = 6)
) C
-- End Visit Occurrence Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= date_add(P.START_DATE, 0) AND A.START_DATE <= date_add(P.START_DATE, 180) ) cc on p.person_id = cc.person_id and p.event_id = cc.event_id
GROUP BY p.person_id, p.event_id
HAVING COUNT(cc.event_id) = 0
-- End Correlated Criteria
 ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
 GROUP BY E.person_id, E.event_id
 HAVING COUNT(index_id) = 5
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;
CREATE TABLE @temp_database_schema.dnfk2x85inclusion_events
USING DELTA
AS
SELECT
inclusion_rule_id, person_id, event_id
FROM
(select inclusion_rule_id, person_id, event_id from @temp_database_schema.dnfk2x85Inclusion_0
UNION ALL
select inclusion_rule_id, person_id, event_id from @temp_database_schema.dnfk2x85Inclusion_1
UNION ALL
select inclusion_rule_id, person_id, event_id from @temp_database_schema.dnfk2x85Inclusion_2) I;
TRUNCATE TABLE @temp_database_schema.dnfk2x85Inclusion_0;
DROP TABLE @temp_database_schema.dnfk2x85Inclusion_0;
TRUNCATE TABLE @temp_database_schema.dnfk2x85Inclusion_1;
DROP TABLE @temp_database_schema.dnfk2x85Inclusion_1;
TRUNCATE TABLE @temp_database_schema.dnfk2x85Inclusion_2;
DROP TABLE @temp_database_schema.dnfk2x85Inclusion_2;
CREATE TABLE @temp_database_schema.dnfk2x85included_events
USING DELTA
AS
SELECT
event_id, person_id, start_date, end_date, op_start_date, op_end_date
FROM
(
 SELECT event_id, person_id, start_date, end_date, op_start_date, op_end_date, row_number() over (partition by person_id order by start_date ASC) as ordinal
 from
 (
 select Q.event_id, Q.person_id, Q.start_date, Q.end_date, Q.op_start_date, Q.op_end_date, SUM(coalesce(POWER(cast(2 as bigint), I.inclusion_rule_id), 0)) as inclusion_rule_mask
 from @temp_database_schema.dnfk2x85qualified_events Q
 LEFT JOIN @temp_database_schema.dnfk2x85inclusion_events I on I.person_id = Q.person_id and I.event_id = Q.event_id
 GROUP BY Q.event_id, Q.person_id, Q.start_date, Q.end_date, Q.op_start_date, Q.op_end_date
 ) MG -- matching groups
 -- the matching group with all bits set ( POWER(2,# of inclusion rules) - 1 = inclusion_rule_mask
 WHERE (MG.inclusion_rule_mask = POWER(cast(2 as bigint),3)-1)
) Results
WHERE Results.ordinal = 1
;
CREATE TABLE @temp_database_schema.dnfk2x85strategy_ends
USING DELTA
AS
SELECT
event_id, person_id, 
 case when date_add(start_date, 180) > op_end_date then op_end_date else date_add(start_date, 180) end as end_date
FROM
@temp_database_schema.dnfk2x85included_events;
CREATE TABLE @temp_database_schema.dnfk2x85cohort_rows
USING DELTA
AS
SELECT
person_id, start_date, end_date
FROM
( -- first_ends
 select F.person_id, F.start_date, F.end_date
 FROM (
 select I.event_id, I.person_id, I.start_date, CE.end_date, row_number() over (partition by I.person_id, I.event_id order by CE.end_date) as ordinal 
 from @temp_database_schema.dnfk2x85included_events I
 join ( -- cohort_ends
-- cohort exit dates
-- End Date Strategy
SELECT event_id, person_id, end_date from @temp_database_schema.dnfk2x85strategy_ends
 ) CE on I.event_id = CE.event_id and I.person_id = CE.person_id and CE.end_date >= I.start_date
 ) F
 WHERE F.ordinal = 1
) FE;
CREATE TABLE @temp_database_schema.dnfk2x85final_cohort
USING DELTA
AS
SELECT
person_id, min(start_date) as start_date, end_date
FROM
( --cteEnds
 SELECT
 c.person_id
 , c.start_date
 , MIN(ed.end_date) AS end_date
 FROM @temp_database_schema.dnfk2x85cohort_rows c
 JOIN ( -- cteEndDates
 SELECT
 person_id
 , date_add(event_date, -1 * 0) as end_date
 FROM
 (
 SELECT
 person_id
 , event_date
 , event_type
 , MAX(start_ordinal) OVER (PARTITION BY person_id ORDER BY event_date, event_type, start_ordinal ROWS UNBOUNDED PRECEDING) AS start_ordinal 
 , ROW_NUMBER() OVER (PARTITION BY person_id ORDER BY event_date, event_type, start_ordinal) AS overall_ord
 FROM
 (
 SELECT
 person_id
 , start_date AS event_date
 , -1 AS event_type
 , ROW_NUMBER() OVER (PARTITION BY person_id ORDER BY start_date) AS start_ordinal
 FROM @temp_database_schema.dnfk2x85cohort_rows
 UNION ALL
 SELECT
 person_id
 , date_add(end_date, 0) as end_date
 , 1 AS event_type
 , NULL
 FROM @temp_database_schema.dnfk2x85cohort_rows
 ) RAWDATA
 ) e
 WHERE (2 * e.start_ordinal) - e.overall_ord = 0
 ) ed ON c.person_id = ed.person_id AND ed.end_date >= c.start_date
 GROUP BY c.person_id, c.start_date
) e
group by person_id, end_date
;
INSERT OVERWRITE TABLE @target_database_schema.@target_cohort_table  SELECT * FROM @target_database_schema.@target_cohort_table  WHERE NOT (cohort_definition_id = @target_cohort_id);
WITH insertion_temp AS (
(SELECT @target_cohort_id as cohort_definition_id, person_id, start_date, end_date 
FROM @temp_database_schema.dnfk2x85final_cohort CO
) UNION ALL (SELECT cohort_definition_id, subject_id, cohort_start_date, cohort_end_date FROM @target_database_schema.@target_cohort_table ))
INSERT OVERWRITE TABLE @target_database_schema.@target_cohort_table  SELECT * FROM insertion_temp;
TRUNCATE TABLE @temp_database_schema.dnfk2x85strategy_ends;
DROP TABLE @temp_database_schema.dnfk2x85strategy_ends;
TRUNCATE TABLE @temp_database_schema.dnfk2x85cohort_rows;
DROP TABLE @temp_database_schema.dnfk2x85cohort_rows;
TRUNCATE TABLE @temp_database_schema.dnfk2x85final_cohort;
DROP TABLE @temp_database_schema.dnfk2x85final_cohort;
TRUNCATE TABLE @temp_database_schema.dnfk2x85inclusion_events;
DROP TABLE @temp_database_schema.dnfk2x85inclusion_events;
TRUNCATE TABLE @temp_database_schema.dnfk2x85qualified_events;
DROP TABLE @temp_database_schema.dnfk2x85qualified_events;
TRUNCATE TABLE @temp_database_schema.dnfk2x85included_events;
DROP TABLE @temp_database_schema.dnfk2x85included_events;
TRUNCATE TABLE @temp_database_schema.dnfk2x85Codesets;
DROP TABLE @temp_database_schema.dnfk2x85Codesets;