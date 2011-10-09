-- phpMyAdmin SQL Dump
-- version 3.2.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
<<<<<<< .mine
-- Generation Time: Oct 09, 2011 at 08:38 PM
=======
-- Generation Time: Oct 08, 2011 at 02:05 PM
>>>>>>> .r33
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
  `ext_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

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

<<<<<<< .mine
INSERT INTO `doc_view` (`id`, `text_title`, `text`, `show_me_title`, `small_version`) VALUES
(7, '68', '69', 0, 0),
(8, '70', '71', 0, 0),
(10, '76', '77', 0, 0),
(13, '82', '83', 0, 0);
=======
INSERT INTO `doc_view` (`id`, `text_title`, `text`, `show_me_title`, `small_version`) VALUES
(7, '68', '69', 0, 0),
(8, '70', '71', 0, 0),
(10, '76', '77', 1, 0);
>>>>>>> .r33

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=388 ;

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
(385, 'unsafe_launch', '5', '{unsafe_launch}', 343),
(386, 'invdown', '3', '{l_invdown}', 343),
(387, 'invup', '3', '{l_invup}', 343);

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
(17, 'Уровень доступа', 'ru', '2011-02-12 01:41:24'),
(56, 'Відгуки', 'ua', '2011-10-02 00:00:00'),
(56, 'Recensioni', 'it', '2011-10-02 00:00:00'),
(56, 'Reviews', 'en', '2011-10-02 00:00:00'),
(56, 'Отзывы', 'ru', '2011-10-02 00:00:00'),
(55, 'Контакти', 'ua', '2011-10-02 00:00:00'),
(55, 'Сontatto', 'it', '2011-10-02 00:00:00'),
(55, 'Contact', 'en', '2011-10-02 00:00:00'),
(55, 'Контакты', 'ru', '2011-10-02 00:00:00'),
(54, 'Про нас', 'ua', '2011-10-02 00:00:00'),
(54, 'Chi siamo', 'it', '2011-10-02 00:00:00'),
(54, 'About Us', 'en', '2011-10-02 00:00:00'),
(54, 'О нас', 'ru', '2011-10-02 00:00:00'),
(53, 'Меню', 'ua', '2011-10-02 00:00:00'),
(53, 'Menu', 'it', '2011-10-02 00:00:00'),
(53, 'Menu', 'en', '2011-10-02 00:00:00'),
(53, 'Меню', 'ru', '2011-10-02 00:00:00'),
(52, 'Новини', 'ua', '2011-10-02 00:00:00'),
(52, 'Notizie', 'it', '2011-10-02 00:00:00'),
(52, 'News', 'en', '2011-10-02 00:00:00'),
(52, 'Новости', 'ru', '2011-10-02 00:00:00'),
(51, 'Интро', 'ua', '2011-10-02 00:00:00'),
(51, 'Intro', 'it', '2011-10-02 00:00:00'),
(51, 'Intro', 'en', '2011-10-02 00:00:00'),
(51, 'Интро', 'ru', '2011-10-02 00:00:00'),
(50, '<p>Далi</p>', 'ua', '0000-00-00 00:00:00'),
(57, 'пиццерия Синьор Помидор', 'ru', '2011-10-05 15:38:49'),
(57, 'Signor Tomato Pizza', 'en', '2011-10-05 15:38:49'),
(57, 'Il signor Pizza pomodoro', 'it', '2011-10-05 15:38:49'),
(57, 'піцерія Синьйор Помідор', 'ua', '2011-10-05 15:38:49'),
(58, 'Пиццерия синьор помидор пица вкусно поесть', 'ru', '2011-10-05 15:38:49'),
(58, 'Signor Pizza tomato pizza eat', 'en', '2011-10-05 15:38:49'),
(58, 'Il signor Pizza Pizza pomodoro mangiare', 'it', '2011-10-05 15:38:49'),
(58, 'Піцерія синьйор помідор піца смачно поїсти', 'ua', '2011-10-05 15:38:49'),
(59, 'Вкуснейшая пицца в киеве, готовится только в пиццерии Синьор Помидор', 'ru', '2011-10-05 15:38:49'),
(59, 'Delicious pizza in Kiev, is produced only in a pizzeria Signor Tomato', 'en', '2011-10-05 15:38:49'),
(59, 'Deliziosa pizza a Kiev, è prodotto solo in una pizzeria signor Pomodoro', 'it', '2011-10-05 15:38:49'),
(59, 'Смачна піца в києві, готується тільки в піцерії Синьйор Помідор', 'ua', '2011-10-05 15:38:49'),
(60, 'tag', 'ru', '2011-10-05 15:38:49'),
(60, 'tag', 'en', '2011-10-05 15:38:49'),
(60, 'tag', 'it', '2011-10-05 15:38:49'),
(60, 'tag', 'ua', '2011-10-05 15:38:49'),
(61, 'Здравствуйте. Мы открыли наш персональный сайт.', 'ru', '2011-10-05 15:54:17'),
(61, 'Hello We opened our personal website.', 'en', '2011-10-05 15:54:17'),
(61, 'Ciao Abbiamo aperto il nostro sito personale.', 'it', '2011-10-05 15:54:17'),
(61, 'Доброго дня. Ми відкрили наш персональний сайт.', 'ua', '2011-10-05 15:54:17'),
(62, 'Здесь мы будем выкладывать самые свежие новинки, также вы можете посмотреть актуальное меню, оставить свои предложения.', 'ru', '2011-10-05 15:54:17'),
(62, 'Here we will lay out the latest news, you can also see the actual menu, leave your suggestions.', 'en', '2011-10-05 15:54:17'),
(62, 'Qui si getterà le ultime notizie, è anche possibile vedere il menu effettivo, lasciare i vostri suggerimenti.', 'it', '2011-10-05 15:54:17'),
(62, 'Тут ми будемо викладати найсвіжіші новинки, також ви можете подивитися актуальне меню, залишити свої пропозиції.', 'ua', '2011-10-05 15:54:17'),
(63, '<p>Здесь мы будем выкладывать самые свежие новинки, также вы можете посмотреть актуальное меню, оставить свои предложения.</p>', 'ru', '2011-10-05 15:54:17'),
(63, '<p><span id="result_box" lang="en"><span>Here we will</span> <span>lay out</span> <span>the latest</span> <span>news</span><span>, you can also</span> <span>see</span> <span>the actual</span> <span>menu</span><span>,</span> <span>leave your</span> <span>suggestions.</span></span></p>', 'en', '2011-10-05 15:54:17'),
(63, '<p><span id="result_box" lang="it"><span>Qui si</span> <span>getter&agrave;</span> <span>le ultime notizie</span><span>, &egrave; anche possibile</span> <span>vedere il</span> <span>menu effettivo</span><span>, lasciare</span> <span>i vostri suggerimenti</span><span>.</span></span></p>', 'it', '2011-10-05 15:54:17'),
(63, '<p><span id="result_box" lang="uk"><span>Тут</span> <span>ми</span> <span>будемо</span> <span>викладати</span> <span>найсвіжіші</span> <span>новинки</span><span>, також ви</span> <span>можете</span> <span>подивитися</span> <span>актуальне</span> <span>меню</span><span>, залишити</span> <span>свої</span> <span>пропозиції.</span></span></p>', 'ua', '2011-10-05 15:54:17'),
(64, 'Новости', 'ru', '2011-10-05 15:58:35'),
(64, 'News', 'en', '2011-10-05 15:58:35'),
(64, 'Notizie', 'it', '2011-10-05 15:58:35'),
(64, 'Новини', 'ua', '2011-10-05 15:58:35'),
(65, 'Новости пицца киев вкусно', 'ru', '2011-10-05 15:58:35'),
(65, 'News cues tasty pizza', 'en', '2011-10-05 15:58:35'),
(65, 'Spunti notizia gustosa pizza', 'it', '2011-10-05 15:58:35'),
(65, 'Новини піца київ смачно', 'ua', '2011-10-05 15:58:35'),
(66, 'Самые свежие новости, актуальное состояние меню. Обновление и новинки', 'ru', '2011-10-05 15:58:35'),
(66, 'The latest news, current state of the menu. Updates and News', 'en', '2011-10-05 15:58:35'),
(66, 'Le ultime notizie, lo stato attuale del menu. Aggiornamenti e Novità', 'it', '2011-10-05 15:58:35'),
(66, 'Найсвіжіші новини, актуальний стан меню. Оновлення та новинки', 'ua', '2011-10-05 15:58:35'),
(67, 'tag', 'ru', '2011-10-05 15:58:35'),
(67, 'tag', 'en', '2011-10-05 15:58:35'),
(67, 'tag', 'it', '2011-10-05 15:58:35'),
<<<<<<< .mine
(67, 'tag', 'ua', '2011-10-05 15:58:35'),
(68, 'logo', 'ru', '2011-10-08 22:56:49'),
(68, 'logo', 'en', '2011-10-08 22:57:19'),
(68, 'logo', 'it', '2011-10-08 22:57:36'),
(68, 'logo', 'ua', '2011-10-08 22:58:49'),
(69, '<img title="logo" src="../../../templates/upload_out/logo_rus.jpg" alt="logo" />', 'ru', '2011-10-08 22:56:49'),
(69, '<img title="logo" src="../../../templates/upload_out/logo_eng.jpg" alt="logo" />', 'en', '2011-10-08 22:57:19'),
(69, '<img title="logo" src="../../../templates/upload_out/logo_italy.jpg" alt="logo" />', 'it', '2011-10-08 22:57:36'),
(69, '<img title="logo" src="/templates/upload_out/logo_ukr.jpg" alt="logo" />', 'ua', '2011-10-08 22:58:49'),
(70, 'mini_logo', 'ru', '2011-10-08 23:33:07'),
(70, 'mini_logo', 'en', '2011-10-08 23:33:07'),
(70, 'mini_logo', 'it', '2011-10-09 00:06:10'),
(70, 'mini_logo', 'ua', '2011-10-08 23:33:07'),
(71, '<img title="mini_logo" src="/templates/upload_out/mini_logo_rus.jpg" alt="mini_logo" />', 'ru', '2011-10-08 23:33:07'),
(71, '<img title="mini_logo" src="/templates/upload_out/mini_logo_eng.jpg" alt="mini_logo" />', 'en', '2011-10-08 23:33:07'),
(71, '<img title="mini_logo" src="/templates/upload_out/mini_logo_italy.jpg" alt="mini_logo" />', 'it', '2011-10-09 00:06:10'),
(71, '<img title="mini_logo" src="../../../templates/upload_out/mini_logo_ukr.jpg" alt="mini_logo" />', 'ua', '2011-10-08 23:33:07'),
(72, 'Контакты', 'ru', '2011-10-09 19:42:18'),
(72, 'Contact', 'en', '2011-10-09 19:42:18'),
(72, 'Сontatto', 'it', '2011-10-09 19:42:18'),
(72, 'Контакти', 'ua', '2011-10-09 19:42:18'),
(73, 'Контакты', 'ru', '2011-10-09 19:42:18'),
(73, 'Contact', 'en', '2011-10-09 19:42:18'),
(73, 'Сontatto', 'it', '2011-10-09 19:42:18'),
(73, 'Контакти', 'ua', '2011-10-09 19:42:18'),
(74, 'Где мы находимся\r\nг. Киев, Русановская набережная, 4\r\n\r\nтелефоны: (044) 295 45 49, (067) 732 55 55\r\n\r\nВремя работы: 11:00-23:00', 'ru', '2011-10-09 19:42:18'),
(74, 'Where we are\r\nc. Kiev, Rusanovskay naberegnay, 4\r\n\r\nphone: (044) 295 45 49, (067) 732 55 55\r\n\r\nTime work: 11:00-23:00', 'en', '2011-10-09 19:42:18'),
(74, 'Dove siamo\r\nKiev, terrapieno Rusanovskaya, 4\r\n\r\nTelefono: (044) 295 45 49, (067) 732 55 55\r\n\r\nOrari: 11:00-23:00', 'it', '2011-10-09 19:42:18'),
(74, 'Де ми знаходимося\r\nм. Київ, Русанівська набережна, 4\r\n\r\nтелефони: (044) 295 45 49, (067) 732 55 55\r\n\r\nЧас роботи: 11:00-23:00', 'ua', '2011-10-09 19:42:18'),
(75, 'tag', 'ru', '2011-10-09 19:42:18'),
(75, 'tag', 'en', '2011-10-09 19:42:18'),
(75, 'tag', 'it', '2011-10-09 19:42:18'),
(75, 'tag', 'ua', '2011-10-09 19:42:18'),
(76, 'contact', 'ru', '2011-10-09 19:48:52'),
(76, 'contact', 'en', '2011-10-09 19:48:55'),
(76, 'contact', 'it', '2011-10-09 19:54:36'),
(76, 'contact', 'ua', '2011-10-09 19:55:14'),
(77, '<p style="text-align: left; padding-left: 90px;"><img title="map" src="http://db/templates/upload_out/map.jpg" alt="map" /></p>\r\n<p style="text-align: left; padding-left: 90px;"><span style="color: #333333;"><strong><span style="font-size: medium;">г. Киев, Русановская набережная, 4</span></strong></span></p>\r\n<p style="text-align: left; padding-left: 90px;"><span style="color: #333333;"><strong><span style="font-size: medium;">телефоны: (044) 295 45 49, (067) 732 55 55</span></strong></span></p>\r\n<p style="text-align: left; padding-left: 90px;"><span style="color: #333333;"><strong><span style="font-size: medium;">Время работы: 11:00-23:00</span></strong></span></p>', 'ru', '2011-10-09 19:48:52'),
(77, '<p style="padding-left: 90px;"><img title="map" src="http://db/templates/upload_out/map.jpg" alt="map" /></p>\r\n<p style="padding-left: 90px;"><span style="color: #333333;"><span style="font-size: medium;"><strong><span id="result_box" lang="en">Kiev, Rusanovskaya embankment, 4<br /><br /> Phone: (044) 295 45 49, (067) 732 55 55<br /><br /> Hours: 11:00-23:00</span></strong></span></span></p>', 'en', '2011-10-09 19:48:55'),
(77, '<p style="padding-left: 90px;"><img title="map" src="http://db/templates/upload_out/map.jpg" alt="map" /></p>\r\n<p style="padding-left: 90px;"><span style="color: #333333;"><span style="font-size: medium;"><strong><span id="result_box" lang="it">Kiev, terrapieno Rusanovskaya, 4<br /><br /> Telefono: (044) 295 45 49, (067) 732 55 55<br /><br /> Orari: 11:00-23:00</span></strong></span></span></p>', 'it', '2011-10-09 19:54:36'),
(77, '<p style="padding-left: 90px;"><img title="map" src="http://db/templates/upload_out/map.jpg" alt="map" /></p>\r\n<p style="padding-left: 90px;"><span style="color: #333333;"><span style="font-size: medium;"><strong><span id="result_box" lang="uk">м. Київ, Русанівська набережна, 4<br /><br /> телефони: (044) 295 45 49, (067) 732 55 55<br /><br /> Час роботи: 11:00-23:00</span></strong></span></span></p>', 'ua', '2011-10-09 19:55:14'),
(78, 'О нас', 'ru', '2011-10-09 20:00:04'),
(78, 'About Us', 'en', '2011-10-09 20:00:04'),
(78, 'Chi siamo', 'it', '2011-10-09 20:00:04'),
(78, 'Про нас', 'ua', '2011-10-09 20:00:04'),
(79, 'О нас', 'ru', '2011-10-09 20:00:04'),
(79, 'About Us', 'en', '2011-10-09 20:00:04'),
(79, 'Chi siamo', 'it', '2011-10-09 20:00:04'),
(79, 'Про нас', 'ua', '2011-10-09 20:00:04'),
(80, 'О нас. Кратка история пиццерии ее философия и принципы.', 'ru', '2011-10-09 20:00:04'),
(80, 'A brief history of pizza its philosophy and principles.', 'en', '2011-10-09 20:00:04'),
(80, 'Una breve storia della pizza la sua filosofia e principi.', 'it', '2011-10-09 20:00:04'),
(80, 'Коротка історія піцерії її філософія і принципи.', 'ua', '2011-10-09 20:00:04'),
(81, 'tag', 'ru', '2011-10-09 20:00:04'),
(81, 'tag', 'en', '2011-10-09 20:00:04'),
(81, 'tag', 'it', '2011-10-09 20:00:04'),
(81, 'tag', 'ua', '2011-10-09 20:00:04'),
(82, 'about us', 'ru', '2011-10-09 20:13:10'),
(82, 'about us', 'en', '2011-10-09 20:14:11'),
(82, 'about us', 'it', '2011-10-09 20:15:36'),
(82, 'about us', 'ua', '2011-10-09 20:16:33'),
(83, '<p><span style="font-size: medium;"><span id="result_box" lang="ru"><span title="Сеньйор Помідор!!!"><br /></span><strong><span style="font-size: large;"><span title="Італійська Піцерія Сеньйор Помідор">Итальянская Пиццерия Сеньор Помидор</span></span></strong></span></span></p>\r\n<p><span style="font-size: medium;"><span id="result_box" lang="ru"><span title="Італійська Піцерія Сеньйор Помідор"><br /></span><span title="Піцерія..."><strong>Пиццерия ...</strong><br /></span><span title="●	популярне місце, де є можливість поїсти, випити, та найважливіше - поспілкуватись, бо в нашому &bdquo;Помідорі&rdquo; панує домашня атмосфера.">●  популярное место, где есть возможность поесть, выпить, и самое важное -  пообщаться, потому что в нашем "Помидора" царит домашняя атмосфера. </span><span title="Тому навіть якщо Ви прийшли самі - Ви не засумуєте, звісно, якщо Вам цього не захочеться">Поэтому даже если вы пришли сами - Вы не соскучишься, конечно, если Вам этого не захочется<br /><br /></span><span title="Чому &bdquo;Сеньйор Помідор&rdquo;?"><strong>Почему "Сеньор Помидор"?</strong><br /></span><span title="●	У італійців дуже поважне ставлення до цього овочу.">● У итальянцев очень уважительное отношение к этому овощу. </span><span title="Велика кількість страв робиться саме з додаванням до них помідорів.">Большое количество блюд делается именно с добавлением к ним помидоров. </span><span title="У цьому випадку нам треба брати приклад з італійців, бо це єдиний овоч, який після теплової обробки не втрачає вітаміну С, який в свою чергу, допомагає нашому організму виробляти речовину &ndash; серотонін, яка ще називається гормоном &bdquo;щастя&rdquo;.">В  этом случае нам надо брать пример с итальянцев, потому что это  единственный овощ, который после тепловой обработки не теряет витамина  С, который в свою очередь, помогает нашему организму вырабатывать  вещество - серотонин, который еще называется гормоном "счастья". </span><span title="І саме тому, в нашому &bdquo;Помідорі&rdquo; усі такі щасливі!">И именно поэтому, в нашем "Помидора" все такие счастливые!<br /><br /></span><span title="Піца"><strong>Пицца</strong><br /></span><span title="●	Це символ Середземномор`я!">● Это символ Средиземноморья! </span><span title="Легенда розповідає, що піца &ndash; це партенопський рецепт, який вигадали у Неаполі у 1889 році.">Легенда рассказывает, что пицца - это партенопський рецепт, который придумали в Неаполе в 1889 году. </span><span title="Перший раз була приготовлена Рафаелем Еспозіто на честь королеви Маргарити.">Первый раз была приготовлена ​​Рафаэлем Эспозито в честь королевы Маргариты. </span><span title="В принципі, щоб задовольнити її Величність, він взяв звичайний шматок тіста, зробивши його тоненьким, круглої форми, потім додав помідорний соус, смачну моцареллу та декілька листиків базиліка.">В  принципе, чтобы удовлетворить ее Величество, он взял обычный кусок  теста, сделав его тоненьким, круглой формы, потом добавил помидорный  соус, вкусную моцареллу и несколько листиков базилика.<br /></span><span title="Відправив все у піч, і коли краєчок набув золотистого кольору, ще палаючою подав королеві.">Отправил все в печь, и когда краешек приобрел золотистый цвет, еще горящей подал королю. </span><span title="Блюдо їй дуже сподобалось і вона спитала у пекаря як зветься цей тип хліба.">Блюдо ей очень понравилось и она спросила у пекаря как называется этот тип хлеба. </span><span title="Він відповів: &laquo;О моя королева!">Он ответил: &laquo;О моя королева! </span><span title="Цей незвичайний хліб з моцареллою, помідором та базиліком відтворює кольори італійського прапору і на Вашу честь зветься &laquo;Піца Маргарита&raquo;.">Этот  необычный хлеб с моцареллой, помидором и базиликом воспроизводит цвета  итальянского флага и в Вашу честь зовется &laquo;Пицца Маргарита&raquo;. </span><span title="Так народилася піца, яку з часом пекарі та кухарі збагатили й іншими інгредієнтами.">Так родилась пицца, которую со временем пекари и повара обогатили и другими ингредиентами.<br /></span><span title="●	Філософ Платон вказував на неї як на здорову страву ( і зараз, дієтологи рекомендують її як їжу легку та ...радісну!)">● Философ Платон указывал на нее как на здоровую блюдо (и сейчас, диетологи рекомендуют ее как пищу легкую и ... радостную!)<br /><br /></span><span title="Італійська кухня"><strong>Итальянская кухня</strong><br /></span><span title="●	Може бути створена ТІЛЬКИ італійським шеф-кухарем">● Может быть создана ТОЛЬКО итальянским шеф-поваром<br /><br /></span><span title="Паста"><strong>Паста</strong><br /></span><span title="●	Це не тільки спагеті Карбонара та Болоньєз">● Это не только спагетти Карбонара и Болоньез<br /></span><span title="●	від неї не повнішають, і це не жарт, бо складні вуглеводи засвоюються з часом, і тому не створюють надлишків енергії">● от нее не полнеют, и это не шутка, потому сложные углеводы усваиваются со временем, и поэтому не создают излишков энергии<br /><br /></span><span title="&bdquo;Аль денте&rdquo;"><strong>"Аль денте"</strong><br /></span><span title="●	Це не &bdquo;недоварені макарони&rdquo;, а правильно приготована паста">● Это не "недоваренные макароны", а правильно приготовленная паста<br /><br /></span><span title="Домашня паста"><strong>Домашняя паста</strong><br /></span><span title="●	предмет особливої гордості &bdquo;Сеньйора Помідора&rdquo;">● предмет особой гордости "Сеньора Помидора"<br /></span><span title="●	те, що треба спробувати у &bdquo;Помідорі&rdquo;">● то, что надо попробовать в "Помидора"<br /></span><span title="●	те, що навряд чи Ви зумієте приготувати у себе вдома">● том, что вряд ли вы сумеете приготовить у себя дома<br /><br /></span><span title="Різотто"><strong>Ризотто</strong><br /></span><span title="●	це знову, зовсім не &bdquo;недоварений рис&rdquo;">● это снова, совсем не "недоваренный рис"<br /></span><span title="●	традиційно готується тільки з італійського рису">● традиционно готовится только из итальянского риса</span></span></span></p>', 'ru', '2011-10-09 20:13:10'),
(83, '<p><span style="font-size: medium;"><span id="result_box" lang="en"><span title="Сеньор Помидор!"><br /></span><strong><span style="font-size: large;"><span title="Итальянская Пиццерия Сеньор Помидор">Italian Tomato Pizza Senor</span></span></strong></span></span></p>\r\n<p><span style="font-size: medium;"><span id="result_box" lang="en"><span title="Итальянская Пиццерия Сеньор Помидор"><br /></span><span title="Пиццерия ..."><strong>Pizza ...</strong><br /></span><span title="● популярное место, где есть возможность поесть, выпить, и самое важное - пообщаться, потому что в нашем ">●  popular place where it is possible to eat, drink, and most importantly -  to communicate, because in our "Tomato," a homely atmosphere. </span><span title="Поэтому даже если вы пришли сами - Вы не соскучишься, конечно, если Вам этого не захочется">So even if you came to do - you do not get bored, of course, if you do not want to<br /><br /></span><span title="Почему "><strong>Why "Senor Tomato"?</strong><br /></span><span title="● У итальянцев очень уважительное отношение к этому овощу.">● The Italians are very respectful to this vegetable. </span><span title="Большое количество блюд делается именно с добавлением к ним помидоров.">A large number of dishes is done with the addition of tomatoes. </span><span title="В этом случае нам надо брать пример с итальянцев, потому что это единственный овощ, который после тепловой обработки не теряет витамина С, который в свою очередь, помогает нашему организму вырабатывать вещество - серотонин, который еще называется гормоном ">In  this case, we must look to the Italians, because it is the only  vegetable that heat treatment does not lose vitamin C, which in turn  helps our bodies produce substances - serotonin, a hormone which is also  called "Happiness." </span><span title="И именно поэтому, в нашем ">And that is why, in our "Tomato" all so happy!<br /><br /></span><span title="Пицца"><strong>Pizza</strong><br /></span><span title="● Это символ Средиземноморья!">● This symbol Mediterranean! </span><span title="Легенда рассказывает, что пицца - это партенопський рецепт, который придумали в Неаполе в 1889 году.">Legend has it that the pizza - it partenopsky recipe that was invented in Naples in 1889. </span><span title="Первый раз была приготовлена Рафаэлем Эспозито в честь королевы Маргариты.">The first time was prepared by Raphael Esposito in honor of Queen Margherita. </span><span title="В принципе, чтобы удовлетворить ее Величество, он взял обычный кусок теста, сделав его тоненьким, круглой формы, потом добавил помидорный соус, вкусную моцареллу и несколько листиков базилика.">In  principle, to satisfy her Majesty, he took an ordinary piece of dough,  making it thin, round shape, then added tomato sauce, mozzarella and a  tasty basil leaves a few.<br /></span><span title="Отправил все в печь, и когда краешек приобрел золотистый цвет, еще горящей подал королю.">Posted by all in the oven, and when the edge of the acquired gold, still burning submitted to the king. </span><span title="Блюдо ей очень понравилось и она спросила у пекаря как называется этот тип хлеба.">The dish she really liked it and she asked the baker how is this type of bread. </span><span title="Он ответил: &laquo;О моя королева!">He replied, "Oh my queen! </span><span title="Этот необычный хлеб с моцареллой, помидором и базиликом воспроизводит цвета итальянского флага и в Вашу честь зовется &laquo;Пицца Маргарита&raquo;.">This  unusual bread with mozzarella, tomato and basil reproduces colors of  the Italian flag in your honor called the "Pizza Margherita." </span><span title="Так родилась пицца, которую со временем пекари и повара обогатили и другими ингредиентами.">Thus was born the pizza, which over time bakers and cooks have enriched and other ingredients.<br /></span><span title="● Философ Платон указывал на нее как на здоровую блюдо (и сейчас, диетологи рекомендуют ее как пищу легкую и ... радостную!)">● The philosopher Plato pointed to it as a healthy meal (and now, nutritionists recommend eating it as easy and happy ...!)<br /><br /></span><span title="Итальянская кухня"><strong>Italian Food</strong><br /></span><span title="● Может быть создана ТОЛЬКО итальянским шеф-поваром">● Can only be created by Italian chef<br /><br /></span><span title="Паста"><strong>Pasta</strong><br /></span><span title="● Это не только спагетти Карбонара и Болоньез">● This is not just spaghetti carbonara and Bolognese<br /></span><span title="● от нее не полнеют, и это не шутка, потому сложные углеводы усваиваются со временем, и поэтому не создают излишков энергии">●  do not get fat from it, and it''s not a joke, because complex  carbohydrates are assimilated over time, and therefore do not create a  surplus of energy<br /><br /></span><strong>"Al dente"</strong><br /><span title="● Это не ">● It is not "undercooked pasta", and properly cooked pasta<br /><br /></span><span title="Домашняя паста"><strong>Homemade pasta</strong><br /></span><span title="● предмет особой гордости ">● a source of pride "Senora Tomato"<br /></span><span title="● то, что надо попробовать в ">● what we should try to "Tomato"<br /></span><span title="● том, что вряд ли вы сумеете приготовить у себя дома">● that it is unlikely you will be able to cook at home<br /><br /></span><span title="Ризотто"><strong>Risotto</strong><br /></span><span title="● это снова, совсем не ">● it again, not "half-cooked rice ''<br /></span><span title="● традиционно готовится только из итальянского риса">● traditionally prepared only from an Italian rice</span></span></span></p>', 'en', '2011-10-09 20:14:11'),
(11, 'Nessuna pagina come', 'it', '2011-10-09 20:23:46'),
(83, '<p><span style="font-size: medium;"><span id="result_box" lang="it"><span title="Сеньор Помидор!"><br /></span><strong><span style="font-size: large;"><span title="Итальянская Пиццерия Сеньор Помидор">Pizza pomodoro italiano Senor</span></span></strong></span></span></p>\r\n<p><span style="font-size: medium;"><span id="result_box" lang="it"><span title="Итальянская Пиццерия Сеньор Помидор"><br /></span><span title="Пиццерия ..."><strong>Pizza ...</strong><br /></span><span title="● популярное место, где есть возможность поесть, выпить, и самое важное - пообщаться, потому что в нашем ">●  popolare luogo dove &egrave; possibile mangiare, bere, e soprattutto - di  comunicare, perch&eacute; nel nostro "Pomodoro", un ambiente familiare. </span><span title="Поэтому даже если вы пришли сами - Вы не соскучишься, конечно, если Вам этого не захочется">Quindi, anche se siete venuti a fare - non si annoia, naturalmente, se non si vuole<br /><br /></span><span title="Почему "><strong>Perch&eacute; "Senor pomodoro"?</strong><br /></span><span title="● У итальянцев очень уважительное отношение к этому овощу.">● Gli italiani sono molto rispettoso di questo ortaggio. </span><span title="Большое количество блюд делается именно с добавлением к ним помидоров.">Un gran numero di piatti &egrave; fatto con l''aggiunta di pomodori. </span><span title="В этом случае нам надо брать пример с итальянцев, потому что это единственный овощ, который после тепловой обработки не теряет витамина С, который в свою очередь, помогает нашему организму вырабатывать вещество - серотонин, который еще называется гормоном ">In  questo caso, dobbiamo guardare agli italiani, perch&eacute; &egrave; l''unico ortaggio  che il trattamento termico non perde la vitamina C, che a sua volta  aiuta il nostro organismo produce sostanze - ". Felicit&agrave;" serotonina, un  ormone che viene anche chiamata </span><span title="И именно поэтому, в нашем ">Ed &egrave; per questo, nel nostro "pomodoro" tutti cos&igrave; felice!<br /><br /></span><span title="Пицца"><strong>Pizza</strong><br /></span><span title="● Это символ Средиземноморья!">● Il simbolo del Mediterraneo! </span><span title="Легенда рассказывает, что пицца - это партенопський рецепт, который придумали в Неаполе в 1889 году.">La leggenda vuole che la pizza - ha partenopsky ricetta che &egrave; stata inventata a Napoli nel 1889. </span><span title="Первый раз была приготовлена Рафаэлем Эспозито в честь королевы Маргариты.">La prima volta &egrave; stata preparata da Raffaello Esposito in onore della regina Margherita. </span><span title="В принципе, чтобы удовлетворить ее Величество, он взял обычный кусок теста, сделав его тоненьким, круглой формы, потом добавил помидорный соус, вкусную моцареллу и несколько листиков базилика.">In  linea di principio, per soddisfare Sua Maest&agrave;, ha preso un normale  pezzo di pasta, rendendolo sottile, forma rotonda, salsa di pomodoro poi  aggiunto, mozzarella e basilico gustoso lascia pochi.<br /></span><span title="Отправил все в печь, и когда краешек приобрел золотистый цвет, еще горящей подал королю.">Inviato da tutti nel forno, e quando il bordo dell''oro acquisito, brucia ancora presentato al re. </span><span title="Блюдо ей очень понравилось и она спросила у пекаря как называется этот тип хлеба.">Il piatto che &egrave; piaciuto molto e lei ha chiesto al fornaio come &egrave; questo tipo di pane. </span><span title="Он ответил: &laquo;О моя королева!">Egli rispose: "Oh, mia regina! </span><span title="Этот необычный хлеб с моцареллой, помидором и базиликом воспроизводит цвета итальянского флага и в Вашу честь зовется &laquo;Пицца Маргарита&raquo;.">Questo  pane insolito con mozzarella, pomodoro e basilico riproduce i colori  della bandiera italiana in tuo onore chiamato "Pizza Margherita". </span><span title="Так родилась пицца, которую со временем пекари и повара обогатили и другими ингредиентами.">Cos&igrave; &egrave; nata la pizza, che nel tempo i panettieri ei cuochi hanno arricchito e altri ingredienti.<br /></span><span title="● Философ Платон указывал на нее как на здоровую блюдо (и сейчас, диетологи рекомендуют ее как пищу легкую и ... радостную!)">● Il filosofo Platone indicava come un pasto sano (e ora, nutrizionisti consigliano di mangiare il pi&ugrave; semplice e felice ...!)<br /><br /></span><span title="Итальянская кухня"><strong>Alimentare italiana</strong><br /></span><span title="● Может быть создана ТОЛЬКО итальянским шеф-поваром">● Possono essere creati solo da chef italiano<br /><br /></span><span title="Паста"><strong>Pasta</strong><br /></span><span title="● Это не только спагетти Карбонара и Болоньез">● Questo non &egrave; solo spaghetti alla carbonara e bolognese<br /></span><span title="● от нее не полнеют, и это не шутка, потому сложные углеводы усваиваются со временем, и поэтому не создают излишков энергии">●  non ingrassare da esso, e non &egrave; uno scherzo, perch&eacute; i carboidrati  complessi vengono assimilati nel corso del tempo, e quindi non si crea  un surplus di energia<br /><br /></span><strong>"Al dente"</strong><br /><span title="● Это не ">● Non &egrave; "pasta cotta", e la pasta cotta<br /><br /></span><span title="Домашняя паста"><strong>Pasta fatta in casa</strong><br /></span><span title="● предмет особой гордости ">● "Pomodoro Senora" una fonte di orgoglio<br /></span><span title="● то, что надо попробовать в ">● che cosa dovremmo cercare di "Pomodoro"<br /></span><span title="● том, что вряд ли вы сумеете приготовить у себя дома">● che &egrave; improbabile che sar&agrave; in grado di cucinare a casa<br /><br /></span><span title="Ризотто"><strong>Risotto</strong><br /></span><span title="● это снова, совсем не ">● di nuovo, non "a met&agrave; cottura il riso ''<br /></span><span title="● традиционно готовится только из итальянского риса">● tradizionalmente preparato solo da un riso italiano</span></span></span></p>', 'it', '2011-10-09 20:15:36'),
(11, 'Немає такої сторінки', 'ua', '2011-10-09 20:23:12'),
(83, '<p><span style="font-size: medium;"><span id="result_box" lang="uk"><span title="Сеньор Помидор!"><br /></span><span style="font-size: large;"><span title="Итальянская Пиццерия Сеньор Помидор">Італійська Піцерія Сеньйор Помідор</span></span></span></span></p>\r\n<p><span style="font-size: medium;"><span id="result_box" lang="uk"><span title="Итальянская Пиццерия Сеньор Помидор"><br /></span><span title="Пиццерия ..."><strong>Піцерія ...</strong><br /></span><span title="● популярное место, где есть возможность поесть, выпить, и самое важное - пообщаться, потому что в нашем ">●  популярне місце, де є можливість поїсти, випити, і найважливіше -  поспілкуватися, бо в нашому "Помідора" панує домашня атмосфера. </span><span title="Поэтому даже если вы пришли сами - Вы не соскучишься, конечно, если Вам этого не захочется">Тому навіть якщо ви прийшли самі - Ви не засумуєш, звичайно, якщо Вам цього не захочеться<br /><br /></span><span title="Почему "><strong>Чому "Сеньйор Помідор"?</strong><br /></span><span title="● У итальянцев очень уважительное отношение к этому овощу.">● У італійців дуже шанобливе ставлення до цього овочу. </span><span title="Большое количество блюд делается именно с добавлением к ним помидоров.">Велика кількість страв робиться саме з додаванням до них помідорів. </span><span title="В этом случае нам надо брать пример с итальянцев, потому что это единственный овощ, который после тепловой обработки не теряет витамина С, который в свою очередь, помогает нашему организму вырабатывать вещество - серотонин, который еще называется гормоном ">У  цьому випадку нам треба брати приклад з італійців, тому що це єдиний  овоч, який після теплової обробки не втрачає вітаміну С, який в свою  чергу, допомагає нашому організму виробляти речовину - серотонін, який  ще називається гормоном "щастя". </span><span title="И именно поэтому, в нашем ">І саме тому, в нашому "Помідора" всі такі щасливі!<br /><br /></span><span title="Пицца"><strong>Піца</strong><br /></span><span title="● Это символ Средиземноморья!">● Це символ Середземномор''я! </span><span title="Легенда рассказывает, что пицца - это партенопський рецепт, который придумали в Неаполе в 1889 году.">Легенда розповідає, що піца - це партенопській рецепт, який придумали в Неаполі в 1889 році. </span><span title="Первый раз была приготовлена Рафаэлем Эспозито в честь королевы Маргариты.">Перший раз була приготовлена ​​Рафаелем Еспозіто на честь королеви Маргарити. </span><span title="В принципе, чтобы удовлетворить ее Величество, он взял обычный кусок теста, сделав его тоненьким, круглой формы, потом добавил помидорный соус, вкусную моцареллу и несколько листиков базилика.">В  принципі, щоб задовольнити її Величність, він узяв звичайний шматок  тіста, зробивши його тоненьким, круглої форми, потім додав помідорний  соус, смачну моцарелу і кілька листочків базиліка.<br /></span><span title="Отправил все в печь, и когда краешек приобрел золотистый цвет, еще горящей подал королю.">Відправив все в піч, і коли краєчок придбав золотистий колір, ще палаючої подав королю. </span><span title="Блюдо ей очень понравилось и она спросила у пекаря как называется этот тип хлеба.">Блюдо їй дуже сподобалося і вона запитала в пекаря як називається цей тип хліба. </span><span title="Он ответил: &laquo;О моя королева!">Він відповів: &laquo;О моя королева! </span><span title="Этот необычный хлеб с моцареллой, помидором и базиликом воспроизводит цвета итальянского флага и в Вашу честь зовется &laquo;Пицца Маргарита&raquo;.">Цей  незвичайний хліб з моцарелою, помідором і базиліком відтворює кольори  італійського прапора і на Вашу честь зветься &laquo;Піца Маргарита&raquo;. </span><span title="Так родилась пицца, которую со временем пекари и повара обогатили и другими ингредиентами.">Так народилася піца, яку з часом пекарі та кухарі збагатили і іншими інгредієнтами.<br /></span><span title="● Философ Платон указывал на нее как на здоровую блюдо (и сейчас, диетологи рекомендуют ее как пищу легкую и ... радостную!)">● Філософ Платон вказував на неї як на здорову блюдо (і зараз, дієтологи рекомендують її як їжу легку і ... радісну!)<br /><br /></span><span title="Итальянская кухня"><strong>Італійська кухня</strong><br /></span><span title="● Может быть создана ТОЛЬКО итальянским шеф-поваром">● Може бути створена ТІЛЬКИ італійським шеф-кухарем<br /><br /></span><span title="Паста"><strong>Паста</strong><br /></span><span title="● Это не только спагетти Карбонара и Болоньез">● Це не тільки спагетті Карбонара і Болоньез<br /></span><span title="● от нее не полнеют, и это не шутка, потому сложные углеводы усваиваются со временем, и поэтому не создают излишков энергии">● від неї не повніють, і це не жарт, тому складні вуглеводи засвоюються з часом, і тому не створюють надлишків енергії<br /><br /></span><strong>"Аль денте"</strong><br /><span title="● Это не ">● Це не "недоварені макарони", а правильно приготована паста<br /><br /></span><span title="Домашняя паста"><strong>Домашня паста</strong><br /></span><span title="● предмет особой гордости ">● предмет особливої ​​гордості "Сеньйора Помідора"<br /></span><span title="● то, что надо попробовать в ">● те, що треба спробувати в "Помідора"<br /></span><span title="● том, что вряд ли вы сумеете приготовить у себя дома">● те, що навряд чи ви зумієте приготувати у себе вдома<br /><br /></span><span title="Ризотто"><strong>Різотто</strong><br /></span><span title="● это снова, совсем не ">● це знову, зовсім не "недоварений рис"<br /></span><span title="● традиционно готовится только из итальянского риса">● традиційно готується тільки з італійського рису</span></span></span></p>', 'ua', '2011-10-09 20:16:33'),
(50, 'ulteriormente', 'it', '2011-10-09 20:21:31'),
(50, 'далі', 'ua', '2011-10-09 20:21:59'),
(1, 'e-mail. posta', 'it', '2011-10-09 20:24:41'),
(1, 'ел. пошта', 'ua', '2011-10-09 20:25:02'),
(2, 'Повідомлення', 'ua', '2011-10-09 20:25:43'),
(2, 'Messaggio', 'it', '2011-10-09 20:26:07'),
(3, 'Aggiungere', 'it', '0000-00-00 00:00:00'),
(3, 'Aggiungere', 'it', '2011-09-10 00:00:00'),
(3, 'Додати', 'ua', '2011-10-09 20:27:17'),
(4, 'коментар доданий', 'ua', '2011-10-09 20:27:55'),
(4, 'Commento aggiunto', 'it', '2011-10-09 20:28:25'),
(5, 'Inserisci il testo da un''immagine', 'it', '2011-10-09 20:21:31'),
(5, 'Введіть текст з малюнка', 'ua', '2011-10-09 20:21:31'),
(6, 'Відповідь на сообшеніе', 'ua', '2011-10-09 20:21:31'),
(6, 'Risposta a tuo messaggio', 'it', '2011-10-09 20:21:31');
=======
(67, 'tag', 'ua', '2011-10-05 15:58:35'),
(68, 'logo', 'ru', '2011-10-08 13:48:18'),
(68, 'logo', 'en', '2011-10-08 13:48:18'),
(68, 'logo', 'it', '2011-10-08 13:48:18'),
(68, 'logo', 'ua', '2011-10-08 13:48:18'),
(69, '<p>logo</p>', 'ru', '2011-10-08 13:48:18'),
(69, '<p>logo</p>', 'en', '2011-10-08 13:48:18'),
(69, '<p>logo</p>', 'it', '2011-10-08 13:48:18'),
(69, '<p>logo</p>', 'ua', '2011-10-08 13:48:18'),
(70, 'mini logo', 'ru', '2011-10-08 13:49:26'),
(70, 'mini logo', 'en', '2011-10-08 13:49:26'),
(70, 'mini logo', 'it', '2011-10-08 13:49:26'),
(70, 'mini logo', 'ua', '2011-10-08 13:49:26'),
(71, '<p>mini logo</p>', 'ru', '2011-10-08 13:49:26'),
(71, '<p>mini logo</p>', 'en', '2011-10-08 13:49:26'),
(71, '<p>mini logo</p>', 'it', '2011-10-08 13:49:26'),
(71, '<p>mini logo</p>', 'ua', '2011-10-08 13:49:26'),
(72, 'О нас', 'ru', '2011-10-08 13:57:46'),
(72, 'About Us', 'en', '2011-10-08 13:57:46'),
(72, 'Chi siamo', 'it', '2011-10-08 13:57:46'),
(72, 'Про нас', 'ua', '2011-10-08 13:57:46'),
(73, 'О нас', 'ru', '2011-10-08 13:57:46'),
(73, 'About Us', 'en', '2011-10-08 13:57:46'),
(73, 'Chi siamo', 'it', '2011-10-08 13:57:46'),
(73, 'Про нас', 'ua', '2011-10-08 13:57:46'),
(74, 'О нас - На этой странице вы найдете общую информацию о нашей пиццерии, ее историю создания и философию', 'ru', '2011-10-08 13:57:46'),
(74, 'On this page you will find general information about our pizza, its history and philosophy of creating', 'en', '2011-10-08 13:57:46'),
(74, 'In questa pagina troverete informazioni generali sulla nostra pizza, la sua storia e la filosofia di creare', 'it', '2011-10-08 13:57:46'),
(74, 'На цій сторінці ви знайдете загальну інформацію про нашу піцерії, її історію створення та філософію', 'ua', '2011-10-08 13:57:46'),
(75, 'tag', 'ru', '2011-10-08 13:57:46'),
(75, 'tag', 'en', '2011-10-08 13:57:46'),
(75, 'tag', 'it', '2011-10-08 13:57:46'),
(75, 'tag', 'ua', '2011-10-08 13:57:46'),
(76, 'О нас', 'ru', '2011-10-08 14:03:27'),
(76, 'About Us', 'en', '2011-10-08 14:03:27'),
(76, 'Chi siamo', 'it', '2011-10-08 14:03:27'),
(76, 'Про нас', 'ua', '2011-10-08 14:03:27'),
(77, '<p><span id="result_box" lang="ru"><span style="background-color: #ebeff9;" title="Сеньйор Помідор!!!">Сеньор Помидор!<br /></span><span title="Італійська Піцерія Сеньйор Помідор">Итальянская Пиццерия Сеньор Помидор<br /></span><span title="Піцерія...">Пиццерия ...<br /></span><span title="●	популярне місце, де є можливість поїсти, випити, та найважливіше - поспілкуватись, бо в нашому &bdquo;Помідорі&rdquo; панує домашня атмосфера.">●  популярное место, где есть возможность поесть, выпить, и самое важное -  пообщаться, потому что в нашем "Помидора" царит домашняя атмосфера. </span><span title="Тому навіть якщо Ви прийшли самі - Ви не засумуєте, звісно, якщо Вам цього не захочеться">Поэтому даже если вы пришли сами - Вы не соскучишься, конечно, если Вам этого не захочется<br /><br /></span><span title="Чому &bdquo;Сеньйор Помідор&rdquo;?">Почему "Сеньор Помидор"?<br /></span><span title="●	У італійців дуже поважне ставлення до цього овочу.">● У итальянцев очень уважительное отношение к этому овощу. </span><span title="Велика кількість страв робиться саме з додаванням до них помідорів.">Большое количество блюд делается именно с добавлением к ним помидоров. </span><span title="У цьому випадку нам треба брати приклад з італійців, бо це єдиний овоч, який після теплової обробки не втрачає вітаміну С, який в свою чергу, допомагає нашому організму виробляти речовину &ndash; серотонін, яка ще називається гормоном &bdquo;щастя&rdquo;.">В  этом случае нам надо брать пример с итальянцев, потому что это  единственный овощ, который после тепловой обработки не теряет витамина  С, который в свою очередь, помогает нашему организму вырабатывать  вещество - серотонин, который еще называется гормоном "счастья". </span><span title="І саме тому, в нашому &bdquo;Помідорі&rdquo; усі такі щасливі!">И именно поэтому, в нашем "Помидора" все такие счастливые!<br /><br /></span><span title="Піца">Пицца<br /></span><span title="●	Це символ Середземномор`я!">● Это символ Средиземноморья! </span><span title="Легенда розповідає, що піца &ndash; це партенопський рецепт, який вигадали у Неаполі у 1889 році.">Легенда рассказывает, что пицца - это партенопський рецепт, который придумали в Неаполе в 1889 году. </span><span title="Перший раз була приготовлена Рафаелем Еспозіто на честь королеви Маргарити.">Первый раз была приготовлена ​​Рафаэлем Эспозито в честь королевы Маргариты. </span><span title="В принципі, щоб задовольнити її Величність, він взяв звичайний шматок тіста, зробивши його тоненьким, круглої форми, потім додав помідорний соус, смачну моцареллу та декілька листиків базиліка.">В  принципе, чтобы удовлетворить ее Величество, он взял обычный кусок  теста, сделав его тоненьким, круглой формы, потом добавил помидорный  соус, вкусную моцареллу и несколько листиков базилика.<br /></span><span title="Відправив все у піч, і коли краєчок набув золотистого кольору, ще палаючою подав королеві.">Отправил все в печь, и когда краешек приобрел золотистый цвет, еще горящей подал королю. </span><span title="Блюдо їй дуже сподобалось і вона спитала у пекаря як зветься цей тип хліба.">Блюдо ей очень понравилось и она спросила у пекаря как называется этот тип хлеба. </span><span title="Він відповів: &laquo;О моя королева!">Он ответил: &laquo;О моя королева! </span><span title="Цей незвичайний хліб з моцареллою, помідором та базиліком відтворює кольори італійського прапору і на Вашу честь зветься &laquo;Піца Маргарита&raquo;.">Этот  необычный хлеб с моцареллой, помидором и базиликом воспроизводит цвета  итальянского флага и в Вашу честь зовется &laquo;Пицца Маргарита&raquo;. </span><span title="Так народилася піца, яку з часом пекарі та кухарі збагатили й іншими інгредієнтами.">Так родилась пицца, которую со временем пекари и повара обогатили и другими ингредиентами.<br /></span><span title="●	Філософ Платон вказував на неї як на здорову страву ( і зараз, дієтологи рекомендують її як їжу легку та ...радісну!)">● Философ Платон указывал на нее как на здоровую блюдо (и сейчас, диетологи рекомендуют ее как пищу легкую и ... радостную!)<br /><br /></span><span title="Італійська кухня">Итальянская кухня<br /></span><span title="●	Може бути створена ТІЛЬКИ італійським шеф-кухарем">● Может быть создана ТОЛЬКО итальянским шеф-поваром<br /><br /></span><span title="Паста">Паста<br /></span><span title="●	Це не тільки спагеті Карбонара та Болоньєз">● Это не только спагетти Карбонара и Болоньез<br /></span><span title="●	від неї не повнішають, і це не жарт, бо складні вуглеводи засвоюються з часом, і тому не створюють надлишків енергії">● от нее не полнеют, и это не шутка, потому сложные углеводы усваиваются со временем, и поэтому не создают излишков энергии<br /><br /></span><span title="&bdquo;Аль денте&rdquo;">"Аль денте"<br /></span><span title="●	Це не &bdquo;недоварені макарони&rdquo;, а правильно приготована паста">● Это не "недоваренные макароны", а правильно приготовленная паста<br /><br /></span><span title="Домашня паста">Домашняя паста<br /></span><span title="●	предмет особливої гордості &bdquo;Сеньйора Помідора&rdquo;">● предмет особой гордости "Сеньора Помидора"<br /></span><span title="●	те, що треба спробувати у &bdquo;Помідорі&rdquo;">● то, что надо попробовать в "Помидора"<br /></span><span title="●	те, що навряд чи Ви зумієте приготувати у себе вдома">● том, что вряд ли вы сумеете приготовить у себя дома<br /><br /></span><span title="Різотто">Ризотто<br /></span><span title="●	це знову, зовсім не &bdquo;недоварений рис&rdquo;">● это снова, совсем не "недоваренный рис"<br /></span><span title="●	традиційно готується тільки з італійського рису">● традиционно готовится только из итальянского риса</span></span></p>', 'ru', '2011-10-08 14:03:27'),
(77, '<p><span id="result_box" lang="en"><span title="Сеньор Помидор!">Senor Tomato!<br /></span><span title="Итальянская Пиццерия Сеньор Помидор">Italian Tomato Pizza Senor<br /></span><span title="Пиццерия ...">Pizza ...<br /></span><span title="● популярное место, где есть возможность поесть, выпить, и самое важное - пообщаться, потому что в нашем &quot;Помидора&quot; царит домашняя атмосфера.">●  popular place where it is possible to eat, drink, and most importantly -  to communicate, because in our "Tomato," a homely atmosphere. </span><span title="Поэтому даже если вы пришли сами - Вы не соскучишься, конечно, если Вам этого не захочется">So even if you came to do - you do not get bored, of course, if you do not want to<br /><br /></span><span title="Почему &quot;Сеньор Помидор&quot;?">Why "Senor Tomato"?<br /></span><span title="● У итальянцев очень уважительное отношение к этому овощу.">● The Italians are very respectful to this vegetable. </span><span title="Большое количество блюд делается именно с добавлением к ним помидоров.">A large number of dishes is done with the addition of tomatoes. </span><span title="В этом случае нам надо брать пример с итальянцев, потому что это единственный овощ, который после тепловой обработки не теряет витамина С, который в свою очередь, помогает нашему организму вырабатывать вещество - серотонин, который еще называется гормоном &quot;счастья&quot;.">In  this case, we must look to the Italians, because it is the only  vegetable that heat treatment does not lose vitamin C, which in turn  helps our bodies produce substances - serotonin, a hormone which is also  called "Happiness." </span><span title="И именно поэтому, в нашем &quot;Помидора&quot; все такие счастливые!">And that is why, in our "Tomato" all so happy!<br /><br /></span><span title="Пицца">Pizza<br /></span><span title="● Это символ Средиземноморья!">● This symbol Mediterranean! </span><span title="Легенда рассказывает, что пицца - это партенопський рецепт, который придумали в Неаполе в 1889 году.">Legend has it that the pizza - it partenopsky recipe that was invented in Naples in 1889. </span><span title="Первый раз была приготовлена Рафаэлем Эспозито в честь королевы Маргариты.">The first time was prepared by Raphael Esposito in honor of Queen Margherita. </span><span title="В принципе, чтобы удовлетворить ее Величество, он взял обычный кусок теста, сделав его тоненьким, круглой формы, потом добавил помидорный соус, вкусную моцареллу и несколько листиков базилика.">In  principle, to satisfy her Majesty, he took an ordinary piece of dough,  making it thin, round shape, then added tomato sauce, mozzarella and a  tasty basil leaves a few.<br /></span><span title="Отправил все в печь, и когда краешек приобрел золотистый цвет, еще горящей подал королю.">Posted by all in the oven, and when the edge of the acquired gold, still burning submitted to the king. </span><span title="Блюдо ей очень понравилось и она спросила у пекаря как называется этот тип хлеба.">The dish she really liked it and she asked the baker how is this type of bread. </span><span title="Он ответил: &laquo;О моя королева!">He replied, "Oh my queen! </span><span title="Этот необычный хлеб с моцареллой, помидором и базиликом воспроизводит цвета итальянского флага и в Вашу честь зовется &laquo;Пицца Маргарита&raquo;.">This  unusual bread with mozzarella, tomato and basil reproduces colors of  the Italian flag in your honor called the "Pizza Margherita." </span><span title="Так родилась пицца, которую со временем пекари и повара обогатили и другими ингредиентами.">Thus was born the pizza, which over time bakers and cooks have enriched and other ingredients.<br /></span><span title="● Философ Платон указывал на нее как на здоровую блюдо (и сейчас, диетологи рекомендуют ее как пищу легкую и ... радостную!)">● The philosopher Plato pointed to it as a healthy meal (and now, nutritionists recommend eating it as easy and happy ...!)<br /><br /></span><span title="Итальянская кухня">Italian Food<br /></span><span title="● Может быть создана ТОЛЬКО итальянским шеф-поваром">● Can only be created by Italian chef<br /><br /></span><span title="Паста">Pasta<br /></span><span title="● Это не только спагетти Карбонара и Болоньез">● This is not just spaghetti carbonara and Bolognese<br /></span><span title="● от нее не полнеют, и это не шутка, потому сложные углеводы усваиваются со временем, и поэтому не создают излишков энергии">●  do not get fat from it, and it''s not a joke, because complex  carbohydrates are assimilated over time, and therefore do not create a  surplus of energy<br /><br /></span><span title="&quot;Аль денте&quot;">"Al dente"<br /></span><span title="● Это не &quot;недоваренные макароны&quot;, а правильно приготовленная паста">● It is not "undercooked pasta", and properly cooked pasta<br /><br /></span><span title="Домашняя паста">Homemade pasta<br /></span><span title="● предмет особой гордости &quot;Сеньора Помидора&quot;">● a source of pride "Senora Tomato"<br /></span><span title="● то, что надо попробовать в &quot;Помидора&quot;">● what we should try to "Tomato"<br /></span><span title="● том, что вряд ли вы сумеете приготовить у себя дома">● that it is unlikely you will be able to cook at home<br /><br /></span><span title="Ризотто">Risotto<br /></span><span title="● это снова, совсем не &quot;недоваренный рис&quot;">● it again, not "half-cooked rice ''<br /></span><span title="● традиционно готовится только из итальянского риса">● traditionally prepared only from an Italian rice</span></span></p>', 'en', '2011-10-08 14:03:27'),
(77, '<p><span id="result_box"><span style="background-color: #ffffff;" title="Сеньор Помидор!">Pomodoro Senor! <br /></span><span style="background-color: #ffffff;" title="Итальянская Пиццерия Сеньор Помидор">Pizza pomodoro italiano Senor <br /></span><span style="background-color: #ffffff;" title="Пиццерия ...">Pizza ... <br /></span><span style="background-color: #ffffff;" title="● популярное место, где есть возможность поесть, выпить, и самое важное - пообщаться, потому что в нашем &quot;Помидора&quot; царит домашняя атмосфера.">●  popolare luogo dove &egrave; possibile mangiare, bere, e soprattutto - di  comunicare, perch&eacute; nel nostro "Pomodoro", un ambiente familiare. </span><span title="Поэтому даже если вы пришли сами - Вы не соскучишься, конечно, если Вам этого не захочется">Quindi, anche se siete venuti a fare - non si annoia, naturalmente, se non si vuole <br /> <br /></span><span style="background-color: #ffffff;" title="Почему &quot;Сеньор Помидор&quot;?">Perch&eacute; "Senor pomodoro"? <br /></span><span style="background-color: #ffffff;" title="● У итальянцев очень уважительное отношение к этому овощу.">● Gli italiani sono molto rispettoso di questo ortaggio. </span><span title="Большое количество блюд делается именно с добавлением к ним помидоров.">Un gran numero di piatti &egrave; fatto con l''aggiunta di pomodori. </span><span style="background-color: #ffffff;" title="В этом случае нам надо брать пример с итальянцев, потому что это единственный овощ, который после тепловой обработки не теряет витамина С, который в свою очередь, помогает нашему организму вырабатывать вещество - серотонин, который еще называется гормоном &quot;счастья&quot;.">In  questo caso, dobbiamo guardare agli italiani, perch&eacute; &egrave; l''unico ortaggio  che il trattamento termico non perde la vitamina C, che a sua volta  aiuta il nostro organismo produce sostanze - ". Felicit&agrave;" serotonina, un  ormone che viene anche chiamata </span><span title="И именно поэтому, в нашем &quot;Помидора&quot; все такие счастливые!">Ed &egrave; per questo, nel nostro "pomodoro" tutti cos&igrave; felice! <br /> <br /></span><span title="Пицца">Pizza <br /></span><span title="● Это символ Средиземноморья!">● Il simbolo del Mediterraneo! </span><span style="background-color: #ffffff;" title="Легенда рассказывает, что пицца - это партенопський рецепт, который придумали в Неаполе в 1889 году.">La leggenda vuole che la pizza - ha partenopsky ricetta che &egrave; stata inventata a Napoli nel 1889. </span><span title="Первый раз была приготовлена Рафаэлем Эспозито в честь королевы Маргариты.">La prima volta &egrave; stata preparata da Raffaello Esposito in onore della regina Margherita. </span><span title="В принципе, чтобы удовлетворить ее Величество, он взял обычный кусок теста, сделав его тоненьким, круглой формы, потом добавил помидорный соус, вкусную моцареллу и несколько листиков базилика.">In  linea di principio, per soddisfare Sua Maest&agrave;, ha preso un normale  pezzo di pasta, rendendolo sottile, forma rotonda, salsa di pomodoro poi  aggiunto, mozzarella e basilico gustoso lascia pochi. <br /></span><span title="Отправил все в печь, и когда краешек приобрел золотистый цвет, еще горящей подал королю.">Inviato da tutti nel forno, e quando il bordo dell''oro acquisito, brucia ancora presentato al re. </span><span title="Блюдо ей очень понравилось и она спросила у пекаря как называется этот тип хлеба.">Il piatto che &egrave; piaciuto molto e lei ha chiesto al fornaio come &egrave; questo tipo di pane. </span><span title="Он ответил: &laquo;О моя королева!">Egli rispose: "Oh, mia regina! </span><span title="Этот необычный хлеб с моцареллой, помидором и базиликом воспроизводит цвета итальянского флага и в Вашу честь зовется &laquo;Пицца Маргарита&raquo;.">Questo  pane insolito con mozzarella, pomodoro e basilico riproduce i colori  della bandiera italiana in tuo onore chiamato "Pizza Margherita". </span><span title="Так родилась пицца, которую со временем пекари и повара обогатили и другими ингредиентами.">Cos&igrave; &egrave; nata la pizza, che nel tempo i panettieri ei cuochi hanno arricchito e altri ingredienti. <br /></span><span title="● Философ Платон указывал на нее как на здоровую блюдо (и сейчас, диетологи рекомендуют ее как пищу легкую и ... радостную!)">● Il filosofo Platone indicava come un pasto sano (e ora, nutrizionisti consigliano di mangiare il pi&ugrave; semplice e felice ...!) <br /> <br /></span><span title="Итальянская кухня">Alimentare italiana <br /></span><span title="● Может быть создана ТОЛЬКО итальянским шеф-поваром">● Possono essere creati solo da chef italiano <br /> <br /></span><span style="background-color: #ffffff;" title="Паста">Pasta <br /></span><span title="● Это не только спагетти Карбонара и Болоньез">● Questo non &egrave; solo spaghetti alla carbonara e bolognese <br /></span><span style="background-color: #ffffff;" title="● от нее не полнеют, и это не шутка, потому сложные углеводы усваиваются со временем, и поэтому не создают излишков энергии">●  non ingrassare da esso, e non &egrave; uno scherzo, perch&eacute; i carboidrati  complessi vengono assimilati nel corso del tempo, e quindi non si crea  un surplus di energia <br /> <br /></span><span title="&quot;Аль денте&quot;">"Al dente" <br /></span><span style="background-color: #ffffff;" title="● Это не &quot;недоваренные макароны&quot;, а правильно приготовленная паста">● Non &egrave; "pasta cotta", e la pasta cotta <br /> <br /></span><span title="Домашняя паста">Pasta fatta in casa <br /></span><span style="background-color: #ffffff;" title="● предмет особой гордости &quot;Сеньора Помидора&quot;">● "Pomodoro Senora" una fonte di orgoglio <br /></span><span style="background-color: #ffffff;" title="● то, что надо попробовать в &quot;Помидора&quot;">● che cosa dovremmo cercare di "Pomodoro" <br /></span><span style="background-color: #ffffff;" title="● том, что вряд ли вы сумеете приготовить у себя дома">● che &egrave; improbabile che sar&agrave; in grado di cucinare a casa <br /> <br /></span><span title="Ризотто">Risotto <br /></span><span title="● это снова, совсем не &quot;недоваренный рис&quot;">● di nuovo, non "a met&agrave; cottura il riso '' <br /></span><span style="background-color: #ffffff;" title="● традиционно готовится только из итальянского риса">● tradizionalmente preparato solo da un riso italiano</span></span></p>', 'it', '2011-10-08 14:03:27'),
(77, '<p><span id="result_box" lang="uk"><span title="Сеньор Помидор!">Сеньйор Помідор!<br /></span><span title="Итальянская Пиццерия Сеньор Помидор">Італійська Піцерія Сеньйор Помідор<br /></span><span title="Пиццерия ...">Піцерія ...<br /></span><span title="● популярное место, где есть возможность поесть, выпить, и самое важное - пообщаться, потому что в нашем &quot;Помидора&quot; царит домашняя атмосфера.">●  популярне місце, де є можливість поїсти, випити, і найважливіше -  поспілкуватися, бо в нашому "Помідора" панує домашня атмосфера. </span><span title="Поэтому даже если вы пришли сами - Вы не соскучишься, конечно, если Вам этого не захочется">Тому навіть якщо ви прийшли самі - Ви не засумуєш, звичайно, якщо Вам цього не захочеться<br /><br /></span><span title="Почему &quot;Сеньор Помидор&quot;?">Чому "Сеньйор Помідор"?<br /></span><span title="● У итальянцев очень уважительное отношение к этому овощу.">● У італійців дуже шанобливе ставлення до цього овочу. </span><span title="Большое количество блюд делается именно с добавлением к ним помидоров.">Велика кількість страв робиться саме з додаванням до них помідорів. </span><span title="В этом случае нам надо брать пример с итальянцев, потому что это единственный овощ, который после тепловой обработки не теряет витамина С, который в свою очередь, помогает нашему организму вырабатывать вещество - серотонин, который еще называется гормоном &quot;счастья&quot;.">У  цьому випадку нам треба брати приклад з італійців, тому що це єдиний  овоч, який після теплової обробки не втрачає вітаміну С, який в свою  чергу, допомагає нашому організму виробляти речовину - серотонін, який  ще називається гормоном "щастя". </span><span title="И именно поэтому, в нашем &quot;Помидора&quot; все такие счастливые!">І саме тому, в нашому "Помідора" всі такі щасливі!<br /><br /></span><span title="Пицца">Піца<br /></span><span title="● Это символ Средиземноморья!">● Це символ Середземномор''я! </span><span title="Легенда рассказывает, что пицца - это партенопський рецепт, который придумали в Неаполе в 1889 году.">Легенда розповідає, що піца - це партенопській рецепт, який придумали в Неаполі в 1889 році. </span><span title="Первый раз была приготовлена Рафаэлем Эспозито в честь королевы Маргариты.">Перший раз була приготовлена ​​Рафаелем Еспозіто на честь королеви Маргарити. </span><span title="В принципе, чтобы удовлетворить ее Величество, он взял обычный кусок теста, сделав его тоненьким, круглой формы, потом добавил помидорный соус, вкусную моцареллу и несколько листиков базилика.">В  принципі, щоб задовольнити її Величність, він узяв звичайний шматок  тіста, зробивши його тоненьким, круглої форми, потім додав помідорний  соус, смачну моцарелу і кілька листочків базиліка.<br /></span><span title="Отправил все в печь, и когда краешек приобрел золотистый цвет, еще горящей подал королю.">Відправив все в піч, і коли краєчок придбав золотистий колір, ще палаючої подав королю. </span><span title="Блюдо ей очень понравилось и она спросила у пекаря как называется этот тип хлеба.">Блюдо їй дуже сподобалося і вона запитала в пекаря як називається цей тип хліба. </span><span title="Он ответил: &laquo;О моя королева!">Він відповів: &laquo;О моя королева! </span><span title="Этот необычный хлеб с моцареллой, помидором и базиликом воспроизводит цвета итальянского флага и в Вашу честь зовется &laquo;Пицца Маргарита&raquo;.">Цей  незвичайний хліб з моцарелою, помідором і базиліком відтворює кольори  італійського прапора і на Вашу честь зветься &laquo;Піца Маргарита&raquo;. </span><span title="Так родилась пицца, которую со временем пекари и повара обогатили и другими ингредиентами.">Так народилася піца, яку з часом пекарі та кухарі збагатили і іншими інгредієнтами.<br /></span><span title="● Философ Платон указывал на нее как на здоровую блюдо (и сейчас, диетологи рекомендуют ее как пищу легкую и ... радостную!)">● Філософ Платон вказував на неї як на здорову блюдо (і зараз, дієтологи рекомендують її як їжу легку і ... радісну!)<br /><br /></span><span title="Итальянская кухня">Італійська кухня<br /></span><span title="● Может быть создана ТОЛЬКО итальянским шеф-поваром">● Може бути створена ТІЛЬКИ італійським шеф-кухарем<br /><br /></span><span title="Паста">Паста<br /></span><span title="● Это не только спагетти Карбонара и Болоньез">● Це не тільки спагетті Карбонара і Болоньез<br /></span><span title="● от нее не полнеют, и это не шутка, потому сложные углеводы усваиваются со временем, и поэтому не создают излишков энергии">● від неї не повніють, і це не жарт, тому складні вуглеводи засвоюються з часом, і тому не створюють надлишків енергії<br /><br /></span><span title="&quot;Аль денте&quot;">"Аль денте"<br /></span><span title="● Это не &quot;недоваренные макароны&quot;, а правильно приготовленная паста">● Це не "недоварені макарони", а правильно приготована паста<br /><br /></span><span title="Домашняя паста">Домашня паста<br /></span><span title="● предмет особой гордости &quot;Сеньора Помидора&quot;">● предмет особливої ​​гордості "Сеньйора Помідора"<br /></span><span title="● то, что надо попробовать в &quot;Помидора&quot;">● те, що треба спробувати в "Помідора"<br /></span><span title="● том, что вряд ли вы сумеете приготовить у себя дома">● те, що навряд чи ви зумієте приготувати у себе вдома<br /><br /></span><span title="Ризотто">Різотто<br /></span><span title="● это снова, совсем не &quot;недоваренный рис&quot;">● це знову, зовсім не "недоварений рис"<br /></span><span title="● традиционно готовится только из итальянского риса">● традиційно готується тільки з італійського рису</span></span></p>', 'ua', '2011-10-08 14:03:27');
>>>>>>> .r33

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `invert_sc`
--

