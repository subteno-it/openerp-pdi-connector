-- Repository creation/upgrade DDL: 
--
-- Nothing was created nor modified in the target repository database.
-- Hit the OK button to execute the generated SQL or Close to reject the changes.
-- Please note that it is possible to change/edit the generated SQL before execution.
--
CREATE TABLE R_REPOSITORY_LOG
(
  ID_REPOSITORY_LOG BIGSERIAL
, REP_VERSION VARCHAR(255)
, LOG_DATE TIMESTAMP
, LOG_USER VARCHAR(255)
, OPERATION_DESC VARCHAR(2000000)
)
;

CREATE TABLE R_VERSION
(
  ID_VERSION BIGSERIAL
, MAJOR_VERSION SMALLINT
, MINOR_VERSION SMALLINT
, UPGRADE_DATE TIMESTAMP
, IS_UPGRADE BOOLEAN
)
;

INSERT INTO R_VERSION(ID_VERSION, MAJOR_VERSION, MINOR_VERSION, UPGRADE_DATE, IS_UPGRADE) VALUES (1,4,0,'2010/11/25 17:09:58.782',E'N');

CREATE TABLE R_DATABASE_TYPE
(
  ID_DATABASE_TYPE BIGSERIAL
, CODE VARCHAR(255)
, DESCRIPTION VARCHAR(255)
)
;

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (1,E'DERBY',E'Apache Derby');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (2,E'AS/400',E'AS/400');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (3,E'INTERBASE',E'Borland Interbase');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (4,E'INFINIDB',E'Calpont InfiniDB');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (5,E'DBASE',E'dBase III, IV or 5');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (6,E'EXTENDB',E'ExtenDB');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (7,E'FIREBIRD',E'Firebird SQL');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (8,E'GENERIC',E'Generic database');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (9,E'GREENPLUM',E'Greenplum');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (10,E'SQLBASE',E'Gupta SQL Base');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (11,E'H2',E'H2');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (12,E'HYPERSONIC',E'Hypersonic');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (13,E'DB2',E'IBM DB2');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (14,E'INFOBRIGHT',E'Infobright');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (15,E'INFORMIX',E'Informix');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (16,E'INGRES',E'Ingres');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (17,E'CACHE',E'Intersystems Cache');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (18,E'KINGBASEES',E'KingbaseES');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (19,E'LucidDB',E'LucidDB');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (20,E'SAPDB',E'MaxDB (SAP DB)');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (21,E'MONETDB',E'MonetDB');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (22,E'MSACCESS',E'MS Access');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (23,E'MSSQL',E'MS SQL Server');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (24,E'MSSQLNATIVE',E'MS SQL Server (Native)');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (25,E'MYSQL',E'MySQL');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (26,E'NEOVIEW',E'Neoview');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (27,E'NETEZZA',E'Netezza');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (28,E'ORACLE',E'Oracle');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (29,E'ORACLERDB',E'Oracle RDB');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (30,E'PALO',E'Palo MOLAP Server');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (31,E'POSTGRESQL',E'PostgreSQL');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (32,E'REMEDY-AR-SYSTEM',E'Remedy Action Request System');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (33,E'SAPR3',E'SAP ERP System');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (34,E'SQLITE',E'SQLite');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (35,E'SYBASE',E'Sybase');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (36,E'SYBASEIQ',E'SybaseIQ');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (37,E'TERADATA',E'Teradata');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (38,E'UNIVERSE',E'UniVerse database');

INSERT INTO R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (39,E'VERTICA',E'Vertica');

CREATE TABLE R_DATABASE_CONTYPE
(
  ID_DATABASE_CONTYPE BIGSERIAL
, CODE VARCHAR(255)
, DESCRIPTION VARCHAR(255)
)
;

INSERT INTO R_DATABASE_CONTYPE(ID_DATABASE_CONTYPE, CODE, DESCRIPTION) VALUES (1,E'Native',E'Native (JDBC)');

INSERT INTO R_DATABASE_CONTYPE(ID_DATABASE_CONTYPE, CODE, DESCRIPTION) VALUES (2,E'ODBC',E'ODBC');

INSERT INTO R_DATABASE_CONTYPE(ID_DATABASE_CONTYPE, CODE, DESCRIPTION) VALUES (3,E'OCI',E'OCI');

INSERT INTO R_DATABASE_CONTYPE(ID_DATABASE_CONTYPE, CODE, DESCRIPTION) VALUES (4,E'Plugin',E'Plugin specific access method');

INSERT INTO R_DATABASE_CONTYPE(ID_DATABASE_CONTYPE, CODE, DESCRIPTION) VALUES (5,E'JNDI',E'JNDI');

CREATE TABLE R_NOTE
(
  ID_NOTE BIGSERIAL
, VALUE_STR VARCHAR(2000000)
, GUI_LOCATION_X INTEGER
, GUI_LOCATION_Y INTEGER
, GUI_LOCATION_WIDTH INTEGER
, GUI_LOCATION_HEIGHT INTEGER
, FONT_NAME VARCHAR(2000000)
, FONT_SIZE INTEGER
, FONT_BOLD BOOLEAN
, FONT_ITALIC BOOLEAN
, FONT_COLOR_RED INTEGER
, FONT_COLOR_GREEN INTEGER
, FONT_COLOR_BLUE INTEGER
, FONT_BACK_GROUND_COLOR_RED INTEGER
, FONT_BACK_GROUND_COLOR_GREEN INTEGER
, FONT_BACK_GROUND_COLOR_BLUE INTEGER
, FONT_BORDER_COLOR_RED INTEGER
, FONT_BORDER_COLOR_GREEN INTEGER
, FONT_BORDER_COLOR_BLUE INTEGER
, DRAW_SHADOW BOOLEAN
)
;

