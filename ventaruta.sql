-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 05-10-2015 a las 23:49:33
-- Versión del servidor: 5.5.44-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `ventaruta`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE IF NOT EXISTS `clientes` (
  `cliente` int(11) NOT NULL AUTO_INCREMENT,
  `rfc` char(13) NOT NULL,
  `razonSocial` varchar(150) NOT NULL,
  `direccionFiscal` varchar(255) NOT NULL,
  `activo` int(1) NOT NULL,
  PRIMARY KEY (`cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Cabecera de clientes' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientesContactos`
--

CREATE TABLE IF NOT EXISTS `clientesContactos` (
  `clienteContacto` int(11) NOT NULL AUTO_INCREMENT,
  `cliente` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `correo` varchar(150) NOT NULL,
  PRIMARY KEY (`clienteContacto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contactos del cliente' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientesDirecciones`
--

CREATE TABLE IF NOT EXISTS `clientesDirecciones` (
  `clienteDireccion` int(11) NOT NULL AUTO_INCREMENT,
  `cliente` int(11) NOT NULL,
  `domicilio` varchar(150) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  PRIMARY KEY (`clienteDireccion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Direcciones de clientes' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE IF NOT EXISTS `compras` (
  `compra` int(11) NOT NULL AUTO_INCREMENT,
  `proveedor` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `estatus` enum('Pendiente','Autorizada','En Proceso','Recibida','Cancelada') NOT NULL,
  PRIMARY KEY (`compra`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Cabecera de compras' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprasProductos`
--

CREATE TABLE IF NOT EXISTS `comprasProductos` (
  `compra` int(11) NOT NULL,
  `producto` int(11) NOT NULL,
  `cantidad` float NOT NULL,
  `precio` float NOT NULL,
  `subtotal` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de compras';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex`
--

CREATE TABLE IF NOT EXISTS `kardex` (
  `kardex` int(11) NOT NULL AUTO_INCREMENT,
  `producto` int(11) NOT NULL,
  `fechaHora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `movimiento` enum('Entrada','Salida') NOT NULL,
  `tabla` enum('compras','ordenesProduccion','ventas') NOT NULL,
  `idTabla` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` float NOT NULL,
  PRIMARY KEY (`kardex`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Kardex de inventario' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lineasProductos`
--

CREATE TABLE IF NOT EXISTS `lineasProductos` (
  `lineaProducto` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(75) NOT NULL,
  PRIMARY KEY (`lineaProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE IF NOT EXISTS `productos` (
  `producto` int(11) NOT NULL AUTO_INCREMENT,
  `clave` char(10) NOT NULL,
  `lineaProducto` int(11) NOT NULL DEFAULT '0',
  `descripcion` varchar(150) NOT NULL,
  `descripcionCorta` varchar(50) NOT NULL,
  `precio` float NOT NULL,
  `activo` int(1) NOT NULL,
  PRIMARY KEY (`producto`),
  UNIQUE KEY `clave` (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Cabecera de productos' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE IF NOT EXISTS `proveedores` (
  `proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `rfc` char(13) NOT NULL,
  `razonSocial` varchar(150) NOT NULL,
  `direccionFiscal` varchar(150) NOT NULL,
  `a1ctivo` int(1) NOT NULL,
  PRIMARY KEY (`proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Cabecera de proveedores' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedoresContactos`
--

CREATE TABLE IF NOT EXISTS `proveedoresContactos` (
  `proveedorContacto` int(11) NOT NULL AUTO_INCREMENT,
  `proveedor` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `telefono` varchar(150) NOT NULL,
  PRIMARY KEY (`proveedorContacto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Datos de contactos de proveedores' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE IF NOT EXISTS `ventas` (
  `venta` int(11) NOT NULL AUTO_INCREMENT,
  `cliente` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `estatus` enum('Nueva','En Proceso','Pago','Enviada','Cancelada','Sin Pago') NOT NULL,
  PRIMARY KEY (`venta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Cabecera de ventas' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasProductos`
--

CREATE TABLE IF NOT EXISTS `ventasProductos` (
  `venta` int(11) NOT NULL,
  `producto` int(11) NOT NULL,
  `cantidad` float NOT NULL,
  `precio` float NOT NULL,
  `impuesto` float NOT NULL,
  `subtotal` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de ventas';

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
