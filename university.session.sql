CREATE TABLE student(
    id serial PRIMARY KEY,
    first_name varchar(100) NOT NULL CHECK (first_name != ''),
    last_name varchar(100) NOT NULL CHECK (last_name != '')
);

ALTER TABLE student
ADD COLUMN group_id int REFERENCES group_university(id);

CREATE TABLE group_university(
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL CHECK (name != '')
);

ALTER TABLE group_university
ADD COLUMN facultet_id int REFERENCES facultet(id);


CREATE TABLE facultet(
    id serial PRIMARY KEY,
    name varchar(150) NOT NULL CHECK (name != '')
);

CREATE TABLE discipline(
    id serial PRIMARY KEY,
    name varchar(150) NOT NULL CHECK (name != ''),
    lector varchar(150) NOT NULL CHECK (lector != '')
);

CREATE TABLE disciplines_to_facultet(
    facultet_id int REFERENCES facultet(id),
    discipline_id int REFERENCES discipline(id),
    PRIMARY KEY(facultet_id, discipline_id)
);


CREATE TABLE exam(
    discipline_id int REFERENCES discipline(id),
    student_id int REFERENCES student(id),
    mark smallint NOT NULL CHECK (mark >= 0) CHECK (mark <=5),
    PRIMARY KEY (discipline_id, student_id)
)