CREATE TABLE R_DATABASE
(
  ID_DATABASE BIGSERIAL
, "name" VARCHAR(255)
, ID_DATABASE_TYPE INTEGER
, ID_DATABASE_CONTYPE INTEGER
, HOST_NAME VARCHAR(255)
, DATABASE_NAME VARCHAR(255)
, PORT INTEGER
, USERNAME VARCHAR(255)
, "password" VARCHAR(255)
, SERVERNAME VARCHAR(255)
, DATA_TBS VARCHAR(255)
, INDEX_TBS VARCHAR(255)
)
;

CREATE TABLE R_DATABASE_ATTRIBUTE
(
  ID_DATABASE_ATTRIBUTE BIGSERIAL
, ID_DATABASE INTEGER
, CODE VARCHAR(255)
, VALUE_STR VARCHAR(2000000)
)
;

CREATE UNIQUE INDEX IDX_DATABASE_ATTRIBUTE_AK
 ON R_DATABASE_ATTRIBUTE
( 
  ID_DATABASE
, CODE
)
;

CREATE TABLE R_DIRECTORY
(
  ID_DIRECTORY BIGSERIAL
, ID_DIRECTORY_PARENT INTEGER
, DIRECTORY_NAME VARCHAR(255)
)
;

CREATE UNIQUE INDEX IDX_DIRECTORY_AK
 ON R_DIRECTORY
( 
  ID_DIRECTORY_PARENT
, DIRECTORY_NAME
)
;

CREATE TABLE R_TRANSFORMATION
(
  ID_TRANSFORMATION BIGSERIAL
, ID_DIRECTORY INTEGER
, "name" VARCHAR(255)
, DESCRIPTION VARCHAR(2000000)
, EXTENDED_DESCRIPTION VARCHAR(2000000)
, TRANS_VERSION VARCHAR(255)
, TRANS_STATUS INTEGER
, ID_STEP_READ INTEGER
, ID_STEP_WRITE INTEGER
, ID_STEP_INPUT INTEGER
, ID_STEP_OUTPUT INTEGER
, ID_STEP_UPDATE INTEGER
, ID_DATABASE_LOG INTEGER
, TABLE_NAME_LOG VARCHAR(255)
, USE_BATCHID BOOLEAN
, USE_LOGFIELD BOOLEAN
, ID_DATABASE_MAXDATE INTEGER
, TABLE_NAME_MAXDATE VARCHAR(255)
, FIELD_NAME_MAXDATE VARCHAR(255)
, OFFSET_MAXDATE NUMERIC(12, 2)
, DIFF_MAXDATE NUMERIC(12, 2)
, CREATED_USER VARCHAR(255)
, CREATED_DATE TIMESTAMP
, MODIFIED_USER VARCHAR(255)
, MODIFIED_DATE TIMESTAMP
, SIZE_ROWSET INTEGER
)
;

CREATE TABLE R_TRANS_ATTRIBUTE
(
  ID_TRANS_ATTRIBUTE BIGSERIAL
, ID_TRANSFORMATION INTEGER
, NR INTEGER
, CODE VARCHAR(255)
, VALUE_NUM BIGINT
, VALUE_STR VARCHAR(2000000)
)
;

CREATE UNIQUE INDEX IDX_TRANS_ATTRIBUTE_LOOKUP
 ON R_TRANS_ATTRIBUTE
( 
  ID_TRANSFORMATION
, CODE
, NR
)
;

CREATE TABLE R_JOB_ATTRIBUTE
(
  ID_JOB_ATTRIBUTE BIGSERIAL
, ID_JOB INTEGER
, NR INTEGER
, CODE VARCHAR(255)
, VALUE_NUM BIGINT
, VALUE_STR VARCHAR(2000000)
)
;

CREATE UNIQUE INDEX IDX_JOB_ATTRIBUTE_LOOKUP
 ON R_JOB_ATTRIBUTE
( 
  ID_JOB
, CODE
, NR
)
;

CREATE TABLE R_DEPENDENCY
(
  ID_DEPENDENCY BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_DATABASE INTEGER
, "table_name" VARCHAR(255)
, FIELD_NAME VARCHAR(255)
)
;

CREATE TABLE R_PARTITION_SCHEMA
(
  ID_PARTITION_SCHEMA BIGSERIAL
, "name" VARCHAR(255)
, DYNAMIC_DEFINITION BOOLEAN
, PARTITIONS_PER_SLAVE VARCHAR(255)
)
;

CREATE TABLE R_PARTITION
(
  ID_PARTITION BIGSERIAL
, ID_PARTITION_SCHEMA INTEGER
, PARTITION_ID VARCHAR(255)
)
;

CREATE TABLE R_TRANS_PARTITION_SCHEMA
(
  ID_TRANS_PARTITION_SCHEMA BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_PARTITION_SCHEMA INTEGER
)
;

CREATE TABLE R_CLUSTER
(
  ID_CLUSTER BIGSERIAL
, "name" VARCHAR(255)
, BASE_PORT VARCHAR(255)
, SOCKETS_BUFFER_SIZE VARCHAR(255)
, SOCKETS_FLUSH_INTERVAL VARCHAR(255)
, SOCKETS_COMPRESSED BOOLEAN
, DYNAMIC_CLUSTER BOOLEAN
)
;

