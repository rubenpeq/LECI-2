const express = require('express');
const session = require('express-session');
const sqlite3 = require('sqlite3').verbose();
const bodyParser = require('body-parser');
const multer = require('multer');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const app = express();
const PORT = process.env.PORT || 3000;

// Configuração do middleware de sessão
app.use(session({
    secret: 'seu_secreto_aqui', // Chave secreta para assinar a sessão
    resave: false,
    saveUninitialized: true
  }));
  

// Caminho para o diretório onde o banco de dados está localizado
const profiledbPath = path.join(__dirname, 'public', 'db', 'perfil.db');

// Conexão com o banco de dados SQLite
const profiledb = new sqlite3.Database(profiledbPath, (err) => {
  if (err) {
    console.error('Erro ao abrir o banco de dados', err.message);
  } else {
    console.log('Conexão bem-sucedida com o banco de dados de perfil');
  }
});

// Caminho para o diretório onde o banco de dados está localizado
const pubdbPath = path.join(__dirname, 'public', 'db', 'pub.db');

// Conexão com o banco de dados SQLite
const pubdb = new sqlite3.Database(pubdbPath, (err) => {
  if (err) {
    console.error('Erro ao abrir o banco de dados', err.message);
  } else {
    console.log('Conexão bem-sucedida com o banco de dados de publicações');
  }
});

// Caminho para o diretório onde o banco de dados está localizado
const hobbiesdbPath = path.join(__dirname, 'public', 'db', 'hobbies.db');

// Conexão com o banco de dados SQLite
const hobbiesdb = new sqlite3.Database(hobbiesdbPath, (err) => {
  if (err) {
    console.error('Erro ao abrir o banco de dados', err.message);
  } else {
    console.log('Conexão bem-sucedida com o banco de dados de hobbies');
  }
});


// Caminho para o diretório onde o banco de dados de mensagens está localizado
const messagesdbPath = path.join(__dirname, 'public', 'db', 'mensagens.db');

// Conexão com o banco de dados SQLite de mensagens
const messagesdb = new sqlite3.Database(messagesdbPath, (err) => {
    if (err) {
        console.error('Erro ao abrir o banco de dados', err.message);
    } else {
        console.log('Conexão bem-sucedida com o banco de dados de mensagens');
    }
});


// Path to events database file
const eventsdbPath = path.join(__dirname, 'public', 'db', 'events.db');

// Connection to events database
const eventsdb = new sqlite3.Database(eventsdbPath, (err) => {
    if (err) {
        console.error('Failed to open events database', err.message);
    } else {
        console.log('Connection to events database was successfull');
    }
});

app.use(express.urlencoded({ extended: true }));

/* ---------------------------- Serve HTML files ---------------------------- */

// Serve the login.html file when someone accesses the root URL
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

app.get('/pagina_inicial', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'pagina_inicial.html'));
});

app.get('/lista_eventos', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'lista_eventos.html'));
});

app.get('/evento', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'evento.html'));
});

app.get('/evento_perfil', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'evento_perfil.html'));
});

app.get('/explorar', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'explorar.html'));
});

app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

app.get('/mensagem_privada', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'mensagem_privada.html'));
});

app.get('/mensagens_geral', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'mensagens_geral.html'));
});

app.get('/perfil', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'perfil.html'));
});

app.get('/publicacoes', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'publicacoes.html'));
});

app.get('/signup', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'signup.html'));
});

app.get('/sobre', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'sobre.html'));
});

app.get('/tela_carregamento', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'tela_carregamento.html'));
});

app.get('/publicar_evento', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'publicar_evento.html'));
});

/* ---------------------------- End Serve HTML files ---------------------------- */

// Serve static files from the 'public' and 'assets' directory
app.use('/vectors', express.static(path.join(__dirname, 'assets', 'vectors')));
app.use('/images', express.static(path.join(__dirname, 'assets', 'images')));
app.use('/pub_images', express.static(path.join(__dirname, 'assets', 'pub_images')));
app.use('/profile_images', express.static(path.join(__dirname, 'assets', 'profile_images')));
app.use('/events-images', express.static(path.join(__dirname, 'assets', 'images', 'events-images')));
app.use('/js', express.static(path.join(__dirname, 'public', 'js')));
app.use('/css', express.static(path.join(__dirname, 'public', 'css')));


// Middleware para servir arquivos estáticos
app.use(express.static('public'));

// Middleware para lidar com o parsing do corpo das requisições
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));


// Serve events.json from the js folder
app.get('/events', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'js', 'events.json'));
});

// Create a new event
const createEvent = (username, date, time, event_name, description, location, category, image_path) => {
    const stmt = db.prepare(`
      INSERT INTO events (username, date, time, event_name, description, location, category, image_path)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `);
    stmt.run(username, date, time, event_name, description, location, category, image_path, (err) => {
      if (err) {
        return console.error(err.message);
      }
      console.log('Event added successfully');
    });
    stmt.finalize();
  };

  // API endpoint to fetch event data
app.get('/api/event', (req, res) => {
    const eventId = req.query.id;
    if (!eventId) {
      return res.status(400).send('Event ID is required');
    }
  
    const eventQuerry = `SELECT * FROM events WHERE id = ?`;
    eventsdb.get(eventQuerry, [eventId], (err, row) => {
      if (err) {
        return res.status(500).send('Failed to retrieve event data');
      }
      if (!row) {
        return res.status(404).send('Event not found');
      }
      res.json(row);
    });
  });  

  
