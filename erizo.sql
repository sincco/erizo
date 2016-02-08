-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 07-02-2016 a las 21:20:12
-- Versión del servidor: 5.5.47-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `erizo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacenes`
--

CREATE TABLE IF NOT EXISTS `almacenes` (
  `almacen` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(75) NOT NULL,
  `activo` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`almacen`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Catálogo de almacenes' AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE IF NOT EXISTS `categorias` (
  `categoria` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` int(11) NOT NULL,
  `categoriaPadre` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Catálogo de categorias' AUTO_INCREMENT=1 ;

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
  PRIMARY KEY (`cliente`),
  UNIQUE KEY `rfc` (`rfc`) COMMENT 'rfc'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Cabecera de clientes' AUTO_INCREMENT=5 ;

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
  `alias` varchar(150) NOT NULL,
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
  `descripcionCorta` varchar(75) NOT NULL,
  `estatus` enum('Solicitud','Cotizada','Autorizada','En Proceso','Recibida','Cancelada') NOT NULL,
  PRIMARY KEY (`compra`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Cabecera de compras' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprasProductos`
--

CREATE TABLE IF NOT EXISTS `comprasProductos` (
  `compraProducto` int(11) NOT NULL AUTO_INCREMENT,
  `compra` int(11) NOT NULL,
  `producto` int(11) NOT NULL DEFAULT '0',
  `cantidad` float NOT NULL,
  `precio` float NOT NULL,
  `subtotal` float NOT NULL,
  `impuesto` float NOT NULL,
  `autorizado` int(11) NOT NULL,
  `fechaRecepcion` date DEFAULT NULL,
  PRIMARY KEY (`compraProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de compras' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `existencias`
--

CREATE TABLE IF NOT EXISTS `existencias` (
  `almacen` int(11) NOT NULL,
  `producto` int(11) NOT NULL,
  `existencias` float NOT NULL,
  `costo` float NOT NULL,
  UNIQUE KEY `existencias` (`almacen`,`producto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Existencias de productos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuestos`
--

CREATE TABLE IF NOT EXISTS `impuestos` (
  `impuesto` int(11) NOT NULL,
  `porcentaje` float NOT NULL,
  `desde` date NOT NULL,
  `hasta` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuestosDefinicion`
--

CREATE TABLE IF NOT EXISTS `impuestosDefinicion` (
  `impuesto` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(25) NOT NULL,
  PRIMARY KEY (`impuesto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Definicion de impuestos' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `impuestosDefinicion`
--

INSERT INTO `impuestosDefinicion` (`impuesto`, `descripcion`) VALUES
(1, 'IVA'),
(2, 'IEPS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex`
--

CREATE TABLE IF NOT EXISTS `kardex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `producto` int(11) NOT NULL,
  `movimiento` enum('Entrada','Salida') NOT NULL,
  `almacen` int(11) NOT NULL,
  `cantidad` float NOT NULL,
  `precio` float NOT NULL,
  `costo` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `movimientos` (`fecha`,`almacen`,`movimiento`),
  UNIQUE KEY `productos` (`fecha`,`producto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tarjeta de movimientos' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE IF NOT EXISTS `productos` (
  `producto` int(11) NOT NULL AUTO_INCREMENT,
  `sku` char(20) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `descripcionCorta` varchar(25) NOT NULL,
  `tipo` enum('Simple','Compuesto') NOT NULL,
  `relacionados` varchar(250) NOT NULL,
  `controlExistencias` int(11) NOT NULL,
  `activo` int(11) NOT NULL,
  `categoria` int(11) NOT NULL,
  PRIMARY KEY (`producto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Catálogo de productos' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productosPrecios`
--

CREATE TABLE IF NOT EXISTS `productosPrecios` (
  `productoPrecio` int(11) NOT NULL AUTO_INCREMENT,
  `producto` int(11) NOT NULL,
  `precio` float NOT NULL,
  `fechaDesde` date NOT NULL,
  `fechaHasta` date NOT NULL,
  `impuestos` varchar(50) NOT NULL,
  PRIMARY KEY (`productoPrecio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE IF NOT EXISTS `proveedores` (
  `proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `rfc` char(13) NOT NULL,
  `razonSocial` varchar(150) NOT NULL,
  `direccionFiscal` varchar(150) NOT NULL,
  `activo` int(1) NOT NULL,
  PRIMARY KEY (`proveedor`),
  UNIQUE KEY `rfc` (`rfc`) COMMENT 'rfc'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Cabecera de proveedores' AUTO_INCREMENT=2 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Datos de contactos de proveedores' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `usuario` int(11) NOT NULL AUTO_INCREMENT,
  `clave` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `activo` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`usuario`),
  UNIQUE KEY `usuario_clave` (`clave`) COMMENT 'usuario_clave'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariosPerfiles`
--

CREATE TABLE IF NOT EXISTS `usuariosPerfiles` (
  `usuarioPerfil` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` int(11) NOT NULL,
  `perfil` int(11) NOT NULL,
  PRIMARY KEY (`usuarioPerfil`),
  UNIQUE KEY `usuariosPerfiles` (`usuario`,`perfil`) COMMENT 'usuariosPerfiles'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Usuarios de perfiles' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE IF NOT EXISTS `ventas` (
  `venta` int(11) NOT NULL AUTO_INCREMENT,
  `cliente` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estatus` enum('Cotizacion','En Proceso','Pago','Entregada','Cancelada','Sin Pago') NOT NULL,
  `vendedor` int(11) NOT NULL,
  PRIMARY KEY (`venta`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Cabecera de ventas' AUTO_INCREMENT=17 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasDocumentos`
--

CREATE TABLE IF NOT EXISTS `ventasDocumentos` (
  `ventaDocumento` int(11) NOT NULL AUTO_INCREMENT,
  `venta` int(11) NOT NULL,
  `tipo` enum('Factura','Remision','Nota de venta') NOT NULL,
  `identificador` varchar(32) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `monto` float NOT NULL,
  PRIMARY KEY (`ventaDocumento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Documentos relacionados con la venta' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasPagos`
--

CREATE TABLE IF NOT EXISTS `ventasPagos` (
  `ventaPago` int(11) NOT NULL AUTO_INCREMENT,
  `venta` int(11) NOT NULL,
  `tipo` enum('Efectivo','Tarjeta','Monedero','Crédito') NOT NULL,
  `monto` float NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`ventaPago`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Histórico de pagos de clientes' AUTO_INCREMENT=43 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasProductos`
--

CREATE TABLE IF NOT EXISTS `ventasProductos` (
  `ventaProducto` int(11) NOT NULL AUTO_INCREMENT,
  `venta` int(11) NOT NULL,
  `producto` int(11) NOT NULL,
  `cantidad` float NOT NULL,
  `precio` float NOT NULL,
  `iva` float NOT NULL,
  `ieps` float NOT NULL,
  `subtotal` float NOT NULL,
  PRIMARY KEY (`ventaProducto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Detalle de ventas' AUTO_INCREMENT=47 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
