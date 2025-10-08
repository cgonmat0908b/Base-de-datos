USE escuela;
SELECT * FROM profesores_alumnos
INNER JOIN profesores ON profesores.id_Profesor = profesores_alumnos.id_Profesor
INNER JOIN alumnos ON alumnos.id_Alumno = profesores_alumnos.id_Alumno;