CREATE TABLE R_SLAVE
(
  ID_SLAVE BIGSERIAL
, "name" VARCHAR(255)
, HOST_NAME VARCHAR(255)
, PORT VARCHAR(255)
, WEB_APP_NAME VARCHAR(255)
, USERNAME VARCHAR(255)
, "password" VARCHAR(255)
, PROXY_HOST_NAME VARCHAR(255)
, PROXY_PORT VARCHAR(255)
, NON_PROXY_HOSTS VARCHAR(255)
, MASTER BOOLEAN
)
;

CREATE TABLE R_CLUSTER_SLAVE
(
  ID_CLUSTER_SLAVE BIGSERIAL
, ID_CLUSTER INTEGER
, ID_SLAVE INTEGER
)
;

CREATE TABLE R_TRANS_SLAVE
(
  ID_TRANS_SLAVE BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_SLAVE INTEGER
)
;

CREATE TABLE R_TRANS_CLUSTER
(
  ID_TRANS_CLUSTER BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_CLUSTER INTEGER
)
;

CREATE TABLE R_TRANS_HOP
(
  ID_TRANS_HOP BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_STEP_FROM INTEGER
, ID_STEP_TO INTEGER
, ENABLED BOOLEAN
)
;

CREATE TABLE R_TRANS_STEP_CONDITION
(
  ID_TRANSFORMATION INTEGER
, ID_STEP INTEGER
, ID_CONDITION INTEGER
)
;

CREATE TABLE R_CONDITION
(
  ID_CONDITION BIGSERIAL
, ID_CONDITION_PARENT INTEGER
, NEGATED BOOLEAN
, "operator" VARCHAR(255)
, LEFT_NAME VARCHAR(255)
, CONDITION_FUNCTION VARCHAR(255)
, RIGHT_NAME VARCHAR(255)
, ID_VALUE_RIGHT INTEGER
)
;

CREATE TABLE R_VALUE
(
  ID_VALUE BIGSERIAL
, "name" VARCHAR(255)
, VALUE_TYPE VARCHAR(255)
, VALUE_STR VARCHAR(255)
, IS_NULL BOOLEAN
)
;

