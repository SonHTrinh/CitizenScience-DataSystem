# Citizen Science
UI Design for Citizen Science 
CIS 4396 - Fall 2019 - Temple University

## Introduction
Citizen Science is an application made for $DEP at Temple University to track and monitor water temperatures

## Prerequisites
* Microsoft SQL Server
* Microsoft Internet Information Service web server

## Installation
1. Run database_scripts.sql to build Database schema
1. Run DML.sql to populate the Database with initial records
1. Configure the `connectionStrings` field in the `Web.config` file located in the `CitizenScience-UIPrototype` directory with the credentials used to access the Database
1. Publish the `CitizenScience-UIPrototype` project to the IIS server

## How to use