// Route to get upcoming events
app.get('/api/upcoming-events', async (req, res) => {
    try {
        // Read events from JSON file
        const eventsData = await fs.promises.readFile(path.join(__dirname, 'public/js/events.json'), 'utf8');
        const events = JSON.parse(eventsData);

        // Filter upcoming events
        const currentDate = new Date();
        const upcomingEvents = events.filter(event => {
            const eventDate = new Date(event.date + 'T' + event.time);
            return eventDate > currentDate;
        });

        // Sort events by date and time, most recent first
        upcomingEvents.sort((a, b) => {
            const dateA = new Date(a.date + 'T' + a.time);
            const dateB = new Date(b.date + 'T' + b.time);
            return dateB - dateA;
        });

        // Reverse the array to display events in reverse chronological order
        upcomingEvents.reverse();

        res.json(upcomingEvents);
    } catch (error) {
        console.error('Error reading upcoming events:', error);
        res.status(500).send('Something went wrong!');
    }
});

// Route to get past events
app.get('/api/past-events', async (req, res) => {
    try {
        // Read events from JSON file
        const eventsData = await fs.promises.readFile(path.join(__dirname, 'public/js/events.json'), 'utf8');
        const events = JSON.parse(eventsData);

        // Filter past events
        const currentDate = new Date();
        const pastEvents = events.filter(event => {
            const eventDate = new Date(event.date + 'T' + event.time);
            return eventDate <= currentDate;
        });

        // Sort events by date and time, most recent first
        pastEvents.sort((a, b) => {
            const dateA = new Date(a.date + 'T' + a.time);
            const dateB = new Date(b.date + 'T' + b.time);
            return dateB - dateA;
        });

        res.json(pastEvents);
    } catch (error) {
        console.error('Error reading past events:', error);
        res.status(500).send('Something went wrong!');
    }
});
app.post('/register', (req, res) => {
    const { nome, email, password , idade} = req.body;

    const profile_image = 'images/default.png'; // Você pode manipular o envio da imagem aqui, se necessário
    const amigos = '';
    const publicacoes = '';
    const eventos = '';
    const hobby = '';
    const sobre = '';

    profiledb.run('INSERT INTO users (nome, email, password, profile_image, amigos, publicacoes, Eventos, hobbies, sobre, idade) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [nome, email, password, profile_image, amigos, publicacoes, eventos, hobby, sobre, idade], function(err) {
        if (err) {
            return console.error('Erro ao inserir registro', err.message);
        }
        console.log(`Registro inserido com sucesso. ID: ${this.lastID}`);
        res.redirect('/login'); // Redireciona para a página de login após o registro
    });
});

app.post('/login', (req, res) => {
    const { username, password } = req.body;

    // Consulta SQL para buscar o usuário pelo nome de usuário
    profiledb.get('SELECT * FROM users WHERE nome = ?', [username], (err, row) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.redirect('/login?error=internal_error');
        }
        // Verifica se o usuário foi encontrado
        if (!row) {
            // Usuário não encontrado
            return res.redirect('/login?error=user_not_found');
        }

        // Verifica se a senha está correta
        if (row.password !== password) {
            // Senha incorreta
            return res.redirect('/login?error=incorrect_password');
        }

        // Credenciais válidas, armazenar o ID do usuário na sessão
        req.session.userId = row.id;

        // Redirecionar para a página inicial
        res.redirect('/pagina_inicial');
    });
});

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        const directory = 'assets/pub_images/';
        // Verificar se o diretório existe
        if (!fs.existsSync(directory)) {
            // Se não existe, crie o diretório
            fs.mkdirSync(directory);
        }
        cb(null, directory);
    },
    filename: function (req, file, cb) {
        // Nome do arquivo
        const fileName = file.fieldname + '-' + Date.now() + path.extname(file.originalname);
        cb(null, fileName);
    }
});


const upload = multer({ storage: storage });

const EventStorage = multer.diskStorage({
    destination: function (req, file, cb) {
        const directory = 'assets/images/events-images';
        // Verificar se o diretório existe
        if (!fs.existsSync(directory)) {
            // Se não existe, crie o diretório
            fs.mkdirSync(directory);
        }
        cb(null, directory);
    },
    filename: function (req, file, cb) {
        // Nome do arquivo
        const fileName = file.fieldname + '-' + Date.now() + path.extname(file.originalname);
        cb(null, fileName);
    }
});

const EventUpload = multer({ storage: EventStorage });

app.use(express.static('public'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));



//Função para mostrar eventos guardados no perilf na página inicial

app.get('/eventos', (req, res) => {
    const userId = req.session.userId; // Supondo que o ID do perfil está armazenado na sessão

    if (!userId) {
        return res.status(401).json({ error: 'Usuário não autenticado' });
    }

    profiledb.get('SELECT Eventos FROM users WHERE id = ?', [userId], (err, row) => {
        if (err) {
            console.error('Erro ao buscar eventos do perfil:', err.message);
            return res.status(500).json({ error: 'Erro ao buscar eventos do perfil.' });
        }

        if (!row) {
            return res.status(404).json({ error: 'Perfil não encontrado.' });
        }

        const eventos = row.Eventos ? row.Eventos.split(',') : [];

        // Consultar o banco de dados para obter os dados dos eventos
        const query = `SELECT * FROM events WHERE id IN (${eventos.map(() => '?').join(',')})`;

        eventsdb.all(query, eventos, (err, rows) => {
            if (err) {
                console.error('Erro ao buscar eventos:', err.message);
                return res.status(500).json({ error: 'Erro ao buscar eventos.' });
            }

            res.json(rows);
        });

    });
});

        




