CREATE TABLE tenders (
  id SERIAL PRIMARY KEY,
  createdAt TIMESTAMP NOT NULL,
  closetAt TIMESTAMP NOT NULL,
  projectName TEXT NOT NULL,
  cgn VARCHAR(255) NOT NULL,
  description TEXT,
  otherObligations TEXT,
  organizerId INT NOT NULL,
  supplierId INT,
  price VARCHAR(255)
);

CREATE TABLE tenders_participants (
  id SERIAL PRIMARY KEY,
  tenderId INT NOT NULL,
  participantId INT NOT NULL
);

CREATE TABLE companies (
  id SERIAL PRIMARY KEY,
  participantName VARCHAR(255) NOT NULL,
  address VARCHAR(255),
  organizationName TEXT,
  phone VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE tenders_works (
  id SERIAL PRIMARY KEY,
  tenderId INT NOT NULL,
  workId INT NOT NULL,
  companyId INT NOT NULL
);

CREATE TABLE works (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL
);

ALTER TABLE tenders
ADD FOREIGN KEY (organizerId) REFERENCES companies (id),
ADD FOREIGN KEY (supplierId) REFERENCES companies (id);

ALTER TABLE tenders_participants
ADD FOREIGN KEY (tenderId) REFERENCES tenders (id),
ADD FOREIGN KEY (participantId) REFERENCES companies (id);

ALTER TABLE tenders_works
ADD FOREIGN KEY (tenderId) REFERENCES tenders (id),
ADD FOREIGN KEY (workId) REFERENCES works (id),
ADD FOREIGN KEY (companyId) REFERENCES companies (id);