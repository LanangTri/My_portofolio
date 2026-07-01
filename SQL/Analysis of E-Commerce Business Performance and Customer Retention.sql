-- 1. Membuat Tabel Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    join_date DATE
);

INSERT INTO Customers 
VALUES 
(1, 'Ahmad Fauzi', 'Jakarta', '2025-01-15'),
(2, 'Siti Aminah', 'Bandung', '2025-02-20'),
(3, 'Budi Santoso', 'Surabaya', '2025-03-10'),
(4, 'Dewi Lestari', 'Jakarta', '2025-05-12'),
(5, 'Rian Hidayat', 'Medan', '2025-06-01');

-- 2. Membuat Tabel Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO Products 
VALUES 
(101, 'Laptop Asus', 'Electronics', 12000000),
(102, 'Smartphone Samsung', 'Electronics', 5000000),
(103, 'Kemeja Pria', 'Fashion', 250000),
(104, 'Sepatu Running', 'Fashion', 750000),
(105, 'Blender Philips', 'Home Appliances', 600000);

-- 3. Membuat Tabel Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Orders 
VALUES 
(1001, 1, 101, '2025-01-20', 1, 12000000),
(1002, 2, 103, '2025-02-25', 2, 500000),
(1003, 1, 102, '2025-03-05', 1, 5000000),
(1004, 3, 104, '2025-03-15', 1, 750000),
(1005, 2, 105, '2025-04-10', 1, 600000),
(1006, 4, 102, '2025-05-20', 1, 5000000),
(1007, 1, 103, '2025-06-15', 3, 750000),
(1008, 5, 101, '2025-06-20', 1, 12000000);

-- 4. Menghitung Total Pendapatan Bulan

SELECT 
	to_char(order_date, 'yyyy-mm') as periode_bulan,
    COUNT(order_id) AS Total_Transaksi,
    SUM(total_amount) AS Total_Pendapatan
FROM Orders
GROUP BY Periode_Bulan
ORDER BY Periode_Bulan;

-- 5. Mencari Kategori Produk Apa Yang Paling Terbesar
SELECT 
    p.category AS Kategori_Produk,
    SUM(o.quantity) AS Total_Produk_Terjual,
    SUM(o.total_amount) AS Total_Pendapatan
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY Total_Pendapatan DESC;

-- 6. Mencari Siapa Pelanggan Dengan Pengeluaran Terbesar
SELECT 
    c.customer_name AS Nama_Pelanggan,
    c.city AS Kota,
    SUM(o.total_amount) AS Total_Belanja
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name, c.city
ORDER BY Total_Belanja DESC
LIMIT 3;

-- 
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS Frekuensi_Belanja
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY Frekuensi_Belanja DESC;