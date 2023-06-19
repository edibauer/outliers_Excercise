/* ALGO */

/*
1. Se realizará una consulta de los pedidos con el campo fechaVenta en la table TB que proviene del esquema OUT con los siguientes argumentos:
    a) El campo origen debe ser igual a 'CPQ'
    b) El campo fechaCompensación no debe estar vacío
    c) El campo vendedor debe tener el nombre del vendedor buscado
    
2. Una vez hecha la consulta, se ejecutará un filtro en los resultados obtenidos con base en la tabla TC de acuerdo a los argumentos específicos del ejecicio:
    a) El campo estatus del empleado debe estar activo [1]
    b) Para que el empleado este activo, la fecha actual debe estar entre la fechaAlta y la fechaBaja.

3. Contar la cantidad de registros encontrados
4. Retornar el resultado del conteo con un entero 

 */

 /* QUERY */
 -- Cosulta de pedidos
 SELECT COUNT(*)
 FROM OUT.TB
 WHERE origen = 'CPQ'
    AND fechaCompensacion IS NOT NULL
    AND vendedor = 'vendedor' -- Colocar dentro del string el nombre del vendedor
    AND fechaVenta BETWEEN 'fecha1' AND 'fecha2' -- Fechas de inicio y fin
    AND EXISTS (
        -- filtro con respecto a TC empleado
        SELECT *
        FROM TC 
        WHERE estatus = 1
            AND GETDATE() BETWEEN fechaAlta AND fechaBaja -- empleado.status = 1 si la fecha actual se encuentra en el rango
            AND TC.empleado = OUT.TB.vendedor

    );
