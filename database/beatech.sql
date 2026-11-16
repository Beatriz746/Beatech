
CREATE DATABASE beatech
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE beatech;

1. USUARIOS
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario VARCHAR(30) NOT NULL,
    data_registo DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

 2. COMUNIDADES
CREATE TABLE comunidades (
    id_comunidade INT AUTO_INCREMENT PRIMARY KEY,
    nome_comunidade VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

 3. CURSOS
CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome_curso VARCHAR(150) NOT NULL,
    descricao TEXT,
    imagem VARCHAR(255),
    nivel VARCHAR(50),
    estado VARCHAR(30),
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

4. INSCRICOES
CREATE TABLE inscricoes (
    id_inscricao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    data_inscricao DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado_inscricao VARCHAR(30) DEFAULT 'ativa',
    percentual_progresso DECIMAL(5,2) DEFAULT 0,
    aulas_concluidas INT DEFAULT 0,
    data_conclusao DATETIME NULL,

    UNIQUE (id_usuario, id_curso),

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_curso)
        REFERENCES cursos(id_curso)
) ENGINE=InnoDB;

 5. MODULOS
CREATE TABLE modulos (
    id_modulo INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    nome_modulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    ordem INT,

    FOREIGN KEY (id_curso)
        REFERENCES cursos(id_curso)
) ENGINE=InnoDB;

6. AULAS
CREATE TABLE aulas (
    id_aula INT AUTO_INCREMENT PRIMARY KEY,
    id_modulo INT NOT NULL,
    titulo_aula VARCHAR(150) NOT NULL,
    descricao TEXT,
    video_url VARCHAR(255),
    duracao INT,
    ordem INT,

    FOREIGN KEY (id_modulo)
        REFERENCES modulos(id_modulo)
) ENGINE=InnoDB;

 7. CERTIFICADOS
CREATE TABLE certificados (
    id_certificado INT AUTO_INCREMENT PRIMARY KEY,
    id_inscricao INT NOT NULL UNIQUE,
    codigo_certificado VARCHAR(100) NOT NULL UNIQUE,
    data_emissao DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_inscricao)
        REFERENCES inscricoes(id_inscricao)
) ENGINE=InnoDB;

 8. PUBLICACOES
CREATE TABLE publicacoes (
    id_publicacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_comunidade INT NOT NULL,
    titulo VARCHAR(150),
    conteudo TEXT NOT NULL,
    data_publicacao DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_comunidade)
        REFERENCES comunidades(id_comunidade)
) ENGINE=InnoDB;

9. COMENTARIOS
CREATE TABLE comentarios (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_publicacao INT NOT NULL,
    conteudo TEXT NOT NULL,
    data_comentario DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_publicacao)
        REFERENCES publicacoes(id_publicacao)
) ENGINE=InnoDB;

10. LIKES
CREATE TABLE likes (
    id_like INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_publicacao INT NOT NULL,
    data_like DATETIME DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (id_usuario, id_publicacao),

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_publicacao)
        REFERENCES publicacoes(id_publicacao)
) ENGINE=InnoDB;

11. RECURSOS
CREATE TABLE recursos (
    id_recurso INT AUTO_INCREMENT PRIMARY KEY,
    id_modulo INT NOT NULL,
    nome_recurso VARCHAR(150) NOT NULL,
    descricao TEXT,
    tipo_recurso VARCHAR(50),
    ficheiro_url VARCHAR(255),
    data_upload DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_modulo)
        REFERENCES modulos(id_modulo)
) ENGINE=InnoDB;
