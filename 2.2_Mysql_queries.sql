USE tienda;

/* 01 */ SELECT nombre FROM producto;
/* 02 */ SELECT nombre, precio FROM producto;
/* 03 */ SELECT * FROM producto;
/* 04 */ SELECT nombre, precio, precio*1.14 FROM producto;
/* 05 */ SELECT nombre AS nom, precio AS euros, precio*1.14 AS dolars FROM producto;
/* 06 */ SELECT UPPER(nombre), precio FROM producto;
/* 07 */ SELECT LOWER(nombre), precio FROM producto;
/* 08 */ SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) FROM fabricante;
/* 09 */ SELECT nombre, ROUND(precio) FROM producto;
/* 10 */ SELECT nombre, TRUNCATE(precio, 0) FROM producto;
/* 11 */ SELECT f.codigo FROM fabricante AS f JOIN producto AS p ON f.codigo = p.codigo_fabricante;
/* 12 */ SELECT DISTINCT f.codigo FROM fabricante AS f JOIN producto AS p ON f.codigo = p.codigo_fabricante;
/* 13 */ SELECT nombre FROM fabricante ORDER BY nombre ASC;
/* 14 */ SELECT nombre FROM fabricante ORDER BY nombre DESC;
/* 15 */ SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC; 
/* 16 */ SELECT nombre FROM fabricante LIMIT 5;
/* 17 */ SELECT nombre FROM fabricante LIMIT 3,2; 
/* 18 */ SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;
/* 19 */ SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
/* 20 */ SELECT nombre FROM producto WHERE codigo_fabricante = 2;
/* 21 */ SELECT p.nombre, p.precio, f.nombre FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo;
/* 22 */ SELECT p.nombre, p.precio, f.nombre FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;
/* 23 */ SELECT p.codigo, p.nombre, f.codigo, f.nombre FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante;
/* 24 */ SELECT p.nombre, p.precio, f.nombre FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo  ORDER BY p.precio LIMIT 1;
/* 25 */ SELECT p.nombre, p.precio, f.nombre FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo  ORDER BY p.precio DESC LIMIT 1;
/* 26 */ SELECT p.* FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE f.nombre = 'Lenovo';
/* 27 */ SELECT p.* FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE f.nombre = 'Crucial' AND p.precio > 200;
/* 28 */ SELECT p.* FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';
/* 29 */ SELECT p.* FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');
/* 30 */ SELECT p.nombre, p.precio FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE f.nombre LIKE '%e';
/* 31 */ SELECT p.nombre, p.precio, f.nombre FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE f.nombre LIKE '%w%';
/* 32 */ SELECT p.nombre, p.precio, f.nombre FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE p.precio >= 180 ORDER BY p.precio DESC, p.nombre ASC;
/* 33 */ SELECT DISTINCT f.codigo, f.nombre FROM fabricante AS f INNER JOIN producto AS p ON f.codigo = p.codigo_fabricante;
/* 34 */ SELECT f.*, p.* FROM fabricante AS f LEFT JOIN producto AS p ON f.codigo = p.codigo_fabricante;
/* 35 */ SELECT DISTINCT f.* FROM fabricante AS f INNER JOIN producto AS p ON p.codigo_fabricante = f.codigo;
/* 36 */ SELECT p.* FROM producto AS p, fabricante AS f WHERE f.codigo = p.codigo_fabricante AND f.nombre = 'Lenovo';
/* 37 */ SELECT * FROM producto WHERE precio = (SELECT MAX(p.precio) FROM producto AS p, fabricante AS f WHERE f.codigo = p.codigo_fabricante AND f.nombre = 'Lenovo');
/* 38 */ SELECT p.nombre FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE precio = (SELECT MAX(precio) FROM producto AS p WHERE f.codigo = codigo_fabricante AND f.nombre = 'Lenovo');
/* 39 */ SELECT p.nombre FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE precio = (SELECT MIN(precio) FROM producto AS p WHERE f.codigo = codigo_fabricante AND f.nombre = 'Hewlett-Packard');
/* 40 */ SELECT * FROM producto WHERE precio >= (SELECT MAX(p.precio) FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE f.nombre = 'Lenovo');
/* 41 */ SELECT p.* FROM producto AS p INNER JOIN fabricante AS f ON f.codigo = p.codigo_fabricante WHERE f.nombre = 'Asus' AND p.precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = f.codigo);


USE universidad;

