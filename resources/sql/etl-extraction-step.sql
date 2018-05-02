SELECT DISTINCT 
extract_db.ip_entity_attrs.application_number AS application_number, 
extract_db.ip_entity_attrs.attr_name AS attribute_name, 
decision_table.attr_val AS decision,  
decision_date_table.attr_val AS decision_date, 
examiner_table.attr_val AS examiner,
extract_db.ip_entity_attrs.is_published AS is_published
FROM extract_db.ip_entity_attrs,
(
SELECT application_number, attr_val
FROM extract_db.ip_entity_attrs
WHERE extract_db.ip_entity_attrs.entity_id = 
(
SELECT ID from extract_db.ip_entities 
where entity_type = 'TRADEMARK'
)
AND
attr_name = 'DECISION'
) AS decision_table,
(
SELECT application_number, attr_val
FROM extract_db.ip_entity_attrs
WHERE extract_db.ip_entity_attrs.entity_id = 
(
SELECT ID from extract_db.ip_entities 
where entity_type = 'TRADEMARK'
)
AND
attr_name = 'DECISION_DATE'
) AS decision_date_table,
(
SELECT application_number, attr_val
FROM extract_db.ip_entity_attrs
WHERE extract_db.ip_entity_attrs.entity_id = 
(
SELECT ID from extract_db.ip_entities 
where entity_type = 'TRADEMARK'
)
AND
attr_name = 'EXAMINER'
) AS examiner_table
WHERE extract_db.ip_entity_attrs.entity_id = 
(
SELECT ID from extract_db.ip_entities 
where entity_type = 'TRADEMARK'
)
AND  extract_db.ip_entity_attrs.attr_name 
IN (
'DECISION',
'DECISION_DATE','EXAMINER'
)
AND extract_db.ip_entity_attrs.application_number = decision_table.application_number
AND extract_db.ip_entity_attrs.application_number = decision_date_table.application_number
AND extract_db.ip_entity_attrs.application_number = examiner_table.application_number;