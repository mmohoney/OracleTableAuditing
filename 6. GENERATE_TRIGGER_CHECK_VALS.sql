SELECT A.COLUMN_ID, 'MMOHONEY.AUDIT_PACKAGE.entity_audit_check_val(DML_EVENT, TABLE_NAME, ''' || A.COLUMN_NAME ||  ''', TABLE_ID, USERNAME, :new.' || A.COLUMN_NAME ||', :old.' || A.COLUMN_NAME || ');' AS MAPPING
  FROM all_tab_cols A
 WHERE table_name = 'DUMMY_TABLE_TO_AUDIT'
   AND OWNER = 'MMOHONEY'
   AND A.COLUMN_NAME NOT LIKE 'SYS%'
   AND A.COLUMN_NAME NOT IN ( 'ID', 'CREATED_DATE', 'CREATED_BY', 'MODIFIED_DATE', 'MODIFIED_BY' )
 ORDER BY A.COLUMN_ID; 
