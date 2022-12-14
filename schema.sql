/* Database schema to keep the structure of entire database. */

CREATE TABLE ANIMALS (
    ID INT, 
    NAME VARCHAR(100), 
    DATE_OF_BIRTH DATE, 
    ESCAPE_ATTEMPTS INT, 
    NEUTERED BOOLEAN,
    WEIGHT_KG DECIMAL);

ALTER TABLE animals ADD species VARCHAR(50);

-- Multiple Tables

CREATE TABLE owners (id SERIAL PRIMARY KEY, full_name VARCHAR(100), age INT);

CREATE TABLE species (id SERIAL PRIMARY KEY, name VARCHAR(100));

--Modify id column of animals table(autoincrement and primary key)
CREATE SEQUENCE animals_id_seq OWNED BY animals.id;

SETVAL('animals_id_seq', (select max(id) from animals), false);

 ALTER TABLE animals ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');

 ALTER TABLE animals DROP COLUMN species;

 ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);

 ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

 -- Join Table

 CREATE TABLE vets (id SERIAL PRIMARY KEY, name VARCHAR(100), age INT, date_of_graduation DATE);

 CREATE TABLE specializations (species_id INT, vets_id INT, 
 CONSTRAINT fk_sp FOREIGN KEY(species_id) REFERENCES species(id), 
 CONSTRAINT fk_ve FOREIGN KEY(vets_id) REFERENCES vets(id));

 CREATE TABLE visits (animals_id INT, vets_id INT, date_of_visit DATE, 
 CONSTRAINT fk_an FOREIGN KEY(animals_id) REFERENCES animals(id), 
 CONSTRAINT fk_ve FOREIGN KEY(vets_id) REFERENCES vets(id));

 -- Database Performance (EXPLAIN ANALYZE)

 -- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

ALTER TABLE visits RENAME COLUMN animals_id TO animal_id;

ALTER TABLE visits RENAME COLUMN vets_id TO vet_id;

-- Create Index on animal_id column of visits table.
CREATE INDEX animal_id_idx ON visits(animal_id asc);

-- Create Index on vet_id column of visits table.
CREATE INDEX  vet_id_idx ON visits(vet_id asc);

-- Create Index  owners_email on email column of owners table.
CREATE INDEX  owner_email_idx  ON owners(email);

