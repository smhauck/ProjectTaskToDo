CREATE TABLE `blog_post` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `title` varchar(255) DEFAULT NULL,
	  `body` text,
	  `publish_date` date DEFAULT NULL,
	  `blog_id` int(11) DEFAULT NULL,
	  `user_id` int(11) DEFAULT NULL,
	  `created_at` datetime DEFAULT NULL,
	  `updated_at` datetime DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `index_blog_post_on_blog_id` (`blog_id`),
	  KEY `index_blog_post_on_user_id` (`user_id`)
) ENGINE=InnoDB;

insert into schema_migration (version) values ('20140824185400');
