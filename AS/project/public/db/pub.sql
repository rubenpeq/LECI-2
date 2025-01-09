CREATE TABLE Publicacoes (
    id INTEGER PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    conteudo_texto TEXT NOT NULL,
    imagem_path VARCHAR(255),
    categoria_id INT NOT NULL,
    perfil_id INT NOT NULL
);