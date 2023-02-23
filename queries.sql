/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name  FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered is TRUE and escape_attempts < 3;
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered is TRUE;
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';
SELECT * FROM animals WHERE weight_kg >=10.4 and weight_kg <=17.3;

-- Transactions
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals; --verifying
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name like '%mon';
SELECT * FROM animals;
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals; --VERIFYING

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_after_Jun;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT delete_after_Jun;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- Questions
--How many animals are there?
SELECT COUNT(*) AS number_of_animals from animals;
--How many animals have never tried to escape?
SELECT COUNT(*) AS number_of_animals from animals WHERE escape_attempts = 0;
--What is the average weight of animals?
SELECT AVG(weight_kg)::numeric(10,2) FROM animals;
--Who escapes the most, neutered or not neutered animals?
SELECT * FROM animals WHERE escape_attempts = ( SELECT MAX (escape_attempts) FROM animals);
-- What is the minimum and maximum weight of each type of animal?
SELECT MAX(weight_kg) as max_weight, MIN(weight_kg) as min_weight FROM animals; 
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)::numeric(10,2) 
    AS average_attempts FROM animals 
    where date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
    GROUP BY species;


--What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id 
WHERE full_name = 'Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT animals.*, species.name AS pokemon_species FROM animals
JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT animals.name AS animal_name, owners.fulL_name AS owner_name FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

--How many animals are there per species?
SELECT species.name AS species_name, COUNT(*) FROM animals
JOIN species ON species.id = animals.species_id
GROUP BY species.name;

--List all Digimon owned by Jennifer Orwell.
SELECT animals.name as animal_name, owners.full_name AS owner_name, species.name AS species_name 
from animals JOIN species ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owner_id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * from animals JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

--Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) AS num_animals
FROM owners LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name ORDER BY num_animals DESC;

--Queries

--Who was the last animal seen by William Tatcher?
SELECT a.name, vets.name as Vet, vi.date_of_visit FROM vets
    JOIN visits vi ON vets.id = vi.vets_id JOIN animals a ON a.id = vi.animals_id
    WHERE vets.name = 'William Tatcher' ORDER BY vi.date_of_visit DESC
    LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) as num_animals_visited_by_mendez FROM vets
    JOIN visits ON vets.id = visits.vets_id WHERE vets.name = 'Stephanie Mendez';

    
-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, sp.name AS specialization FROM vets
    LEFT JOIN specializations s ON s.vets_id = vets.id LEFT JOIN  species sp ON s.species_id = sp.id;


-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal_name, vi.date_of_visit FROM animals
    JOIN visits vi ON vi.animals_id = animals.id JOIN vets ve ON ve.id = vi.vets_id 
    WHERE ve.name = 'Stephanie Mendez' AND vi.date_of_visit >= '2020-04-01' AND vi.date_of_visit <= '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*) AS number_of_visit FROM animals
    JOIN visits ON visits.animals_id = animals.id GROUP BY animals.name
    ORDER BY number_of_visit DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name as vet_name, visits.date_of_visit, animals.name as animal_name FROM visits 
    JOIN vets ON vets.id = visits.vets_id JOIN animals ON animals.id = visits.animals_id
    WHERE vets.name = 'Maisy Smith' ORDER BY visits.date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT date_of_visit,
    a.date_of_birth AS animal_date_of_birth,a.escape_attempts,
	a.neutered, a.weight_kg AS animal_weight,
	vets.name AS vet_name, vets.age AS vet_age,
	vets.date_of_graduation FROM visits
    JOIN animals a ON a.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
    ORDER BY date_of_visit LIMIT 1;


-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) as number_of_visit
    FROM visits JOIN animals a ON a.id = visits.animals_id
    JOIN vets ON vets.id = visits.vets_id
    JOIN specializations ON specializations.vets_id = visits.vets_id
    WHERE a.species_id != specializations.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name as species, COUNT(*) FROM visits
    JOIN vets ON vets.id = visits.vets_id
    JOIN animals a ON a.id = visits.animals_id
    JOIN species ON species.id = a.species_id
    WHERE vets.name = 'Maisy Smith'
    GROUP BY species.name;