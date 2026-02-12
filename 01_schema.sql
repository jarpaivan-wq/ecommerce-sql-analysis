-- =====================================================
-- Script: 01_schema.sql
-- Description: Database and table creation
-- Project: E-commerce SQL Analysis
-- =====================================================

-- Create database
CREATE DATABASE IF NOT EXISTS ecommerce_ropa;
USE ecommerce_ropa;

-- =====================================================
-- Table: clientes (customers)
-- Description: Stores registered customer information
-- =====================================================
CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL,
    ciudad VARCHAR(50)
);

-- =====================================================
-- Table: productos (products)
-- Description: Product catalog
-- =====================================================
CREATE TABLE productos (
    producto_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(150) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock_actual INT NOT NULL
);

-- =====================================================
-- Table: ventas (sales)
-- Description: Sales transaction records
-- =====================================================
CREATE TABLE ventas (
    venta_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    fecha_venta DATETIME NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

-- =====================================================
-- Table: detalle_ventas (sale_details)
-- Description: Individual items in each sale
-- =====================================================
CREATE TABLE detalle_ventas (
    detalle_id INT PRIMARY KEY AUTO_INCREMENT,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (venta_id) REFERENCES ventas(venta_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

-- =====================================================
-- Indexes for query optimization
-- =====================================================
CREATE INDEX idx_ventas_cliente ON ventas(cliente_id);
CREATE INDEX idx_ventas_fecha ON ventas(fecha_venta);
CREATE INDEX idx_detalle_venta ON detalle_ventas(venta_id);
CREATE INDEX idx_detalle_producto ON detalle_ventas(producto_id);

-- Verify created tables
SHOW TABLES;
