CREATE TABLE multimedia(
"Identifier" text,
"type" text,
"rightsHolder" text,
"creator" text,
"accessURI" text,
"format" text,
"variantLiteral" text,
"license" text);

CREATE TABLE occurences(
"id" text,
"occurrenceID" text,
"catalogNumber" text,
"basisOfRecord" text,
"collectionCode" text,
"scientificName" text,
"taxonRank" text,
"kingdom" text,
"family" text,
"higherClassification" text,
"vernacularName" text,
"previousIdentifications" integer,
"individualCount" integer,
"lifeStage" text,
"sex" text,
"longitudeDecimal" numeric,
"latitudeDecimal" numeric,
"geodeticDatum" text,
"dataGeneralizations" text,
"coordinateUncertaintyInMeters" numeric,
"continent" text,
"country" text,
"countryCode" text,
"stateProvince" text,
"locality" text,
"habitat" text,
"recordedBy" text,
"eventID" integer,
"eventDate" text,
"eventTime" text,
"samplingProtocol" text,
"behavior" text,
"associatedTaxa" text,
"references" text,
"rightsHolder" text,
"license" text,
"modified" text);

/*
SQLite version 3.31.1 2020-01-27 19:55:54
Enter ".help" for usage hints.
sqlite> .headers on
sqlite> .mode csv
sqlite> .output poland.csv */

SELECT * FROM occurences WHERE country = "Poland";