CREATE TABLE R_STEP_TYPE
(
  ID_STEP_TYPE BIGSERIAL
, CODE VARCHAR(255)
, DESCRIPTION VARCHAR(255)
, HELPTEXT VARCHAR(255)
)
;

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (1,E'Abort',E'Abort',E'Abort a transformation');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (2,E'AccessInput',E'Access Input',E'Read data from a Microsoft Access file');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (3,E'AccessOutput',E'Access Output',E'Stores records into an MS-Access database table.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (4,E'CheckSum',E'Add a checksum',E'Add a checksum column for each input row');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (5,E'Constant',E'Add constants',E'Add one or more constants to the input rows');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (6,E'Sequence',E'Add sequence',E'Get the next value from an sequence');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (7,E'FieldsChangeSequence',E'Add value fields changing sequence',E'Add sequence depending of fields value change.\nEach time value of at least one field change, PDI will reset sequence. ');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (8,E'AddXML',E'Add XML',E'Encode several fields into an XML fragment');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (9,E'AggregateRows',E'Aggregate Rows',E'This step type allows you to aggregate rows.\nIt can''t do groupings.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (10,E'AnalyticQuery',E'Analytic Query',E'Execute analytic queries over a sorted dataset (LEAD/LAG/FIRST/LAST)');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (11,E'Append',E'Append streams',E'Append 2 streams in an ordered way');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (12,E'BlockingStep',E'Blocking Step',E'This step blocks until all incoming rows have been processed.  Subsequent steps only recieve the last input row to this step.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (13,E'Calculator',E'Calculator',E'Create new fields by performing simple calculations');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (14,E'DBProc',E'Call DB Procedure',E'Get back information by calling a database procedure.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (15,E'ChangeFileEncoding',E'Change file encoding',E'Change file encoding and create a new file');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (16,E'ColumnExists',E'Check if a column exists',E'Check if a column exists in a table on a specified connection.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (17,E'FileLocked',E'Check if file is locked',E'Check if a file is locked by another process');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (18,E'WebServiceAvailable',E'Check if webservice is available',E'Check if a webservice is available');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (19,E'CloneRow',E'Clone row',E'Clone a row as many times as needed');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (20,E'ClosureGenerator',E'Closure Generator',E'This step allows you to generates a closure table using parent-child relationships.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (21,E'CombinationLookup',E'Combination lookup/update',E'Update a junk dimension in a data warehouse.\nAlternatively, look up information in this dimension.\nThe primary key of a junk dimension are all the fields.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (22,E'RowsToResult',E'Copy rows to result',E'Use this step to write rows to the executing job.\nThe information will then be passed to the next entry in this job.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (23,E'CreditCardValidator',E'Credit card validator',E'The Credit card validator step will help you tell:\n(1) if a credit card number is valid (uses LUHN10 (MOD-10) algorithm)\n(2) which credit card vendor handles that number\n(VISA, MasterCard, Diners Club, EnRoute, American Express (AMEX),...)');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (24,E'CsvInput',E'CSV file input',E'Simple CSV file input');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (25,E'DataGrid',E'Data Grid',E'Enter rows of static data in a grid, usually for testing, reference or demo purpose');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (26,E'Validator',E'Data Validator',E'Validates passing data based on a set of rules');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (27,E'DBJoin',E'Database join',E'Execute a database query using stream values as parameters');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (28,E'DBLookup',E'Database lookup',E'Look up values in a database using field values');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (29,E'CubeInput',E'De-serialize from file',E'Read rows of data from a data cube.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (30,E'Delay',E'Delay row',E'Output each input row after a delay');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (31,E'Delete',E'Delete',E'Delete data in a database table based upon keys');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (32,E'DetectEmptyStream',E'Detect empty stream',E'This step will output one empty row if input stream is empty\n(ie when input stream does not contain any row)');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (33,E'DimensionLookup',E'Dimension lookup/update',E'Update a slowly changing dimension in a data warehouse.\nAlternatively, look up information in this dimension.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (34,E'Dummy',E'Dummy (do nothing)',E'This step type doesn''t do anything.\nIt''s useful however when testing things or in certain situations where you want to split streams.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (35,E'DummyPlugin',E'Dummy plugin',E'This is a dummy plugin test step');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (36,E'DynamicSQLRow',E'Dynamic SQL row',E'Execute dynamic SQL statement build in a previous field');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (37,E'MailInput',E'Email messages input',E'Read POP3/IMAP server and retrieve messages');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (38,E'ShapeFileReader',E'ESRI Shapefile Reader',E'Reads shape file data from an ESRI shape file and linked DBF file');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (39,E'ExcelInput',E'Excel Input',E'Read data from a Microsoft Excel Workbook.  This works with Excel sheets of Excel 95, 97 and 2000.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (40,E'ExcelOutput',E'Excel Output',E'Stores records into an Excel (XLS) document with formatting information.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (41,E'ExecProcess',E'Execute a process',E'Execute a process and return the result');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (42,E'ExecSQLRow',E'Execute row SQL script',E'Execute SQL script extracted from a field\ncreated in a previous step.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (43,E'ExecSQL',E'Execute SQL script',E'Execute an SQL script, optionally parameterized using input rows');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (44,E'FileExists',E'File exists',E'Check if a file exists');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (45,E'FilterRows',E'Filter rows',E'Filter rows using simple equations');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (46,E'FixedInput',E'Fixed file input',E'Fixed file input');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (47,E'Formula',E'Formula',E'Calculate a formula using Pentaho''s libformula');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (48,E'FuzzyMatch',E'Fuzzy match',E'Finding approximate matches to a string using matching algorithms.\nRead a field from a main stream and output approximative value from lookup stream.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (49,E'RandomValue',E'Generate random value',E'Generate random value');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (50,E'RowGenerator',E'Generate Rows',E'Generate a number of empty or equal rows.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (51,E'getXMLData',E'Get data from XML',E'Get data from XML file by using XPath.\n This step also allows you to parse XML defined in a previous field.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (52,E'GetFileNames',E'Get File Names',E'Get file names from the operating system and send them to the next step.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (53,E'FilesFromResult',E'Get files from result',E'This step allows you to read filenames used or generated in a previous entry in a job.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (54,E'GetFilesRowsCount',E'Get Files Rows Count',E'Get Files Rows Count');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (55,E'GetPreviousRowField',E'Get previous row fields',E'Get fields value of previous row.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (56,E'RowsFromResult',E'Get rows from result',E'This allows you to read rows from a previous entry in a job.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (57,E'GetSubFolders',E'Get SubFolder names',E'Read a parent folder and return all subfolders');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (58,E'SystemInfo',E'Get System Info',E'Get information from the system like system date, arguments, etc.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (59,E'GetTableNames',E'Get table names',E'Get table names from database connection and send them to the next step');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (60,E'GetVariable',E'Get Variables',E'Determine the values of certain (environment or Kettle) variables and put them in field values.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (61,E'GPBulkLoader',E'Greenplum Bulk Loader',E'Greenplum Bulk Loader');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (62,E'GroupBy',E'Group by',E'Builds aggregates in a group by fashion.\nThis works only on a sorted input.\nIf the input is not sorted, only double consecutive rows are handled correctly.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (63,E'ParallelGzipCsvInput',E'GZIP CSV Input',E'Parallel GZIP CSV file input reader');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (64,E'HTTP',E'HTTP client',E'Call a web service over HTTP by supplying a base URL by allowing parameters to be set dynamically');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (65,E'HTTPPOST',E'HTTP Post',E'Call a web service request over HTTP by supplying a base URL by allowing parameters to be set dynamically');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (66,E'DetectLastRow',E'Identify last row in a stream',E'Last row will be marked');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (67,E'IfNull',E'If field value is null',E'Sets a field value to a constant if it is null.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (68,E'InfobrightOutput',E'Infobright Loader',E'Load data to an Infobright database table');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (69,E'Injector',E'Injector',E'Injector step to allow to inject rows into the transformation through the java API');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (70,E'InsertUpdate',E'Insert / Update',E'Update or insert rows in a database based upon keys.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (71,E'JavaFilter',E'Java Filter',E'Filter rows using java code');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (72,E'JoinRows',E'Join Rows (cartesian product)',E'The output of this step is the cartesian product of the input streams.\nThe number of rows is the multiplication of the number of rows in the input streams.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (73,E'LDAPInput',E'LDAP Input',E'Read data from LDAP host');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (74,E'LDIFInput',E'LDIF Input',E'Read data from LDIF files');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (75,E'LoadFileInput',E'Load file content in memory',E'Load file content in memory');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (76,E'LucidDBBulkLoader',E'LucidDB Bulk Loader',E'Load data into LucidDB by using their bulk load command in streaming mode. (Doesnt work on Windows!)');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (77,E'LucidDBStreamingLoader',E'LucidDB Streaming Loader',E'Load data into LucidDB by using Remote Rows UDX.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (78,E'Mail',E'Mail',E'Send eMail.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (79,E'MailValidator',E'Mail Validator',E'Check if an email address is valid.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (80,E'Mapping',E'Mapping (sub-transformation)',E'Run a mapping (sub-transformation), use MappingInput and MappingOutput to specify the fields interface');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (81,E'MappingInput',E'Mapping input specification',E'Specify the input interface of a mapping');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (82,E'MappingOutput',E'Mapping output specification',E'Specify the output interface of a mapping');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (83,E'MemoryGroupBy',E'Memory Group by',E'Builds aggregates in a group by fashion.\nThis step doesn''t require sorted input.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (84,E'MergeJoin',E'Merge Join',E'Joins two streams on a given key and outputs a joined set. The input streams must be sorted on the join key');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (85,E'MergeRows',E'Merge Rows (diff)',E'Merge two streams of rows, sorted on a certain key.  The two streams are compared and the equals, changed, deleted and new rows are flagged.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (86,E'StepMetastructure',E'Metadata structure of stream',E'This is a step to read the metadata of the incoming stream.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (87,E'ScriptValueMod',E'Modified Java Script Value',E'This is a modified plugin for the Scripting Values with improved interface and performance.\nWritten & donated to open source by Martin Lange, Proconis : http://www.proconis.de');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (88,E'MondrianInput',E'Mondrian Input',E'Execute and retrieve data using an MDX query against a Pentaho Analyses OLAP server (Mondrian)');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (89,E'MonetDBBulkLoader',E'MonetDB Bulk Loader',E'Load data into MonetDB by using their bulk load command in streaming mode.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (90,E'MySQLBulkLoader',E'MySQL Bulk Loader',E'MySQL bulk loader step, loading data over a named pipe (not available on MS Windows)');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (91,E'NullIf',E'Null if...',E'Sets a field value to null if it is equal to a constant value');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (92,E'NumberRange',E'Number range',E'Create ranges based on numeric field');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (93,E'OlapInput',E'OLAP Input',E'Execute and retrieve data using an MDX query against any XML/A OLAP datasource using olap4j');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (94,E'OraBulkLoader',E'Oracle Bulk Loader',E'Use Oracle Bulk Loader to load data');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (95,E'PaloCellInput',E'Palo Cells Input  ',E'Reads data from a defined Palo Cube ');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (96,E'PaloCellOutput',E'Palo Cells Output  ',E'Writes data to a defined Palo Cube ');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (97,E'PaloDimInput',E'Palo Dimension Input  ',E'Reads data from a defined Palo Dimension ');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (98,E'PaloDimOutput',E'Palo Dimension Output  ',E'Writes data to defined Palo Dimension ');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (99,E'PGBulkLoader',E'PostgreSQL Bulk Loader',E'PostgreSQL Bulk Loader');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (100,E'ProcessFiles',E'Process files',E'Process one file per row (copy or move or delete).\nThis step only accept filename in input.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (101,E'PropertyOutput',E'Properties Output',E'Write data to properties file');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (102,E'PropertyInput',E'Property Input',E'Read data (key, value) from properties files.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (103,E'RegexEval',E'Regex Evaluation',E'Regular expression Evaluation\nThis step uses a regular expression to evaluate a field. It can also extract new fields out of an existing field with capturing groups.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (104,E'ReplaceString',E'Replace in string',E'Replace all occurences a word in a string with another word.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (105,E'ReservoirSampling',E'Reservoir Sampling',E'[Transform] Samples a fixed number of rows from the incoming stream');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (106,E'Denormaliser',E'Row denormaliser',E'Denormalises rows by looking up key-value pairs and by assigning them to new fields in the output rows.\nThis method aggregates and needs the input rows to be sorted on the grouping fields');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (107,E'Flattener',E'Row flattener',E'Flattens consecutive rows based on the order in which they appear in the input stream');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (108,E'Normaliser',E'Row Normaliser',E'De-normalised information can be normalised using this step type.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (109,E'RssInput',E'RSS Input',E'Read RSS feeds');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (110,E'RssOutput',E'RSS Output',E'Read RSS stream.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (111,E'S3CSVINPUT',E'S3 CSV Input',E'S3 CSV Input');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (112,E'SalesforceDelete',E'Salesforce Delete',E'Delete records in Salesforce module.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (113,E'SalesforceInput',E'Salesforce Input',E'!BaseStep.TypeTooltipDesc.SalesforceInput!');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (114,E'SalesforceInsert',E'Salesforce Insert',E'Insert records in Salesforce module.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (115,E'SalesforceUpdate',E'Salesforce Update',E'Update records in Salesforce module.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (116,E'SalesforceUpsert',E'Salesforce Upsert',E'Insert or update records in Salesforce module.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (117,E'SampleRows',E'Sample rows',E'Filter rows based on the line number.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (118,E'SapInput',E'SAP Input',E'Read data from SAP ERP, optionally with parameters');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (119,E'Script',E'Script',E'Calculate values by scripting in Ruby, Python, Groovy, JavaScript, ... (JSR-223)');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (120,E'SelectValues',E'Select values',E'Select or remove fields in a row.\nOptionally, set the field meta-data: type, length and precision.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (121,E'SyslogMessage',E'Send message to Syslog',E'Send message to Syslog server');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (122,E'CubeOutput',E'Serialize to file',E'Write rows of data to a data cube');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (123,E'SetValueField',E'Set field value',E'Set value of a field with another value field');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (124,E'SetValueConstant',E'Set field value to a constant',E'Set value of a field to a constant');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (125,E'FilesToResult',E'Set files in result',E'This step allows you to set filenames in the result of this transformation.\nSubsequent job entries can then use this information.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (126,E'SetVariable',E'Set Variables',E'Set environment variables based on a single input row.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (127,E'SocketReader',E'Socket reader',E'Socket reader.  A socket client that connects to a server (Socket Writer step).');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (128,E'SocketWriter',E'Socket writer',E'Socket writer.  A socket server that can send rows of data to a socket reader.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (129,E'SortRows',E'Sort rows',E'Sort rows based upon field values (ascending or descending)');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (130,E'SortedMerge',E'Sorted Merge',E'Sorted Merge');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (131,E'SplitFieldToRows3',E'Split field to rows',E'Splits a single string field by delimiter and creates a new row for each split term');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (132,E'FieldSplitter',E'Split Fields',E'When you want to split a single field into more then one, use this step type.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (133,E'SQLFileOutput',E'SQL File Output',E'Output SQL INSERT statements to file');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (134,E'StreamLookup',E'Stream lookup',E'Look up values coming from another stream in the transformation.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (135,E'XMLInputSax',E'Streaming XML Input',E'Read data from an XML file in a streaming fashing, working faster and consuming less memory');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (136,E'StringCut',E'Strings cut',E'Strings cut (substring).');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (137,E'SwitchCase',E'Switch / Case',E'Switch a row to a certain target step based on the case value in a field.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (138,E'SynchronizeAfterMerge',E'Synchronize after merge',E'This step perform insert/update/delete in one go based on the value of a field. ');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (139,E'TableExists',E'Table exists',E'Check if a table exists on a specified connection');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (140,E'TableInput',E'Table input',E'Read information from a database table.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (141,E'TableOutput',E'Table output',E'Write information to a database table');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (142,E'TeraFast',E'Teradata Fastload Bulk Loader',E'The Teradata Fastload Bulk loader');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (143,E'TextFileInput',E'Text file input',E'Read data from a text file in several formats.\nThis data can then be passed on to the next step(s)...');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (144,E'TextFileOutput',E'Text file output',E'Write rows to a text file.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (145,E'Unique',E'Unique rows',E'Remove double rows and leave only unique occurrences.\nThis works only on a sorted input.\nIf the input is not sorted, only double consecutive rows are handled correctly.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (146,E'UniqueRowsByHashSet',E'Unique rows (HashSet)',E'Remove double rows and leave only unique occurrences by using a HashSet.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (147,E'UnivariateStats',E'Univariate Statistics',E'This step computes some simple stats based on a single input field');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (148,E'Update',E'Update',E'Update data in a database table based upon keys');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (149,E'UserDefinedJavaClass',E'User Defined Java Class',E'This step allows you to program a step using Java code');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (150,E'Janino',E'User Defined Java Expression',E'Calculate the result of a Java Expression using Janino');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (151,E'ValueMapper',E'Value Mapper',E'Maps values of a certain field from one value to another');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (152,E'WebServiceLookup',E'Web services lookup',E'Look up information using web services (WSDL)');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (153,E'WriteToLog',E'Write to log',E'Write data to log');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (154,E'XBaseInput',E'XBase input',E'Reads records from an XBase type of database file (DBF)');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (155,E'XMLInput',E'XML Input',E'Read data from an XML file');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (156,E'XMLJoin',E'XML Join',E'Joins a stream of XML-Tags into a target XML string');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (157,E'XMLOutput',E'XML Output',E'Write data to an XML file');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (158,E'XSDValidator',E'XSD Validator',E'Validate XML source (files or streams) against XML Schema Definition.');

INSERT INTO R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (159,E'XSLT',E'XSL Transformation',E'Transform XML stream using XSL (eXtensible Stylesheet Language).');

CREATE TABLE R_STEP
(
  ID_STEP BIGSERIAL
, ID_TRANSFORMATION INTEGER
, "name" VARCHAR(255)
, DESCRIPTION VARCHAR(2000000)
, ID_STEP_TYPE INTEGER
, DISTRIBUTE BOOLEAN
, COPIES SMALLINT
, GUI_LOCATION_X INTEGER
, GUI_LOCATION_Y INTEGER
, GUI_DRAW BOOLEAN
)
;

CREATE TABLE R_STEP_ATTRIBUTE
(
  ID_STEP_ATTRIBUTE BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_STEP INTEGER
, NR INTEGER
, CODE VARCHAR(255)
, VALUE_NUM BIGINT
, VALUE_STR VARCHAR(2000000)
)
;

CREATE UNIQUE INDEX IDX_STEP_ATTRIBUTE_LOOKUP
 ON R_STEP_ATTRIBUTE
( 
  ID_STEP
, CODE
, NR
)
;

CREATE TABLE R_STEP_DATABASE
(
  ID_TRANSFORMATION INTEGER
, ID_STEP INTEGER
, ID_DATABASE INTEGER
)
;

CREATE INDEX IDX_STEP_DATABASE_LU1
 ON R_STEP_DATABASE
( 
  ID_TRANSFORMATION
)
;

CREATE INDEX IDX_STEP_DATABASE_LU2
 ON R_STEP_DATABASE
( 
  ID_DATABASE
)
;

CREATE TABLE R_TRANS_NOTE
(
  ID_TRANSFORMATION INTEGER
, ID_NOTE INTEGER
)
;

CREATE TABLE R_LOGLEVEL
(
  ID_LOGLEVEL BIGSERIAL
, CODE VARCHAR(255)
, DESCRIPTION VARCHAR(255)
)
;

INSERT INTO R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (1,E'Error',E'Error logging only');

INSERT INTO R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (2,E'Minimal',E'Minimal logging');

INSERT INTO R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (3,E'Basic',E'Basic logging');

INSERT INTO R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (4,E'Detailed',E'Detailed logging');

INSERT INTO R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (5,E'Debug',E'Debugging');

INSERT INTO R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (6,E'Rowlevel',E'Rowlevel (very detailed)');

CREATE TABLE R_LOG
(
  ID_LOG BIGSERIAL
, "name" VARCHAR(255)
, ID_LOGLEVEL INTEGER
, LOGTYPE VARCHAR(255)
, FILENAME VARCHAR(255)
, FILEEXTENTION VARCHAR(255)
, ADD_DATE BOOLEAN
, ADD_TIME BOOLEAN
, ID_DATABASE_LOG INTEGER
, TABLE_NAME_LOG VARCHAR(255)
)
;

CREATE TABLE R_JOB
(
  ID_JOB BIGSERIAL
, ID_DIRECTORY INTEGER
, "name" VARCHAR(255)
, DESCRIPTION VARCHAR(2000000)
, EXTENDED_DESCRIPTION VARCHAR(2000000)
, JOB_VERSION VARCHAR(255)
, JOB_STATUS INTEGER
, ID_DATABASE_LOG INTEGER
, TABLE_NAME_LOG VARCHAR(255)
, CREATED_USER VARCHAR(255)
, CREATED_DATE TIMESTAMP
, MODIFIED_USER VARCHAR(255)
, MODIFIED_DATE TIMESTAMP
, USE_BATCH_ID BOOLEAN
, PASS_BATCH_ID BOOLEAN
, USE_LOGFIELD BOOLEAN
, SHARED_FILE VARCHAR(255)
)
;

CREATE TABLE R_JOBENTRY_DATABASE
(
  ID_JOB INTEGER
, ID_JOBENTRY INTEGER
, ID_DATABASE INTEGER
)
;

CREATE INDEX IDX_JOBENTRY_DATABASE_LU1
 ON R_JOBENTRY_DATABASE
( 
  ID_JOB
)
;

CREATE INDEX IDX_JOBENTRY_DATABASE_LU2
 ON R_JOBENTRY_DATABASE
( 
  ID_DATABASE
)
;

CREATE TABLE R_JOBENTRY_TYPE
(
  ID_JOBENTRY_TYPE BIGSERIAL
, CODE VARCHAR(255)
, DESCRIPTION VARCHAR(255)
)
;

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (1,E'ABORT',E'Abort job');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (2,E'ADD_RESULT_FILENAMES',E'Add filenames to result');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (3,E'MYSQL_BULK_FILE',E'BulkLoad from Mysql into file');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (4,E'MSSQL_BULK_LOAD',E'BulkLoad into MSSQL');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (5,E'MYSQL_BULK_LOAD',E'BulkLoad into Mysql');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (6,E'CHECK_DB_CONNECTIONS',E'Check Db connections');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (7,E'CHECK_FILES_LOCKED',E'Check files locked');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (8,E'FOLDER_IS_EMPTY',E'Check if a folder is empty');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (9,E'CONNECTED_TO_REPOSITORY',E'Check if connected to repository');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (10,E'JobCategory.Category.XML_WELL_FORMED',E'Check if XML file is well formed');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (11,E'WEBSERVICE_AVAILABLE',E'Check webservice availability');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (12,E'FILES_EXIST',E'Checks if files exist');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (13,E'COLUMNS_EXIST',E'Columns exist in a table');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (14,E'FOLDERS_COMPARE',E'Compare folders');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (15,E'COPY_FILES',E'Copy Files');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (16,E'COPY_MOVE_RESULT_FILENAMES',E'Copy or Move result filenames');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (17,E'CREATE_FOLDER',E'Create a folder');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (18,E'CREATE_FILE',E'Create file');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (19,E'DELETE_FILE',E'Delete file');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (20,E'DELETE_RESULT_FILENAMES',E'Delete filenames from result');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (21,E'DELETE_FILES',E'Delete files');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (22,E'DELETE_FOLDERS',E'Delete folders');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (23,E'MSGBOX_INFO',E'Display Msgbox Info');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (24,E'DTD_VALIDATOR',E'DTD Validator');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (25,E'DummyJob',E'Dummy plugin');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (26,E'EVAL_FILES_METRICS',E'Evaluate files metrics');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (27,E'EVAL_TABLE_CONTENT',E'Evaluate rows number in a table');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (28,E'EXPORT_REPOSITORY',E'Export repository to XML file');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (29,E'FILE_COMPARE',E'File Compare');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (30,E'FILE_EXISTS',E'File Exists');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (31,E'FTP_DELETE',E'FTP Delete');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (32,E'FTP',E'Get a file with FTP');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (33,E'FTPS_GET',E'Get a file with FTPS');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (34,E'SFTP',E'Get a file with SFTP');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (35,E'GET_POP',E'Get mails (POP3/IMAP)');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (36,E'HTTP',E'HTTP');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (37,E'EVAL',E'JavaScript');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (38,E'JOB',E'Job');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (39,E'MAIL',E'Mail');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (40,E'JobCategory.Category.Mail_VALIDATOR',E'Mail validator');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (41,E'MOVE_FILES',E'Move Files');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (42,E'MS_ACCESS_BULK_LOAD',E'MS Access Bulk Load');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (43,E'PING',E'Ping a host');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (44,E'FTP_PUT',E'Put a file with FTP');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (45,E'SFTPPUT',E'Put a file with SFTP');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (46,E'SYSLOG',E'Send information using Syslog');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (47,E'SNMP_TRAP',E'Send SNMP trap');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (48,E'SET_VARIABLES',E'Set variables');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (49,E'SHELL',E'Shell');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (50,E'SIMPLE_EVAL',E'Simple evaluation');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (51,E'SPECIAL',E'Special entries');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (52,E'SQL',E'SQL');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (53,E'SSH2_GET',E'SSH2 Get');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (54,E'SSH2_PUT',E'SSH2 Put');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (55,E'SUCCESS',E'Success');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (56,E'TABLE_EXISTS',E'Table exists');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (57,E'TRANS',E'Transformation');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (58,E'TRUNCATE_TABLES',E'Truncate tables');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (59,E'UNZIP',E'Unzip file');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (60,E'FTPS_PUT',E'Upload files to FTPS');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (61,E'DELAY',E'Wait for');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (62,E'WAIT_FOR_FILE',E'Wait for file');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (63,E'WAIT_FOR_SQL',E'Wait for SQL');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (64,E'WRITE_TO_LOG',E'Write To Log');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (65,E'XSD_VALIDATOR',E'XSD Validator');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (66,E'XSLT',E'XSL Transformation');

INSERT INTO R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (67,E'ZIP_FILE',E'Zip file');

CREATE TABLE R_JOBENTRY
(
  ID_JOBENTRY BIGSERIAL
, ID_JOB INTEGER
, ID_JOBENTRY_TYPE INTEGER
, "name" VARCHAR(255)
, DESCRIPTION VARCHAR(2000000)
)
;

CREATE TABLE R_JOBENTRY_COPY
(
  ID_JOBENTRY_COPY BIGSERIAL
, ID_JOBENTRY INTEGER
, ID_JOB INTEGER
, ID_JOBENTRY_TYPE INTEGER
, NR SMALLINT
, GUI_LOCATION_X INTEGER
, GUI_LOCATION_Y INTEGER
, GUI_DRAW BOOLEAN
, PARALLEL BOOLEAN
)
;

CREATE TABLE R_JOBENTRY_ATTRIBUTE
(
  ID_JOBENTRY_ATTRIBUTE BIGSERIAL
, ID_JOB INTEGER
, ID_JOBENTRY INTEGER
, NR INTEGER
, CODE VARCHAR(255)
, VALUE_NUM NUMERIC(13, 2)
, VALUE_STR VARCHAR(2000000)
)
;

CREATE UNIQUE INDEX IDX_JOBENTRY_ATTRIBUTE_LOOKUP
 ON R_JOBENTRY_ATTRIBUTE
( 
  ID_JOBENTRY_ATTRIBUTE
, CODE
, NR
)
;

CREATE TABLE R_JOB_HOP
(
  ID_JOB_HOP BIGSERIAL
, ID_JOB INTEGER
, ID_JOBENTRY_COPY_FROM INTEGER
, ID_JOBENTRY_COPY_TO INTEGER
, ENABLED BOOLEAN
, EVALUATION BOOLEAN
, UNCONDITIONAL BOOLEAN
)
;

CREATE TABLE R_JOB_NOTE
(
  ID_JOB INTEGER
, ID_NOTE INTEGER
)
;

CREATE TABLE R_TRANS_LOCK
(
  ID_TRANS_LOCK BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_USER INTEGER
, LOCK_MESSAGE VARCHAR(2000000)
, LOCK_DATE TIMESTAMP
)
;

CREATE TABLE R_JOB_LOCK
(
  ID_JOB_LOCK BIGSERIAL
, ID_JOB INTEGER
, ID_USER INTEGER
, LOCK_MESSAGE VARCHAR(2000000)
, LOCK_DATE TIMESTAMP
)
;

CREATE TABLE R_USER
(
  ID_USER BIGSERIAL
, "login" VARCHAR(255)
, "password" VARCHAR(255)
, "name" VARCHAR(255)
, DESCRIPTION VARCHAR(255)
, ENABLED BOOLEAN
)
;

INSERT INTO R_USER(ID_USER, "login", "password", "name", DESCRIPTION, ENABLED) VALUES (1,E'admin',E'2be98afc86aa7f2e4cb79ce71da9fa6d4',E'Administrator',E'User manager',E'Y');

INSERT INTO R_USER(ID_USER, "login", "password", "name", DESCRIPTION, ENABLED) VALUES (2,E'guest',E'2be98afc86aa7f2e4cb79ce77cb97bcce',E'Guest account',E'Read-only guest account',E'Y');


