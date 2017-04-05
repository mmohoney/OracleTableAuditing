CREATE OR REPLACE PACKAGE MMOHONEY.AUDIT_PACKAGE
AS
  /*UPDATE THE DISPLAY_TEXT COLUMN ON THE AUDIT RECORD - GENERALLY TEXT FOR USERS*/
  PROCEDURE entity_audit_update_text(
    p_audit_id IN NUMBER,
    p_text     IN VARCHAR2);
  /*TO BE CALLED WHEN RECORD INSERTED*/
  PROCEDURE entity_audit_record_insert(
    p_table_name IN VARCHAR2,
    p_table_id   IN NUMBER,
    p_username   IN VARCHAR2,
    p_audit_id   OUT NUMBER);
  /*TO BE CALLED WHEN RECORD DELETED*/
  PROCEDURE entity_audit_record_delete(
    p_table_name IN VARCHAR2,
    p_table_id   IN NUMBER,
    p_username   IN VARCHAR2,
    p_audit_id   OUT NUMBER );
  /*OVERLOADED METHOD - TO BE CALLED WHEN VALUES ARE CHANGING */
  PROCEDURE entity_audit_check_val(
    p_dml_event   IN VARCHAR2,
    p_table_name  IN VARCHAR2,
    p_column_name IN VARCHAR2,
    p_table_id    IN NUMBER,
    p_username    IN VARCHAR2,
    p_new_value   IN VARCHAR2,
    p_old_value   IN VARCHAR2,
    p_audit_id    OUT NUMBER );
  /*OVERLOADED METHOD - TO BE CALLED WHEN VALUES ARE CHANGING */
  PROCEDURE entity_audit_check_val(
    p_dml_event   IN VARCHAR2,
    p_table_name  IN VARCHAR2,
    p_column_name IN VARCHAR2,
    p_table_id    IN NUMBER,
    p_username    IN VARCHAR2,
    p_new_value   IN TIMESTAMP,
    p_old_value   IN TIMESTAMP,
    p_audit_id    OUT NUMBER );
  /*OVERLOADED METHOD - TO BE CALLED WHEN VALUES ARE CHANGING */
  PROCEDURE entity_audit_check_val(
    p_dml_event   IN VARCHAR2,
    p_table_name  IN VARCHAR2,
    p_column_name IN VARCHAR2,
    p_table_id    IN NUMBER,
    p_username    IN VARCHAR2,
    p_new_value   IN NUMBER,
    p_old_value   IN NUMBER,
    p_audit_id    OUT NUMBER );
END; 
