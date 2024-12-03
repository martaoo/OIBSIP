const express = require("express");
const bodyParser = require("body-parser");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const app = express();
const PORT = 3000;

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));

// Dummy User Database
const users = [];

// Secret Key for JWT
const SECRET_KEY = "mysecretkey";

// Routes

// Register User
app.post("/register", async (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ message: "Username and password are required." });
    }

    // Check if user already exists
    const userExists = users.find(user => user.username === username);
    if (userExists) {
        return res.status(400).json({ message: "User already exists." });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Save user
    users.push({ username, password: hashedPassword });
    res.status(201).json({ message: "User registered successfully!" });
});

// Login User
app.post("/login", async (req, res) => {
    const { username, password } = req.body;

    // Find user
    const user = users.find(user => user.username === username);
    if (!user) {
        return res.status(400).json({ message: "Invalid credentials." });
    }

    // Verify password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
        return res.status(400).json({ message: "Invalid credentials." });
    }

    // Generate JWT
    const token = jwt.sign({ username: user.username }, SECRET_KEY, { expiresIn: "1h" });
    res.status(200).json({ message: "Login successful!", token });
});

// Secured Page
app.get("/secured", (req, res) => {
    const token = req.headers["authorization"];

    if (!token) {
        return res.status(401).json({ message: "Access denied. No token provided." });
    }

    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        res.status(200).json({ message: `Welcome, ${decoded.username}!` });
    } catch (error) {
        res.status(401).json({ message: "Invalid token." });
    }
});

// Start Server
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
