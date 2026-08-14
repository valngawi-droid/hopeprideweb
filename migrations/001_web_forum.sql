-- Hope Pride web-only tables. Aman untuk gamemode karena prefix `web_`.
-- Idempotent: dapat dijalankan berulang tanpa menghapus data.

CREATE TABLE IF NOT EXISTS `web_forum_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(40) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(160) NOT NULL DEFAULT '',
  `icon` varchar(8) NOT NULL DEFAULT '◇',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `admin_only` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`), UNIQUE KEY `uq_forum_category_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `web_forum_topics` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `author_ucp` varchar(25) NOT NULL,
  `title` varchar(120) NOT NULL,
  `content` text NOT NULL,
  `pinned` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`), KEY `idx_forum_topic_category` (`category_id`,`pinned`,`updated_at`), KEY `idx_forum_topic_author` (`author_ucp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `web_forum_posts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `topic_id` bigint(20) NOT NULL,
  `author_ucp` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`), KEY `idx_forum_post_topic` (`topic_id`,`created_at`), KEY `idx_forum_post_author` (`author_ucp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `web_forum_categories` (`slug`,`name`,`description`,`icon`,`sort_order`,`admin_only`) VALUES
('announcements','Announcements','Pengumuman dan informasi resmi Hope Pride.','✦',10,1),
('guides','Guides & Tutorials','Panduan bermain, UCP, dan roleplay untuk warga.','§',20,0),
('general','General Discussion','Diskusi umum komunitas Hope Pride.','◉',30,0),
('roleplay','Roleplay Stories','Cerita IC, character story, dan dokumentasi roleplay.','♙',40,0),
('business','Business & Marketplace','Promosi warung, toko pakaian, dan bisnis warga.','▦',50,0),
('support','Help & Support','Pertanyaan teknis dan bantuan akun.','?',60,0)
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`),`description`=VALUES(`description`),`icon`=VALUES(`icon`),`sort_order`=VALUES(`sort_order`),`admin_only`=VALUES(`admin_only`);
