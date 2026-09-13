const { app, BrowserWindow, ipcMain } = require('electron');
const sqlite3 = require('sqlite3').verbose();
const fs = require('fs');
const path = require('path');

/**
 * SOKO - Main Process
 * Handles window management and database initialization.
 */

let mainWindow;

// Database configuration
const DB_PATH = path.join(app.getPath('userData'), 'soko.db');
const SCHEMA_PATH = path.join(__dirname, 'database', 'schema.sql');

function initDatabase() {
    return new Promise((resolve, reject) => {
        const db = new sqlite3.Database(DB_PATH, (err) => {
            if (err) {
                console.error('Error opening database:', err);
                return reject(err);
            }
            console.log(`Connected to SQLite database at: ${DB_PATH}`);
        });

        db.run('PRAGMA foreign_keys = ON;', (err) => {
            if (err) console.error('Error enabling foreign keys:', err);
        });

        fs.readFile(SCHEMA_PATH, 'utf8', (err, sql) => {
            if (err) {
                console.error(`Critical Error: Could not read schema file at ${SCHEMA_PATH}.`);
                return resolve();
            }

            db.exec(sql, (err) => {
                if (err) {
                    console.error('Error executing schema:', err);
                    reject(err);
                } else {
                    console.log('Database schema initialized successfully.');
                    resolve();
                }
            });
        });
    });
}

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1200,
        height: 800,
        backgroundColor: '#0a0a0a',
        frame: false, // Remove native window frame for VS Code style
        webPreferences: {
            nodeIntegration: true,
            contextIsolation: false,
        },
    });

    mainWindow.loadFile('index.html');
}

// Window Control Handlers
ipcMain.on('window-min', () => mainWindow.minimize());
ipcMain.on('window-max', () => {
    if (mainWindow.isMaximized()) {
        mainWindow.unmaximize();
    } else {
        mainWindow.maximize();
    }
});
ipcMain.on('window-close', () => mainWindow.close());

app.whenReady().then(async () => {
    try {
        await initDatabase();
        createWindow();
    } catch (error) {
        console.error('Failed to initialize application:', error);
    }

    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) createWindow();
    });
});

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit();
});
