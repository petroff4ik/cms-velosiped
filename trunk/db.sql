-- phpMyAdmin SQL Dump
-- version 3.2.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 02, 2011 at 11:34 AM
-- Server version: 5.1.40
-- PHP Version: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `catalogp`
--

CREATE TABLE IF NOT EXISTS `catalogp` (
  `idcp` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(2) NOT NULL,
  `name_alias` int(11) NOT NULL,
  `descr_alias` int(11) NOT NULL,
  `price_alias` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `id_doc` int(11) NOT NULL,
  `pos` int(11) NOT NULL,
  `file_name` text NOT NULL,
  `path` text NOT NULL,
  PRIMARY KEY (`idcp`),
  KEY `price_alias` (`price_alias`),
  KEY `descr_alias` (`descr_alias`),
  KEY `name_alias` (`name_alias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `catalogp`
--


-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` int(11) NOT NULL,
  `body` int(11) NOT NULL,
  `id_doc` int(11) NOT NULL,
  `int_id` int(11) NOT NULL,
  `ext_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `comment`
--


-- --------------------------------------------------------

--
-- Table structure for table `doc_view`
--

CREATE TABLE IF NOT EXISTS `doc_view` (
  `id` int(11) NOT NULL,
  `text_title` text,
  `text` text,
  `show_me_title` int(11) NOT NULL,
  `small_version` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doc_view`
--


-- --------------------------------------------------------

--
-- Table structure for table `form_level`
--

CREATE TABLE IF NOT EXISTS `form_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(20) DEFAULT NULL,
  `level` varchar(10) DEFAULT NULL,
  `name` text,
  `id_level` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `url` (`url`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=386 ;

--
-- Dumping data for table `form_level`
--

INSERT INTO `form_level` (`id`, `url`, `level`, `name`, `id_level`) VALUES
(333, 'templates', '2', '{tem_templates}', 1),
(2, 'securitys', '5', '{s_security}', 1),
(3, 'edit', '4', '{e_edit_cat}', 32),
(4, 'create', '4', '{c_create_doc}', 32),
(5, 'edit_doc', '4', '{ed_edit_doc}', 32),
(6, 'save_edit', '4', '{e_save}', 32),
(7, 'save_edit_d', '4', '{ed_save_doc}', 32),
(8, 'save_doc', '4', '{ed_save_doc_n}', 32),
(9, 'add', '4', '{ad_add_del}', 32),
(10, 'add_in', '4', '{ad_insert}', 32),
(11, 'add_r', '4', '{ad_add_cat}', 32),
(12, 'del', '4', '{ad_del}', 32),
(13, 'info', '2', '{i_info}', 32),
(14, 'modules', '3', '{m_mod}', 1),
(15, 'load_files', '4', '{m_load_files}', 14),
(16, 'mod_options', '4', '{m_options}', 14),
(17, 'side', '3', '{tem_add_side}', 333),
(18, 'temp_all', '3', '{tem_all}', 333),
(19, 'temp_ld', '4', '{tem_load\\del}', 333),
(20, 'element', '5', '{s_element}', 2),
(21, 'save_element', '5', '{s_element}', 2),
(22, 'quit_mod_opt', '2', '{quit}', 14),
(23, 'quit_adm', '2', '{quit}', 1),
(24, 'quit', '2', '{quit}', 32),
(25, 'save_l', '5', '{save_level}', 2),
(26, 'edit_user', '5', '{s_edit_user}', 2),
(27, 's_add_user', '5', '{s_add_user}', 2),
(28, 's_add_login', '5', '{s_add_login}', 2),
(29, 's_del_user', '5', '{del}', 2),
(30, 's_del_login', '5', '{del}', 2),
(31, 's_edit_login', '5', '{s_edit_login}', 2),
(32, '', '3', '{all_cat}', 1),
(33, 'tem_side_l', '5', '{tem_l_un}', 333),
(34, 'tem_add_s', '5', '{tem_add_side}', 333),
(35, 'save_tmp_inf', '5', '{tem_save}', 333),
(36, 'tem_side_d', '5', '{tem_del_side}', 333),
(335, 'tem_del_tem', '5', '{tem_del_tem}', 333),
(336, 'lang', '3', '{l_lang}', 1),
(337, 'l_ch_def', '3', '{l_ch_def}', 336),
(338, 'l_save_info', '5', '{l_save_info}', 336),
(339, 'l_add', '5', '{l_add}', 336),
(340, 'l_del', '5', '{l_del}', 336),
(341, 'document', '3', '{document}', 1),
(342, 'm_save_mod', '5', '{m_save_mod}', 14),
(343, 'id', '3', '{id}', 1),
(344, 'launch', '4', '{launch}', 343),
(345, 'hidedoc', '4', '{hidedoc}', 343),
(346, 'showdoc', '4', '{showdoc}', 343),
(347, 'savesidedoc', '4', '{savesidedoc}', 343),
(348, 'message', '', '{sys_message}', 3),
(349, 'safe_launch', '3', '{safe_launch}', 2),
(350, 'branch', '3', '{branch}', 343),
(351, 'returnpath', '3', '{ajaxquery}', 341),
(352, 'galery', '3', '{galery)', 341),
(353, 'returnside', '3', '{ajaxqueryside}', 341),
(354, 'add_doc', '4', '{add_doc}', 343),
(355, 'uncoupling', '3', '{edm_uncoupling}', 32),
(356, 'changevector', '3', '{changevector}', 343),
(357, 'savedate', '4', '{savedate}', 343),
(358, 'ajaxloadside', '3', '{ajaxloadside}', 32),
(359, 'save_nl', '5', '{save_nl}', 14),
(360, 'options', '5', '{options}', 1),
(361, 'cache', '5', '{cache}', 360),
(362, 'cache_clean', '5', '{l_cache_clean}', 360),
(363, 'cache_clean_old', '5', '{l_cache_clean_old}', 360),
(364, 'cache_clean_hand', '5', '{l_cache_clean_hand}', 360),
(365, 'config', '5', '{config}', 360),
(366, 'config_save', '5', '{l_config_save}', 360),
(367, 'add_page', '5', '{l_add_page}', 341),
(368, 'add_edit_d', '5', '{l_add_edit_d}', 341),
(369, 'insertPagesInDoc', '5', '{insertPagesInDoc}', 343),
(370, 'log', '5', '{log}', 360),
(371, 'clean_log', '5', '{l_clean_log}', 360),
(372, 'delnsdoc', '5', '{delnsdoc}', 1),
(373, 'invert', '5', '{l_invert}', 343),
(374, 'proxy', '5', '{l_proxy}', 360),
(375, 'invcreate', '5', '{l_invcreate}', 343),
(376, 'invcreatedb', '5', '{l_invcreatedb}', 343),
(377, 'delinv', '5', '{l_delinv}', 343),
(378, 'edittemplate', '5', '{l_edittemplate}', 333),
(379, 'readtemplate', '5', '{l_readtemplate}', 333),
(380, 'saveftemplate', '5', '{l_saveftemplate}', 333),
(381, 'editinv', '5', '{l_editinv}', 343),
(382, 'updateinv', '5', '{l_updateinv}', 343),
(383, 'createinvfordoc', '5', '{l_createinvfordoc}', 343),
(384, 'createinvfortree', '5', '{l_createinvfortree}', 343),
(385, 'unsafe_launch', '5', '{unsafe_launch}', 343);

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE IF NOT EXISTS `gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` text NOT NULL,
  `file_name` text NOT NULL,
  `description` int(11) NOT NULL,
  `id_doc` int(11) NOT NULL,
  `show_description` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `gallery`
--


-- --------------------------------------------------------

--
-- Table structure for table `id_lang_text`
--

CREATE TABLE IF NOT EXISTS `id_lang_text` (
  `id` int(11) NOT NULL,
  `text` text,
  `lang` varchar(3) DEFAULT NULL,
  `date` datetime NOT NULL,
  KEY `id` (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `id_lang_text`
--

INSERT INTO `id_lang_text` (`id`, `text`, `lang`, `date`) VALUES
(11, '<p>Ищешь пупсика?</p>', 'ru', '2010-08-05 17:20:29'),
(11, 'Error not found', 'en', '2010-08-05 17:20:00'),
(18, 'Выйти из системы', 'ru', '2011-02-12 00:00:00'),
(19, 'Не хватает полномочий', 'ru', '0000-00-00 00:00:00'),
(50, 'дальше', 'ru', '0000-00-00 00:00:00'),
(50, 'next', 'en', '0000-00-00 00:00:00'),
(1, 'эл. почта', 'ru', '2011-01-10 16:34:35'),
(1, 'email', 'en', '2011-01-10 16:35:01'),
(2, 'Сообшение', 'ru', '2011-01-10 16:48:38'),
(2, 'Message', 'en', '2011-01-10 16:49:03'),
(3, 'Добавить', 'ru', '2011-01-10 16:53:16'),
(3, 'Add', 'en', '2011-01-10 16:53:35'),
(4, 'Комментарий добавлен', 'ru', '2011-01-10 22:49:37'),
(4, 'Comment add', 'en', '2011-01-10 22:49:56'),
(5, 'Введите текст с картинки', 'ru', '2011-01-12 11:57:15'),
(5, 'captcha', 'en', '2011-01-12 11:57:30'),
(6, 'Ответ на сообшение', 'ru', '2011-01-13 12:12:44'),
(6, 'Answer to', 'en', '2011-01-13 12:13:01'),
(7, 'Войти', 'ru', '2011-02-11 11:49:39'),
(7, 'Enter', 'en', '2011-02-11 11:49:54'),
(8, 'Заполните оба поля.', 'ru', '2011-02-11 15:28:25'),
(9, 'Неправильный логин.', 'ru', '2011-02-11 15:28:34'),
(10, 'Неправильный пароль.', 'ru', '2011-02-11 15:29:01'),
(12, 'Вышло количество попыток входа.', 'ru', '2011-02-11 15:50:06'),
(13, 'Операция прошла неудачно', 'ru', '2011-02-11 23:38:45'),
(14, 'Операция прошла удачно', 'ru', '2011-02-11 23:39:07'),
(15, 'Здраствуйте', 'ru', '2011-02-12 01:40:15'),
(16, 'Вы', 'ru', '2011-02-12 01:41:02'),
(17, 'Уровень доступа', 'ru', '2011-02-12 01:41:24');

-- --------------------------------------------------------

--
-- Table structure for table `invert_sc`
--

CREATE TABLE IF NOT EXISTS `invert_sc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iddoc` int(11) NOT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  `ns_tree` int(11) DEFAULT NULL,
  `idint` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `invert_sc`
--


-- --------------------------------------------------------

--
-- Table structure for table `lang`
--

CREATE TABLE IF NOT EXISTS `lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(3) DEFAULT NULL,
  `alias` varchar(30) DEFAULT NULL,
  `default_lang` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `lang`
--

INSERT INTO `lang` (`id`, `name`, `alias`, `default_lang`) VALUES
(1, 'ru', 'Русский', 'true'),
(2, 'en', 'English', '');

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE IF NOT EXISTS `modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(10) DEFAULT NULL,
  `name` varchar(15) DEFAULT NULL,
  `schedule` int(11) DEFAULT NULL,
  `scheduleSide` varchar(12) DEFAULT NULL,
  `templates` text,
  `name_module` varchar(30) DEFAULT NULL,
  `help_annotation` text,
  `events` varchar(5) NOT NULL,
  `number_launch` int(11) NOT NULL,
  `level_access` int(11) NOT NULL,
  `s_edit` varchar(1) NOT NULL,
  `s_create` varchar(1) NOT NULL,
  `s_del` varchar(1) NOT NULL,
  `s_events` int(11) NOT NULL,
  `s_add` int(11) NOT NULL,
  `cache` int(1) NOT NULL,
  `free_cache` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scheduleSide` (`scheduleSide`),
  KEY `class` (`class`),
  KEY `scheduleSide_2` (`scheduleSide`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `class`, `name`, `schedule`, `scheduleSide`, `templates`, `name_module`, `help_annotation`, `events`, `number_launch`, `level_access`, `s_edit`, `s_create`, `s_del`, `s_events`, `s_add`, `cache`, `free_cache`) VALUES
(3, 'news', 'show', 0, 'news_sc', '', 'Новостной модуль.', 'Отображает,добавляет, редактирует новости. ', '1', 5, 0, '1', '1', '1', 1, 0, 1, ''),
(1, 'dv', 'id', 1, 'dv_sc', '', 'Статические страницы', 'Манипулирует статическими страницами (контакт,о нас). Кроме того позволяет отображать их блогом или какупрошенные новости.', '1', 4, 0, '1', '1', '1', 1, 0, 1, ''),
(2, 'comment', 'comm', 1, 'comment_sc', 'templates/site/tpl_module/comment', 'Комментарии', 'Добавление,просмотр,удаление комментариев', '1', 3, 0, '1', '1', '1', 1, 0, 0, '_comm_schedule'),
(5, 'lang', 'choose', 1, 'lang_sc', '', 'Мульти-языковой модуль', 'Модуль языковой подержки(системный)', '1', 1, 0, '', '1', '', 0, 0, 0, ''),
(4, 'tree', 'start', 1, 'tree_sc', '', 'Сис. католог(дерево)', 'Отображает меню, создает его, манипулирует системной информацией', '1', 2, 0, '', '1', '1', 1, 0, 1, ''),
(6, 'user_auth', 'login', 1, 'user_auth_sc', '', 'Авторизация на сайте', 'Класс для авторизации юзве', '1', 0, 0, '', '1', '', 0, 0, 0, ''),
(22, 'tags', 'show', 1, 'tags_sc', '', 'Теги', 'Теги, заголовки, ключи и дескрипторы', '0', 6, 0, '1', '1', '1', 0, 0, 1, ''),
(23, 'catalogp', 'show', 0, 'catalogp_sc', '', 'Католог упр.', 'Католого с одним вложением,упрошеный', '1', 7, 0, '1', '1', '1', 1, 0, 1, ''),
(24, 'map', 'show', 0, 'map_sc', NULL, 'Карта сайта', 'Создает карту сайта', '1', 8, 0, '0', '1', '1', 1, 0, 1, ''),
(25, 'gallery', 'img', 0, 'img_sc', '', 'Галерея', 'Ajax-фото галерея', '1', 9, 0, '1', '1', '1', 1, 1, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE IF NOT EXISTS `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` int(11) DEFAULT NULL,
  `title` int(11) NOT NULL,
  `shortdescr` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `id_doc` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shortdescr` (`shortdescr`),
  KEY `title` (`title`),
  KEY `body` (`body`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `news`
--


-- --------------------------------------------------------

--
-- Table structure for table `ns_doc`
--

CREATE TABLE IF NOT EXISTS `ns_doc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `father_id` int(11) NOT NULL,
  `show_me` int(11) DEFAULT NULL,
  `module` varchar(20) DEFAULT NULL,
  `side_for_doc` varchar(10) DEFAULT NULL,
  `children_id` int(11) NOT NULL,
  `mod_order` varchar(4) NOT NULL,
  `mod_group` int(11) NOT NULL,
  `mod_options` int(11) NOT NULL,
  `sch` int(11) NOT NULL,
  `types` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `father_id` (`father_id`),
  KEY `module` (`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ns_doc`
--


-- --------------------------------------------------------

--
-- Table structure for table `ns_tree`
--

CREATE TABLE IF NOT EXISTS `ns_tree` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `lft` bigint(20) NOT NULL,
  `rgt` bigint(20) NOT NULL,
  `level` bigint(20) NOT NULL,
  `show_me` int(10) DEFAULT NULL,
  `adress` text,
  `side` varchar(10) NOT NULL,
  `module` varchar(10) NOT NULL,
  `template_out` text NOT NULL,
  `func_name` varchar(20) NOT NULL,
  `alias` varchar(20) NOT NULL,
  `templates_int` text NOT NULL,
  `short_a` int(11) NOT NULL,
  `max_short_a` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nslrl_idx` (`lft`,`rgt`,`level`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ns_tree`
--


-- --------------------------------------------------------

--
-- Table structure for table `side_module`
--

CREATE TABLE IF NOT EXISTS `side_module` (
  `id` varchar(12) DEFAULT NULL,
  `side` varchar(10) DEFAULT NULL,
  `id_template` int(11) NOT NULL,
  KEY `side` (`side`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `side_module`
--

INSERT INTO `side_module` (`id`, `side`, `id_template`) VALUES
('lang_sc', 'lang', 4),
('lang_sc', 'lang', 1),
('news_ev', 'body', 4),
('news_ev', 'body', 1),
('catalogp_sc', 'body', 5),
('comment_sc', 'comment_vi', 5),
('tags_sc', 'title', 5),
('tags_st', 'title', 5),
('tags_sc', 'title', 4),
('tags_st', 'title', 4),
('tags_sc', 'title', 1),
('tags_st', 'title', 1),
('user_auth_sc', 'lang', 1),
('lang_sc', 'lang', 5),
('lang_ev', 'lang', 5),
('tags_st', NULL, 1),
('tags_sc', NULL, 1),
('tags_st', NULL, 4),
('tags_sc', NULL, 4),
('tags_st', NULL, 5),
('tags_sc', NULL, 5),
('tags_st', 'meta_key', 1),
('tags_sc', 'meta_key', 1),
('tags_st', 'meta_key', 4),
('tags_sc', 'meta_key', 4),
('tags_st', 'meta_key', 5),
('tags_sc', 'meta_key', 5),
('tags_st', 'meta_descr', 1),
('tags_sc', 'meta_descr', 1),
('tags_st', 'meta_descr', 4),
('tags_sc', 'meta_descr', 4),
('tags_st', 'meta_descr', 5),
('tags_sc', 'meta_descr', 5),
('comment_sc', 'comment', 5),
('comment_ev', 'body', 4),
('comment_ev', 'comment_vi', 5),
('comment_ev', 'comment', 5),
('gallery_ev', 'body', 1),
('gallery_ev', 'body', 4),
('gallery_ev', 'body', 5),
('catalogp_ev', 'body', 4),
('catalogp_ev', 'body', 5);

-- --------------------------------------------------------

--
-- Table structure for table `side_site`
--

CREATE TABLE IF NOT EXISTS `side_site` (
  `side` varchar(10) DEFAULT NULL,
  `free` varchar(5) DEFAULT NULL,
  `id_template` int(11) NOT NULL,
  `ids` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ids`),
  KEY `side` (`side`),
  KEY `id_template` (`id_template`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

--
-- Dumping data for table `side_site`
--

INSERT INTO `side_site` (`side`, `free`, `id_template`, `ids`) VALUES
('body', '1', 1, 1),
('lang', '1', 1, 2),
('menu', '1', 2, 3),
('lang', '1', 2, 4),
('menu', '1', 3, 5),
('lang', '1', 3, 6),
('menu', '1', 4, 7),
('lang', '1', 4, 8),
('title', '1', 1, 9),
('title', '1', 4, 10),
('body', '1', 4, 11),
('meta_key', '1', 1, 12),
('meta_descr', '1', 1, 13),
('menu', '1', 1, 14),
('meta_key', '1', 4, 16),
('meta_descr', '1', 4, 17),
('comment', '1', 4, 25),
('comment_vi', '1', 4, 26),
('body', '1', 5, 28),
('lang', '1', 5, 29),
('menu', '1', 5, 30),
('title', '1', 5, 31),
('meta_key', '1', 5, 32),
('meta_descr', '1', 5, 33),
('comment_vi', '1', 5, 34),
('comment', '1', 5, 35),
('slogan', '1', 5, 36),
('slogan1', '1', 5, 37);

-- --------------------------------------------------------

--
-- Table structure for table `sys_info`
--

CREATE TABLE IF NOT EXISTS `sys_info` (
  `id_lang` int(11) NOT NULL,
  `name_message` text NOT NULL,
  `module` varchar(10) NOT NULL,
  `show_me` varchar(10) NOT NULL,
  `page` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_info`
--

INSERT INTO `sys_info` (`id_lang`, `name_message`, `module`, `show_me`, `page`) VALUES
(50, 'next', 'dv', '1', 'any'),
(11, 'show_404', 'message', '1', 'any'),
(1, 'email', 'comment', '1', 'any'),
(2, 'body_message', 'comment', '1', 'any'),
(3, 'add', 'comment', '1', 'any'),
(4, 'comm_add', 'comment', '1', 'any'),
(5, 'captcha', 'comment', '1', 'any'),
(6, 'answerto', 'comment', '1', 'any'),
(7, 'u_enter', 'user_auth', '1', 'any'),
(8, 'lempty_fields', 'user_auth', '1', 'any'),
(9, 'login_error', 'user_auth', '1', 'any'),
(10, 'password_error', 'user_auth', '1', 'any'),
(12, 'count_error', 'user_auth', '1', 'any'),
(13, 'er_sys', 'message', '1', 'any'),
(14, 'ok', 'message', '1', 'any'),
(15, 'hello_login', 'user_auth', '1', 'any'),
(16, 'we_are', 'user_auth', '1', 'any'),
(17, 'level_access', 'user_auth', '1', 'any'),
(18, 'quit', 'user_auth', '1', 'any'),
(19, 'titlen', 'user_auth', '1', 'any');

-- --------------------------------------------------------

--
-- Table structure for table `tags_side`
--

CREATE TABLE IF NOT EXISTS `tags_side` (
  `idts` int(11) NOT NULL AUTO_INCREMENT,
  `id_template` int(11) NOT NULL,
  `id_side` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`idts`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tags_side`
--


-- --------------------------------------------------------

--
-- Table structure for table `tags_voc`
--

CREATE TABLE IF NOT EXISTS `tags_voc` (
  `idtv` int(11) NOT NULL AUTO_INCREMENT,
  `id_doc` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`idtv`),
  KEY `id_doc` (`id_doc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tags_voc`
--


-- --------------------------------------------------------

--
-- Table structure for table `templates`
--

CREATE TABLE IF NOT EXISTS `templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path_file` text,
  `name` varchar(20) DEFAULT NULL,
  `show_me` varchar(10) DEFAULT NULL,
  `path_small_img` text,
  `name_project` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `templates`
--

INSERT INTO `templates` (`id`, `path_file`, `name`, `show_me`, `path_small_img`, `name_project`) VALUES
(1, 'templates/site/tpl_site/intro/intro.tpl', 'intro', '0', 'templates/site/tpl_site/intro/small_img/small_img.jpg', 'intro'),
(4, 'templates/site/tpl_site/main/main.tpl', 'main', '0', 'templates/site/tpl_site/main/small_img/small_img.jpg', 'main'),
(5, 'templates/site/tpl_site/default/default.tpl', 'default', '1', 'templates/site/tpl_site/default/small_img/small_img.jpg', 'default');

-- --------------------------------------------------------

--
-- Table structure for table `type_users`
--

CREATE TABLE IF NOT EXISTS `type_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) DEFAULT NULL,
  `level` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `type_users`
--

INSERT INTO `type_users` (`id`, `type`, `level`) VALUES
(1, 'admin', '5'),
(6, 'user', '3');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `name` text,
  `adress` varchar(30) DEFAULT NULL,
  `pass` text,
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_user`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`name`, `adress`, `pass`, `id`, `id_user`) VALUES
('admin', 'admin@mail', 'b07769b541f447c55b2d73be1b4fd1f4', 1, 1),
('Менаджер', 'test@mail.ru', 'c4ca4238a0b923820dcc509a6f75849b', 6, 4);
