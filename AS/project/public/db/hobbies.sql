CREATE TABLE Hobbies (
    id INTEGER PRIMARY KEY,
    hobby VARCHAR(100) NOT NULL
);

CREATE TABLE PublicacoesHobbies (
    id INTEGER PRIMARY KEY,
    id_hobby INT,
    atividade VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_hobby) REFERENCES Hobbies(id)
);