-- 1. Tabel Master Club
CREATE TABLE club (
    id_klub SERIAL PRIMARY KEY,
    nama_klub VARCHAR(100) NOT NULL,
    kota VARCHAR(100),
    stadion VARCHAR(100),
    kapasitas_stadion INT
);

-- Insert Data Club 
INSERT INTO club (id_klub, nama_klub, kota, stadion, kapasitas_stadion) VALUES
(1, 'Arsenal F.C.', 'London', 'Emirates Stadium', 60704),
(2, 'Manchester City F.C.', 'Manchester', 'Etihad Stadium', 52900),
(3, 'Manchester United F.C.', 'Manchester', 'Old Trafford', 74244),
(4, 'Aston Villa F.C.', 'Birmingham', 'Villa Park', 43205),
(5, 'Liverpool F.C.', 'Liverpool', 'Anfield', 61276),
(6, 'Bournemouth F.C', 'Bournemouth', 'Vitality Stadium', 11307),
(7, 'Sunderland', 'Sunderland', 'Stadium of Light',  49000),
(8, 'Brighton & Hove Albion', 'Brighton & Hove', 'American Express Stadium', 31876),
(9, 'Brentford', 'London', 'Gtech Community Stadium', 17250),
(10, 'Chelsea', 'London', 'Stamford Bridge', 40341),
(11, 'Fulham', 'London', 'Craven Cottage', 25678),
(12, 'Newcastle United', 'Newcastle', 'St. James Park', 52338),
(13, 'Everton', 'Liverpool', 'Stadion Hill Dickinson', 52769),
(14, 'Leeds United', 'Leeds', 'Elland Road', 37645),
(15, 'Crystal Palace', 'London', 'Selhurst Park', 25486),
(16, 'Nottingham Forest', 'Nottingham', 'City Ground', 30445),
(17, 'Tottenham Hotspur', 'London', 'Tottenham Hotspur Stadium', 62850),
(18, 'West Ham United F.C.', 'London', 'London Stadium', 62500),
(19, 'Burnley F.C.', 'Burnley', 'Turf Moor', 21990),
(20, 'Wolverhampton Wanderers F.C.', 'Wolverhampton', 'Molineux Stadium', 31750);

-- 2. Tabel Master Pemain
CREATE TABLE player (
    id_pemain Serial PRIMARY KEY,
    nama_pemain VARCHAR(100) NOT NULL,
    id_klub INT,
    posisi VARCHAR(50),
    gol INT DEFAULT 0,
    assist INT DEFAULT 0,
    clean_sheet INT DEFAULT 0,
    FOREIGN KEY (id_klub) REFERENCES club(id_klub) ON DELETE SET NULL
);

-- Insert Data Pemain Bintang Musim Ini
INSERT INTO player (nama_pemain, id_klub, posisi, gol, assist, clean_sheet) VALUES
('Erling Haaland', 2, 'Forward', 27, 8, 0),
('Bruno Fernandes', 3, 'Midfielder', 9, 21, 0),
('David Raya', 1, 'Goalkeeper', 0, 0, 19),
('Igor Thiago', 4, 'Forward', 22, 1, 0),
('Declan Rice', 1, 'Midfielder', 5, 7, 0),
('Rayan Cherki', 2, 'Midfielder', 4, 12, 0);

-- 3. Tabel Statistik Klasemen Akhir Musim
CREATE TABLE klasemen_akhir (
    posisi INT PRIMARY KEY,
    id_klub INT,
    main INT DEFAULT 38,
    menang INT,
    seri INT,
    kalah INT,
    gol_masuk INT,
    gol_kemasukan INT,
    selisih_gol INT,
    poin INT,
    FOREIGN KEY (id_klub) REFERENCES club(id_klub)
);
-- INSERT Data Club Akhir Klasemen
INSERT INTO klasemen_akhir (posisi, id_klub, menang, seri, kalah, gol_masuk, gol_kemasukan, selisih_gol, poin) VALUES
(1, 1, 26, 7, 5, 71, 27, 44, 85),   -- Arsenal (Juara)
(2, 2, 23, 9, 6, 77, 35, 42, 78),   -- Man City
(3, 3, 20, 11, 7, 69, 50, 19, 71),  -- Man United
(4, 4, 19, 8, 11, 56, 49, 7, 65),   -- Aston Villa
(5, 5, 17, 9, 12, 63, 53, 10, 60),  -- Liverpool
(6, 6, 13, 18, 7, 58, 54, 4, 57),   -- Bournemouth
(7, 7, 14, 12, 12, 42, 48, -6, 54), -- Sunderland
(8, 8, 14, 11, 13, 52, 46, 6, 53),  -- Brighton
(9, 9, 14, 11, 13, 58, 52, 3, 53),	-- Brentford
(10, 10, 14, 10, 14, 58, 52, 6, 52), -- Chelsea
(11, 11, 15, 7, 16, 47, 51, -4, 52), --Fulham
(12, 12, 14, 7, 17, 53, 55, -2, 49), -- Newcastle
(13, 13, 13, 10, 15, 47, 50, -3, 49), -- Everton
(14, 14, 11, 14, 13, 49, 56, -7, 47), -- Leeds 
(15, 15, 11, 12, 15, 41, 51, -10, 45), -- Crystal Palace
(16, 16, 11, 11, 16, 48, 51, -3, 44), -- Nottingham
(17, 17, 10, 11, 17, 48, 57, -9, 41), -- Tottenham
(18, 18, 10, 9, 19, 46, 65, -19, 39),-- West Ham (Degradasi)
(19, 19, 4, 10, 24, 38, 75, -37, 22),-- Burnley (Degradasi)
(20, 20, 3, 11, 24, 27, 68, -41, 20); -- Wolves (Degradasi)

-- 4. JOIN Klasemen dengan Nama Club
SELECT 
    k.posisi, 
    nama_klub , 
    k.poin, 
    k.selisih_gol, 
    stadion 
FROM klasemen_akhir k
JOIN club  ON k.id_klub = club.id_klub 
ORDER BY k.posisi ASC;

-- 5. Analisis Produktivitas Pemain G/A
SELECT 
    p2.nama_pemain , 
    c.nama_klub , 
    p2.gol , 
    p2.assist , 
    (p2.gol  + p2.assist ) AS total_kontribusi_gol
FROM player p2
JOIN club c  ON p2.id_klub = c.id_klub
ORDER BY total_kontribusi_gol DESC;

-- 6. Case When Segmentasi Tim Berdasarkan Tiket Kompetisi Eropa
SELECT 
    k.posisi ,
    nama_klub,
    k.poin,
    CASE 
        WHEN k.posisi <= 4 THEN 'Lolos UEFA Champions League'
        WHEN k.posisi = 5 THEN 'Lolos UEFA Europa League'
        WHEN k.posisi >= 18 THEN 'Degradasi ke Championship'
        ELSE 'Aman di Mid-Table'
    END AS status_akhir_musim
FROM klasemen_akhir k
JOIN club c  ON k.id_klub = c.id_klub 
ORDER BY k.posisi ASC;
