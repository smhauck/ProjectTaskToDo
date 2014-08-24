CREATE TABLE `blog` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `title` varchar(255) DEFAULT NULL,
	  `description` text,
	  `created_at` datetime DEFAULT NULL,
	  `updated_at` datetime DEFAULT NULL,
	  `creator_id` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into schema_migration (version) values ('20140824185300');
