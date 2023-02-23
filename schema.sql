/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT,
	name varchar(100),
	date_of_birth DATE,
	escape_attempts INT,
	neutered bool,
	weight_kg DECIMAL
);
ALTER TABLE animals ADD COLUMN species VARCHAR(100);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
	full_name varchar(100),
	age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
	name varchar(100)
);

ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals  ADD column id SERIAL PRIMARY KEY;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id BIGINT REFERENCES species (id);
ALTER TABLE animals ADD owner_id BIGINT REFERENCES owners (id);