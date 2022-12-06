-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 19, 2022 at 06:52 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soluw`
--

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int(11) NOT NULL,
  `nombreCategoria` varchar(100) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Table structure for table `especializacion`
--

CREATE TABLE `especializacion` (
  `idEspecializacion` int(11) NOT NULL,
  `nombreEspecializacion` varchar(150) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Dumping data for table `especializacion`
--

INSERT INTO `especializacion` (`idEspecializacion`, `nombreEspecializacion`) VALUES
(1, 'Electricidad'),
(2, 'Pintura'),
(3, 'Jardineria'),
(4, 'Plomeria');

-- --------------------------------------------------------

--
-- Table structure for table `orden`
--

CREATE TABLE `orden` (
  `idOrden` int(11) NOT NULL,
  `idServicoTecnico` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `nombreServicio` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
  `precioServicio` float NOT NULL,
  `nombreTecnico` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `corregimiento` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `barriada` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `casa` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fechaAccion` datetime DEFAULT NULL,
  `estadoOrden` varchar(30) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Dumping data for table `orden`
--

INSERT INTO `orden` (`idOrden`, `idServicoTecnico`, `idUsuario`, `nombreServicio`, `precioServicio`, `nombreTecnico`, `corregimiento`, `barriada`, `casa`, `fechaAccion`, `estadoOrden`) VALUES
(7, 10, 10, 'Servicios de Pintura x Mt2', 3.5, 'Josafat Pinzon', 'San Francisco', 'San Sebastian', '49-B', '2022-07-19 10:42:00', 'En Proceso'),
(8, 6, 10, 'Falla Electrica', 30.7, 'Christian Lol', 'San Francisco', 'San Sebastian', '49-B', '2022-07-19 07:50:00', 'En Proceso'),
(9, 8, 10, 'Reparacion de Lavamanos', 15, 'Edgar De Gracia', 'San Francisco', 'San Sebastian', '49-B', '2022-07-20 23:18:00', 'En Proceso'),
(10, 6, 10, 'Falla Electrica', 30.7, 'Christian Lol', 'San Francisco', 'San Sebastian', '49-B', '2022-07-20 23:18:00', 'En Proceso'),
(11, 4, 10, 'Falla Electrica', 30.7, 'Alex Uwu', 'San Francisco', 'San Sebastian', '49-B', '2022-07-20 14:20:00', 'En Proceso');

-- --------------------------------------------------------

--
-- Table structure for table `servicio`
--

