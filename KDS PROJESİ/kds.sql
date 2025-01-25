-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 03 Oca 2025, 18:36:18
-- Sunucu sürümü: 8.2.0
-- PHP Sürümü: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `kds`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `meslekler`
--

DROP TABLE IF EXISTS `meslekler`;
CREATE TABLE IF NOT EXISTS `meslekler` (
  `meslek_kodu` int NOT NULL AUTO_INCREMENT,
  `meslek_adi` varchar(255) COLLATE utf8mb4_turkish_ci NOT NULL,
  PRIMARY KEY (`meslek_kodu`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `meslekler`
--

INSERT INTO `meslekler` (`meslek_kodu`, `meslek_adi`) VALUES
(1, 'Depo Operatörü'),
(2, 'Depo Personeli');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `personel`
--

DROP TABLE IF EXISTS `personel`;
CREATE TABLE IF NOT EXISTS `personel` (
  `personel_id` int NOT NULL AUTO_INCREMENT,
  `personel_ad` varchar(255) COLLATE utf8mb4_turkish_ci NOT NULL,
  `personel_soyad` varchar(255) COLLATE utf8mb4_turkish_ci NOT NULL,
  `is_basi_tarih` date NOT NULL,
  `takim_id` int NOT NULL,
  `meslek_kodu` int NOT NULL,
  `urun_genel_performans` decimal(10,2) NOT NULL,
  `tur_genel_performans` decimal(10,2) NOT NULL,
  PRIMARY KEY (`personel_id`),
  KEY `takim_id` (`takim_id`),
  KEY `meslek_kodu` (`meslek_kodu`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `personel`
--

INSERT INTO `personel` (`personel_id`, `personel_ad`, `personel_soyad`, `is_basi_tarih`, `takim_id`, `meslek_kodu`, `urun_genel_performans`, `tur_genel_performans`) VALUES
(1, 'Nazım', 'Bilgiç', '2025-01-12', 2, 2, 23.00, 20.20),
(2, 'Ozan', 'Çolak', '2024-11-10', 1, 2, 28.90, 27.50),
(3, 'Ali', 'Işık', '2024-09-09', 3, 2, 25.80, 24.50),
(5, 'Selim', 'Yılmaz', '2024-01-08', 2, 1, 22.40, 27.80);

--
-- Tetikleyiciler `personel`
--
DROP TRIGGER IF EXISTS `update_meslek_kodu_before_insert`;
DELIMITER $$
CREATE TRIGGER `update_meslek_kodu_before_insert` BEFORE INSERT ON `personel` FOR EACH ROW BEGIN
 IF TIMESTAMPDIFF (YEAR, NEW.is_basi_tarih, NOW()) >=1 THEN
  SET NEW.meslek_kodu = 2;
 ELSE
  SET NEW.meslek_kodu = 1;
 END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `update_meslek_kodu_on_insert`;
DELIMITER $$
CREATE TRIGGER `update_meslek_kodu_on_insert` BEFORE UPDATE ON `personel` FOR EACH ROW BEGIN
 IF NEW.is_basi_tarih != OLD.is_basi_tarih THEN
  IF TIMESTAMPDIFF(YEAR, NEW.is_basi_tarih, NOW()) >= 1 THEN
  SET NEW.meslek_kodu = 2;
 ELSE
  SET NEW.meslek_kodu = 1;
  END IF;
 END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `takimlar`
--

DROP TABLE IF EXISTS `takimlar`;
CREATE TABLE IF NOT EXISTS `takimlar` (
  `takim_id` int NOT NULL AUTO_INCREMENT,
  `takim_ad` varchar(255) COLLATE utf8mb4_turkish_ci NOT NULL,
  PRIMARY KEY (`takim_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `takimlar`
--

INSERT INTO `takimlar` (`takim_id`, `takim_ad`) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `takim_liderleri`
--

DROP TABLE IF EXISTS `takim_liderleri`;
CREATE TABLE IF NOT EXISTS `takim_liderleri` (
  `takim_lideri_id` int NOT NULL AUTO_INCREMENT,
  `takim_lideri_ad` varchar(255) COLLATE utf8mb4_turkish_ci NOT NULL,
  `takim_lideri_soyad` varchar(255) COLLATE utf8mb4_turkish_ci NOT NULL,
  `is_basi_tarih` date NOT NULL,
  PRIMARY KEY (`takim_lideri_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `takim_liderleri`
--

INSERT INTO `takim_liderleri` (`takim_lideri_id`, `takim_lideri_ad`, `takim_lideri_soyad`, `is_basi_tarih`) VALUES
(1, 'Mehmet Ali', 'Ardıç', '2015-01-23'),
(2, 'Osman', 'Aysan', '2024-08-13'),
(3, 'Yüksel', 'Balcı', '2020-09-15');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tur_performans`
--

DROP TABLE IF EXISTS `tur_performans`;
CREATE TABLE IF NOT EXISTS `tur_performans` (
  `t_performans_id` int NOT NULL AUTO_INCREMENT,
  `t_aralik_2024` int NOT NULL,
  `t_ocak_2025` int NOT NULL,
  `t_subat_2025` int NOT NULL,
  `t_mart_2025` int NOT NULL,
  `t_nisan_2025` int NOT NULL,
  `t_mayis_2025` int NOT NULL,
  PRIMARY KEY (`t_performans_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tetikleyiciler `tur_performans`
--
DROP TRIGGER IF EXISTS `trg_insert_update_tur_genel_performans`;
DELIMITER $$
CREATE TRIGGER `trg_insert_update_tur_genel_performans` AFTER INSERT ON `tur_performans` FOR EACH ROW BEGIN
    UPDATE personel
    SET tur_genel_performans =
    ROUND((
        SELECT SUM(t_aralik_2024 + t_ocak_2025 + t_subat_2025 + t_mart_2025 + t_nisan_2025 + t_mayis_2025)
        FROM tur_performans
        WHERE tur_performans.t_performans_id = personel.personel_id
      ) / (
          SELECT SUM(t_aralik_2024 + t_ocak_2025 + t_subat_2025 + t_mart_2025 + t_nisan_2025 + t_mayis_2025)
          FROM tur_performans 
    ) * 100, 1);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `urun_performans`
--

DROP TABLE IF EXISTS `urun_performans`;
CREATE TABLE IF NOT EXISTS `urun_performans` (
  `u_performans_id` int NOT NULL AUTO_INCREMENT,
  `u_aralik_2024` int NOT NULL,
  `u_ocak_2025` int NOT NULL,
  `u_subat_2025` int NOT NULL,
  `u_mart_2025` int NOT NULL,
  `u_nisan_2025` int NOT NULL,
  `u_mayis_2025` int NOT NULL,
  PRIMARY KEY (`u_performans_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tetikleyiciler `urun_performans`
--
DROP TRIGGER IF EXISTS `trg_insert_update_genel_performans`;
DELIMITER $$
CREATE TRIGGER `trg_insert_update_genel_performans` AFTER INSERT ON `urun_performans` FOR EACH ROW BEGIN
    UPDATE personel
    SET urun_genel_performans =
    ROUND((
        SELECT SUM(u_aralik_2024 + u_ocak_2025 + u_subat_2025 + u_mart_2025 + u_nisan_2025 + u_mayis_2025)
        FROM urun_performans
        WHERE u_performans_id = personel.personel_id
      ) / (
          SELECT SUM(u_aralik_2024 + u_ocak_2025 + u_subat_2025 + u_mart_2025 + u_nisan_2025 + u_mayis_2025)
          FROM urun_performans 
    ) * 100, 1);
END
$$
DELIMITER ;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `personel`
--
ALTER TABLE `personel`
  ADD CONSTRAINT `personel_ibfk_1` FOREIGN KEY (`takim_id`) REFERENCES `takimlar` (`takim_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `personel_ibfk_2` FOREIGN KEY (`meslek_kodu`) REFERENCES `meslekler` (`meslek_kodu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `takim_liderleri`
--
ALTER TABLE `takim_liderleri`
  ADD CONSTRAINT `takim_liderleri_ibfk_1` FOREIGN KEY (`takim_lideri_id`) REFERENCES `takimlar` (`takim_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `tur_performans`
--
ALTER TABLE `tur_performans`
  ADD CONSTRAINT `tur_performans_ibfk_1` FOREIGN KEY (`t_performans_id`) REFERENCES `personel` (`personel_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `urun_performans`
--
ALTER TABLE `urun_performans`
  ADD CONSTRAINT `urun_performans_ibfk_1` FOREIGN KEY (`u_performans_id`) REFERENCES `personel` (`personel_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
