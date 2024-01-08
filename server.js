require('dotenv').config();

const express = require('express');
const cookieParser = require('cookie-parser');
const jwt = require('jsonwebtoken');
const mysql = require('mysql2');
const path = require('path');
const app = express();
const port = 5000;

app.use(cookieParser()); // Use cookie-parser middleware to handle cookies

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: 'URGAYS',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Function to execute MySQL queries
function query(sql, values) {
    return new Promise((resolve, reject) => {
        pool.query(sql, values, (err, results) => {
            if (err) {
                reject(err);
            } else {
                resolve(results);
            }
        });
    });
}

// Function to generate JWT token
function generateToken(payload) {
    const options = {
        expiresIn: '1h',
    };

    const secretKey = process.env.JWT_SECRET_KEY;

    const token = jwt.sign(payload, secretKey, options);
    return token;
}

// Middleware function for token verification
function verifyToken(req, res, next) {
    // Read the token from the cookie
    const token = req.cookies.token;

    // Verify the token
    jwt.verify(token, process.env.JWT_SECRET_KEY, (err, decoded) => {
        if (err) {
            console.error('Error verifying token:', err);
            // Handle token verification error, e.g., redirect to login
            res.redirect('/login');
        } else {
            // Token is valid, you can use the decoded information
            console.log('Decoded token:', decoded);
            // Attach the decoded user information to the request object
            req.user = decoded;
            next(); // Continue to the next middleware or route handler
        }
    });
};

// Route for serving login page
app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'views/login.html'));
});

// Route for handling authorization
app.get('/authorize', async (req, res) => {
    const username = req.query.username;
    const password = req.query.password;

    try {
        // Check if user credentials are valid
        const results = await query('SELECT * FROM Gamer WHERE Username = ? AND Password = ?', [username, password]);

        if (results.length <= 0) {
            res.redirect('/login');
            return;
        }

        const gamer = results[0];

        const payload = {
            id: gamer.id,
            username: gamer.username,
            role: 'gamer'
        };

        // Generate a JWT token
        const token = generateToken(payload);

        // Update the user's token in the database
        await query('UPDATE Gamer SET Token = ? WHERE ID = ?', [token, gamer.id]);

        // Set the token as an HTTP-only cookie
        res.cookie('token', token, { httpOnly: true });

        // Redirect to the home page
        res.redirect('/home');
    }
    catch (error) {
        console.error('Error during login:', error);
        res.status(500).send('Internal Server Error');
    }
});

// Apply the middleware to routes that require authorization
app.get('/home', verifyToken, (req, res) => {
    res.sendFile(path.join(__dirname, 'views/home.html'));
});

// Route to fetch genres from the database
app.get('/genres', verifyToken, async (req, res) => {
    try {
        // Fetch genres from the 'Genre' table
        const genres = await query('SELECT * FROM Genre');

        // Send the genres as JSON
        res.json({ genres });
    } catch (error) {
        console.error('Error fetching genres:', error);
        res.status(500).send('Internal Server Error');
    }
});

app.get('/home.js', (req, res) => {
    res.sendFile(path.join(__dirname, 'views/home.js'));
});

// Route for serving the CSS file
app.get('/style.css', (req, res) => {
    res.sendFile(path.join(__dirname, 'views/style.css'));
});

// Default route redirects to the login page
app.get('/', (req, res) => {
    res.redirect('/home');
});

// The 404 route also requires token verification
app.get('*', verifyToken, (req, res) => {
    res.status(404).sendFile(path.join(__dirname, 'views/404.html'));
});

// Start the server
app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});
