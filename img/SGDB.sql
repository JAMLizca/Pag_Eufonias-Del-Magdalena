-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 04-05-2026 a las 23:04:21
-- Versión del servidor: 8.0.45-0ubuntu0.24.04.1
-- Versión de PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `SGDB`
--
CREATE DATABASE IF NOT EXISTS `SGDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `SGDB`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alimentacion`
--
-- Creación: 16-03-2026 a las 19:50:11
--

CREATE TABLE `alimentacion` (
  `id` bigint UNSIGNED NOT NULL,
  `finca_id` bigint UNSIGNED NOT NULL,
  `lote_id` bigint UNSIGNED NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `tipo_alimento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad_kg` decimal(8,2) NOT NULL,
  `fecha` date NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bovinos`
--
-- Creación: 16-03-2026 a las 19:50:10
--

CREATE TABLE `bovinos` (
  `id` bigint UNSIGNED NOT NULL,
  `finca_id` bigint UNSIGNED NOT NULL,
  `raza_id` bigint UNSIGNED NOT NULL,
  `lote_id` bigint UNSIGNED DEFAULT NULL,
  `arete` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sexo` enum('Macho','Hembra') COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` enum('Toro','Vaca','Ternero','Ternera','Novillo','Novilla','Becerro') COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `peso_inicial` decimal(8,2) DEFAULT NULL,
  `estado_salud` enum('Saludable','En observación','En tratamiento') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Saludable',
  `proposito` enum('Carne','Leche','Doble propósito','Cría') COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `bovinos`
--

INSERT INTO `bovinos` (`id`, `finca_id`, `raza_id`, `lote_id`, `arete`, `nombre`, `sexo`, `categoria`, `fecha_nacimiento`, `peso_inicial`, `estado_salud`, `proposito`, `activo`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 'BOV-001', 'Luna', 'Hembra', 'Vaca', '2021-03-15', 420.00, 'En observación', 'Leche', 0, '2026-03-17 06:02:09', '2026-04-14 01:29:28'),
(2, 1, 1, NULL, 'BOV-002', 'Luna', 'Hembra', 'Vaca', '2021-03-15', 380.00, 'Saludable', 'Leche', 1, '2026-03-23 19:53:31', '2026-05-03 23:54:45'),
(3, 1, 1, NULL, 'BOV-003', 'Sol', 'Hembra', 'Ternero', '2026-04-11', 100.00, 'Saludable', 'Doble propósito', 0, '2026-04-28 05:51:52', '2026-04-28 05:52:09'),
(4, 1, 1, NULL, 'BOV-005', 'Sol', 'Hembra', 'Vaca', '2026-05-31', 550.00, 'En observación', 'Leche', 1, '2026-05-05 00:37:17', '2026-05-05 00:37:17'),
(5, 1, 1, NULL, 'BOV-004', 'Marcos', 'Macho', 'Toro', '2026-05-03', 750.00, 'En tratamiento', 'Cría', 1, '2026-05-05 00:40:41', '2026-05-05 00:40:41'),
(6, 1, 6, NULL, 'BOV-006', 'Casimiro', 'Macho', 'Toro', '2026-05-04', 320.00, 'En observación', 'Doble propósito', 1, '2026-05-05 03:54:34', '2026-05-05 03:54:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos_sanitarios`
--
-- Creación: 16-03-2026 a las 19:50:11
--

CREATE TABLE `eventos_sanitarios` (
  `id` bigint UNSIGNED NOT NULL,
  `finca_id` bigint UNSIGNED NOT NULL,
  `bovino_id` bigint UNSIGNED NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `tipo` enum('Vacunación','Desparasitación','Tratamiento','Revisión') COLLATE utf8mb4_unicode_ci NOT NULL,
  `producto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dosis` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha` date NOT NULL,
  `proxima_fecha` date DEFAULT NULL,
  `estado` enum('Programado','Ejecutado','Cancelado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Programado',
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `eventos_sanitarios`
--

INSERT INTO `eventos_sanitarios` (`id`, `finca_id`, `bovino_id`, `usuario_id`, `tipo`, `producto`, `dosis`, `fecha`, `proxima_fecha`, `estado`, `observaciones`, `created_at`, `updated_at`) VALUES
(3, 1, 2, 1, 'Vacunación', 'Oxi', '10ml', '2026-05-03', '2026-05-24', 'Ejecutado', NULL, '2026-05-03 23:50:20', '2026-05-03 23:52:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fincas`
--
-- Creación: 16-03-2026 a las 19:50:10
--

CREATE TABLE `fincas` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo_finca` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `propietario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `fincas`
--

INSERT INTO `fincas` (`id`, `codigo_finca`, `nombre`, `password`, `logo_url`, `direccion`, `propietario`, `telefono`, `activo`, `created_at`, `updated_at`) VALUES
(1, 'FINCA001', 'La Esperanza', '$2y$12$fDbl/gTUqM2ekKPuQFBcHOe37rWrQQ6MVX5R9sqCc3BqC6jK5WXQK', NULL, NULL, 'Juan Perez', NULL, 1, '2026-03-17 05:28:06', '2026-03-17 05:28:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lotes`
--
-- Creación: 16-03-2026 a las 19:50:10
--

CREATE TABLE `lotes` (
  `id` bigint UNSIGNED NOT NULL,
  `finca_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacidad` int DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--
-- Creación: 16-03-2026 a las 19:50:10
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2026_03_16_194103_create_fincas_table', 1),
(2, '2026_03_16_194138_create_usuarios_table', 1),
(3, '2026_03_16_194155_create_razas_table', 1),
(4, '2026_03_16_194203_create_lotes_table', 1),
(5, '2026_03_16_194209_create_bovinos_table', 1),
(6, '2026_03_16_194216_create_produccion_leche_table', 1),
(7, '2026_03_16_194224_create_pesajes_table', 1),
(8, '2026_03_16_194228_create_eventos_sanitarios_table', 1),
(9, '2026_03_16_194233_create_alimentacion_table', 1),
(10, '2026_03_17_001948_create_personal_access_tokens_table', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--
-- Creación: 17-03-2026 a las 00:20:24
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pesajes`
--
-- Creación: 16-03-2026 a las 19:50:11
--

CREATE TABLE `pesajes` (
  `id` bigint UNSIGNED NOT NULL,
  `finca_id` bigint UNSIGNED NOT NULL,
  `bovino_id` bigint UNSIGNED NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `peso_kg` decimal(8,2) NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pesajes`
--

INSERT INTO `pesajes` (`id`, `finca_id`, `bovino_id`, `usuario_id`, `fecha`, `peso_kg`, `observaciones`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 3, '2026-05-04', 670.00, NULL, '2026-05-05 03:07:19', '2026-05-05 03:07:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `produccion_leche`
--
-- Creación: 16-03-2026 a las 19:50:10
--

CREATE TABLE `produccion_leche` (
  `id` bigint UNSIGNED NOT NULL,
  `finca_id` bigint UNSIGNED NOT NULL,
  `bovino_id` bigint UNSIGNED NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `turno` enum('Mañana','Tarde','Noche') COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad_litros` decimal(8,2) NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `produccion_leche`
--

INSERT INTO `produccion_leche` (`id`, `finca_id`, `bovino_id`, `usuario_id`, `fecha`, `turno`, `cantidad_litros`, `observaciones`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 3, '2026-05-04', 'Mañana', 2.30, NULL, '2026-05-04 23:56:15', '2026-05-05 03:08:34'),
(2, 1, 4, 3, '2026-05-04', 'Tarde', 7.40, NULL, '2026-05-05 00:39:00', '2026-05-05 00:39:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `razas`
--
-- Creación: 16-03-2026 a las 19:50:10
--

CREATE TABLE `razas` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `proposito` enum('Carne','Leche','Doble propósito') COLLATE utf8mb4_unicode_ci NOT NULL,
  `origen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `razas`
--

INSERT INTO `razas` (`id`, `nombre`, `descripcion`, `proposito`, `origen`, `created_at`, `updated_at`) VALUES
(1, 'Angus', 'Raza de carne originaria de Escocia', 'Carne', 'Escocia', '2026-03-17 05:59:44', '2026-03-17 05:59:44'),
(2, 'Holstein', 'Raza lechera de gran tamaño y alta producción, originaria de Holanda', 'Leche', 'Holanda', '2026-05-05 03:50:13', '2026-05-05 03:50:13'),
(3, 'Brahman', 'Raza cebuína de doble propósito, originaria de la India, reconocida por su resistencia al calor y a las enfermedades', 'Doble propósito', 'India', '2026-05-05 03:52:33', '2026-05-05 03:52:33'),
(4, 'Simmental', 'Raza de doble propósito de origen suizo, conocida por su gran tamaño y buena producción tanto de carne como de leche', 'Doble propósito', 'Suiza', '2026-05-05 03:52:56', '2026-05-05 03:52:56'),
(5, 'Girolando', 'Raza sintética de doble propósito originaria de Brasil, resultado del cruce entre las razas Gir y Holstein', 'Doble propósito', 'Brasil', '2026-05-05 03:53:11', '2026-05-05 03:53:11'),
(6, 'Normando', 'Raza de doble propósito originaria de Francia, conocida por la alta calidad grasa de su leche, ideal para quesos y mantequilla', 'Doble propósito', 'Francia', '2026-05-05 03:53:25', '2026-05-05 03:53:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--
-- Creación: 16-03-2026 a las 19:50:10
--

CREATE TABLE `usuarios` (
  `id` bigint UNSIGNED NOT NULL,
  `finca_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` enum('admin','empleado') COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `finca_id`, `nombre`, `email`, `password`, `rol`, `activo`, `created_at`, `updated_at`) VALUES
(1, 1, 'Carlos', NULL, '$2y$12$w1ZN4PFi/TFBZbgZ3eannO0Kmo1CT2S6w1317U3bZiNe3HEO3pQKu', 'admin', 1, '2026-03-17 05:30:34', '2026-03-17 05:30:34'),
(2, 1, 'Maria', NULL, '$2y$12$gwTgZpHnW.LdjdG4gfFuauxVAQUjfegUSw4EjClQu1jat8AhKcnZW', 'empleado', 0, '2026-05-03 23:31:17', '2026-05-05 00:41:56'),
(3, 1, 'Juan', NULL, '$2y$12$NWQjXdTjBC4fl87oP.wlfudRVb9xkvrLINqQeSk35g869K0.bsiai', 'empleado', 1, '2026-05-03 23:48:31', '2026-05-03 23:48:31');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alimentacion`
--
ALTER TABLE `alimentacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `alimentacion_finca_id_foreign` (`finca_id`),
  ADD KEY `alimentacion_lote_id_foreign` (`lote_id`),
  ADD KEY `alimentacion_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `bovinos`
--
ALTER TABLE `bovinos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bovinos_arete_unique` (`arete`),
  ADD KEY `bovinos_finca_id_foreign` (`finca_id`),
  ADD KEY `bovinos_raza_id_foreign` (`raza_id`),
  ADD KEY `bovinos_lote_id_foreign` (`lote_id`);

--
-- Indices de la tabla `eventos_sanitarios`
--
ALTER TABLE `eventos_sanitarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eventos_sanitarios_finca_id_foreign` (`finca_id`),
  ADD KEY `eventos_sanitarios_bovino_id_foreign` (`bovino_id`),
  ADD KEY `eventos_sanitarios_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `fincas`
--
ALTER TABLE `fincas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fincas_codigo_finca_unique` (`codigo_finca`);

--
-- Indices de la tabla `lotes`
--
ALTER TABLE `lotes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lotes_finca_id_foreign` (`finca_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indices de la tabla `pesajes`
--
ALTER TABLE `pesajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pesajes_finca_id_foreign` (`finca_id`),
  ADD KEY `pesajes_bovino_id_foreign` (`bovino_id`),
  ADD KEY `pesajes_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `produccion_leche`
--
ALTER TABLE `produccion_leche`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produccion_leche_finca_id_foreign` (`finca_id`),
  ADD KEY `produccion_leche_bovino_id_foreign` (`bovino_id`),
  ADD KEY `produccion_leche_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `razas`
--
ALTER TABLE `razas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarios_finca_id_foreign` (`finca_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alimentacion`
--
ALTER TABLE `alimentacion`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bovinos`
--
ALTER TABLE `bovinos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `eventos_sanitarios`
--
ALTER TABLE `eventos_sanitarios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `fincas`
--
ALTER TABLE `fincas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `lotes`
--
ALTER TABLE `lotes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pesajes`
--
ALTER TABLE `pesajes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `produccion_leche`
--
ALTER TABLE `produccion_leche`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `razas`
--
ALTER TABLE `razas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alimentacion`
--
ALTER TABLE `alimentacion`
  ADD CONSTRAINT `alimentacion_finca_id_foreign` FOREIGN KEY (`finca_id`) REFERENCES `fincas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `alimentacion_lote_id_foreign` FOREIGN KEY (`lote_id`) REFERENCES `lotes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `alimentacion_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT;

--
-- Filtros para la tabla `bovinos`
--
ALTER TABLE `bovinos`
  ADD CONSTRAINT `bovinos_finca_id_foreign` FOREIGN KEY (`finca_id`) REFERENCES `fincas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bovinos_lote_id_foreign` FOREIGN KEY (`lote_id`) REFERENCES `lotes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bovinos_raza_id_foreign` FOREIGN KEY (`raza_id`) REFERENCES `razas` (`id`) ON DELETE RESTRICT;

--
-- Filtros para la tabla `eventos_sanitarios`
--
ALTER TABLE `eventos_sanitarios`
  ADD CONSTRAINT `eventos_sanitarios_bovino_id_foreign` FOREIGN KEY (`bovino_id`) REFERENCES `bovinos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `eventos_sanitarios_finca_id_foreign` FOREIGN KEY (`finca_id`) REFERENCES `fincas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `eventos_sanitarios_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT;

--
-- Filtros para la tabla `lotes`
--
ALTER TABLE `lotes`
  ADD CONSTRAINT `lotes_finca_id_foreign` FOREIGN KEY (`finca_id`) REFERENCES `fincas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pesajes`
--
ALTER TABLE `pesajes`
  ADD CONSTRAINT `pesajes_bovino_id_foreign` FOREIGN KEY (`bovino_id`) REFERENCES `bovinos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pesajes_finca_id_foreign` FOREIGN KEY (`finca_id`) REFERENCES `fincas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pesajes_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT;

--
-- Filtros para la tabla `produccion_leche`
--
ALTER TABLE `produccion_leche`
  ADD CONSTRAINT `produccion_leche_bovino_id_foreign` FOREIGN KEY (`bovino_id`) REFERENCES `bovinos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `produccion_leche_finca_id_foreign` FOREIGN KEY (`finca_id`) REFERENCES `fincas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `produccion_leche_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_finca_id_foreign` FOREIGN KEY (`finca_id`) REFERENCES `fincas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
