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
			// dni impar pasa a ser 00
			if ((emp.DNI MOD 2) <> 0) then
			begin
				emp.DNI := 0;
			end;
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
	
	procedure cargarEmp(emp: empleado; var arc: archivo);
	var
		e: empleado;
		existe: boolean;
	begin
		existe := false;
		reset(arc);
		while not EOF(arc) and not existe do
		begin
			read(arc, e);
			if (e.numE = emp.numE) then
				existe:= true;
		end;

		if (existe) then
		begin
			writeln('Empleado ya cargado');
		end
		else
		begin
			writeln('Cargando empleado...');
			write(arc, emp);
			writeln('Empleado cargado!');
		end;
		close(arc);
	end;
	
	procedure agregarEmp(var arc: archivo);
	var 
		e: empleado;
		num, age, dni: integer;
		name, surname: string;
	begin
		write('Ingrese num empleado: ');
		readln(num);
		e.numE:= num;
		write('Ingrese nombre: ');
		readln(name);
		e.nombre:= name;
		write('Ingrese apellido: ');
		readln(surname);
		e.apellido:= surname;
		write('Ingrese edad: ');
		readln(age);
		e.edad:= age;
		write('Ingrese DNI: ');
		readln(dni);
		e.DNI:= dni;
		cargarEmp(e, arc);
	end;
	
	procedure exportar(var arc: archivo; var fila: Text);
	var
		e:empleado;
	begin
		reset(arc);
		assign(fila, 'todos_empleados.txt');
		rewrite(fila);
		while not EOF(arc) do
		begin
			read(arc, e);
			writeln(fila, 'Num empleado: ', e.numE);
			writeln(fila, 'Nombre: ', e.nombre);
			writeln(fila, 'Apellido: ', e.apellido);
			writeln(fila, 'edad: ', e.edad);
			writeln(fila, 'DNI: ', e.DNI);
			writeln(fila, '----------');
			writeln();
		end;
		close(arc);
		close(fila);
	end;

	function opcion():integer;
	var
		op: integer;
	begin
		sepa();
		writeln('0: Finalizar');
		writeln('1: Añadir empleados');
		writeln('2: Modificar edad empleado');
		writeln('3: Exportar contenido');
		writeln('4: Exportar empleados que no tengan DNI');
		writeln('5: Imprimir');
		write('Elija una opcion: '); readln(op);
		opcion:=op;
	end;
	
	procedure indice(var arc: archivo; var fila: Text);
	var
		i: integer;
		
	begin
		i:= opcion();
		while(i <> 0)do begin
			case i of
				1:
				begin
					agregarEmp(arc);
				end;
				2: 
				begin
					writeln('Modificar edad');
				end;
				3: 
				begin
					exportar(arc, fila);
				end;
				4:
				begin
					
				end;
				5:
				begin
					inciso2(arc);
				end;
			else
				writeln('Opcion invalida');
			end;
			i:= opcion();
		end;
		writeln('Finaliza el programa');
	end;
	
var 
	arc: archivo;
	
	fila: Text;
BEGIN
	Randomize;
	asignar(arc);
	cargarFile(arc);
	// inciso3(arc);
	indice(arc, fila);
END.
