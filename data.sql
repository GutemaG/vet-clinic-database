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


--Insert the following data for specialties:
INSERT INTO specializations (species_id, vets_id)
	VALUES (
			(SELECT id FROM species WHERE name = 'Pokemon'),(SELECT id FROM vets WHERE name = 'William Tatcher')
		),
	   (
			(SELECT id FROM species WHERE name = 'Pokemon'),(SELECT id FROM vets WHERE name = 'Stephanie Mendez')
		),
       (
			(SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
	   (
			(SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harkness')
		);

--Insert the following data for visits: 
INSERT INTO visits (animals_id, vets_id, date_of_visit) 
VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-05-24'),
	((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22'),
	((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14'),
	((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04'),
	((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07'),
	((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29'),
	((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03'),
	((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03'),
	((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
	((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');