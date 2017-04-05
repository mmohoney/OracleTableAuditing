# OracleTableAuditing
Complete Oracle Schema for Table Auditing

1. Open each script in order they are numbered in.
2. Replace the user "MMOHONEY" with the user you are applying the schema to.
3. Run each script, 1 through 7, and confirm changes were applied to the database.
4. After changes have been applied to the database, run each statement in script numbered 8. This will confirm and demonstrate the scripts. NOTE: If your sql application does not open a session for each window you will need to put a "commit;" after each statement to view the changes. 

- It should be noted ENTITY_AUDIT should house all tables you are auditing. There is no need to create a separate table for each table you will be auditing. In production our table is approaching half a billion (with a B) records without any application performance degradation with nearly 150 tables audited.

- Columns get added to tables all the time. This can make it difficult to find columns which may have missing audit triggers. Run the script titled "FIND_MISSING_AUDIT_COLUMNS" to find any columns where the table is being audited, but individual columns are not. 

- If you wish to find tables which are missing audit triggers, run the script titled "FIND_MISSING_AUDIT_TABLES". This can identify tables that have been added but should be audited.
