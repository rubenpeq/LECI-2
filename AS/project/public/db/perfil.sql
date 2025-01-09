PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  nome TEXT,
  email TEXT,
  password TEXT,
  profile_image TEXT,
  amigos TEXT,
  publicacoes TEXT,
  Eventos TEXT,
  hobbies TEXT,
  atividades TEXT,
  sobre TEXT,
  idade INTEGER
);
COMMIT;