INSERT INTO `invert_sc` (`id`, `iddoc`, `lft`, `rgt`, `ns_tree`, `idint`) VALUES
(4, 8, 0, 0, 1, NULL);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `lang`
--

INSERT INTO `lang` (`id`, `name`, `alias`, `default_lang`) VALUES
(1, 'ru', 'Русский', 'true'),
(2, 'en', 'English', ''),
(3, 'it', 'Italiano', ''),
(4, 'ua', 'Український', '');

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
(24, 'map', 'show', 0, 'map_sc', '', 'Карта сайта', 'Создает карту сайта', '1', 8, 0, '0', '1', '1', 1, 0, 1, ''),
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `body`, `title`, `shortdescr`, `date`, `id_doc`) VALUES
(1, 82, 80, 81, '2011-10-02', 2),
(2, 63, 61, 62, '2011-10-05', 5);

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
  `sch_n` int(11) NOT NULL DEFAULT '0',
  `prew_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `father_id` (`father_id`),
  KEY `module` (`module`)
<<<<<<< .mine
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;
=======
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;
>>>>>>> .r33

--
-- Dumping data for table `ns_doc`
--

<<<<<<< .mine
INSERT INTO `ns_doc` (`id`, `date`, `father_id`, `show_me`, `module`, `side_for_doc`, `children_id`, `mod_order`, `mod_group`, `mod_options`, `sch`, `types`, `sch_n`, `prew_id`) VALUES
(1, '2011-10-05 15:12:46', 1, 1, 'lang', 'module', 0, '', 0, 0, 1, '', 0, 0),
(2, '2011-10-05 15:13:07', 1, 1, 'tree', 'module', 0, '', 0, 0, 1, '', 0, 0),
(3, '2011-10-05 15:38:49', 1, 1, 'tags', 'module', 0, '', 0, 0, 0, '', 0, 0),
(7, '2011-10-08 22:49:05', 1, 1, 'dv', 'logo', 0, '', 0, 0, 0, '', 0, 0),
(5, '2011-10-05 15:54:17', 2, 1, 'news', 'body', 0, '', 0, 0, 0, '', 0, 0),
(6, '2011-10-05 15:58:35', 2, 1, 'tags', 'module', 0, '', 0, 0, 0, '', 0, 0),
(8, '2011-10-08 23:33:07', 1, 1, 'dv', 'mini_logo', 0, '', 0, 0, 1, '', 0, 0),
(9, '2011-10-09 19:42:18', 5, 1, 'tags', 'module', 0, '', 0, 0, 0, '', 0, 0),
(10, '2011-10-09 19:46:06', 5, 1, 'dv', 'body', 0, '', 0, 0, 0, '', 0, 0),
(11, '2011-10-09 00:00:00', 6, 1, 'comment', 'body', 0, 'comm', 0, 0, 0, 'form', 0, 0),
(12, '2011-10-09 20:00:04', 4, 1, 'tags', 'module', 0, '', 0, 0, 0, '', 0, 0),
(13, '2011-10-09 20:10:38', 4, 1, 'dv', 'body', 0, '', 0, 0, 0, '', 0, 0);
=======
INSERT INTO `ns_doc` (`id`, `date`, `father_id`, `show_me`, `module`, `side_for_doc`, `children_id`, `mod_order`, `mod_group`, `mod_options`, `sch`, `types`, `sch_n`, `prew_id`) VALUES
(1, '2011-10-05 15:12:46', 1, 1, 'lang', 'module', 0, '', 0, 0, 1, '', 0, 0),
(2, '2011-10-05 15:13:07', 1, 1, 'tree', 'module', 0, '', 0, 0, 1, '', 0, 0),
(3, '2011-10-05 15:38:49', 1, 1, 'tags', 'module', 0, '', 0, 0, 0, '', 0, 0),
(7, '2011-10-08 13:48:18', 1, 1, 'dv', 'logo', 0, '', 0, 0, 0, '', 0, 0),
(5, '2011-10-05 15:54:17', 2, 1, 'news', 'body', 0, '', 0, 0, 0, '', 0, 0),
(6, '2011-10-05 15:58:35', 2, 1, 'tags', 'module', 0, '', 0, 0, 0, '', 0, 0),
(8, '2011-10-08 13:49:26', 1, 1, 'dv', 'mini_logo', 0, '', 0, 0, 1, '', 0, 0),
(9, '2011-10-08 13:57:46', 4, 1, 'tags', 'module', 0, '', 0, 0, 0, '', 0, 0),
(10, '2011-10-08 14:03:27', 4, 1, 'dv', 'body', 0, '', 0, 0, 0, '', 0, 0);
>>>>>>> .r33

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `ns_tree`
--

INSERT INTO `ns_tree` (`id`, `name`, `lft`, `rgt`, `level`, `show_me`, `adress`, `side`, `module`, `template_out`, `func_name`, `alias`, `templates_int`, `short_a`, `max_short_a`) VALUES
(1, 'intro', 1, 12, 0, 1, '', 'menu', 'tree', '1', 'start', '51', '', 0, 1),
(2, 'news', 2, 3, 1, 1, '', 'menu', 'news', '4', 'show', '52', '', 0, 1),
(3, 'menu', 4, 5, 1, 1, '', 'menu', 'catalogp', '4', 'show', '53', '', 0, 1),
(4, 'about_us', 6, 7, 1, 1, '', 'menu', 'dv', '4', 'id', '54', '', 0, 1),
(5, 'contact', 8, 9, 1, 1, '', 'menu', 'dv', '4', 'id', '55', '', 0, 1),
(6, 'reviews', 10, 11, 1, 1, '', 'menu', 'comment', '4', 'comm', '56', '', 0, 1);

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
('tags_sc', 'meta_key', 5),
('tags_st', 'meta_key', 5),
('tags_sc', 'meta_key', 4),
('user_auth_sc', 'lang', 1),
('lang_sc', 'lang', 5),
('lang_ev', 'lang', 5),
('tags_st', 'meta_key', 4),
('tags_sc', 'meta_key', 1),
('tags_st', 'meta_key', 1),
('tags_sc', NULL, 5),
('tags_st', NULL, 5),
('tags_sc', NULL, 4),
('tags_st', NULL, 4),
('tags_sc', NULL, 1),
('tags_st', NULL, 1),
('tags_sc', 'title', 5),
('tags_st', 'title', 5),
('tags_sc', 'title', 4),
('tags_st', 'title', 4),
('tags_sc', 'title', 1),
('tags_st', 'title', 1),
('comment_sc', 'comment', 5),
('comment_ev', 'body', 4),
('comment_ev', 'comment_vi', 5),
('comment_ev', 'comment', 5),
('gallery_ev', 'body', 1),
('gallery_ev', 'body', 4),
('gallery_ev', 'body', 5),
('catalogp_ev', 'body', 4),
('catalogp_ev', 'body', 5),
('map_sc', 'body', 1),
('map_ev', 'body', 1),
('tags_st', 'meta_descr', 1),
('tags_sc', 'meta_descr', 1),
('tags_st', 'meta_descr', 4),
('tags_sc', 'meta_descr', 4),
('tags_st', 'meta_descr', 5),
('tags_sc', 'meta_descr', 5);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=40 ;

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
('slogan1', '1', 5, 37),
('logo', '1', 1, 38),
('mini_logo', '1', 4, 39);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `tags_side`
--

INSERT INTO `tags_side` (`idts`, `id_template`, `id_side`, `type`) VALUES
(1, 1, 9, 'tags_title'),
(2, 4, 10, 'tags_title'),
(3, 5, 31, 'tags_title'),
(4, 1, 0, 'tags_tags'),
(5, 4, 0, 'tags_tags'),
(6, 5, 0, 'tags_tags'),
(7, 1, 12, 'tags_metakey'),
(8, 4, 16, 'tags_metakey'),
(9, 5, 32, 'tags_metakey'),
(10, 1, 13, 'tags_metadescr'),
(11, 4, 17, 'tags_metadescr'),
(12, 5, 33, 'tags_metadescr');

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
<<<<<<< .mine
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;
=======
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;
>>>>>>> .r33

--
-- Dumping data for table `tags_voc`
--

INSERT INTO `tags_voc` (`idtv`, `id_doc`, `type`, `pid`) VALUES
(1, 57, 'tags_title', 3),
(2, 58, 'tags_metakey', 3),
(3, 59, 'tags_metadescr', 3),
(4, 60, 'tags_tags', 3),
(5, 64, 'tags_title', 6),
(6, 65, 'tags_metakey', 6),
(7, 66, 'tags_metadescr', 6),
<<<<<<< .mine
(8, 67, 'tags_tags', 6),
(9, 72, 'tags_title', 9),
(10, 73, 'tags_metakey', 9),
(11, 74, 'tags_metadescr', 9),
(12, 75, 'tags_tags', 9),
(13, 78, 'tags_title', 12),
(14, 79, 'tags_metakey', 12),
(15, 80, 'tags_metadescr', 12),
(16, 81, 'tags_tags', 12);
=======
(8, 67, 'tags_tags', 6),
(9, 72, 'tags_title', 9),
(10, 73, 'tags_metakey', 9),
(11, 74, 'tags_metadescr', 9),
(12, 75, 'tags_tags', 9);
>>>>>>> .r33

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
