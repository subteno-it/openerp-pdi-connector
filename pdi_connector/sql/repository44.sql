-- Repository creation/upgrade DDL: 
--
CREATE TABLE kettle.R_REPOSITORY_LOG
(
  ID_REPOSITORY_LOG BIGSERIAL
, REP_VERSION VARCHAR(255)
, LOG_DATE TIMESTAMP
, LOG_USER VARCHAR(255)
, OPERATION_DESC VARCHAR(2000000)
)
;
ALTER TABLE kettle.R_REPOSITORY_LOG OWNER TO %(db_user)s;

CREATE TABLE kettle.R_VERSION
(
  ID_VERSION BIGSERIAL
, MAJOR_VERSION SMALLINT
, MINOR_VERSION SMALLINT
, UPGRADE_DATE TIMESTAMP
, IS_UPGRADE CHAR(1)
)
;
ALTER TABLE kettle.R_VERSION OWNER TO %(db_user)s;

INSERT INTO kettle.R_VERSION(ID_VERSION, MAJOR_VERSION, MINOR_VERSION, UPGRADE_DATE, IS_UPGRADE) VALUES (1,4,0, now(),E'N');

CREATE TABLE kettle.R_DATABASE_TYPE
(
  ID_DATABASE_TYPE BIGSERIAL
, CODE VARCHAR(255)
, DESCRIPTION VARCHAR(255)
)
;
ALTER TABLE kettle.R_DATABASE_TYPE OWNER TO %(db_user)s;


INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (1,E'DERBY',E'Apache Derby');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (2,E'AS/400',E'AS/400');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (3,E'INTERBASE',E'Borland Interbase');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (4,E'INFINIDB',E'Calpont InfiniDB');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (5,E'DBASE',E'dBase III, IV or 5');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (6,E'EXASOL4',E'Exasol 4');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (7,E'EXTENDB',E'ExtenDB');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (8,E'FIREBIRD',E'Firebird SQL');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (9,E'GENERIC',E'Generic database');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (10,E'GREENPLUM',E'Greenplum');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (11,E'SQLBASE',E'Gupta SQL Base');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (12,E'H2',E'H2');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (13,E'HIVE',E'Hadoop Hive');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (14,E'HYPERSONIC',E'Hypersonic');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (15,E'DB2',E'IBM DB2');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (16,E'INFOBRIGHT',E'Infobright');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (17,E'INFORMIX',E'Informix');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (18,E'INGRES',E'Ingres');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (19,E'VECTORWISE',E'Ingres VectorWise');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (20,E'CACHE',E'Intersystems Cache');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (21,E'KINGBASEES',E'KingbaseES');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (22,E'LucidDB',E'LucidDB');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (23,E'SAPDB',E'MaxDB (SAP DB)');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (24,E'MONETDB',E'MonetDB');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (25,E'MSACCESS',E'MS Access');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (26,E'MSSQL',E'MS SQL Server');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (27,E'MSSQLNATIVE',E'MS SQL Server (Native)');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (28,E'MYSQL',E'MySQL');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (29,E'NEOVIEW',E'Neoview');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (30,E'NETEZZA',E'Netezza');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (31,E'ORACLE',E'Oracle');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (32,E'ORACLERDB',E'Oracle RDB');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (33,E'PALO',E'Palo MOLAP Server');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (34,E'POSTGRESQL',E'PostgreSQL');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (35,E'REMEDY-AR-SYSTEM',E'Remedy Action Request System');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (36,E'SAPR3',E'SAP ERP System');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (37,E'SQLITE',E'SQLite');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (38,E'SYBASE',E'Sybase');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (39,E'SYBASEIQ',E'SybaseIQ');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (40,E'TERADATA',E'Teradata');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (41,E'UNIVERSE',E'UniVerse database');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (42,E'VERTICA',E'Vertica');

INSERT INTO kettle.R_DATABASE_TYPE(ID_DATABASE_TYPE, CODE, DESCRIPTION) VALUES (43,E'VERTICA5',E'Vertica 5+');

CREATE TABLE kettle.R_DATABASE_CONTYPE
(
  ID_DATABASE_CONTYPE BIGSERIAL
, CODE VARCHAR(255)
, DESCRIPTION VARCHAR(255)
)
;
ALTER TABLE kettle.R_DATABASE_CONTYPE OWNER TO %(db_user)s;

INSERT INTO kettle.R_DATABASE_CONTYPE(ID_DATABASE_CONTYPE, CODE, DESCRIPTION) VALUES (1,E'Native',E'Native (JDBC)');

INSERT INTO kettle.R_DATABASE_CONTYPE(ID_DATABASE_CONTYPE, CODE, DESCRIPTION) VALUES (2,E'ODBC',E'ODBC');

INSERT INTO kettle.R_DATABASE_CONTYPE(ID_DATABASE_CONTYPE, CODE, DESCRIPTION) VALUES (3,E'OCI',E'OCI');

INSERT INTO kettle.R_DATABASE_CONTYPE(ID_DATABASE_CONTYPE, CODE, DESCRIPTION) VALUES (4,E'Plugin',E'Plugin specific access method');

INSERT INTO kettle.R_DATABASE_CONTYPE(ID_DATABASE_CONTYPE, CODE, DESCRIPTION) VALUES (5,E'JNDI',E'JNDI');

CREATE TABLE kettle.R_NOTE
(
  ID_NOTE BIGSERIAL
, VALUE_STR VARCHAR(2000000)
, GUI_LOCATION_X INTEGER
, GUI_LOCATION_Y INTEGER
, GUI_LOCATION_WIDTH INTEGER
, GUI_LOCATION_HEIGHT INTEGER
, FONT_NAME VARCHAR(2000000)
, FONT_SIZE INTEGER
, FONT_BOLD CHAR(1)
, FONT_ITALIC CHAR(1)
, FONT_COLOR_RED INTEGER
, FONT_COLOR_GREEN INTEGER
, FONT_COLOR_BLUE INTEGER
, FONT_BACK_GROUND_COLOR_RED INTEGER
, FONT_BACK_GROUND_COLOR_GREEN INTEGER
, FONT_BACK_GROUND_COLOR_BLUE INTEGER
, FONT_BORDER_COLOR_RED INTEGER
, FONT_BORDER_COLOR_GREEN INTEGER
, FONT_BORDER_COLOR_BLUE INTEGER
, DRAW_SHADOW CHAR(1)
)
;
ALTER TABLE kettle.R_NOTE OWNER TO %(db_user)s;

CREATE TABLE kettle.R_DATABASE
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
ALTER TABLE kettle.R_DATABASE OWNER TO %(db_user)s;

CREATE TABLE kettle.R_DATABASE_ATTRIBUTE
(
  ID_DATABASE_ATTRIBUTE BIGSERIAL
, ID_DATABASE INTEGER
, CODE VARCHAR(255)
, VALUE_STR VARCHAR(2000000)
)
;
ALTER TABLE kettle.R_DATABASE_ATTRIBUTE OWNER TO %(db_user)s;

CREATE UNIQUE INDEX IDX_R_DATABASE_ATTRIBUTE_AK
 ON kettle.R_DATABASE_ATTRIBUTE
( 
  ID_DATABASE
, CODE
)
;

CREATE TABLE kettle.R_DIRECTORY
(
  ID_DIRECTORY BIGSERIAL
, ID_DIRECTORY_PARENT INTEGER
, DIRECTORY_NAME VARCHAR(255)
)
;
ALTER TABLE kettle.R_DIRECTORY OWNER TO %(db_user)s;

