# Status types
INSERT INTO `status_types` (`id`, `name`) VALUES(1, 'Informational');
INSERT INTO `status_types` (`id`, `name`) VALUES(2, 'Success');
INSERT INTO `status_types` (`id`, `name`) VALUES(3, 'Redirection');
INSERT INTO `status_types` (`id`, `name`) VALUES(4, 'Client Error');
INSERT INTO `status_types` (`id`, `name`) VALUES(5, 'Server Error');

# Status codes
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(1, 1, '100', 'Continue');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(2, 1, '101', 'Switching Protocols');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(3, 1, '102', 'Processing');

INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(4, 2, '200', 'OK');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(5, 2, '201', 'Created');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(6, 2, '202', 'Accepted');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(7, 2, '203', 'Non-Authoritative Information');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(8, 2, '204', 'No Content');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(9, 2, '205', 'Reset Content');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(10, 2, '206', 'Partial Content');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(11, 2, '207', 'Multi-Status');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(12, 2, '226', 'IM Used');

INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(13, 3, '300', 'Multiple Choices');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(14, 3, '301', 'Moved Permanently');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(15, 3, '302', 'Found');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(16, 3, '303', 'See Other');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(17, 3, '304', 'Not Modified');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(18, 3, '305', 'Use Proxy');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(19, 3, '307', 'Temporary Redirect');

INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(20, 4, '400', 'Bad Request');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(21, 4, '401', 'Unauthorized');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(22, 4, '402', 'Payment Required');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(23, 4, '403', 'Forbidden');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(24, 4, '404', 'Not Found');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(25, 4, '405', 'Method Not Allowed');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(26, 4, '406', 'Not Acceptable');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(27, 4, '407', 'Proxy Authentication Required');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(28, 4, '408', 'Request Timeout');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(29, 4, '409', 'Conflict');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(30, 4, '410', 'Gone');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(31, 4, '411', 'Length Required');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(32, 4, '412', 'Precondition Failed');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(33, 4, '413', 'Request Entity Too Large');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(34, 4, '414', 'Request-URI Too Long');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(35, 4, '415', 'Unsupported Media Type');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(36, 4, '416', 'Request Range Not Satisfiable');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(37, 4, '417', 'Expectation Failed');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(38, 4, '422', 'Unprocessable Entity');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(39, 4, '423', 'Locked');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(40, 4, '424', 'Failed Dependency');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(41, 4, '426', 'Upgrade Required');

INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(42, 5, '500', 'Internal Server Error');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(43, 5, '501', 'Not Implemented');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(44, 5, '502', 'Bad Gateway');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(45, 5, '503', 'Service Unavailable');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(46, 5, '504', 'Gateway Timeout');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(47, 5, '505', 'HTTP Version Not Supported');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(48, 5, '507', 'Insufficient Storage');
INSERT INTO `status_codes` (`id`, `status_type_id`, `code`, `description`) VALUES(49, 5, '510', 'Not Extended');