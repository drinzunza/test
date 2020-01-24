UPDATE etags SET change =
(select CONCAT('{"observationNames":["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"],"defects":[',
(select STRING_AGG(CONCAT('"', id, '"'), ',') from defects), ']}'))
WHERE hash = 'd321c054fe104101613a54f01be1a3b';
