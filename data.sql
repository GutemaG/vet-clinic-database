/* Populate database with sample data. */

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 1, 'Agumon', 'Feb 3, 2020', 0, true, 10.23);

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 2, 'Gabumon', 'Nov 15, 2018', 2, true, 8);
	

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 3, 'Pikachu', 'Jan 7, 2021', 1, false, 15.04);

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 4, 'Devimon', 'May 12, 2017', 5, true, 11);

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 5, 'Charmander', 'Feb 8, 2020', 0, false, -11);

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 6, 'Plantomon', 'Nov 15, 2021', 3, true, -5.7);

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 7, 'Squirtle', 'Apr 2, 1993', 3, false, -12.13);

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 8, 'Angemon', 'Jun 7, 2005', 1, true, -45);

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 9, 'Boramon', 'Jun 7, 2005', 7, true, 20.4);

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 10, 'Blossom', 'Oct 13, 1998', 3, true, 17);

INSERT INTO animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	values( 11, 'Ditto', 'May 14, 2022', 4, true, 22);

--sert the following data into the owners table: 
INSERT INTO owners (full_name, age) VALUES('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES('Bob', 45);
INSERT INTO owners (full_name, age) VALUES('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES('Jodie Whittaker', 38);

--Insert the following data into the species table: 
INSERT INTO species (name) VALUES('Pokemon');
INSERT INTO species (name) VALUES('Digimon');

--Modify your inserted animals so it includes the species_id value: 
UPDATE animals SET species_id = (SELECT id from species WHERE name = 'Digimon')
WHERE name like '%mon';
UPDATE animals SET species_id = (SELECT id from species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

--Modify your inserted animals to include owner information (owner_id): 
UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon'  OR name = 'Boarmon';