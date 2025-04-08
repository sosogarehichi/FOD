{
Realizar un programa que presente un menú con opciones para:
	a. Crear un archivo de registros no ordenados de empleados y completarlo con
	datos ingresados desde teclado. De cada empleado se registra: número de
	empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
	DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
	
	b. Abrir el archivo anteriormente generado y 
		i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
		determinado, el cual se proporciona desde el teclado.
		ii. Listar en pantalla los empleados de a uno por línea.
		iii. Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.
	NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.
	
}
program tp1.ej3;

type

	empleado = record
		numE: integer;
		nombre: string;
		apellido: string;
		edad: integer;
		DNI: integer;
	end;
	
	archivo = file of empleado;
	
	procedure sepa(); begin writeln('------------------------------------'); end;
	
	procedure asignar(var arc : archivo);
	var
		name: string;
	begin
		write('Ingrese nombre del archivo: ');
		readln(name);
		assign(arc, name);
		rewrite(arc); // se crea el archivo por primera vez
	end;
		
	procedure cargarFile(var arc : archivo);
	var
		emp: empleado;
	begin
		write('Ingrese apellido del empleado: ');
		readln(emp.apellido);
		 while (emp.apellido <> 'fin') do
		 begin
			emp.numE:= random(100);
			write('Ingrese nombre del empleado: ');
			readln(emp.nombre);
			emp.edad:= random(20) + 65;
			emp.DNI:= random(10);
			write(arc, emp);
			write('Ingrese apellido del empleado: ');
			readln(emp.apellido);
		end;
		close(arc);
	end;
	
	procedure imprimir(e: empleado);
	begin
		sepa();
		writeln('Empleado nro: ', e.numE);
		writeln('Nombre y Apellido: ', e.nombre, ' ', e.apellido);
		writeln('Edad: ', e.edad);			
		writeln('DNI: ', e.DNI);
	end;
	
	procedure inciso2(var arc: archivo);
	var
		e: empleado;
	begin
		writeln();
		sepa();
		writeln('Lista de empleados: ');
		reset(arc);
		while not EOF(arc) do
		begin
			read(arc, e);
			imprimir(e);
		end;
		close(arc);
	end;
	
	procedure inciso1(var arc: archivo);
	var
		e: empleado;
		ape: string;
	begin
		writeln();
		write('Ingrese nombre/apellido a buscar: ');
		readln(ape);
		reset(arc);
		writeln();
		sepa();
		writeln('Coincidencias: ');
		while not EOF(arc) do
		begin
			read(arc, e);
			if ((e.apellido = ape ) or (e.nombre = ape)) then
			begin
				imprimir(e);
			end;
		end;
		close(arc);
	end;
	
	procedure inciso3(var arc: archivo);
	var
		e: empleado;
	begin
		writeln();
		sepa();
		writeln('Empleados proximos a jubilarse: ');
		reset(arc);
		while not EOF(arc) do
		begin
			read(arc, e);
			if (e.edad >= 70) then
			begin
				imprimir(e);
			end;
		end;
		close(arc);
	end;
	
var 
	arc: archivo;

BEGIN
	Randomize;
	asignar(arc);
	cargarFile(arc);
	inciso1(arc);
	inciso2(arc);
	inciso3(arc);
END.
