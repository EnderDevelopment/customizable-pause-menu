CREATE TABLE IF NOT EXISTS player_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(60) NOT NULL,
    menu_settings JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (identifier)
);

INSERT INTO player_data (identifier, menu_settings) VALUES ('default', '{"backgroundColor": {"r": 0, "g": 0, "b": 0, "a": 200}, "textColor": {"r": 255, "g": 255, "b": 255, "a": 255}, "buttonColor": {"r": 50, "g": 50, "b": 50, "a": 200}, "buttonHoverColor": {"r": 100, "g": 100, "b": 100, "a": 200}}');