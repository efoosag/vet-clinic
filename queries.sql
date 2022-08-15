/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2010-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Transaction 1*/
BEGIN;

UPDATE animals SET species='digimon' WHERE name LIKE '%mon';

UPDATE animals SET species='pokemon' WHERE species IS NULL;

COMMIT;

/* Transactio 2*/
BEGIN;

DELETE FROM animals;

ROLLBACK;

/* Transactio 3*/
BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;

UPDATE animals SET weight_kg = (weight_kg * -1);

ROLLBACK TO SP1;

UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg < 0;

COMMIT;

/* Trasaction 4*/
SELECT COUNT(*) AS "NUMBER OF ANIMALS" FROM animals;

SELECT COUNT(*) AS "NUMBER OF ANIMALS THAT HAVE NEVER TRIED TO ESCAPE" FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS "AVERAGE WEIGHT OF ANIMALS" FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