CREATE UNIQUE INDEX IDX_R_DIRECTORY_AK
 ON kettle.R_DIRECTORY
( 
  ID_DIRECTORY_PARENT
, DIRECTORY_NAME
)
;

CREATE TABLE kettle.R_TRANSFORMATION
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
, USE_BATCHID CHAR(1)
, USE_LOGFIELD CHAR(1)
, ID_DATABASE_MAXDATE INTEGER
, TABLE_NAME_MAXDATE VARCHAR(255)
, FIELD_NAME_MAXDATE VARCHAR(255)
, OFFSET_MAXDATE NUMERIC(14, 2)
, DIFF_MAXDATE NUMERIC(14, 2)
, CREATED_USER VARCHAR(255)
, CREATED_DATE TIMESTAMP
, MODIFIED_USER VARCHAR(255)
, MODIFIED_DATE TIMESTAMP
, SIZE_ROWSET INTEGER
)
;
ALTER TABLE kettle.R_TRANSFORMATION OWNER TO %(db_user)s;

CREATE TABLE kettle.R_TRANS_ATTRIBUTE
(
  ID_TRANS_ATTRIBUTE BIGSERIAL
, ID_TRANSFORMATION INTEGER
, NR INTEGER
, CODE VARCHAR(255)
, VALUE_NUM BIGINT
, VALUE_STR VARCHAR(2000000)
)
;
ALTER TABLE kettle.R_TRANS_ATTRIBUTE OWNER TO %(db_user)s;

CREATE UNIQUE INDEX IDX_TRANS_ATTRIBUTE_LOOKUP
 ON kettle.R_TRANS_ATTRIBUTE
( 
  ID_TRANSFORMATION
, CODE
, NR
)
;

CREATE TABLE kettle.R_JOB_ATTRIBUTE
(
  ID_JOB_ATTRIBUTE BIGSERIAL
, ID_JOB INTEGER
, NR INTEGER
, CODE VARCHAR(255)
, VALUE_NUM BIGINT
, VALUE_STR VARCHAR(2000000)
)
;
ALTER TABLE kettle.R_JOB_ATTRIBUTE OWNER TO %(db_user)s;

CREATE UNIQUE INDEX IDX_JOB_ATTRIBUTE_LOOKUP
 ON kettle.R_JOB_ATTRIBUTE
( 
  ID_JOB
, CODE
, NR
)
;

CREATE TABLE kettle.R_DEPENDENCY
(
  ID_DEPENDENCY BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_DATABASE INTEGER
, "table_name" VARCHAR(255)
, FIELD_NAME VARCHAR(255)
)
;
ALTER TABLE kettle.R_DEPENDENCY OWNER TO %(db_user)s;

CREATE TABLE kettle.R_PARTITION_SCHEMA
(
  ID_PARTITION_SCHEMA BIGSERIAL
, "name" VARCHAR(255)
, DYNAMIC_DEFINITION CHAR(1)
, PARTITIONS_PER_SLAVE VARCHAR(255)
)
;
ALTER TABLE kettle.R_PARTITION_SCHEMA OWNER TO %(db_user)s;

CREATE TABLE kettle.R_PARTITION
(
  ID_PARTITION BIGSERIAL
, ID_PARTITION_SCHEMA INTEGER
, PARTITION_ID VARCHAR(255)
)
;
ALTER TABLE kettle.R_PARTITION OWNER TO %(db_user)s;

CREATE TABLE kettle.R_TRANS_PARTITION_SCHEMA
(
  ID_TRANS_PARTITION_SCHEMA BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_PARTITION_SCHEMA INTEGER
)
;
ALTER TABLE kettle.R_TRANS_PARTITION_SCHEMA OWNER TO %(db_user)s;

CREATE TABLE kettle.R_CLUSTER
(
  ID_CLUSTER BIGSERIAL
, "name" VARCHAR(255)
, BASE_PORT VARCHAR(255)
, SOCKETS_BUFFER_SIZE VARCHAR(255)
, SOCKETS_FLUSH_INTERVAL VARCHAR(255)
, SOCKETS_COMPRESSED CHAR(1)
, DYNAMIC_CLUSTER CHAR(1)
)
;
ALTER TABLE kettle.R_CLUSTER OWNER TO %(db_user)s;

CREATE TABLE kettle.R_SLAVE
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
, MASTER CHAR(1)
)
;
ALTER TABLE kettle.R_SLAVE OWNER TO %(db_user)s;

CREATE TABLE kettle.R_CLUSTER_SLAVE
(
  ID_CLUSTER_SLAVE BIGSERIAL
, ID_CLUSTER INTEGER
, ID_SLAVE INTEGER
)
;
ALTER TABLE kettle.R_CLUSTER_SLAVE OWNER TO %(db_user)s;

CREATE TABLE kettle.R_TRANS_SLAVE
(
  ID_TRANS_SLAVE BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_SLAVE INTEGER
)
;
ALTER TABLE kettle.R_TRANS_SLAVE OWNER TO %(db_user)s;

CREATE TABLE kettle.R_TRANS_CLUSTER
(
  ID_TRANS_CLUSTER BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_CLUSTER INTEGER
)
;
ALTER TABLE kettle.R_TRANS_CLUSTER OWNER TO %(db_user)s;

CREATE TABLE kettle.R_TRANS_HOP
(
  ID_TRANS_HOP BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_STEP_FROM INTEGER
, ID_STEP_TO INTEGER
, ENABLED CHAR(1)
)
;
ALTER TABLE kettle.R_TRANS_HOP OWNER TO %(db_user)s;

CREATE TABLE kettle.R_TRANS_STEP_CONDITION
(
  ID_TRANSFORMATION INTEGER
, ID_STEP INTEGER
, ID_CONDITION INTEGER
)
;
ALTER TABLE kettle.R_TRANS_STEP_CONDITION OWNER TO %(db_user)s;

CREATE TABLE kettle.R_CONDITION
(
  ID_CONDITION BIGSERIAL
, ID_CONDITION_PARENT INTEGER
, NEGATED CHAR(1)
, "operator" VARCHAR(255)
, LEFT_NAME VARCHAR(255)
, CONDITION_FUNCTION VARCHAR(255)
, RIGHT_NAME VARCHAR(255)
, ID_VALUE_RIGHT INTEGER
)
;
ALTER TABLE kettle.R_CONDITION OWNER TO %(db_user)s;

CREATE TABLE kettle.R_VALUE
(
  ID_VALUE BIGSERIAL
, "name" VARCHAR(255)
, VALUE_TYPE VARCHAR(255)
, VALUE_STR VARCHAR(255)
, IS_NULL CHAR(1)
)
;
ALTER TABLE kettle.R_VALUE OWNER TO %(db_user)s;

