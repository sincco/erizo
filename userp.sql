-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 10-11-2015 a las 00:57:08
-- Versión del servidor: 5.5.46-0ubuntu0.14.04.2
-- Versión de PHP: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `userp`
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
-- Estructura de tabla para la tabla `almacenesProductos`
--

CREATE TABLE IF NOT EXISTS `almacenesProductos` (
  `almacenProducto` int(11) NOT NULL AUTO_INCREMENT,
  `almacen` int(11) NOT NULL,
  `producto` int(11) NOT NULL,
  `existencias` int(11) NOT NULL,
  `costo` int(11) NOT NULL,
  PRIMARY KEY (`almacenProducto`),
  UNIQUE KEY `almacenProducto` (`almacen`,`producto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Existencias en almacenes' AUTO_INCREMENT=21 ;

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
-- Estructura de tabla para la tabla `gastos`
--

CREATE TABLE IF NOT EXISTS `gastos` (
  `gasto` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(75) NOT NULL,
  PRIMARY KEY (`gasto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='catalogo de gastos' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gastosRuta`
--

CREATE TABLE IF NOT EXISTS `gastosRuta` (
  `gastoRuta` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `vendedor` int(11) NOT NULL,
  PRIMARY KEY (`gastoRuta`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='gastos de venta por día' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gastosRutasDetalle`
--

CREATE TABLE IF NOT EXISTS `gastosRutasDetalle` (
  `gastoRutaDetalle` int(11) NOT NULL AUTO_INCREMENT,
  `gastoRuta` int(11) NOT NULL,
  `gasto` int(11) NOT NULL,
  `monto` float NOT NULL,
  PRIMARY KEY (`gastoRutaDetalle`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='detalle de gastos por ruta' AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuestos`
--

CREATE TABLE IF NOT EXISTS `impuestos` (
  `ivaPorcentaje` int(11) NOT NULL,
  `desde` date NOT NULL,
  `hasta` date DEFAULT NULL,
  `iepsPorcentaje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Control de impuestos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex`
--

CREATE TABLE IF NOT EXISTS `kardex` (
  `kardex` int(11) NOT NULL AUTO_INCREMENT,
  `producto` int(11) NOT NULL,
  `fechaHora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `movimiento` enum('Entrada','Salida') NOT NULL,
  `tabla` enum('compras','ordenesProduccion','ventas','transferencias') NOT NULL,
  `idTabla` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` float NOT NULL DEFAULT '1',
  `costo` float NOT NULL DEFAULT '1',
  PRIMARY KEY (`kardex`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Kardex de inventario' AUTO_INCREMENT=55 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lineasProductos`
--

CREATE TABLE IF NOT EXISTS `lineasProductos` (
  `lineaProducto` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(75) NOT NULL,
  `activo` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`lineaProducto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logOperaciones`
--

CREATE TABLE IF NOT EXISTS `logOperaciones` (
  `logOperacion` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` int(11) NOT NULL,
  `fechaHora` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `accion` enum('Creacion','Lectura','Actualización','Baja') NOT NULL,
  `tabla` varchar(15) NOT NULL,
  `campo` varchar(15) NOT NULL,
  `id` varchar(15) NOT NULL,
  PRIMARY KEY (`logOperacion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Log de operaciones en el sistema (CRUD)' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfiles`
--

CREATE TABLE IF NOT EXISTS `perfiles` (
  `perfil` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(75) NOT NULL,
  `permisos` varchar(250) NOT NULL,
  `activo` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Perfiles de acceso al sistema' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planVentas`
--

CREATE TABLE IF NOT EXISTS `planVentas` (
  `planVenta` int(11) NOT NULL AUTO_INCREMENT,
  `desde` date NOT NULL,
  `hasta` date NOT NULL,
  `monto` float NOT NULL,
  PRIMARY KEY (`planVenta`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Plan de ventas por periodo' AUTO_INCREMENT=3 ;

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
  `unidadMedida` char(3) NOT NULL DEFAULT 'NA',
  `iva` int(11) NOT NULL DEFAULT '1',
  `costo` float NOT NULL DEFAULT '0',
  `activo` int(1) NOT NULL,
  PRIMARY KEY (`producto`),
  UNIQUE KEY `clave` (`clave`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Cabecera de productos' AUTO_INCREMENT=19 ;

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
-- Estructura de tabla para la tabla `transferencias`
--

CREATE TABLE IF NOT EXISTS `transferencias` (
  `transferencia` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `almacenOrigen` int(11) NOT NULL,
  `almacenDestino` int(11) NOT NULL,
  `motivo` varchar(150) NOT NULL,
  PRIMARY KEY (`transferencia`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Cabecera de transferencia entre almacenes' AUTO_INCREMENT=3 ;

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
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE IF NOT EXISTS `vendedores` (
  `vendedor` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` int(11) NOT NULL,
  `almacen` int(11) NOT NULL,
  PRIMARY KEY (`vendedor`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Catálogo de vendedores y relación con almacenes (Tiendas, Puntos de Venta)' AUTO_INCREMENT=3 ;

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
