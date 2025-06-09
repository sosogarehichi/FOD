{
1. Una empresa posee un archivo con información de los ingresos percibidos por diferentes 
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado, 
nombre y monto de la comisión. La información del archivo se encuentra ordenada por 
código de empleado y cada empleado puede aparecer más de una vez en el archivo de 
comisiones.  
Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En 
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una 
única vez con el valor total de sus comisiones. 
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser 
recorrido una única vez.
}


program tp2.ej2;

type
	
	prod = record
		cod: integer;
		nombre; String;
		precio: real;
		stock: integer;
		stockMin: integer;
	end;
	
	maestro = file of producto;
	
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
		regm: producto;
		regd: ventaProd;
	begin
		reset(mae);
		reset(det);
		while not EOF(det) do
		begin
			read(mae, regm);
			read(det, regd);
			while (regm.cod <> regd.cod) do
				read(mae, regm);
			regm.stock := regm.stock - regd.cantVen;
			write(mae, regm);
		end;
		close(det);
		close(mae);
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
	
	procedure indice();
	var
		i: integer;
	begin
		i := opcion();
		while (i <> opcion) do
		begin
			case i of
			1:
			begin
			end;
			2:
			begin
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

