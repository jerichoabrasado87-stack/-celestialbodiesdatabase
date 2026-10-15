SELECT 'CREATE DATABASE universe' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'universe')\gexec
\connect universe

CREATE TABLE IF NOT EXISTS galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(80) NOT NULL UNIQUE,
  description TEXT NOT NULL,
  age_in_millions_of_years NUMERIC NOT NULL,
  is_spherical BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(80) NOT NULL UNIQUE,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  age_in_millions_of_years NUMERIC NOT NULL,
  surface_temperature_kelvin INT NOT NULL,
  is_spherical BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(80) NOT NULL UNIQUE,
  star_id INT NOT NULL REFERENCES star(star_id),
  description TEXT NOT NULL,
  orbital_period_days INT NOT NULL,
  has_life BOOLEAN NOT NULL,
  mass_in_earth_masses NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(80) NOT NULL UNIQUE,
  planet_id INT NOT NULL REFERENCES planet(planet_id),
  description TEXT NOT NULL,
  is_spherical BOOLEAN NOT NULL,
  distance_from_earth NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS nebula (
  nebula_id SERIAL PRIMARY KEY,
  name VARCHAR(80) NOT NULL UNIQUE,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  description TEXT NOT NULL,
  age_in_millions_of_years NUMERIC NOT NULL,
  has_life BOOLEAN NOT NULL
);

INSERT INTO galaxy (name, description, age_in_millions_of_years, is_spherical) VALUES
  ('Milky Way', 'A barred spiral galaxy containing our Solar System.', 13600, TRUE),
  ('Andromeda', 'The nearest large spiral galaxy to the Milky Way.', 10000, TRUE),
  ('Triangulum', 'A small spiral galaxy in the Local Group.', 12000, TRUE),
  ('Whirlpool', 'A grand-design spiral galaxy interacting with NGC 5195.', 13000, TRUE),
  ('Sombrero', 'A bright galaxy with a prominent central bulge and dust lane.', 13000, TRUE),
  ('Cartwheel', 'A ring galaxy reshaped by a high-speed galactic collision.', 12000, TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO star (name, galaxy_id, age_in_millions_of_years, surface_temperature_kelvin, is_spherical) VALUES
  ('Sun', 1, 4600, 5778, TRUE),
  ('Sirius', 1, 242, 9940, TRUE),
  ('Proxima Centauri', 1, 4850, 3042, TRUE),
  ('Vega', 1, 455, 9602, TRUE),
  ('Altair', 1, 1200, 7550, TRUE),
  ('Betelgeuse', 1, 10, 3600, TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO planet (name, star_id, description, orbital_period_days, has_life, mass_in_earth_masses) VALUES
  ('Mercury', 1, 'A small rocky planet closest to the Sun.', 88, FALSE, 0.055),
  ('Venus', 1, 'A dense world with a thick carbon dioxide atmosphere.', 225, FALSE, 0.815),
  ('Earth', 1, 'A temperate ocean world known to support life.', 365, TRUE, 1),
  ('Mars', 1, 'A cold desert planet with ancient river valleys.', 687, FALSE, 0.107),
  ('Jupiter', 1, 'A massive gas giant with a long-lived great storm.', 4333, FALSE, 317.8),
  ('Saturn', 1, 'A gas giant surrounded by a bright ring system.', 10759, FALSE, 95.2),
  ('Uranus', 1, 'An ice giant rotating on its side.', 30687, FALSE, 14.5),
  ('Neptune', 1, 'A distant ice giant with supersonic winds.', 60190, FALSE, 17.1),
  ('Aurelia', 2, 'A fictional temperate planet orbiting Sirius.', 42, FALSE, 1.4),
  ('Cinder', 3, 'A fictional rocky world orbiting Proxima Centauri.', 11, FALSE, 0.8),
  ('Lumen', 4, 'A fictional bright world orbiting Vega.', 225, FALSE, 1.2),
  ('Zephyr', 5, 'A fictional gas giant orbiting Altair.', 90, FALSE, 85)
ON CONFLICT (name) DO NOTHING;

INSERT INTO moon (name, planet_id, description, is_spherical, distance_from_earth) VALUES
  ('Moon', 3, 'Earth natural satellite.', TRUE, 384400),
  ('Phobos', 4, 'A small irregular moon of Mars.', FALSE, 78340000),
  ('Deimos', 4, 'The smaller outer moon of Mars.', FALSE, 78340000),
  ('Io', 5, 'A volcanically active moon of Jupiter.', TRUE, 628300000),
  ('Europa', 5, 'An icy moon with a subsurface ocean.', TRUE, 628300000),
  ('Ganymede', 5, 'The largest moon in the Solar System.', TRUE, 628300000),
  ('Callisto', 5, 'An ancient cratered moon of Jupiter.', TRUE, 628300000),
  ('Mimas', 6, 'A small icy moon with a giant crater.', TRUE, 1275000000),
  ('Enceladus', 6, 'An icy moon that sprays water-rich plumes.', TRUE, 1275000000),
  ('Tethys', 6, 'An icy moon with a vast impact basin.', TRUE, 1275000000),
  ('Dione', 6, 'A bright icy moon of Saturn.', TRUE, 1275000000),
  ('Rhea', 6, 'Saturn second-largest moon.', TRUE, 1275000000),
  ('Titan', 6, 'A world with lakes of liquid methane.', TRUE, 1275000000),
  ('Iapetus', 6, 'A moon with striking light and dark hemispheres.', TRUE, 1275000000),
  ('Miranda', 7, 'A small moon with dramatic cliffs.', TRUE, 2720000000),
  ('Ariel', 7, 'An icy moon of Uranus.', TRUE, 2720000000),
  ('Umbriel', 7, 'A dark, heavily cratered moon of Uranus.', TRUE, 2720000000),
  ('Titania', 7, 'The largest moon of Uranus.', TRUE, 2720000000),
  ('Oberon', 7, 'A distant icy moon of Uranus.', TRUE, 2720000000),
  ('Triton', 8, 'A captured icy moon orbiting Neptune backwards.', TRUE, 4350000000)
ON CONFLICT (name) DO NOTHING;

INSERT INTO nebula (name, galaxy_id, description, age_in_millions_of_years, has_life) VALUES
  ('Orion Nebula', 1, 'A nearby stellar nursery visible to the naked eye.', 3, FALSE),
  ('Eagle Nebula', 1, 'A star-forming region containing the Pillars of Creation.', 5, FALSE),
  ('Carina Nebula', 1, 'A vast star-forming complex in the southern sky.', 3, FALSE)
ON CONFLICT (name) DO NOTHING;
