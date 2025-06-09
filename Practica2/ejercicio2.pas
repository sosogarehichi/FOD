{
2. El encargado de ventas de un negocio de productos de limpieza desea administrar el stock 
de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los 
productos que comercializa. De cada producto se maneja la siguiente información: código de 
producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se 
genera un archivo detalle donde se registran todas las ventas de productos realizadas. De 
cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide 
realizar un programa con opciones para: 
	a. Actualizar el archivo maestro con el archivo detalle, sabiendo que: 
		● Ambos archivos están ordenados por código de producto. 
		● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del 
		archivo detalle. 
		● El archivo detalle sólo contiene registros que están en el archivo maestro.
	b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo 
	stock actual esté por debajo del stock mínimo permitido.

}


program tp2.ej2;

type
	
	prod = record
		cod: integer;
		nombre: String;
		precio: real;
		stock: integer;
		stockMin: integer;
	end;
	
	maestro = file of prod;
	
	ventaProd = record
		codProd: integer;
		cantVen: integer;
	end;
	
	detalle = file of ventaProd;
	
	procedure asignar(var mae: maestro; var det: detalle);
	begin
		assign(mae, 'maestro_producto.dat');
		assign(det, 'detalle_producto.dat');
		rewrite(mae);
		rewrite(det);
	end;
	
	procedure actualizar(var mae: maestro; var det: detalle);
	var
		regm: prod;
		regd: ventaProd;
	begin
		reset(mae);
		reset(det);
		while not EOF(det) do
		// mientras no se llegue al final del archivo detalle
		begin
			read(mae, regm);
			read(det, regd);
			// leo ambos archivos
			while (regm.cod <> regd.cod) do
				read(mae, regm);
				// mientras el codigo del maestro y el detalle
				// sean distintos, avanzo (está ordenado)
			// si sale del while es pq los códigos coinciden
			// se inicializan cod y total
			codAct:= regd.cod;
			totVenta:= 0;
			// puede ser que un producto tenga varias ventas, entonces:
			// se totaliza la cantidad vendida del detalle
			// y luego se actualiza
			while (reg.cod = codAct) do // mientras el código siga siendo igual
			begin
				// sumo el total vendido
				totVenta := totVenta + reg.cantVen;
				read(det, regd);
			end;
			// entonces actualiza el stock en el maestro
			// se debe volver uno atrás
			seek(mae, filepos(mae)-1);
			regm.stock := regm.stock - totVenta;
			write(mae, regm);
		end;
		close(det);
		close(mae);
	end;

	procedure exportar(var mae: maestro; var fila: Text);
	var
		regm: prod;
	begin
		reset(mae);
		assign(fila, 'stock_minimo.txt');
		rewrite(fila);
		while not EOF(mae) do
		begin
			read(mae, regm);
			if (regm.stock < regm.stockMin) then
			begin
				writeln(fila, 'Código producto: ', regm.cod);
				writeln(fila, 'Producto: ',regm.nombre);
				writeln(fila, 'Precio: ', regm.precio);
				writeln(fila, 'Stock actual: ', regm.stock);
				writeln(fila, 'Stock min: ', regm.stock);
				writeln(fila, '-----------------------');
			end;
		end;
		close(mae);
		close(fila);
	end;
	
	
	function opcion(): integer;
	var
		op: integer;
	begin
		writeln('0. Finalizar.');
		writeln('1. Actualizar archivo maestro.');
		writeln('2. Listar stock mínimo.');
		readln(op);
		opcion := op;
	end;
	
	procedure indice(var mae: maestro; var det: detalle; fila: Text);
	var
		i: integer;
	begin
		i := opcion();
		while (i <> 0) do
		begin
			case i of
			1:
			begin
				actualizar(mae, det);
			end;
			2:
			begin
				exportar(mae, fila);
			end;
			else
				writeln('Opción inválida.');
			end;
			i := opcion();
		end;
		writeln('Finaliza el programa.');
	end;

var
	mae: maestro;
	det: detalle;

BEGIN
	asignar(maestro, detalle);
	
END.

