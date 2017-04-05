SELECT DISTINCT T.table_name
  FROM all_tab_columns T
       LEFT JOIN all_triggers A
              ON A.TABLE_NAME = T.TABLE_NAME
                 AND A.OWNER = T.OWNER
                 AND ( Upper(dbms_metadata.Get_ddl('TRIGGER', A.TRIGGER_NAME, A.OWNER)) LIKE Upper('%check_val(%' || T.column_name || '%)%') )
WHERE T.OWNER IN( 'MMOHONEY' )
   AND T.COLUMN_NAME NOT IN ( 'ID', 'CREATED_DATE', 'CREATED_BY', 'MODIFIED_DATE', 'MODIFIED_BY' )
   AND A.TABLE_NAME IS NULL