// Rota para adicionar um evento
app.post('/api/adicionar_evento', (req, res) => {
    const eventId = req.body.event_id;
    console.log('Evento ID:', eventId);
    const userId = req.session.userId; // Supondo que o ID do perfil está armazenado na sessão

    if (!userId) {
        return res.status(401).json({ success: false, error: 'Usuário não autenticado' });
    }

    // Verificar se o evento já foi adicionado

    profiledb.get('SELECT * FROM users WHERE id = ?', [userId], (err, row) => {
        if (err) {
            console.error('Erro ao buscar perfil:', err.message);
            return res.status(500).json({ success: false, error: 'Erro ao buscar perfil.' });
        }

        if (!row) {
            return res.status(404).json({ success: false, error: 'Perfil não encontrado.' });
        }

        const eventos = row.Eventos ? row.Eventos.split(',') : [];

        if (eventos.includes(eventId)) {
            return res.json({ success: false, error: 'Evento já adicionado' });
        }

        // Adicionar o evento à lista de eventos do perfil
        eventos.push(eventId);
        const eventosAtualizados = eventos.join(',');
        profiledb.run('UPDATE users SET Eventos = ? WHERE id = ?', [eventosAtualizados, userId], function(err) {
            if (err) {
                console.error('Erro ao adicionar evento ao perfil:', err.message);
                return res.status(500).json({ success: false, error: 'Erro ao adicionar evento ao perfil.' });
            }
            res.json({ success: true });
        });
    });
});




// Rota para adicionar uma nova publicação
app.post('/adicionar_publicacao', upload.single('imagem'), (req, res) => {
    const { titulo, conteudo_texto, categoria_nome, tipo_publicacao } = req.body;
    const perfil_id = req.session.userId;  // Supondo que o ID do perfil está armazenado na sessão
    let imagem_path = '';

    if (req.file) {
        imagem_path = 'pub_images/' + req.file.filename;
        console.log('Imagem recebida:', req.file); // Log para verificar se o arquivo está sendo recebido
    } else {
        console.log('Nenhuma imagem recebida');
    }

    console.log('Imagem path:', imagem_path);

    console.log(categoria_nome);

    // Buscar o ID da categoria pelo nome
    hobbiesdb.get('SELECT id FROM PublicacoesHobbies WHERE atividade = ?', [categoria_nome], (err, row) => {
        if (err) {
            console.error('Erro ao buscar categoria:', err.message);
            return res.status(500).json({ success: false, error: 'Erro ao buscar categoria.' });
        }
        if (!row) {
            return res.status(404).json({ success: false, error: 'Categoria não encontrada.' });
        }

        console.log("categoria encontrada");

        const categoria_id = row.id;

        const query = `
            INSERT INTO Publicacoes (titulo, conteudo_texto, imagem_path, categoria_id, perfil_id)
            VALUES (?, ?, ?, ?, ?)
        `;

        pubdb.run(query, [titulo, conteudo_texto, imagem_path, categoria_id, perfil_id], function(err) {
            if (err) {
                console.error('Erro ao adicionar publicação:', err.message);
                return res.status(500).json({ success: false, error: 'Erro ao adicionar publicação.' });
            }
            console.log("publicação adicioanada");
            res.json({ success: true });
        });
    });
});

// Function to export events to JSON
function exportEventsToJson(db, jsonFilePath) {
    // Query events from the database
    const query = 'SELECT * FROM events';

    db.all(query, (err, rows) => {
        if (err) {
            console.error('Error querying events:', err);
            return;
        }

        // Convert rows to JSON
        const jsonData = JSON.stringify(rows, null, 2);

        // Write JSON data to a file
        fs.writeFile(jsonFilePath, jsonData, (err) => {
            if (err) {
                console.error('Error writing JSON file:', err);
                return;
            }
            console.log('Events exported to JSON successfully');
        });
    });
}

