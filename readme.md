# Kettle ETL Attribute Mapping Demo

This project demonstrates the use of [Pentaho Kettle](https://community.hds.com/docs/DOC-1009855) to perform ETL (Extract, Transform and Load) attribute mapping operations.

## Kettle overview

Kettle is a free, open source (LGPL) ETL (Extraction, Transformation and Loading) tool. 

Kettle is a recursive acronym for *Kettle Extraction, Transport, Transformation and Loading Environment*.

Being an ETL tool, Kettle is an environment that is designed to:

* collect data from a variety of sources (extraction);
* move and modify data (transport and transform) while cleansing, denormalizing, aggregating and enriching it in the process;
* store data (loading) in the final target destination;

## Kettle Architecture

Kettle is built with the Java programming language and consists of four distinct applications:

![Kettle Architecture](/docs/images/kettle-ecosystem.png)

* **Spoon** is a graphically oriented end-user tool to model the flow of data from input through transformation to output
* **Pan** is a commandline tool that executes transformations modelled with Spoon
* **Chef** is a graphically oriented end-user tool used to model jobs. Jobs consist of job entries such as transformations, FTP downloads etc. that are placed in a flow of control
* **Kitchen** is a commandline tool used to execute jobs created with Chef

**Model-driven**

An interesting feature of Kettle is that it is model-driven. Both Spoon and Chef offer a graphical user interface to define the ETL processes on a high level. Typically, this involves no actual programming at all - rather, it's a purely declarative task which results in a model.

The command line tools Pan and Kitchen (or rather the underlying API) know how to read and interpret the models created by Spoon and Chef respectively. These tools actually execute the implied ETL processes. This is done all in one go: there is no intermediate code generation or compilation involved.

**Repository-Based**

Models can be saved to file in a particular XML format, or they can be stored into a relational database: a repository. Using a repository can be a major advantage, especially when handling many models. Because the models are stored in a structured manner, arbitrary queries can be written against the repository. 

The repository may also be used to store the logs that are generated when executing transformations and jobs.

## What does the demo do?

The demo demonstrates the use of Kettle in order to:

* extract data from a source database
* map and load data to a destination database
* update the source database following a successful load operation
* provide error handling for each step in the ETL process

Additionally, the demo includes a Spring boot microservice which offers:

* a status page providing visualization of published attributes
* a published attributes web service that provides a JSON output of the attributes that have been published

## Prerequisites

The demo assumes the following prerequisites:

* [MySql v5.X.X server](https://downloads.mysql.com/archives/community/)
* [Java  Oracle JDK 1.8](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* [Maven 3.X.X](https://maven.apache.org/download.cgi)

Two new database schemas must be created in MySql; `extract_db` and `load_db`.

A MySql user should be created (optional) and granted access to these two new schemas.

The demo assumes the following MySql user:

* **Username**: kettle-demo
* **Password**: Pa$$word

If these credentials are not suitable then the preferred MySql user can be specified at a later stage.

Once the schemas have been created, the [etl-ddl-dml.sql](/resources/sql/etl-ddl-dml.sql) file should be executed in the MySql console/workbench in order to create the database structure and pre-populate the databases with required data.

## Kettle installation and configuration

Kettle is platform independent and can be downloaded from the link below:

* [Kettle CE 4.4.0](https://sourceforge.net/projects/pentaho/files/Data%20Integration/4.4.0-stable/pdi-ce-4.4.0-stable.zip/download)

Once downloaded, the archive should be extracted to a preferred location on your workstation.

The extracted location will be referred to as `$KETTLE_HOME`.

Although Kettle supports many different database vendors it can not include every vendor's binary driver for licencing reasons.

The MySql driver is not included in the Kettle CE distribution so it needs to be installed.

* Download the MySql driver from the following link: [mysql-connector-java-5.1.46.jar](http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.46/mysql-connector-java-5.1.46.jar)
* Copy the downloaded *mysql-connector-java-5.1.46.jar* file to `$KETTLE_HOME/data-integration/libext/JDBC`

## Creating the Kettle transformation

For the purposes of this demo we will only be using the *Spoon* module of Kettle.

*Spoon* can be lauched via `$KETTLE_HOME/data-integration/bin/spoon.sh|bat`

When launching *Spoon* you will be prompted to create a repository. For simplicity, choose to create a *File* repository which uses a folder located on your workstation.

When *Spoon* has launched, the transformation file [etl-attribute-mapping-transformation.ktr](resources/transformation/etl-attribute-mapping-transformation.ktr)  can be imported via *File > Import form an XML file*.

The imported transformation file describes the ETL processes shown in the image below:

![ETL Mapping Processes](/docs/images/etl-mapping-processes.png)

The ETL steps included in the transform are:

1. extract data from a source database
1. map and load data to a destination database
1. Set the `is_published` attribute to true
1. update the source database following a successful load operation
1. provide error handling for each step in the ETL process

If your MySql installation is not installed on the same machine as Kettle or if you are using a different MySql user (not the expected kettle-demo user) then you will need to configured the database connections.

The database connections can be configured in *Spoon* by editing the specific connections via the *View tab -> ETL Mapping Attribute Transformation -> Database connections*.

![ETL Database Connections](/docs/images/etl-view-database-connections.png)

## Executing the Kettle transformation

The transformation process can be executed via *Spoon*.

*Action -> Run -> Launch*

![ETL Launch](/docs/images/etl-action-launch.png)

The executed transformation process will provide a report indicating the metrics of the transformation process steps.

![ETL Metrics](/docs/images/etl-transformation-metrics.png)

## Running the microservice

The microservice is located in the [microservice](microservice) directory and can be built and executed using the maven command shown below:

* `mvn clean package`
* `java -jar target/kettle-demo.jar

The microservice end points are shown below:

* http://localhost:8080/status
* http://localhost:8080/public-attributes


*Status endpoint*

![Microservice status endpoint](/docs/images/ms-status.png)

*Public attributes web service*

![Microservice public attibutes endpoint](/docs/images/ms-public-attributes.png)














