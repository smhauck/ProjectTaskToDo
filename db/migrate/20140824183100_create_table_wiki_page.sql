CREATE TABLE `wiki_page` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `title` varchar(255) DEFAULT NULL,
	  `body` text,
	  `version` int(11) DEFAULT NULL,
	  `wiki_id` int(11) NOT NULL,
	  `product_id` int(11) DEFAULT NULL,
	  `story_id` int(11) DEFAULT NULL,
	  `task_id` int(11) DEFAULT NULL,
	  `user_id` int(11) DEFAULT NULL,
	  `created_at` datetime DEFAULT NULL,
	  `updated_at` datetime DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `index_wiki_page_on_wiki_id` (`wiki_id`),
	  KEY `index_wiki_page_on_product_id` (`product_id`),
	  KEY `index_wiki_page_on_story_id` (`story_id`),
	  KEY `index_wiki_page_on_task_id` (`task_id`),
	  KEY `index_wiki_page_on_user_id` (`user_id`)
) ENGINE=InnoDB;




insert into schema_migration (version) values ('20140824183100');
