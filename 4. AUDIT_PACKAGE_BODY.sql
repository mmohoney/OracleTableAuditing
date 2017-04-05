CREATE OR REPLACE PACKAGE BODY MMOHONEY.AUDIT_PACKAGE
AS
  /*UPDATE THE DISPLAY_TEXT COLUMN ON THE AUDIT RECORD - GENERALLY TEXT FOR USERS*/
  PROCEDURE entity_audit_update_text(p_audit_id IN NUMBER,
                                     p_text     IN VARCHAR2)
  IS
  BEGIN
      IF ( p_audit_id IS NULL ) THEN
        RETURN;
      END IF;

      UPDATE MMOHONEY.ENTITY_AUDIT
         SET DISPLAY_TEXT = p_text
       WHERE ID = p_audit_id;
  END;
  /*END Entity_audit_update_text*/
  /*TO BE CALLED WHEN RECORD INSERTED*/
  PROCEDURE entity_audit_record_insert(p_table_name IN VARCHAR2,
                                       p_table_id   IN NUMBER,
                                       p_username   IN VARCHAR2,
                                       p_audit_id   OUT NUMBER)
  IS
    DML_EVENT VARCHAR2(25);
  BEGIN
      p_audit_id := NULL;

      p_audit_id := ENTITY_AUDIT_SEQ.NEXTVAL;

      INSERT INTO MMOHONEY.ENTITY_AUDIT
                  (ID,
                   USERNAME,
                   TIMESTAMP,
                   DML_EVENT_TYPE,
                   TABLE_NAME,
                   COLUMN_NAME,
                   NEW_VALUE,
                   OLD_VALUE,
                   TABLE_ID)
           VALUES ( p_audit_id,p_username,SYSTIMESTAMP,'INSERT',Upper(p_table_name),'INSERT',To_char(p_table_id),NULL,p_table_id );
  END;
  /*END Entity_audit_record_insert*/
  /*TO BE CALLED WHEN RECORD DELETED*/
  PROCEDURE entity_audit_record_delete(p_table_name IN VARCHAR2,
                                       p_table_id   IN NUMBER,
                                       p_username   IN VARCHAR2,
                                       p_audit_id   OUT NUMBER)
  IS
    DML_EVENT VARCHAR2(25);
  BEGIN
      p_audit_id := NULL;

      p_audit_id := ENTITY_AUDIT_SEQ.NEXTVAL;

      INSERT INTO MMOHONEY.ENTITY_AUDIT
                  (ID,
                   USERNAME,
                   TIMESTAMP,
                   DML_EVENT_TYPE,
                   TABLE_NAME,
                   COLUMN_NAME,
                   NEW_VALUE,
                   OLD_VALUE,
                   TABLE_ID)
           VALUES ( p_audit_id,p_username,SYSTIMESTAMP,'DELETE',Upper(p_table_name),'DELETE',NULL,To_char(p_table_id),p_table_id );
  END;
  /*END Entity_audit_record_delete*/
  /*OVERLOADED METHOD - TO BE CALLED WHEN VALUES ARE CHANGING */
  PROCEDURE entity_audit_check_val(p_dml_event   IN VARCHAR2,
                                   p_table_name  IN VARCHAR2,
                                   p_column_name IN VARCHAR2,
                                   p_table_id    IN NUMBER,
                                   p_username    IN VARCHAR2,
                                   p_new_value   IN VARCHAR2,
                                   p_old_value   IN VARCHAR2,
                                   p_audit_id    OUT NUMBER)
  IS
  BEGIN
      p_audit_id := NULL;

      IF ( p_new_value <> p_old_value
            OR ( p_new_value IS NULL
                 AND p_old_value IS NOT NULL )
            OR ( p_new_value IS NOT NULL
                 AND p_old_value IS NULL ) ) THEN
        p_audit_id := ENTITY_AUDIT_SEQ.NEXTVAL;

        INSERT INTO MMOHONEY.ENTITY_AUDIT
                    (ID,
                     USERNAME,
                     TIMESTAMP,
                     DML_EVENT_TYPE,
                     TABLE_NAME,
                     COLUMN_NAME,
                     NEW_VALUE,
                     OLD_VALUE,
                     TABLE_ID)
             VALUES ( p_audit_id,p_username,SYSTIMESTAMP,Upper(p_dml_event),Upper(p_table_name),Upper(p_column_name),p_new_value,p_old_value,p_table_id );
      END IF;
  END;
  /*END entity_audit_check_val*/
  /*OVERLOADED METHOD - TO BE CALLED WHEN VALUES ARE CHANGING */
  PROCEDURE entity_audit_check_val(p_dml_event   IN VARCHAR2,
                                   p_table_name  IN VARCHAR2,
                                   p_column_name IN VARCHAR2,
                                   p_table_id    IN NUMBER,
                                   p_username    IN VARCHAR2,
                                   p_new_value   IN TIMESTAMP,
                                   p_old_value   IN TIMESTAMP,
                                   p_audit_id    OUT NUMBER)
  IS
  BEGIN
      p_audit_id := NULL;

      IF ( p_new_value <> p_old_value
            OR ( p_new_value IS NULL
                 AND p_old_value IS NOT NULL )
            OR ( p_new_value IS NOT NULL
                 AND p_old_value IS NULL ) ) THEN
        p_audit_id := ENTITY_AUDIT_SEQ.NEXTVAL;

        INSERT INTO MMOHONEY.ENTITY_AUDIT
                    (ID,
                     USERNAME,
                     TIMESTAMP,
                     DML_EVENT_TYPE,
                     TABLE_NAME,
                     COLUMN_NAME,
                     NEW_VALUE,
                     OLD_VALUE,
                     TABLE_ID)
             VALUES ( p_audit_id,p_username,SYSTIMESTAMP,Upper(p_dml_event),Upper(p_table_name),Upper(p_column_name),(SELECT Nvl(To_char(p_new_value, 'yyyy-mm-dd hh24:mi:ss'), NULL)
                                                                                                                       FROM dual),(SELECT Nvl(To_char(p_old_value, 'yyyy-mm-dd hh24:mi:ss'), NULL)
                                                                                                                                     FROM dual),p_table_id);
      END IF;
  END;
  /*END entity_audit_check_val*/
  /*OVERLOADED METHOD - TO BE CALLED WHEN VALUES ARE CHANGING */
  PROCEDURE entity_audit_check_val(p_dml_event   IN VARCHAR2,
                                   p_table_name  IN VARCHAR2,
                                   p_column_name IN VARCHAR2,
                                   p_table_id    IN NUMBER,
                                   p_username    IN VARCHAR2,
                                   p_new_value   IN NUMBER,
                                   p_old_value   IN NUMBER,
                                   p_audit_id    OUT NUMBER)
  IS
  BEGIN
      p_audit_id := NULL;

      IF ( p_new_value <> p_old_value
            OR ( p_new_value IS NULL
                 AND p_old_value IS NOT NULL )
            OR ( p_new_value IS NOT NULL
                 AND p_old_value IS NULL ) ) THEN
        p_audit_id := ENTITY_AUDIT_SEQ.NEXTVAL;

        INSERT INTO MMOHONEY.ENTITY_AUDIT
                    (ID,
                     USERNAME,
                     TIMESTAMP,
                     DML_EVENT_TYPE,
                     TABLE_NAME,
                     COLUMN_NAME,
                     NEW_VALUE,
                     OLD_VALUE,
                     TABLE_ID)
             VALUES ( p_audit_id,p_username,SYSTIMESTAMP,Upper(p_dml_event),Upper(p_table_name),Upper(p_column_name),p_new_value,p_old_value,p_table_id );
      END IF;
  END;
  /*END entity_audit_check_val*/
END AUDIT_PACKAGE;
