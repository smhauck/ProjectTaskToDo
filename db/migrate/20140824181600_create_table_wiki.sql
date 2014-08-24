CREATE TABLE `wiki` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `title` varchar(255) DEFAULT NULL,
	  `description` text,
	  `created_at` datetime DEFAULT NULL,
	  `updated_at` datetime DEFAULT NULL,
	  `product_id` int(11) DEFAULT NULL,
	  `start_page_id` int(11) DEFAULT NULL,
	  `creator_id` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `index_wiki_on_product_id` (`product_id`)
) ENGINE=InnoDB;


insert into schema_migration (version) values ('20140824181600');

