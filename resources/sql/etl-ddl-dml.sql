DROP TABLE IF EXISTS extract_db.ip_entity_attrs;
DROP TABLE IF EXISTS extract_db.ip_entities;

CREATE TABLE extract_db.ip_entities (
    id BIGINT NOT NULL,
	entity_type VARCHAR(255) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE extract_db.ip_entity_attrs (
    id BIGINT NOT NULL,
	entity_id BIGINT NOT NULL,
	application_number VARCHAR(255) NOT NULL,
	attr_name VARCHAR(255) NOT NULL,
	attr_val VARCHAR(255) NOT NULL,
	is_published BOOLEAN NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (entity_id) REFERENCES extract_db.ip_entities(id)
);

INSERT INTO extract_db.ip_entities (id, entity_type)
VALUES (1, 'TRADEMARK');

INSERT INTO extract_db.ip_entity_attrs (id, entity_id, application_number, attr_name, attr_val, is_published)
VALUES (1, 1, '12345A', 'DECISION', 'Rejected on absolute grounds', 0);

INSERT INTO extract_db.ip_entity_attrs (id, entity_id, application_number, attr_name, attr_val, is_published)
VALUES (2, 1, '12345A', 'EXAMINER', 'Luke Skywalker', 0);

INSERT INTO extract_db.ip_entity_attrs (id, entity_id, application_number, attr_name, attr_val, is_published)
VALUES (3, 1, '12345A', 'DECISION_DATE', '2018-04-30', 0);

INSERT INTO extract_db.ip_entity_attrs (id, entity_id, application_number, attr_name, attr_val, is_published)
VALUES (4, 1, '12345A', 'FIELD_A', 'Field A data', 0);

INSERT INTO extract_db.ip_entity_attrs (id, entity_id, application_number, attr_name, attr_val, is_published)
VALUES (5, 1, '12345A', 'FIELD_B', 'Field B data', 0);

INSERT INTO extract_db.ip_entity_attrs (id, entity_id, application_number, attr_name, attr_val, is_published)
VALUES (7, 1, '54321Z', 'DECISION', 'Approved', 0);

INSERT INTO extract_db.ip_entity_attrs (id, entity_id, application_number, attr_name, attr_val, is_published)
VALUES (8, 1, '54321Z', 'EXAMINER', 'Dath Vader', 0);

INSERT INTO extract_db.ip_entity_attrs (id, entity_id, application_number, attr_name, attr_val, is_published)
VALUES (9, 1, '54321Z', 'DECISION_DATE', '2018-05-01', 0);

INSERT INTO extract_db.ip_entity_attrs (id, entity_id, application_number, attr_name, attr_val, is_published)
VALUES (10, 1, '54321Z', 'FIELD_A', 'Field A data', 0);

INSERT INTO extract_db.ip_entity_attrs (id, entity_id, application_number, attr_name, attr_val, is_published)
VALUES (11, 1, '54321Z', 'FIELD_B', 'Field B data', 0);


DROP TABLE IF EXISTS load_db.dossier_info;

CREATE TABLE load_db.dossier_info (
    id BIGINT NOT NULL,
	dossier_id VARCHAR(255) NOT NULL,
	legal_dec VARCHAR(255),
	dt_legal_dec DATE,
	reviewer_name VARCHAR(255),
	PRIMARY KEY (id)
);

INSERT INTO load_db.dossier_info (id, dossier_id)
VALUES (1, '12345A');

INSERT INTO load_db.dossier_info (id, dossier_id)
VALUES (2, '54321Z');
