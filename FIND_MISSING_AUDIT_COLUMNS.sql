SELECT T.OWNER,
       T.TABLE_NAME,
       T.COLUMN_NAME,
       TD.TRIGGER_NAME
  FROM (SELECT T.OWNER,
               T.TABLE_NAME,
               A.TRIGGER_NAME,
               Upper(dbms_metadata.Get_ddl('TRIGGER', A.TRIGGER_NAME, T.OWNER)) AS DDL
          FROM all_tables T
               JOIN all_triggers A
                 ON T.OWNER = A.OWNER
                    AND T.TABLE_NAME = A.TABLE_NAME
         WHERE T.OWNER IN ( 'MMOHONEY' )) TD
       JOIN all_tab_columns T
         ON TD.OWNER = T.OWNER
            AND TD.TABLE_NAME = T.TABLE_NAME
 WHERE T.COLUMN_NAME NOT IN ( 'ID', 'CREATED_DATE', 'CREATED_BY', 'MODIFIED_DATE', 'MODIFIED_BY' )
   AND ( Upper(TD.DDL) LIKE Upper('%AUDIT_PACKAGE%') )
   AND NOT ( Upper(TD.DDL) LIKE Upper('%check_val(%' || T.column_name || '%)%') )
 ORDER BY T.OWNER,
          T.TABLE_NAME,
          T.COLUMN_NAME,
          TD.TRIGGER_NAME;
