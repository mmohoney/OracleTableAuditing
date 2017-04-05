--TABLE CREATION
CREATE TABLE MMOHONEY.AUDIT_DML_EVENT_TYPE
  (
     ID                  NUMBER(10) NOT NULL,
     DESCRIPTION         VARCHAR(255) NOT NULL,
     ACTIVE              NUMBER(1) NOT NULL,
     DISPLAY_DESCRIPTION VARCHAR(255) NOT NULL
  );

--CONTRAINT
ALTER TABLE MMOHONEY.AUDIT_DML_EVENT_TYPE
  ADD CONSTRAINT AUDIT_DML_EVENT_TYPE_1U PRIMARY KEY (ID);

ALTER TABLE MMOHONEY.AUDIT_DML_EVENT_TYPE
  ADD CONSTRAINT AUDIT_DML_EVENT_TYPE_2U UNIQUE (DESCRIPTION);

--PRIV
GRANT SELECT, INSERT, UPDATE ON MMOHONEY.AUDIT_DML_EVENT_TYPE TO MMOHONEY;

--INSERT
INSERT INTO MMOHONEY.AUDIT_DML_EVENT_TYPE (ID, DESCRIPTION, ACTIVE, DISPLAY_DESCRIPTION) VALUES(1,'INSERT',1,'Creation'); 
INSERT INTO MMOHONEY.AUDIT_DML_EVENT_TYPE (ID, DESCRIPTION, ACTIVE, DISPLAY_DESCRIPTION) VALUES(2,'UPDATE',1,'Modification');
INSERT INTO MMOHONEY.AUDIT_DML_EVENT_TYPE (ID, DESCRIPTION, ACTIVE, DISPLAY_DESCRIPTION) VALUES(3,'DELETE',1,'Deletion'); 
COMMIT;

--SELECT *
--  FROM MMOHONEY.AUDIT_DML_EVENT_TYPE
-- ORDER BY ID; 