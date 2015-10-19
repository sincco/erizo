-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 19-10-2015 a las 13:06:59
-- Versión del servidor: 5.5.44-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `userp`
--

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`cliente`, `rfc`, `razonSocial`, `direccionFiscal`, `activo`) VALUES
(0, 'AAAA010101AAA', 'Venta en mostrador', '', 1);

--
-- Volcado de datos para la tabla `impuestos`
--

INSERT INTO `impuestos` (`ivaPorcentaje`, `desde`, `hasta`, `iepsPorcentaje`) VALUES
(16, '2000-01-01', NULL, 10);

--
-- Volcado de datos para la tabla `lineasProductos`
--

INSERT INTO `lineasProductos` (`lineaProducto`, `descripcion`, `activo`) VALUES
(3, 'Genericos', 1);

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`producto`, `clave`, `lineaProducto`, `descripcion`, `descripcionCorta`, `precio`, `unidadMedida`, `iva`, `ieps`, `activo`) VALUES
(9, 'abc123', 3, 'Producto 1', 'Prod 1', 150, 'PZA', 1, 0, 1);

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuario`, `clave`, `password`, `activo`) VALUES
(1, 'ivanmiranda', 'gSpVQYAUBLJoQD3Scjz4fb5+OtDvlNm1PyZ91m7AY9M=', 1);

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`venta`, `cliente`, `fecha`, `estatus`) VALUES
(1, 0, '2015-10-19', 'En Proceso'),
(2, 0, '2015-10-19', 'En Proceso'),
(3, 0, '2015-10-19', 'En Proceso'),
(4, 0, '2015-10-19', 'En Proceso'),
(5, 0, '2015-10-19', 'En Proceso');

--
-- Volcado de datos para la tabla `ventasProductos`
--

INSERT INTO `ventasProductos` (`venta`, `producto`, `cantidad`, `precio`, `iva`, `ieps`, `subtotal`) VALUES
(2, 0, 10, 150, 240, 0, 1740),
(2, 0, 0, 0, 0, 0, 0),
(0, 0, 10, 150, 240, 0, 1740),
(0, 0, 0, 0, 0, 0, 0),
(3, 0, 10, 150, 240, 0, 1740),
(4, 0, 5, 150, 120, 0, 870),
(5, 9, 10, 150, 240, 0, 1740);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