CREATE TABLE kettle.R_STEP_TYPE
(
  ID_STEP_TYPE BIGSERIAL
, CODE VARCHAR(255)
, DESCRIPTION VARCHAR(255)
, HELPTEXT VARCHAR(255)
)
;
ALTER TABLE kettle.R_STEP_TYPE OWNER TO %(db_user)s;

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (1,E'AggregateRows',E'Agrégation Lignes',E'Cette étape permet d''aggréger les lignes.{0}Elle ne peut effectuer de groupements.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (2,E'MemoryGroupBy',E'Agrégation sans tri',E'Calcul d''agregations sans nécéssité de trier les lignes du flux d''entrée.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (3,E'GroupBy',E'Agrégation valeurs',E'Réaliser des groupements.Fonctionne uniquement sur des champs préalablement triés.\nSi les lignes ne sont pas triées, les lignes identiques et consécutives seront traitées correctement.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (4,E'CheckSum',E'Ajout checksum',E'Calcul de checksum pour chaque ligne du flux d''entrée.\nLe résultat ainsi obtenu sera mis dans une nouveau champ.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (5,E'Constant',E'Ajout constantes',E'Ajouter une ou plusieurs constantes aux flux d''entrée');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (6,E'Sequence',E'Ajout séquence',E'Récupérer la valeur suivante depuis une séquence');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (7,E'FieldsChangeSequence',E'Ajout séquence réinitialisable',E'Cette étape ajoute une séquence au flux d''entrée.\nCette séquence va être réinialisée à chaque changement\ndes valeurs des champs renseignées.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (8,E'AddXML',E'Ajouter ligne XML',E'Encoder plusieurs colonnes en fragment XML');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (9,E'AccessOutput',E'Alimentation base MS Access',E'Alimenter une table d''une base de données MS-Access.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (10,E'TextFileOutput',E'Alimentation fichier',E'Écrire lignes dans ficher texte. Vous pouvez exporter sous plusieurs formats (txt, csv,xls,...)');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (11,E'TypeExitExcelWriterStep',E'Alimentation fichier Excel (xlsx)',E'Alimentation ou mise à jour de fichier Excel');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (12,E'JsonOutput',E'Alimentation fichier Json',E'Création d''un bloc Json et écriture dans un fichier ou un champ.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (13,E'CubeOutput',E'Alimentation fichier kettle',E'Écrire données dans un fichier au format PDI');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (14,E'ExcelOutput',E'Alimentation fichier MS Excel',E'Alimenter un fichier Excel (XLS) avec les données.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (15,E'PropertyOutput',E'Alimentation fichier propriétés',E'Ecriture de valeurs (Clé/Valeur) dans un fichier de propriétés (.properties)');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (16,E'XMLOutput',E'Alimentation fichier XML',E'Écrire dans un fichier XML');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (17,E'LDAPOutput',E'Alimentation LDAP',E'Insertion, mise à jour, ajout ou suppression d''éléments basés sur leur DN (Distinguished  Name).');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (18,E'SelectValues',E'Altération structure flux',E'Sélectionner ou retirer des champs dans une ligne.{0} Possibilité de modifier le type, longueur et précision du champ.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (19,E'Flattener',E'Aplatissement de lignes',E'Flattens consequetive rows based on the order in which they appear in the input stream');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (20,E'DBProc',E'Appel Procédure Stockée (BDD)',E'Appeler des procédures stockées dans des bases de données.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (21,E'Script',E'Appel script interprété',E'Calcul de valeurs grâce à Ruby, Python, Groovy, JavaScript, ... (JSR-223)');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (22,E'ScriptValueMod',E'Appel script interprété Rhino',E'Plugiciel permettant décrire des scripts Java.\n Ecrit et gracieusement offert par Martin Lange, Proconis : http://www.proconis.de');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (23,E'AvroInput',E'Avro Input',E'Reads data from an Avro file');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (24,E'BlockUntilStepsFinish',E'Bloquage lignes lié à d''autres étapes',E'Cette étape démarrera la transmission des lignes\nlorsque chacune des étapes spécifiées aura fini son exécution.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (25,E'SwitchCase',E'Branchement conditionnel',E'Diriger une ligne vers une étape cible en fonction de la valeur d''un champ.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (26,E'Calculator',E'Calcul',E'Créer de nouveaux champs à partir de calculs simples');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (27,E'Formula',E'Calculateur',E'Calcul en utilisant la librairie de Pentaho');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (28,E'CassandraInput',E'Cassandra Input',E'Reads data from a Cassandra table');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (29,E'CassandraOutput',E'Cassandra Output',E'Writes to a Cassandra table');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (30,E'ChangeFileEncoding',E'Changement encodage fichier',E'Changement de l''encodage d''un fichier.\nUn nouveau fichier sera crée avec un encodage cible.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (31,E'LoadFileInput',E'Chargement contenu fichier en mémoire',E'Chargement de tout le contenu d''un fichier en mémoire');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (32,E'ElasticSearchBulk',E'Chargement en bloc vers ElasticSearch',E'Chargement en bloc de données vers ElasticSearch');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (33,E'GPBulkLoader',E'Chargement en bloc vers Greenplum',E'Chargement en bloc de données dans une base de données Greenplum');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (34,E'GPLoad',E'Chargement en bloc vers Greenplum',E'Chargement en bloc vers Greenplum');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (35,E'InfobrightOutput',E'Chargement en bloc vers Infobright',E'Chargement en bloc vers une base de données Infobright');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (36,E'VectorWiseBulkLoader',E'Chargement en bloc vers Ingres VectorWise',E'Chargement en bloc de données vers une base\nen exécutant la commande de chargement "COPY TABLE".');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (37,E'LucidDBBulkLoader',E'Chargement en bloc vers LuciDB',E'Chargement en bloc de données vers une base LuciDB.\nATTENTION, cettte étape ne fonctionne pas sous Windows!');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (38,E'LucidDBStreamingLoader',E'Chargement en bloc vers LuciDB',E'Chargement en bloc de données vers une base LuciDB.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (39,E'MySQLBulkLoader',E'Chargement en bloc vers MySQL',E'Cette étape permet de charger en bloc\n des données dans une base de données MySQL');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (40,E'OraBulkLoader',E'Chargement en bloc vers Oracle',E'Cette étape permet de charger en bloc\n des données dans une base de données Oracle');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (41,E'PGBulkLoader',E'Chargement en bloc vers PostgreSQL',E'Chargement en bloc de données dans une base de données PostgreSQL');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (42,E'TeraFast',E'Chargement en bloc vers TeraData',E'Chargement en bloc de données vers une base Teradata.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (43,E'MonetDBBulkLoader',E'Chargement en bloc vers une Base Monet',E'Chargement de données en bloc vers une Base de Données Monet.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (44,E'HTTP',E'Client HTTP',E'Appel d''un service HTTP en soumettant l''adresse (URL) et des paramètres');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (45,E'HTTPPOST',E'Client HTTP (POST)',E'Appel d''un service HTTP (méthode POST) en soumettant l''adresse (URL) et des paramètres');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (46,E'Rest',E'Client Rest',E'Client Rest');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (47,E'WebServiceLookup',E'Client service web',E'Appel d''une méthode d''un service web en passant les arguments.\n Les paramètres sont renvoyés en consultant le WSDL de l''url.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (48,E'CloneRow',E'Clonage ligne',E'Clonez chaque ligne du flux d''entrée\nautant de fois que vous le souhaitez.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (49,E'ClosureGenerator',E'Closure Generator',E'This step allows you to generates a closure table using parent-child relationships.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (50,E'MergeRows',E'Comparaison lignes',E'Comparer deux flux, triés suivant une certaine clé.\n Les deux flux sont comparés suivant certaines clés.\n Les nouvelles lignes,les lignes modifiées et les lignes supprimés sont marquées.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (51,E'SortedMerge',E'Comparaison triée lignes',E'Jointure triée');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (52,E'ConcatFields',E'Concat Fields',E'Concat fields together into a new field (similar to the Text File Output step)');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (53,E'FilesToResult',E'Copie fichiers dans le résulat',E'Cette étape permet d''ajouter des nom de fichiers au résultat de la transformation.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (54,E'RowsToResult',E'Copie lignes vers le résultat',E'Utiliser cette tâche pour écrire des lignes dans la tâche en cours d''exécution.\nCette information sera translise à l''entrée suivante de la tâche.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (55,E'CouchDbInput',E'CouchDb Input',E'Reads from a Couch DB view');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (56,E'SymmetricCryptoTrans',E'Cryptographie symétrique',E'Cryptage et décryptage de données grâce au cryptage symétrique.\nLes algorithmes de cryptage disponibles sont DES, AEC, TripleDES.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (57,E'UserDefinedJavaClass',E'Création de classe java',E'Création de classe java');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (58,E'NumberRange',E'Création plages de nombres',E'Création de plages de nombres');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (59,E'SetVariable',E'Création Variables',E'Créer des variables d''environnement.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (60,E'DimensionLookup',E'Dimension à variation lente',E'Mettre à jour une dimension à variation lente (Slowly changing Dimension).');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (61,E'FieldSplitter',E'Décomposition Champs',E'Utiliser cette étape pour décomposer un champ en plusieurs.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (62,E'SplitFieldToRows3',E'Décomposition de champs en lignes',E'Décomposition d''un champ de type chaîne de caractères\n suivant un délimiteur et création de lignes\n (autant de lignes que de part trouvées).');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (63,E'Unique',E'Dédoublonnage',E'Permet d''effectuer un dédoublonnage.{0}Uniquement si les lignes sont préalablement triées.\n{1}Si les lignes ne sont pas triées, uniquement les lignes identiques consécutives sont prise en compte.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (64,E'UniqueRowsByHashSet',E'Dédoublonnage de lignes (HashSet)',E'Permet d''effectuer un dédoublonnage grâce à un HashSet.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (65,E'Denormaliser',E'Dénormalisation ligne',E'Dénormaliser les lignes.{0} Cette méthode nécéssite un tri sur les champs de groupement');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (66,E'AnalyticQuery',E'Déplacement dans flux',E'Déplacement (Avant, arrière) dans flux and récupération de la valeur d''un champ agrégé');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (67,E'DetectEmptyStream',E'Détection flux vide',E'Cette étape permet de détecter si un flux est vide (pas de lignes).\nSi c''est le cas, une ligne comprenant des valeurs nulles sera produite.\nSi le flux contient des lignes, alors cette étape ne transmettra aucun ligne.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (68,E'ReservoirSampling',E'Echantillonnage aléatoire',E'Sélection sur un échantillon aléatoire de N lignes du flux d''entrée\n(où N est inconnue a priori) de X lignes aléatoires.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (69,E'SampleRows',E'Echantillonnage fixe',E'Sélection de lignes grâce à leur numéro.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (70,E'WriteToLog',E'Ecriture dans trace',E'Ecriture de données dans la trace');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (71,E'TypeExitEdi2XmlStep',E'Edi to XML',E'Converts Edi text to generic XML');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (72,E'Mail',E'Envoi courriel',E'Envoi de courriers électoniques.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (73,E'SyslogMessage',E'Envoi d''information via Syslog',E'Envoi d''information vers un serveur Syslog');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (74,E'ShapeFileReader',E'ESRI Shapefile Reader',E'Reads shape file data from an ESRI shape file and linked DBF file');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (75,E'RegexEval',E'Evaluation par exp reg',E'Permet dévaluer un champ par une expression régulière (Regexp).');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (76,E'DummyPlugin',E'Example plugin',E'This is an example for a plugin test step');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (77,E'SQLFileOutput',E'Export instructions SQL vers fichier',E'Export instructions INSERT SQL vers un fichier');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (78,E'getXMLData',E'Extraction de données depuis XML',E'Extraction de données depuis des fichiers XML ou le contenu d''un champ\ndéfini dans les étapes précédentes.\nVous devez fournir une valeur XPath à partir de laquelle la recherche va s''effectuée.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (79,E'StringCut',E'Extraction depuis chaînes de caractères',E'Extraction depuis des chaînes de caractères.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (80,E'TextFileInput',E'Extraction depuis fichier',E'Lire données depuis un fichier texte.{0}Les informations lues peuvent être transmises à d''autres étapes...');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (81,E'ParallelGzipCsvInput',E'Extraction depuis fichier CSB Gzip',E'Extraction en parallèle de données depuis un fichier CSV Gzip');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (82,E'CsvInput',E'Extraction depuis fichier CSV',E'Extraction depuis ficher CSV');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (83,E'S3CSVINPUT',E'Extraction depuis fichier CSV S3',E'S3 CSV Input');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (84,E'CubeInput',E'Extraction depuis fichier kettle',E'Lire données depuis un fichier au format PDI.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (85,E'FixedInput',E'Extraction depuis fichier longueur fixe',E'Extraction depuis ficher longueur fixe');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (86,E'ExcelInput',E'Extraction depuis fichier MS Excel',E'Lire des données depuis un classeur Excel.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (87,E'PropertyInput',E'Extraction depuis fichier propriétés',E'Extraction de données depuis des fichiers de propriétés (properties).');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (88,E'XBaseInput',E'Extraction depuis Fichier XBase',E'Lire enregistrements depuis des fichier XBase (DBF)');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (89,E'XMLInput',E'Extraction depuis fichier XML',E'Lire données depuis un fichier XML');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (90,E'LDIFInput',E'Extraction depuis fichiers LDIF',E'Extraction de données depuis des fichiers LDIF');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (91,E'XMLInputStream',E'Extraction depuis fichiers XML volumineux (StAX)',E'Extraction de données depuis des fichiers XML complexes.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (92,E'XMLInputSax',E'Extraction depuis flux XML (SAX)',E'Lire données depuis un fichier XML avec SAX');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (93,E'TypeExitGoogleAnalyticsInputStep',E'Extraction depuis Google analytics',E'Extraction de données depuis l''API de Google analytics.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (94,E'JsonInput',E'Extraction depuis Json',E'Extraction de données depuis une source Json (fichier ou champ du flux entrant).');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (95,E'LDAPInput',E'Extraction depuis LDAP',E'Extraction de données depuis un serveur LDAP');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (96,E'OlapInput',E'Extraction depuis OLAP',E'Extraction de données depuis un cube OLAP\n grâce au langage MDX et linterface olap4j.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (97,E'SalesforceInput',E'Extraction depuis Salesforce',E'Extraction de donnees depuis Salesforce');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (98,E'TableInput',E'Extraction depuis table',E'Lire informations depuis table BDD.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (99,E'MondrianInput',E'Extraction depuis un cube Mondrian',E'Extraction de données depuis un cube OLAP Mondrian');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (100,E'AccessInput',E'Extraction depuis une base MS Access',E'Extraction de données depuis une base de données Microsoft Access');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (101,E'YamlInput',E'Extraction depuis Yaml ',E'Extraction de données Yaml depuis une source (fichier, flux). ');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (102,E'MailInput',E'Extraction messages (POP3/IMAP)',E'Extraction de messages depuis un serveur POP3 ou IMAP');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (103,E'Janino',E'Exécution d''expression Java',E'Exécution d''expression Java grâce à Janino');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (104,E'SSH',E'Exécution de commandes SSH',E'Exécution de commandes SSH and récupération des sorties standard et erreur.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (105,E'ExecProcess',E'Exécution de processus',E'Exécuter un processus et retourne le résultat de l''exécution.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (106,E'RuleExecutor',E'Exécution de règles',E'Exécution de règles sur un jeu de lignes');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (107,E'SingleThreader',E'Exécution mono-exétron',E'Exécution d''une transformation sur un unique exétron.\nLa sous-transformation doit contenir une étape d''injection par laquelle les données arriveront depuis la transformation parent en bloc.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (108,E'ExecSQL',E'Exécution script SQL',E'Exécuter un script SQL. Vous avez la possibilité d''utiliser\ncomme paramètres les champs du flux en entrée.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (109,E'ExecSQLRow',E'Exécution script SQL dynamique',E'Exécution d''instructions SQL dynamiquement.\nLes instructions sont récupérées depuis le contenu\nd''un champ créé dans une étape précédente..');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (110,E'Mapping',E'Exécution sous-transformation',E'Exécuter une sous-transformation, utiliser  les spécifications d''entrée et de sortie \npour indiquer les champs en entrée et en sortie de la sous transformation');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (111,E'Dummy',E'Factice',E'Ce type d''étape ne fait rien.\nElle est cependant pratique lorsque vous désirez tester des transformations.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (112,E'FilterRows',E'Filtrage lignes',E'Filtrer les lignes grâce à de simples équations');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (113,E'JavaFilter',E'Filtrage lignes (expression Java)',E'Création de conditions de filtrage de lignes grâce\nà l''exécution de code Java via Janino.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (114,E'AutoDoc',E'Génération automatique de documentation',E'Génération automatique de documentation\ndepuis des fichiers transformation ou tâche');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (115,E'SecretKeyGenerator',E'Génération de clés secrètes',E'Génération de clés secrètes pour les algorithmes de cryptographie symétrique tel que AES, DES et TripleDES.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (116,E'RandomCCNumberGenerator',E'Génération de numéros de carte',E'Génération automatique de numéros de carte\naléatoires et valides (contrôle de Luhn) pour différents type de carte.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (117,E'PentahoReportingOutput',E'Génération de rapports Pentaho',E'Exécution de rapports Pentaho (PRPT)');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (118,E'DataGrid',E'Génération données (grille)',E'Création de données statiques');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (119,E'RssOutput',E'Génération flux RSS',E'Génération de flux RSS et ATOM.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (120,E'RowGenerator',E'Génération Lignes',E'Générer un nombre de lignes.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (121,E'RandomValue',E'Génération valeurs aléatoires',E'Génération de valeurs aléatoires.\nCes valeurs seront ajoutées au flux d''entreé si il en existe un\nautrement un nouveau flux sera généré.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (122,E'HadoopFileInputPlugin',E'Hadoop File Input',E'Process files from an HDFS location');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (123,E'HadoopFileOutputPlugin',E'Hadoop File Output',E'Create files in an HDFS location');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (124,E'HBaseInput',E'HBase Input',E'Reads data from a HBase table according to a mapping');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (125,E'HBaseOutput',E'HBase Output',E'Writes data to an HBase table according to a mapping');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (126,E'HBaseRowDecoder',E'HBase Row Decoder',E'Decodes an incoming key and HBase result object according to a mapping');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (127,E'HL7Input',E'HL7 Input',E'Reads and parses HL7 messages and outputs a series of values from the messages');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (128,E'DetectLastRow',E'Identification dernière ligne',E'Cette étape permet d''identifier la dernière ligne\ndans un flux.Un champ (booléen) sera ajouté au flux entrant.\nSeule la dernière ligne aura la valeur Vrai''.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (129,E'Injector',E'Injecteur de lignes',E'Cette étape permet d''injecter des lignes dans la transformation à travers l''API Java');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (130,E'MetaInject',E'Injection de métadonnées',E'Cette étape permet d''injecter dans une transformation cible\n des paramètres avant l''exécution de la transformation.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (131,E'InsertUpdate',E'Insertion / Mise à jour table',E'Insérer ou mettre à jour lignes dans une table.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (132,E'SalesforceInsert',E'Insertion dans Salesforce',E'Insertion de données dans un module Salesforce.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (133,E'TableOutput',E'Insertion dans table',E'Écrire informations dans table BDD');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (134,E'SalesforceUpsert',E'Insertion/Mise à jour Salesforce',E'Insertion/mise à jour de données dans un module Salesforce.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (135,E'DynamicSQLRow',E'Interrogation dynamique d''une BdD',E'Interrogation dynamique d''une Base de données');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (136,E'DBJoin',E'Jointure Base de données',E'Exécuter une requête SQL en utilisant des paramètres');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (137,E'MergeJoin',E'Jointure comparaison lignes',E'Effectuer une jointure de deux flux suivant une clé. Les flux d''entrée doivent être triés sur la clé de jointure');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (138,E'MultiwayMergeJoin',E'Jointure multiple',E'Jointure entre plusieurs flux');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (139,E'XMLJoin',E'Jointure XML',E'Jointure de flux XML (tags)');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (140,E'RssInput',E'Lecture de flux RSS',E'Extraction d''informations depuis un flux RSS.\nCette étape permet notamment de récupérer des informations\n depuis des sites dont le contenu change fréquemment.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (141,E'SocketReader',E'Lecture depuis prise (Socket)',E'Client qui peut se connecter à une prise (Socket) d''un serveur.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (142,E'StringOperations',E'Manipulation de chaînes de caractères',E'Application de divers fonctions sur les chaînes de caractères.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (143,E'HadoopEnterPlugin',E'MapReduce Input',E'Enter a Hadoop Mapper or Reducer transformation');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (144,E'HadoopExitPlugin',E'MapReduce Output',E'Exit a Hadoop Mapper or Reducer transformation');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (145,E'Delay',E'Mise en place temporisation',E'Produire chaque ligne du flux d''entrée après un délai.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (146,E'Abort',E'Mise en échec transformation',E'Mise en échec de la transformation');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (147,E'SalesforceUpdate',E'Mise à jour de Salesforce',E'Mise à jour de données dans un module Salesforce.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (148,E'CombinationLookup',E'Mise à jour dimension junk',E'Mettre à jour une dimension junk dans un entrepôt de données.\nLa clé primaire d''une dimension junk dimension représente tous les champs.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (149,E'Update',E'Mise à jour table',E'Mettre à jour données dans une table');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (150,E'MonetDBAgileMart',E'MonetDB Agile Mart',E'Load data into MonetDB for Agile BI use cases');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (151,E'MongoDbInput',E'MongoDb Input',E'Reads from a Mongo DB collection');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (152,E'MongoDbOutput',E'MongoDb Output',E'Writes to a Mongo DB collection');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (153,E'Normaliser',E'Normalisation Ligne',E'Normaliser des informations dé-normalisées.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (154,E'PaloCellInput',E'Palo Cell Input',null);

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (155,E'PaloCellOutput',E'Palo Cell Output',null);

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (156,E'PaloDimInput',E'Palo Dim Input',null);

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (157,E'PaloDimOutput',E'Palo Dim Output',null);

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (158,E'Append',E'Prioritisation de deux flux',E'Permet de transmettre en priorité un flux.\n Les lignes du second flux seront transmises après que la dernière ligne\n du flux prioritaire le soit.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (159,E'PrioritizeStreams',E'Prioritisation de flux',E'Prioritisation de flux.\nLes lignes de chaque flux seront transmises\nsuivant l''ordre que vous souhaitez.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (160,E'JoinRows',E'Produit cartésien',E'Le résultat de cette étape est le produit cartésien des flux d''entrée.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (161,E'FuzzyMatch',E'Recherche approximative',E'Recherche de valeurs approximates grâce à plusieurs algorithmes.\nLecture de valeurs depuis un champ de flux principaux et récupération de valeurs approximatives depuis un flux source.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (162,E'DBLookup',E'Recherche dans Base de données',E'Rechercher valeurs dans une base  de données suivant des valeurs');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (163,E'StreamLookup',E'Recherche dans flux',E'Rechercher valeurs provenants d''un flux dans une transformation.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (164,E'ReplaceString',E'Remplacer dans chaînes de caractères',E'Remplacer une partie dans une chaîne de caractères.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (165,E'SetValueField',E'Remplacer valeur d''un champ',E'Remplacer la valeur d''un champ par celle d''un autre champ');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (166,E'SetValueConstant',E'Remplacer valeur d''un champ par constante',E'Remplacer la valeur d''un champ par une constante.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (167,E'IfNull',E'Remplacer valeur nulle',E'Remplacer la valeur du champ\npar une valeur par défaut si elle est nulle.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (168,E'NullIf',E'Rendre champ nul si',E'Mettre un champ à Nul si sa valeur vaut une constante');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (169,E'GetSlaveSequence',E'Récupération d''ID depuis serveur esclave',E'Récupération dIDs uniques en bloc depuis un serveur esclave.\nLa séquence utilisée doit être définie sur le serveur esclave au niveau du fichier XML de configuration.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (170,E'FilesFromResult',E'Récupération fichiers depuis le résultat',E'Cette étape permet de récupérer les nom de fichier générés par une entrée précédente dans une tâche.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (171,E'SystemInfo',E'Récupération Infos Système',E'Récupérer les informations système comme la date, arguments, etc.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (172,E'RowsFromResult',E'Récupération lignes depuis le résultat',E'cette étape vous permet de lire les lignes depuis une entrée précédente dans la tâche.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (173,E'GetTableNames',E'Récupération liste tables',E'Récupération de la liste des tables, vues\n, procédures stoquées et synonymes depuis une base de données.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (174,E'GetFileNames',E'Récupération Nom fichiers',E'Récupération des noms de fichiers\nà partir d''un répertoire (ou de fichier)\nsaisie en fixe ou récupéré dynamiquement dans le flux. ');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (175,E'GetRepositoryNames',E'Récupération objets référentiel',E'Récupérer des informations sur les tâches et transformations\ndéfinies dans un référentiel.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (176,E'GetSubFolders',E'Récupération sous répertoires',E'Récupération de tous les sous répertoires\npour un répertoire saisi en fixe ou récupéré dynamiquement.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (177,E'StepsMetrics',E'Récupération statistiques étapes',E'Récupération des statistiques (nombre de lignes lues, écrites,...) d''une ou plusieurs étapes.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (178,E'StepMetastructure',E'Récupération structure flux',E'Cette étape permet de lire un flux d''entrée et d''en extraire\nles informations sur la structure (meta données) essentiellement les champs du flux.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (179,E'GetFilesRowsCount',E'Récupération total lignes dans fichier',E'Comptage du nombre de lignes dans un fichier texte.\n Le caractère séparateur est renseigné par l''utilisateur.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (180,E'GetPreviousRowField',E'Récupération valeurs ligne précédente',E'Récupération de la valeur de champs de la ligne précédente.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (181,E'GetVariable',E'Récupération Variables',E'Déterminer la valeur d''une variable d''environnement et la placer dans un champ.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (182,E'S3FileOutputPlugin',E'S3 File Output',E'Create files in an S3 location');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (183,E'SapInput',E'SAP Input',E'Read data from SAP ERP, optionally with parameters');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (184,E'SASInput',E'SAS Input',E'This step reads files in sas7bdat (SAS) native format');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (185,E'MappingInput',E'Spécification entrée sous-transformation',E'Indiquer l''interface d''entrée de la sous transformation');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (186,E'MappingOutput',E'Spécification sortie sous-transformation',E'Indiquer l''interface de sortie de la sous transformation');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (187,E'SSTableOutput',E'SSTable Output',E'Writes to a filesystem directory as a Cassandra SSTable');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (188,E'UnivariateStats',E'Statistiques simples',E'Cette étape permet de calculer des statistiques simples sur les lignes');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (189,E'SalesforceDelete',E'Suppression dans Salesforce',E'Suppression de données dans un module Salesforce.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (190,E'Delete',E'Suppression dans table',E'Supprimer données dans une table');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (191,E'SynchronizeAfterMerge',E'Synchronisation de données',E'Cette étape permet de réaliser une insertion/mise à jour/suppression\nselon la valeur d''un champ créé dans une étape précédente. ');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (192,E'TableAgileMart',E'Table Agile Mart',E'Load data into a table for Agile BI use cases');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (193,E'ValueMapper',E'Tableau de correspondance',E'Mapper les valeurs d''un champ d''une valeur à une autre');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (194,E'ProcessFiles',E'Traitement fichiers',E'Cette étape permet de copier ou déplacer ou supprimer un fichier.\nUn fichier est traité à chaque ligne (pas de répertoire).');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (195,E'XSLT',E'Transformation XSL',E'Transformer un flux XML grâce au langage de description de feuilles (XSL).');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (196,E'SortRows',E'Tri lignes',E'Trier lignes suivant certains champs (ascendant et descandant)');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (197,E'MailValidator',E'Validation addresse électronique',E'Vérification si une addresse électronique est valide.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (198,E'CreditCardValidator',E'Validation carte de crédit',E'Cette étape vous permettra de :\n(1) Vérifier si le numéro d''une carte de crédit est valide (selon l''algorithme de Luhn)\n(2) Connaître le fournisseur de la carte\n(VISA, MasterCard, Diners Club, EnRoute, American Express (AMEX),...)');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (199,E'Validator',E'Validation de données',E'Validation des champs de flux entrants grâce à la définition de règles.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (200,E'XSDValidator',E'Validation XML par XSD',E'Valider une source XML (fichiers ou flux) par une définition de schéma XML.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (201,E'WebServiceAvailable',E'Vérification disponibilité service web',E'Vérification si un service web est disponible');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (202,E'ColumnExists',E'Vérification existance colonne',E'Cette étape permet de vérifier si une colonne\nexiste dans une table sur une connexion spécifiée.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (203,E'FileExists',E'Vérification existance fichier',E'Cette étape vérifie si un fichier (ou un dossier)\nexiste.Si c''est la cas, la valeur de retour sera VRAI (Y) autrement FAUX (N).');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (204,E'TableExists',E'Vérification existance table',E'Cette étape permet de vérifier si une table\nexiste sur une connexion spécifiée.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (205,E'FileLocked',E'Vérification vérrouillage fichier',E'Vérification si un fichier est vérrouillé par un autre processus');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (206,E'SocketWriter',E'Écriture vers prise (Socket)',E'Permet d''envoyer des données vers une prise (Socket) d''un serveur.');

INSERT INTO kettle.R_STEP_TYPE(ID_STEP_TYPE, CODE, DESCRIPTION, HELPTEXT) VALUES (207,E'BlockingStep',E'Étape bloquage lignes',E'Cette étape attend de recevoir la dernière ligne avant de transmettre cette dernière à l''étape suivante\n Vous pouvez en outre transmettre toutes les lignes.');

CREATE TABLE kettle.R_STEP
(
  ID_STEP BIGSERIAL
, ID_TRANSFORMATION INTEGER
, "name" VARCHAR(255)
, DESCRIPTION VARCHAR(2000000)
, ID_STEP_TYPE INTEGER
, DISTRIBUTE CHAR(1)
, COPIES SMALLINT
, GUI_LOCATION_X INTEGER
, GUI_LOCATION_Y INTEGER
, GUI_DRAW CHAR(1)
)
;
ALTER TABLE kettle.R_STEP OWNER TO %(db_user)s;

CREATE TABLE kettle.R_STEP_ATTRIBUTE
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
ALTER TABLE kettle.R_STEP_ATTRIBUTE OWNER TO %(db_user)s;

CREATE UNIQUE INDEX IDX_R_STEP_ATTRIBUTE_LOOKUP
 ON kettle.R_STEP_ATTRIBUTE
( 
  ID_STEP
, CODE
, NR
)
;

CREATE TABLE kettle.R_STEP_DATABASE
(
  ID_TRANSFORMATION INTEGER
, ID_STEP INTEGER
, ID_DATABASE INTEGER
)
;
ALTER TABLE kettle.R_STEP_DATABASE OWNER TO %(db_user)s;

CREATE INDEX IDX_R_STEP_DATABASE_LU1
 ON kettle.R_STEP_DATABASE
( 
  ID_TRANSFORMATION
)
;

CREATE INDEX IDX_R_STEP_DATABASE_LU2
 ON kettle.R_STEP_DATABASE
( 
  ID_DATABASE
)
;

CREATE TABLE kettle.R_TRANS_NOTE
(
  ID_TRANSFORMATION INTEGER
, ID_NOTE INTEGER
)
;
ALTER TABLE kettle.R_TRANS_NOTE OWNER TO %(db_user)s;

CREATE TABLE kettle.R_LOGLEVEL
(
  ID_LOGLEVEL BIGSERIAL
, CODE VARCHAR(255)
, DESCRIPTION VARCHAR(255)
)
;
ALTER TABLE kettle.R_LOGLEVEL OWNER TO %(db_user)s;

INSERT INTO kettle.R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (1,E'Error',E'Uniquement Erreurs');

INSERT INTO kettle.R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (2,E'Minimal',E'Trace minimale');

INSERT INTO kettle.R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (3,E'Basic',E'Niveau de base');

INSERT INTO kettle.R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (4,E'Detailed',E'Niveau détaillé');

INSERT INTO kettle.R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (5,E'Debug',E'Débogage');

INSERT INTO kettle.R_LOGLEVEL(ID_LOGLEVEL, CODE, DESCRIPTION) VALUES (6,E'Rowlevel',E'Niveau très détaillé');

CREATE TABLE kettle.R_LOG
(
  ID_LOG BIGSERIAL
, "name" VARCHAR(255)
, ID_LOGLEVEL INTEGER
, LOGTYPE VARCHAR(255)
, FILENAME VARCHAR(255)
, FILEEXTENTION VARCHAR(255)
, ADD_DATE CHAR(1)
, ADD_TIME CHAR(1)
, ID_DATABASE_LOG INTEGER
, TABLE_NAME_LOG VARCHAR(255)
)
;
ALTER TABLE kettle.R_LOG OWNER TO %(db_user)s;

CREATE TABLE kettle.R_JOB
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
, USE_BATCH_ID CHAR(1)
, PASS_BATCH_ID CHAR(1)
, USE_LOGFIELD CHAR(1)
, SHARED_FILE VARCHAR(255)
)
;
ALTER TABLE kettle.R_JOB OWNER TO %(db_user)s;

CREATE TABLE kettle.R_JOBENTRY_DATABASE
(
  ID_JOB INTEGER
, ID_JOBENTRY INTEGER
, ID_DATABASE INTEGER
)
;
ALTER TABLE kettle.R_JOBENTRY_DATABASE OWNER TO %(db_user)s;

CREATE INDEX IDX_R_JOBENTRY_DATABASE_LU1
 ON kettle.R_JOBENTRY_DATABASE
( 
  ID_JOB
)
;

CREATE INDEX IDX_R_JOBENTRY_DATABASE_LU2
 ON kettle.R_JOBENTRY_DATABASE
( 
  ID_DATABASE
)
;

CREATE TABLE kettle.R_JOBENTRY_TYPE
(
  ID_JOBENTRY_TYPE BIGSERIAL
, CODE VARCHAR(255)
, DESCRIPTION VARCHAR(255)
)
;
ALTER TABLE kettle.R_JOBENTRY_TYPE OWNER TO %(db_user)s;

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (1,E'PING',E'Accéssibilité Hôte (Ping)');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (2,E'SET_VARIABLES',E'Affectation variables');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (3,E'MSGBOX_INFO',E'Affichage message information');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (4,E'ADD_RESULT_FILENAMES',E'Ajout nom de fichiers au résultat');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (5,E'EMRJobExecutorPlugin',E'Amazon EMR Job Executor');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (6,E'HiveJobExecutorPlugin',E'Amazon Hive Job Executor');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (7,E'WAIT_FOR_SQL',E'Attente apparition données SQL');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (8,E'WAIT_FOR_FILE',E'Attente apparition fichier');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (9,E'MSSQL_BULK_LOAD',E'Chargement en bloc MSSQL');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (10,E'MYSQL_BULK_LOAD',E'Chargement en bloc vers Mysql');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (11,E'MS_ACCESS_BULK_LOAD',E'Chargement en bloc vers une base MS Access');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (12,E'MYSQL_BULK_FILE',E'Chargement vers un fichier depuis Mysql');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (13,E'FILE_COMPARE',E'Comparaison de fichiers');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (14,E'FOLDERS_COMPARE',E'Comparaison de répertoires');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (15,E'DOS_UNIX_CONVERTER',E'Convertion fichiers entre DOS et UNIX');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (16,E'COPY_FILES',E'Copie de fichiers');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (17,E'COPY_MOVE_RESULT_FILENAMES',E'Copie ou déplacement de fichiers dans résultat');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (18,E'PGP_ENCRYPT_FILES',E'Cryptage de fichier via PGP');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (19,E'ZIP_FILE',E'Création archive Zip');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (20,E'EVAL',E'Création Evaluation');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (21,E'CREATE_FILE',E'Création fichier');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (22,E'SIMPLE_EVAL',E'Création simple évaluation');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (23,E'CREATE_FOLDER',E'Créer un répertoire');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (24,E'PGP_DECRYPT_FILES',E'Décryptage de fichiers via PGP');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (25,E'MOVE_FILES',E'Déplacement de fichiers');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (26,E'WRITE_TO_FILE',E'Ecriture dans fichier');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (27,E'WRITE_TO_LOG',E'Ecriture dans trace');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (28,E'SPECIAL',E'Entrées spéciales');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (29,E'MAIL',E'Envoi Courriel');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (30,E'SYSLOG',E'Envoi d''information via Syslog');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (31,E'FTP_PUT',E'Envoi de fichiers via FTP');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (32,E'SNMP_TRAP',E'Envoi de messages SNMP');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (33,E'SFTPPUT',E'Envoi fichiers avec SFTP');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (34,E'FTPS_PUT',E'Envoi fichiers via FTPS');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (35,E'SSH2_PUT',E'Envoi fichiers via SSH2');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (36,E'EVAL_FILES_METRICS',E'Evaluation statistiques fichiers');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (37,E'EVAL_TABLE_CONTENT',E'Evaluer le nombre de lignes d''une table');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (38,E'DummyJob',E'Example plugin');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (39,E'EXPORT_REPOSITORY',E'Export référentiel vers fichier XML');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (40,E'UNZIP',E'Extraction fichiers depuis archive Zip');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (41,E'SHELL',E'Exécution commandes Shell');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (42,E'TALEND_JOB_EXEC',E'Exécution de tâche Talend');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (43,E'SQL',E'Exécution script SQL');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (44,E'TRANS',E'Exécution Transformation');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (45,E'JOB',E'Exécution Tâche');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (46,E'HadoopCopyFilesPlugin',E'Hadoop Copy Files');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (47,E'HadoopJobExecutorPlugin',E'Hadoop Job Executor');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (48,E'HL7MLLPAcknowledge',E'HL7 MLLP Acknowledge');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (49,E'HL7MLLPInput',E'HL7 MLLP Input');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (50,E'DELAY',E'Mise en place Temporisation');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (51,E'ABORT',E'Mise en échec tâche');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (52,E'OozieJobExecutor',E'Oozie Job Executor');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (53,E'HadoopTransJobExecutorPlugin',E'Pentaho MapReduce');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (54,E'HadoopPigScriptExecutorPlugin',E'Pig Script Executor');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (55,E'GET_POP',E'Récupération courriels (POP3/IAMP)');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (56,E'SFTP',E'Récupération fichier via SFTP');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (57,E'FTP',E'Récupération fichiers via FTP');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (58,E'FTPS_GET',E'Récupération fichiers via FTPS');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (59,E'SSH2_GET',E'Récupération fichiers via SSH2');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (60,E'SqoopExport',E'Sqoop Export');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (61,E'SqoopImport',E'Sqoop Import');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (62,E'SUCCESS',E'Succès tâche');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (63,E'FTP_DELETE',E'Suppression de fichiers via FTP');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (64,E'DELETE_FOLDERS',E'Suppression de répertoires');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (65,E'DELETE_FILE',E'Suppression fichier');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (66,E'DELETE_FILES',E'Suppression fichiers');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (67,E'DELETE_RESULT_FILENAMES',E'suppression nom de fichiers depuis résultat');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (68,E'XSLT',E'Tranformation XSL');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (69,E'HTTP',E'Transfert fichier via HTTP');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (70,E'TRUNCATE_TABLES',E'Tronquage de tables');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (71,E'MAIL_VALIDATOR',E'Validation adresse électronique');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (72,E'DTD_VALIDATOR',E'Validation fichier XML avec DTD');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (73,E'XSD_VALIDATOR',E'Validation fichier XML avec XSD');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (74,E'CONNECTED_TO_REPOSITORY',E'Vérification connexion référentiel');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (75,E'CHECK_DB_CONNECTIONS',E'Vérification connexions');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (76,E'WEBSERVICE_AVAILABLE',E'Vérification disponibilité service web');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (77,E'COLUMNS_EXIST',E'Vérification existance colonnes');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (78,E'FILE_EXISTS',E'Vérification existence fichier');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (79,E'FILES_EXIST',E'Vérification existence fichiers');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (80,E'TABLE_EXISTS',E'Vérification existence Table');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (81,E'XML_WELL_FORMED',E'Vérification si fichier XML bien formé');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (82,E'PGP_VERIFY_FILES',E'Vérification signature via PGP');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (83,E'CHECK_FILES_LOCKED',E'Vérification vérrouillage fichiers');

INSERT INTO kettle.R_JOBENTRY_TYPE(ID_JOBENTRY_TYPE, CODE, DESCRIPTION) VALUES (84,E'FOLDER_IS_EMPTY',E'Vérifier si un répertoire est vide');

CREATE TABLE kettle.R_JOBENTRY
(
  ID_JOBENTRY BIGSERIAL
, ID_JOB INTEGER
, ID_JOBENTRY_TYPE INTEGER
, "name" VARCHAR(255)
, DESCRIPTION VARCHAR(2000000)
)
;
ALTER TABLE kettle.R_JOBENTRY OWNER TO %(db_user)s;

CREATE TABLE kettle.R_JOBENTRY_COPY
(
  ID_JOBENTRY_COPY BIGSERIAL
, ID_JOBENTRY INTEGER
, ID_JOB INTEGER
, ID_JOBENTRY_TYPE INTEGER
, NR SMALLINT
, GUI_LOCATION_X INTEGER
, GUI_LOCATION_Y INTEGER
, GUI_DRAW CHAR(1)
, PARALLEL CHAR(1)
)
;
ALTER TABLE kettle.R_JOBENTRY_COPY OWNER TO %(db_user)s;

CREATE TABLE kettle.R_JOBENTRY_ATTRIBUTE
(
  ID_JOBENTRY_ATTRIBUTE BIGSERIAL
, ID_JOB INTEGER
, ID_JOBENTRY INTEGER
, NR INTEGER
, CODE VARCHAR(255)
, VALUE_NUM NUMERIC(15, 2)
, VALUE_STR VARCHAR(2000000)
)
;
ALTER TABLE kettle.R_JOBENTRY_ATTRIBUTE OWNER TO %(db_user)s;

CREATE UNIQUE INDEX IDX_R_JOBENTRY_ATTRIBUTE_LOOKUP
 ON kettle.R_JOBENTRY_ATTRIBUTE
( 
  ID_JOBENTRY_ATTRIBUTE
, CODE
, NR
)
;

CREATE TABLE kettle.R_JOB_HOP
(
  ID_JOB_HOP BIGSERIAL
, ID_JOB INTEGER
, ID_JOBENTRY_COPY_FROM INTEGER
, ID_JOBENTRY_COPY_TO INTEGER
, ENABLED CHAR(1)
, EVALUATION CHAR(1)
, UNCONDITIONAL CHAR(1)
)
;
ALTER TABLE kettle.R_JOB_HOP OWNER TO %(db_user)s;

CREATE TABLE kettle.R_JOB_NOTE
(
  ID_JOB INTEGER
, ID_NOTE INTEGER
)
;
ALTER TABLE kettle.R_JOB_NOTE OWNER TO %(db_user)s;

CREATE TABLE kettle.R_TRANS_LOCK
(
  ID_TRANS_LOCK BIGSERIAL
, ID_TRANSFORMATION INTEGER
, ID_USER INTEGER
, LOCK_MESSAGE VARCHAR(2000000)
, LOCK_DATE TIMESTAMP
)
;
ALTER TABLE kettle.R_TRANS_LOCK OWNER TO %(db_user)s;

CREATE TABLE kettle.R_JOB_LOCK
(
  ID_JOB_LOCK BIGSERIAL
, ID_JOB INTEGER
, ID_USER INTEGER
, LOCK_MESSAGE VARCHAR(2000000)
, LOCK_DATE TIMESTAMP
)
;
ALTER TABLE kettle.R_JOB_LOCK OWNER TO %(db_user)s;

CREATE TABLE kettle.r_user
(
  ID_USER BIGSERIAL
, "login" VARCHAR(255)
, "password" VARCHAR(255)
, "name" VARCHAR(255)
, DESCRIPTION VARCHAR(255)
, ENABLED CHAR(1)
)
;
ALTER TABLE kettle.R_USER OWNER TO %(db_user)s;

INSERT INTO kettle.R_USER(ID_USER, "login", "password", "name", DESCRIPTION, ENABLED) VALUES (1,E'admin',E'2be98afc86aa7f2e4cb79ce71da9fa6d4',E'Administrator',E'User manager',E'Y');

INSERT INTO kettle.R_USER(ID_USER, "login", "password", "name", DESCRIPTION, ENABLED) VALUES (2,E'guest',E'2be98afc86aa7f2e4cb79ce77cb97bcce',E'Guest account',E'Read-only guest account',E'Y');

-- END OF FILE