// Handle POST request to /add-event
app.post('/add-event', EventUpload.single('image'), (req, res) => {
    // Retrieve userId from session or request payload
    const userId = req.session.userId; // Assuming it's stored in session

    // Query perfil.db to fetch username based on userId
    profiledb.get('SELECT nome FROM users WHERE id = ?', [userId], (err, row) => {
        if (err) {
            console.error('Error querying perfil.db:', err);
            return res.status(500).send('Internal Server Error');
        }

        if (!row) {
            return res.status(404).send('User not found');
        }

        const username = row.nome;

        // Now you have the username, you can proceed to insert data into events.db
        const { date, time, event_name, description, location, category } = req.body;
        let image_path = req.file ? req.file.path : null;

        // Check if image_path exists and starts with 'assets/images/'
        if (image_path && image_path.startsWith('assets/images/')) {
        // Modify image_path to start at 'events-images/'
        image_path = image_path.substring('assets/images/'.length);
        }

        const sql = `INSERT INTO events (username, date, time, event_name, description, location, category, image_path) 
                     VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;

        eventsdb.run(sql, [username, date, time, event_name, description, location, category, image_path], function (err) {
            if (err) {
                console.error('Error inserting data into events.db:', err);
                return res.status(500).send('Failed to add event');
            }

            // Run the function to export events to JSON
            exportEventsToJson(eventsdb, 'public/js/events.json');

            res.send('Event added successfully');
        });
    });
});


// Rota para buscar informações do perfil
app.get('/perfil_info/:id?', (req, res) => {
    let userId;
    if (req.params.id !== null && req.params.id !== undefined && req.params.id !== 'null') {
        userId = req.params.id;
    } else {
        userId = req.session.userId;
    }

    if (!userId) {
        return res.status(401).json({ error: 'Usuário não autenticado' });
    }

    const query = 'SELECT sobre, idade FROM users WHERE id = ?';

    profiledb.get(query, [userId], (err, row) => {
        if (err) {
            console.error('Erro ao buscar informações do perfil:', err.message);
            return res.status(500).json({ error: 'Erro ao buscar informações do perfil.' });
        }

        if (!row) {
            return res.status(404).json({ error: 'Perfil não encontrado.' });
        }

        res.json(row);
    });
});


// Rota para adicionar uma nova mensagem
app.post('/mensagens', (req, res) => {
    console.log(req.body); // Verifique se o corpo da requisição está sendo recebido corretamente
    const { mensagem, pessoa2_id } = req.body;
    const pessoa1_id = req.session.userId;
    const timestamp = new Date().toISOString().replace('T', ' ').substr(0, 19);

    const formattedMessage = `--${mensagem}--${timestamp}--`;

    messagesdb.run(`INSERT INTO messages (pessoa1_id, pessoa2_id, mensagem) VALUES (?, ?, ?)`, 
    [pessoa1_id, pessoa2_id, formattedMessage], function(err) {
        if (err) {
            return res.status(500).send(err.message);
        }
        res.status(201).send('Mensagem adicionada com sucesso');
    });
});

// Configuração do multer para armazenar as imagens de perfil
const storage2 = multer.diskStorage({
    destination: function (req, file, cb) {
        const directory = 'assets/profile_images/';
        // Verificar se o diretório existe
        if (!fs.existsSync(directory)) {
            // Se não existe, crie o diretório
            fs.mkdirSync(directory);
        }
        cb(null, directory);
    },
    filename: function (req, file, cb) {
        // Nome do arquivo
        const fileName = file.fieldname + '-' + Date.now() + path.extname(file.originalname);
        cb(null, fileName);
    }
});

// Upload de imagens com o multer
const upload2 = multer({ storage: storage2 });

// Rota para lidar com a solicitação de upload de imagem
app.post('/uploadImage', upload2.single('profile_image'), (req, res) => {
    const userId = req.session.userId; // ID do usuário

    // Caminho da imagem
    const imagePath = 'profile_images/' + req.file.filename;

    // Atualizar o caminho da imagem no banco de dados
    profiledb.run('UPDATE users SET profile_image = ? WHERE id = ?', [imagePath, userId], (dbErr) => {
        if (dbErr) {
            console.error('Erro ao atualizar caminho da imagem no banco de dados:', dbErr);
            res.status(500).send('Erro ao atualizar caminho da imagem no banco de dados');
            return;
        }

        console.log('Caminho da imagem atualizado no banco de dados');
        res.status(200).send('Imagem do perfil atualizada com sucesso');
    });
});
// Rota para exibir os hobbies e atividades do usuário
app.get('/atividades', (req, res) => {
    const userId = req.session.userId; // Recupera o ID do usuário da sessão

    if (!userId) {
        return res.status(401).send('Usuário não autenticado');
    }

    // Consultar o banco de dados para obter os hobbies e atividades do usuário
    profiledb.get('SELECT atividades FROM users WHERE id = ?', [userId], (err, row) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.status(500).send('Erro ao consultar o banco de dados');
        }

        if (row) {
            // Obter os hobbies e atividades do resultado da consulta
            const atividades = row.atividades ? row.atividades.split(',').filter(atividade => atividade.trim() !== '') : [];


            // Enviar os hobbies e atividades como resposta
            res.json({ atividades });
        } else {
            res.status(404).send('Usuário não encontrado');
        }
    });
});

// Rota para exibir todos os hobbies
app.get('/hobbiespesq', (req, res) => {
    // Consultar o banco de dados para obter todos os hobbies
    hobbiesdb.all('SELECT hobby FROM Hobbies', (err, rows) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.status(500).send('Erro ao consultar o banco de dados');
        }

        // Extrair os hobbies das linhas retornadas
        const hobbies = rows.map(row => row.hobby);

        // Enviar os hobbies como resposta
        res.json({ hobbies });
    });
});
// Rota para adicionar uma nova atividade ao perfil do usuário
app.get('/adicionar-atividade', (req, res) => {
    const userId = req.session.userId; // Recupera o ID do usuário da sessão
    const atividade = req.query.atividade;

    if (!userId) {
        return res.status(401).send('Usuário não autenticado');
    }

    // Função para atualizar o perfil do usuário com a nova atividade
    const atualizarPerfil = (coluna, listaAtualizada) => {
        profiledb.run(`UPDATE users SET ${coluna} = ? WHERE id = ?`, [listaAtualizada, userId], (err) => {
            if (err) {
                console.error(`Erro ao atualizar ${coluna} do usuário:`, err.message);
                return res.status(500).send(`Erro ao atualizar ${coluna} do usuário`);
            }
            res.status(200).send(`Nova atividade adicionada ao perfil do usuário com sucesso`);
        });
    };

    // Consultar a base de dados para verificar se a atividade já existe no perfil do usuário
    profiledb.get('SELECT atividades FROM users WHERE id = ?', [userId], (err, row) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.status(500).send('Erro ao consultar o banco de dados');
        }

        if (row) {
            const atividadesDoUsuario = row.atividades ? row.atividades.split(',') : [];

            if (atividadesDoUsuario.includes(atividade)) {
                // Se a atividade já estiver no perfil do usuário, enviar a resposta indicando que a atividade já existe
                return res.status(400).send('Atividade já existe no perfil do usuário');
            } else {
                // Verificar se a atividade existe na tabela de PublicacoesHobbies
                hobbiesdb.get('SELECT * FROM PublicacoesHobbies WHERE atividade = ?', [atividade], (err, row) => {
                    if (err) {
                        console.error('Erro ao consultar o banco de dados:', err.message);
                        return res.status(500).send('Erro ao consultar o banco de dados');
                    }

                    if (row) {
                        // A atividade existe na base de dados
                        atividadesDoUsuario.push(atividade);
                        const novaListaAtividades = atividadesDoUsuario.join(',');
                        atualizarPerfil('atividades', novaListaAtividades);
                    } else {
                        // Se a atividade não existe na base de dados, enviar a resposta indicando que a atividade não existe
                        res.status(400).send('Atividade não existe na base de dados');
                    }
                });
            }
        } else {
            res.status(404).send('Usuário não encontrado');
        }
    });
});

app.get('/remover-atividade', (req, res) => {
    const userId = req.session.userId; // Recupera o ID do usuário da sessão
    const atividade = req.query.atividade;

    if (!userId) {
        return res.status(401).send('Usuário não autenticado');
    }

    // Função para atualizar o perfil do usuário removendo a atividade
    const atualizarPerfil = (coluna, listaAtualizada) => {
        profiledb.run(`UPDATE users SET ${coluna} = ? WHERE id = ?`, [listaAtualizada, userId], (err) => {
            if (err) {
                console.error(`Erro ao atualizar ${coluna} do usuário:`, err.message);
                return res.status(500).send(`Erro ao atualizar ${coluna} do usuário`);
            }
            res.status(200).send(`Atividade removida do perfil do usuário com sucesso`);
        });
    };

    // Consultar a base de dados para verificar se a atividade existe no perfil do usuário
    profiledb.get('SELECT atividades FROM users WHERE id = ?', [userId], (err, row) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.status(500).send('Erro ao consultar o banco de dados');
        }

        if (row) {
            const atividadesDoUsuario = row.atividades ? row.atividades.split(',') : [];

            if (!atividadesDoUsuario.includes(atividade)) {
                // Se a atividade não estiver no perfil do usuário, enviar a resposta indicando que a atividade não existe
                return res.status(400).send('Atividade não existe no perfil do usuário');
            } else {
                // Remover a atividade da lista de atividades do usuário
                const index = atividadesDoUsuario.indexOf(atividade);
                if (index > -1) {
                    atividadesDoUsuario.splice(index, 1);
                }
                const novaListaAtividades = atividadesDoUsuario.join(',');
                atualizarPerfil('atividades', novaListaAtividades);
            }
        } else {
            res.status(404).send('Usuário não encontrado');
        }
    });
});

  


// Rota para verificar se a atividade já existe na base de dados
app.get('/verificar-atividade', (req, res) => {
    const atividade = req.query.atividade;

    // Consultar a base de dados para verificar se a atividade já existe no perfil do usuário
    profiledb.get('SELECT atividades FROM users WHERE id = ?', [req.session.userId], (err, row) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.status(500).send('Erro ao consultar o banco de dados');
        }

        if (row) {
            const atividadesDoUsuario = row.atividades ? row.atividades.split(',') : [];
            const atividadeJaNoPerfil = atividadesDoUsuario.includes(atividade);

            if (atividadeJaNoPerfil) {
                // Se a atividade já estiver no perfil do usuário, enviar a resposta indicando que a atividade já existe
                return res.json({ existe: true, mensagem: 'Atividade já existe no perfil do usuário' });
            } else {
                // Se a atividade não estiver no perfil do usuário, verificar se ela existe na base de dados em geral
                hobbiesdb.get('SELECT * FROM PublicacoesHobbies WHERE atividade = ?', [atividade], (err, row) => {
                    if (err) {
                        console.error('Erro ao consultar o banco de dados:', err.message);
                        return res.status(500).send('Erro ao consultar o banco de dados');
                    }

                    if (row) {
                        // Se a atividade existe na base de dados, enviar a resposta indicando que a atividade existe
                        return res.json({ existe: false, mensagem: 'Atividade existe na base de dados' });
                    } else {
                        // Se a atividade não existe na base de dados, enviar a resposta indicando que a atividade não existe
                        return res.json({ existe: true, mensagem: 'Atividade não existe na base de dados' });
                    }
                });
            }
        } else {
            res.status(404).send('Usuário não encontrado');
        }
    });
});

  



app.get('/nomes_conversas', (req, res) => {
    const userId = req.session.userId; // Recupera o ID do usuário da sessão

    if (!userId) {
        return res.status(401).send('Usuário não autenticado');
    }

    // Consulta o banco de dados para obter os nomes das pessoas com quem o usuário já conversou
    messagesdb.all('SELECT DISTINCT CASE WHEN pessoa1_id = ? THEN pessoa2_id ELSE pessoa1_id END AS id FROM messages WHERE pessoa1_id = ? OR pessoa2_id = ?', [userId, userId, userId], (err, rows) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.status(500).send('Erro ao consultar o banco de dados');
        }

        // Verifica se não há nenhuma conversa registrada
        if (rows.length === 0) {
            return res.json({ lastMessages: {} }); // Retorna um objeto vazio se não houver conversas
        }

        // Obtém os IDs das pessoas com quem o usuário já conversou
        const ids = rows.map(row => row.id);

        // Consulta o banco de dados para obter os nomes correspondentes aos IDs
        profiledb.all('SELECT id, nome, profile_image FROM users WHERE id IN (' + ids.join(',') + ')', (err, rows) => {
            if (err) {
                console.error('Erro ao consultar o banco de dados:', err.message);
                return res.status(500).send('Erro ao consultar o banco de dados');
            }

            // Mapeia os IDs para um objeto de nome e ID
            const idToProfile = {};
            rows.forEach(row => {
                idToProfile[row.id] = { nome: row.nome, profile_image: row.profile_image };
            });

            // Consulta o banco de dados para obter a última mensagem entre o usuário e cada pessoa
            messagesdb.all('SELECT pessoa1_id, pessoa2_id, mensagem FROM messages WHERE (pessoa1_id = ? OR pessoa2_id = ?) AND (pessoa1_id IN (' + ids.join(',') + ') OR pessoa2_id IN (' + ids.join(',') + '))', [userId, userId], (err, rows) => {
                if (err) {
                    console.error('Erro ao consultar o banco de dados:', err.message);
                    return res.status(500).send('Erro ao consultar o banco de dados');
                }

                // Estrutura de dados para armazenar as últimas mensagens
                const lastMessages = {};

                // Processa as mensagens para encontrar a última mensagem de cada conversa
                rows.forEach(row => {
                    const otherUserId = row.pessoa1_id === userId ? row.pessoa2_id : row.pessoa1_id;
                    const message = row.mensagem;
                    const timestampMatch = message.match(/--\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}--$/);
                    const timestamp = timestampMatch ? timestampMatch[0].slice(2, -2) : 'Data desconhecida';
                    const mensagemSemTimestamp = timestampMatch ? message.replace(timestampMatch[0], '') : message;
                    const mensagemSemMarcador = mensagemSemTimestamp.replace(/--/g, '');
                    if (!(otherUserId in lastMessages) || timestamp > lastMessages[otherUserId].timestamp) {
                        lastMessages[otherUserId] = {
                            id: otherUserId, // Adiciona o ID da outra pessoa
                            nome: idToProfile[otherUserId].nome,
                            profile_image: idToProfile[otherUserId].profile_image, // Add this line to include the profile image
                            mensagem: mensagemSemMarcador.trim(),
                            timestamp: timestamp
                        };
                    }
                });

                // Enviar os nomes, IDs e as últimas mensagens como resposta
                res.json({ lastMessages });
            });
        });
    });
});



app.get('/mensagens/:idOutraPessoa', (req, res) => {
    const userId = req.session.userId; // ID do usuário logado
    const idOutraPessoa = req.params.idOutraPessoa; // ID da outra pessoa
  
    if (!userId) {
        return res.status(401).send('Usuário não autenticado');
    }
  
    // Consulta o banco de dados para obter as mensagens da conversa entre o usuário logado e a outra pessoa
    messagesdb.all('SELECT mensagem, pessoa1_id FROM messages WHERE (pessoa1_id = ? AND pessoa2_id = ?) OR (pessoa1_id = ? AND pessoa2_id = ?)', [userId, idOutraPessoa, idOutraPessoa, userId], (err, rows) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.status(500).send('Erro ao consultar o banco de dados');
        }

        // Obtém o nome da outra pessoa
        profiledb.get('SELECT nome FROM users WHERE id = ?', [idOutraPessoa], (err, row) => {
            if (err) {
                console.error('Erro ao consultar o banco de dados:', err.message);
                return res.status(500).send('Erro ao consultar o banco de dados');
            }

            // Processa as mensagens para remover o trecho de timestamp e os caracteres "--"
            const mensagensFormatadas = rows.map(row => {
                const message = row.mensagem;
                const mensagemSemMarcador = message.replace(/--/g, '');
                const timestampMatch = mensagemSemMarcador.match(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/);
                const mensagemSemTimestamp = timestampMatch ? mensagemSemMarcador.replace(timestampMatch[0], '') : mensagemSemMarcador;
                return { mensagem: mensagemSemTimestamp.trim(), pessoa1_id: row.pessoa1_id, nomeOutraPessoa: row.nome };
            });

            // Envie as mensagens formatadas como resposta
            res.json({ mensagens: mensagensFormatadas,
                nomeOutraPessoa: row.nome
             });
        });
    });
});


// Rota para buscar as categorias associadas a um hobby
app.get('/categorias/:nomeHobby', (req, res) => {
    const nomeHobby = req.params.nomeHobby;

    // Consulta o banco de dados para obter o ID do hobby com base no nome
    hobbiesdb.get('SELECT id FROM Hobbies WHERE hobby = ?', [nomeHobby], (err, row) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.status(500).send('Erro ao consultar o banco de dados');
        }

        if (!row) {
            return res.status(404).send('Hobby não encontrado');
        }

        const idHobby = row.id;

        // Consulta o banco de dados para obter as categorias associadas ao hobby
        hobbiesdb.all('SELECT atividade FROM PublicacoesHobbies WHERE id_hobby = ?', [idHobby], (err, rows) => {
            if (err) {
                console.error('Erro ao consultar o banco de dados:', err.message);
                return res.status(500).send('Erro ao consultar o banco de dados');
            }

            // Extrai as categorias do resultado da consulta
            const categorias = rows.map(row => row.atividade);

            // Retorna as categorias como resposta
            res.json({ categorias });
        });
    });
});

app.get('/atividade/:id_hobby', (req, res) => {
    const idHobby = req.params.id_hobby;
    // Consulta ao banco de dados para obter a atividade associada ao id_hobby
    hobbiesdb.all('SELECT atividade FROM PublicacoesHobbies WHERE id = ?', [idHobby], (err, rows) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            res.status(500).send('Erro ao consultar o banco de dados');
        } else {
            // Extrai a atividade do resultado da consulta
            const atividade = rows.length > 0 ? rows[0].atividade : null;
            // Retorna a atividade como resposta
            res.json({ atividade });
        }
    });
});


app.get('/buscarCategorias', (req, res) => {
    const termo = req.query.termo;

    // Consulta o banco de dados para obter as categorias que correspondem ao termo
    hobbiesdb.all('SELECT DISTINCT atividade FROM PublicacoesHobbies WHERE atividade LIKE ?', [`%${termo}%`], (err, rows) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.status(500).send('Erro ao consultar o banco de dados');
        }

        // Extrai as categorias do resultado da consulta
        const categorias = rows.map(row => row.atividade);

        // Retorna as categorias como resposta
        res.json({ categorias });
    });
});

// Rota para buscar as publicações associadas a uma categoria
app.get('/publicacoes/:categoria', (req, res) => {
    const categoria = req.params.categoria;

    console.log(`Buscando ID para a categoria: ${categoria}`);

    // Primeiro, obter o ID da categoria com base no nome da categoria
    hobbiesdb.get('SELECT id FROM PublicacoesHobbies WHERE atividade = ?', [categoria], (err, row) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados dos hobbies:', err.message);
            return res.status(500).send('Erro ao consultar o banco de dados dos hobbies');
        }

        if (!row) {
            console.log(`Categoria não encontrada: ${categoria}`);
            return res.status(404).send('Categoria não encontrada');
        }

        const categoriaId = row.id;
        console.log(`ID da categoria encontrada: ${categoriaId}`);

        // Em seguida, obter as publicações associadas a esse ID de categoria
        pubdb.all('SELECT * FROM Publicacoes WHERE categoria_id = ?', [categoriaId], (err, rows) => {
            if (err) {
                console.error('Erro ao consultar o banco de dados das publicações:', err.message);
                return res.status(500).send('Erro ao consultar o banco de dados das publicações');
            }

            console.log('Publicações encontradas:', rows);

            // Retorna todas as publicações, independentemente do tipo
            res.json({ publicacoes: rows });
        });
    });
});



app.post('/register', (req, res) => {
    const { nome, email, password, idade } = req.body;

    const profile_image = ''; // Você pode manipular o envio da imagem aqui, se necessário
    const amigos = '';
    const publicacoes = '';
    const eventos = '';
    const hobby = '';
    const sobre = '';
    const atividades = '';

    profiledb.run('INSERT INTO users (nome, email, password, profile_image, amigos, publicacoes, Eventos, hobbies, atividades,sobre, idade) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [nome, email, password, profile_image, amigos, publicacoes, eventos, hobby, atividades, sobre, idade], function(err) {
        if (err) {
            return console.error('Erro ao inserir registro', err.message);
        }
        console.log(`Registro inserido com sucesso. ID: ${this.lastID}`);
        res.redirect('/login'); // Redireciona para a página de login após o registro
    });
});

// Fetch profile data
app.get('/api/perfil/:id?', (req, res) => {
    let userId;
    if (req.params.id !== null && req.params.id !== undefined && req.params.id !== 'null') {
        userId = req.params.id;
    } else {
        userId = req.session.userId;
    }
    console.log('userId' + userId);
    if (!userId) return res.status(401).send('Usuário não autenticado');
    
    profiledb.get('SELECT nome, profile_image, publicacoes FROM users WHERE id = ?', [userId], (err, row) => {
        if (err) {
            console.error('Erro ao consultar o banco de dados:', err.message);
            return res.status(500).send('Erro ao obter dados do perfil');
        }
        // Parse das strings de publicações, eventos e hobbies
        row.publicacoes = row.publicacoes ? row.publicacoes.split(',') : [];
        row.Eventos = row.Eventos ? row.Eventos.split(',') : [];
        row.hobbies = row.hobbies ? row.hobbies.split(',') : [];
        res.json(row);
    });
});



// Função para obter o ID do usuário com base no nome
app.get('/nome_para_id/:nome', (req, res) => {
    const nome = req.params.nome;

    const query = `SELECT id FROM users WHERE nome = ?`;

    profiledb.get(query, [nome], (err, row) => {
        if (err) {
            console.error('Erro ao buscar ID do usuário:', err.message);
            res.status(500).json({ error: 'Erro ao buscar ID do usuário' });
        } else if (row) {
            res.json({ id: row.id });
        } else {
            res.status(404).json({ error: 'Usuário não encontrado' });
        }
    });
});

// Função para obter o ID do usuário com base no nome
app.get('/id_para_nome/:id', (req, res) => {
    const id = req.params.id;

    const query = `SELECT nome FROM users WHERE id = ?`;

    profiledb.get(query, [id], (err, row) => {
        if (err) {
            console.error('Erro ao buscar nome do usuário:', err.message);
            res.status(500).json({ error: 'Erro ao buscar nome do usuário' });
        } else if (row) {
            res.json({ nome: row.nome });
        } else {
            res.status(404).json({ error: 'Usuário não encontrado' });
        }
    });
});

// Função para buscar todas as publicações de um usuário específico
app.get('/publicacoes_usuario/:id?', (req, res) => {
    if (req.params.id !== null && req.params.id !== undefined && req.params.id !== 'null') {
        userId = req.params.id;
    } else {
        userId = req.session.userId;
    }
    const query = `SELECT * FROM Publicacoes WHERE perfil_id = ?`;
    
    pubdb.all(query, [userId], (err, rows) => {
      if (err) {
        console.error('Erro ao consultar o banco de dados das publicações:', err.message);
        res.status(500).send('Erro ao consultar o banco de dados das publicações');
      } else {
        res.json({ publicacoes: rows });
      }
    });
});





// User registration
app.post('/signup', (req, res) => {
    const { username, password, age, hobbies } = req.body;
    const initialImage = 'default_profile.png';
    profiledb.run('INSERT INTO users (nome, password, idade, profile_image, publicacoes, eventos, hobbies) VALUES (?, ?, ?, ?, ?, ?, ?)', 
    [username, password, age, initialImage, JSON.stringify([]), 0, hobbies], (err) => {
        if (err) {
            console.error('Erro ao registrar usuário:', err.message);
            return res.status(500).send('Erro ao registrar usuário');
        }
        res.redirect('/login');
    });
});

app.post('/editar_sobre', (req, res) => {
    const userId = req.session.userId;
    const novoSobre = req.body.sobre;

    if (!userId) {
        return res.status(401).send('Usuário não autenticado');
    }

    // Atualizar o campo "sobre" na base de dados para o usuário atual
    profiledb.run('UPDATE users SET sobre = ? WHERE id = ?', [novoSobre, userId], function(err) {
        if (err) {
            console.error('Erro ao atualizar sobre do usuário:', err.message);
            return res.status(500).send('Erro ao atualizar sobre do usuário');
        }
        console.log('Sobre do usuário atualizado com sucesso.');
        res.sendStatus(200); // Responder com sucesso ao cliente
    });
});


// Defina a rota para buscar todos os usuários registrados
app.get('/todos_utilizadores', (req, res) => {
    const query = 'SELECT nome FROM users';

    profiledb.all(query, (err, rows) => {
        if (err) {
            console.error('Erro ao buscar todos os usuários:', err.message);
            res.status(500).json({ error: 'Erro ao buscar todos os usuários' });
        } else {
            res.json({ users: rows });
        }
    });
});

// Logout route
app.post('/logout', (req, res) => {
    req.session.destroy((err) => {
        if (err) {
            console.error('Erro ao encerrar a sessão:', err.message);
            return res.status(500).send('Erro ao encerrar a sessão');
        }
        res.redirect('/login');
    });
});


//const Publicacao = require('./js/publicacao');

// Rota para excluir uma publicação
app.delete('/excluir_publicacao/:id', (req, res) => {
    const { id } = req.params;

    // Consulta SQL para excluir a publicação com base no ID
    pubdb.run('DELETE FROM Publicacoes WHERE id = ?', [id], function(err) {
        if (err) {
            return console.error('Erro ao excluir publicação', err.message);
        }
        console.log(`Publicação excluída com sucesso. ID: ${id}`);
        res.sendStatus(200);
    });
});

/* --------------- Close open databases when the server stops running --------------- */

// Function to close the database connections
const closeDatabases = () => {
    profiledb.close((err) => {
      if (err) {
        return console.error(err.message);
      }
      console.log('Closed profiles database connection.');
    });

    pubdb.close((err) => {
        if (err) {
          return console.error(err.message);
        }
        console.log('Closed publications database connection.');
      });

      messagesdb.close((err) => {
        if (err) {
          return console.error(err.message);
        }
        console.log('Closed messages database connection.');
      });

    hobbiesdb.close((err) => {
        if (err) {
          return console.error(err.message);
        }
        console.log('Closed hobbies database connection.');
      });

      eventsdb.close((err) => {
        if (err) {
          return console.error(err.message);
        }
        console.log('Closed events database connection.');
      });
      
      // Additional code to handle callback when all connections are closed
      console.log('All database connections closed.');
};
  
  // Handle various shutdown events
  process.on('SIGINT', () => {
    console.log('\nReceived SIGINT. Shutting down gracefully...');
    closeDatabases();
    process.exit(0);
  });
  
  process.on('SIGTERM', () => {
    console.log('\nReceived SIGTERM. Shutting down gracefully...');
    closeDatabases();
    process.exit(0);
  });
  
  process.on('exit', (code) => {
    console.log(`About to exit with code: ${code}`);
    closeDatabases();
  });
  
  // You can also handle uncaught exceptions to ensure the database is closed
  process.on('uncaughtException', (err) => {
    console.error('Uncaught exception:', err);
    closeDatabases();
    process.exit(1);
  });

  // Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});