/* 01 */ SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;
/* 02 */ SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
/* 03 */ SELECT * FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
/* 04 */ SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';
/* 05 */ SELECT * FROM asignatura WHERE id_grado = 7 AND curso = 3 AND cuatrimestre = 1;
/* 06 */ SELECT p.apellido1, p.apellido2, p.nombre, d.nombre  FROM profesor AS pr INNER JOIN persona AS p ON pr.id_profesor = p.id LEFT JOIN departamento AS d ON pr.id_profesor = d.id ORDER BY p.apellido1, p.apellido2, p.nombre;
/* 07 */ SELECT a.nombre, c.anyo_inicio, c.anyo_fin FROM alumno_se_matricula_asignatura as m INNER JOIN persona AS p ON m.id_alumno = p.id INNER JOIN asignatura AS a ON m.id_asignatura = a.id INNER JOIN curso_escolar AS c ON m.id_curso_escolar = c.id WHERE p.nif = '26902806M';
/* 08 */ SELECT DISTINCT d.nombre FROM departamento AS d INNER JOIN profesor AS p ON d.id = p.id_departamento INNER JOIN asignatura AS a ON a.id_profesor = p.id_profesor INNER JOIN grado AS g ON g.id = a.id_grado WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
/* 09 */ SELECT DISTINCT p.* FROM persona AS p INNER JOIN alumno_se_matricula_asignatura AS a ON a.id_alumno = p.id INNER JOIN curso_escolar AS c ON c.id = a.id_curso_escolar WHERE c.anyo_inicio = 2018 AND c.anyo_fin = 2019;

/* 01 */ SELECT p.apellido1, p.apellido2, p.nombre, d.nombre FROM profesor as pr RIGHT JOIN persona AS p ON p.id = pr.id_profesor LEFT JOIN departamento AS d ON d.id = pr.id_departamento ORDER BY p.apellido1, p.apellido2, p.nombre;
/* 02 */ SELECT p.* FROM persona AS p LEFT JOIN profesor AS pr ON pr.id_profesor = p.id WHERE p.tipo = 'profesor' AND pr.id_departamento IS NULL;
/* 03 */ SELECT d.* FROM departamento AS d LEFT JOIN profesor AS p ON d.id = p.id_departamento WHERE p.id_departamento IS NULL;
/* 04 */ SELECT p.* FROM asignatura AS a INNER JOIN profesor AS pr ON pr.id_profesor = a.id RIGHT JOIN persona AS p ON p.id = pr.id_profesor WHERE p.tipo = 'profesor' AND pr.id_profesor IS NULL;
/* 05 */ SELECT a.* FROM asignatura AS a LEFT JOIN profesor AS pr ON a.id_profesor = pr.id_profesor WHERE pr.id_profesor IS NULL;
/* 06 */ SELECT DISTINCT d.* FROM departamento AS d LEFT JOIN profesor AS pr ON pr.id_departamento = d.id LEFT JOIN asignatura AS a ON a.id_profesor = pr.id_profesor LEFT JOIN alumno_se_matricula_asignatura AS al ON al.id_asignatura = a.id WHERE al.id_asignatura IS NULL;

/* 01 */ SELECT COUNT(*) FROM persona WHERE tipo = 'alumno';
/* 02 */ SELECT COUNT(*) FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
/* 03 */ SELECT d.nombre, COUNT(p.id) AS num FROM profesor AS pr INNER JOIN departamento AS d ON d.id = pr.id_departamento INNER JOIN persona AS p ON p.id = pr.id_profesor GROUP BY d.nombre ORDER BY num DESC;
/* 04 */ SELECT d.nombre, COUNT(p.id) AS num FROM departamento AS d LEFT JOIN profesor AS pr ON d.id = pr.id_departamento LEFT JOIN persona AS p ON p.id = pr.id_profesor GROUP BY d.nombre ORDER BY num DESC;
/* 05 */ SELECT g.nombre, COUNT(a.id) AS num FROM grado AS g LEFT JOIN asignatura AS a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY num DESC;
/* 06 */ SELECT g.nombre, COUNT(a.id) AS num FROM grado AS g LEFT JOIN asignatura AS a ON g.id = a.id_grado GROUP BY g.nombre HAVING num > 40 ORDER BY num DESC;
/* 07 */ SELECT g.nombre, a.tipo, SUM(a.creditos) AS num FROM grado AS g INNER JOIN asignatura AS a ON g.id = a.id_grado GROUP BY g.nombre, a.tipo;
/* 08 */ SELECT c.anyo_inicio, COUNT(al.id_alumno) FROM curso_escolar AS c INNER JOIN alumno_se_matricula_asignatura AS al ON c.id = al.id_curso_escolar GROUP BY c.anyo_inicio;
/* 09 */ SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id_profesor) AS num FROM persona AS p LEFT JOIN profesor AS pr ON pr.id_profesor = p.id INNER JOIN asignatura AS a ON a.id_profesor = pr.id_profesor WHERE p.tipo='profesor' GROUP BY p.id ORDER BY num DESC;
/* 10 */ SELECT * FROM persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;
/* 11 */ SELECT DISTINCT p.* FROM persona AS p INNER JOIN profesor AS pr ON pr.id_profesor = p.id LEFT JOIN asignatura AS a ON a.id_profesor = pr.id_profesor WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL;