CREATE TABLE `servicio` (
  `idServicio` int(11) NOT NULL,
  `nombreServicio` varchar(200) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `precioServicio` float NOT NULL DEFAULT 0,
  `descripcion` varchar(500) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `idEspecializacion` int(11) NOT NULL,
  `esPromocion` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Dumping data for table `servicio`
--

INSERT INTO `servicio` (`idServicio`, `nombreServicio`, `precioServicio`, `descripcion`, `idEspecializacion`, `esPromocion`) VALUES
(1, 'Reparacion de AC', 45.5, 'Reparacion de un AC', 1, 0),
(2, 'Falla Electrica', 30.7, 'Reparacion de un fallo general', 1, 0),
(3, 'Podar Cesped x Mt2', 5, 'Se poda cesped por mt2', 3, 1),
(4, 'Reparacion de Inodoro', 50, 'Reparacion completa de inodoros', 4, 0),
(5, 'Reparacion de Lavamanos', 15, 'Reparacion completa de lavamanos', 4, 1),
(6, 'Servicios de Pintura x Mt2', 3.5, 'Pintura y acabados por mt2', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `servicio_tecnico`
--

CREATE TABLE `servicio_tecnico` (
  `idServicoTecnico` int(11) NOT NULL,
  `idServicio` int(11) NOT NULL,
  `idTecnico` int(11) NOT NULL,
  `imagen` varchar(500) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Dumping data for table `servicio_tecnico`
--

INSERT INTO `servicio_tecnico` (`idServicoTecnico`, `idServicio`, `idTecnico`, `imagen`) VALUES
(1, 1, 1, 'aire.jpg'),
(2, 2, 1, 'pexels-photo-7861963.webp'),
(3, 1, 5, 'refrigerar.jpg'),
(4, 2, 5, 'tool-desk.JPG'),
(5, 1, 6, 'reparacion-aire-acondicionado.jpg'),
(6, 2, 6, 'tecnico2.jpg'),
(7, 4, 2, 'indoro.jpg'),
(8, 5, 2, 'plomeria.jpeg'),
(9, 3, 3, 'cortacesped.jpg'),
(10, 6, 4, 'pintor.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tecnico`
--

CREATE TABLE `tecnico` (
  `idTecnico` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `descripcion` varchar(1000) COLLATE utf8_spanish2_ci NOT NULL,
  `foto` varchar(500) COLLATE utf8_spanish2_ci NOT NULL,
  `valoracion` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Dumping data for table `tecnico`
--

INSERT INTO `tecnico` (`idTecnico`, `idUsuario`, `descripcion`, `foto`, `valoracion`) VALUES
(1, 1, 'Especialista en electricidad', 'perfiltecnico.jpg', 5),
(2, 2, 'Especialista en plomeria', 'person_1.jpg', 3.9),
(3, 3, 'Especialista en jardineria', 'person_2.jpg', 4.2),
(4, 4, 'Especialista en Pintura', 'person_3.jpg', 4.6),
(5, 5, 'Especialista en Electricidad', 'tecnico1.jpg', 3.7),
(6, 6, 'Especialista en Electricidad', 'tecnico3.jpg', 4.2);

-- --------------------------------------------------------

--
-- Table structure for table `tecnico_especializacion`
--

CREATE TABLE `tecnico_especializacion` (
  `idTecnicoEspe` int(11) NOT NULL,
  `idTecnico` int(11) NOT NULL,
  `idEspecializacion` int(11) NOT NULL,
  `nombreEspecializacion` varchar(500) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Dumping data for table `tecnico_especializacion`
--

INSERT INTO `tecnico_especializacion` (`idTecnicoEspe`, `idTecnico`, `idEspecializacion`, `nombreEspecializacion`) VALUES
(1, 1, 1, 'Electricidad'),
(2, 2, 4, 'Plomeria'),
(3, 3, 3, 'Jardineria'),
(4, 4, 2, 'Pintura'),
(5, 5, 1, 'Electricidad'),
(6, 6, 1, 'Electricidad');

-- --------------------------------------------------------

--
-- Table structure for table `telefono_tecnico`
--

CREATE TABLE `telefono_tecnico` (
  `idTelefono` int(11) NOT NULL,
  `idTecnico` int(11) NOT NULL,
  `numTelefono` varchar(20) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Dumping data for table `telefono_tecnico`
--

INSERT INTO `telefono_tecnico` (`idTelefono`, `idTecnico`, `numTelefono`) VALUES
(1, 1, '6666-8888'),
(2, 2, '6666-2222'),
(3, 3, '6666-1111'),
(4, 4, '6666-4444'),
(5, 5, '6666-0000'),
(6, 6, '6666-9999');

-- --------------------------------------------------------

--
-- Table structure for table `tipousuario`
--

CREATE TABLE `tipousuario` (
  `idTipoUser` int(11) NOT NULL,
  `tipoUser` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Dumping data for table `tipousuario`
--

INSERT INTO `tipousuario` (`idTipoUser`, `tipoUser`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `idTipoUser` int(11) NOT NULL,
  `nombre` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `apellido` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `email` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `direccion` varchar(500) COLLATE utf8_spanish2_ci NOT NULL,
  `edad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `idTipoUser`, `nombre`, `apellido`, `email`, `password`, `direccion`, `edad`) VALUES
(1, 1, 'Jesus', 'Osorio', 'jaguar45@gmail.com', '123456', 'Campus Levi Sasso', 22),
(2, 1, 'Edgar', 'De Gracia', 'panda88@gmail.com', '123456', 'Campus Levi Sasso', 22),
(3, 1, 'Leonardo', 'Kobayashi', 'pandarojo66@gmail.com', '123456', 'Don Bosco', 22),
(4, 1, 'Josafat', 'Pinzon', 'capibara00@gmail.com', '123456', 'Domo Universidad de Panama', 25),
(5, 1, 'Alex', 'Uwu', 'hatsune09@gmail.com', '123456', 'Colon Barrio Colon', 26),
(6, 1, 'Christian', 'Lol', 'jyxn56@gmail.com', '123456', 'Don Bosco', 21),
(7, 2, 'Edwin', 'Diaz', 'edwin.diaz5@utp.ac.pa', '123456', 'San Sebastian', 21),
(10, 2, 'Samantha', 'Miranda', 'smiranda@mail.com', '$2a$08$YpThgHLDpDnDmcahp4Xqk.NJSTRx6I560q/N3L/N1bO966ia.SUbC', 'Las Garzas de Pacora', 21);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indexes for table `especializacion`
--
ALTER TABLE `especializacion`
  ADD PRIMARY KEY (`idEspecializacion`);

--
-- Indexes for table `orden`
--
ALTER TABLE `orden`
  ADD PRIMARY KEY (`idOrden`),
  ADD KEY `idServicoTecnico` (`idServicoTecnico`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indexes for table `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`idServicio`),
  ADD KEY `idEspecializacion` (`idEspecializacion`);

--
-- Indexes for table `servicio_tecnico`
--
ALTER TABLE `servicio_tecnico`
  ADD PRIMARY KEY (`idServicoTecnico`),
  ADD KEY `idServicio` (`idServicio`),
  ADD KEY `idTecnico` (`idTecnico`);

--
-- Indexes for table `tecnico`
--
ALTER TABLE `tecnico`
  ADD PRIMARY KEY (`idTecnico`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indexes for table `tecnico_especializacion`
--
ALTER TABLE `tecnico_especializacion`
  ADD PRIMARY KEY (`idTecnicoEspe`),
  ADD KEY `idTecnico` (`idTecnico`),
  ADD KEY `idEspecializacion` (`idEspecializacion`);

--
-- Indexes for table `telefono_tecnico`
--
ALTER TABLE `telefono_tecnico`
  ADD PRIMARY KEY (`idTelefono`),
  ADD KEY `idTecnico` (`idTecnico`);

--
-- Indexes for table `tipousuario`
--
ALTER TABLE `tipousuario`
  ADD PRIMARY KEY (`idTipoUser`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `idTipoUser` (`idTipoUser`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `especializacion`
--
ALTER TABLE `especializacion`
  MODIFY `idEspecializacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orden`
--
ALTER TABLE `orden`
  MODIFY `idOrden` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `servicio`
--
ALTER TABLE `servicio`
  MODIFY `idServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `servicio_tecnico`
--
ALTER TABLE `servicio_tecnico`
  MODIFY `idServicoTecnico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tecnico`
--
ALTER TABLE `tecnico`
  MODIFY `idTecnico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tecnico_especializacion`
--
ALTER TABLE `tecnico_especializacion`
  MODIFY `idTecnicoEspe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `telefono_tecnico`
--
ALTER TABLE `telefono_tecnico`
  MODIFY `idTelefono` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tipousuario`
--
ALTER TABLE `tipousuario`
  MODIFY `idTipoUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orden`
--
ALTER TABLE `orden`
  ADD CONSTRAINT `orden_ibfk_1` FOREIGN KEY (`idServicoTecnico`) REFERENCES `servicio_tecnico` (`idServicoTecnico`),
  ADD CONSTRAINT `orden_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`);

--
-- Constraints for table `servicio`
--
ALTER TABLE `servicio`
  ADD CONSTRAINT `servicio_ibfk_1` FOREIGN KEY (`idEspecializacion`) REFERENCES `especializacion` (`idEspecializacion`);

--
-- Constraints for table `servicio_tecnico`
--
ALTER TABLE `servicio_tecnico`
  ADD CONSTRAINT `servicio_tecnico_ibfk_1` FOREIGN KEY (`idServicio`) REFERENCES `servicio` (`idServicio`),
  ADD CONSTRAINT `servicio_tecnico_ibfk_2` FOREIGN KEY (`idTecnico`) REFERENCES `tecnico` (`idTecnico`);

--
-- Constraints for table `tecnico`
--
ALTER TABLE `tecnico`
  ADD CONSTRAINT `tecnico_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`);

--
-- Constraints for table `tecnico_especializacion`
--
ALTER TABLE `tecnico_especializacion`
  ADD CONSTRAINT `tecnico_especializacion_ibfk_1` FOREIGN KEY (`idTecnico`) REFERENCES `tecnico` (`idTecnico`),
  ADD CONSTRAINT `tecnico_especializacion_ibfk_2` FOREIGN KEY (`idEspecializacion`) REFERENCES `especializacion` (`idEspecializacion`);

--
-- Constraints for table `telefono_tecnico`
--
ALTER TABLE `telefono_tecnico`
  ADD CONSTRAINT `telefono_tecnico_ibfk_1` FOREIGN KEY (`idTecnico`) REFERENCES `tecnico` (`idTecnico`);

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`idTipoUser`) REFERENCES `tipousuario` (`idTipoUser`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
