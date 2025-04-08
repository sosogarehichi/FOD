{
Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.
}

program tp1.ej2;
type
	archivo = file of integer;
	
	procedure leerFile(var arc: archivo);
	var
		a, suma, cant, cantMil: integer;
	begin
	suma:= 0;
	cant:= 0;
	cantMil:= 0;
	while not EOF(arc) do
	begin
		read(arc, a);
		suma:= suma + a;
		cant:= cant + 1;
		writeln(a);
		if (a < 15) then
		begin
			cantMil:= cantMil + 1;
		end;
	end;
		writeln('--------------');
		writeln('Num menores a 1500: ', cantMil);
		writeln('Total: ', suma);
		writeln('Cant:', cant);
		writeln('--------------');
		writeln('Promedio: ', (suma/cant):2:2);
	end;
	
	// si se hacen acciones dentro del proceso conviene abrir/cerrar dentro del mismo
	
	procedure asignar(var arc: archivo);
	var
		name: string;
	begin
		write('Proporcione nombre de archivo: ');
		readln(name);
		assign(arc, name);
	end;

var
	arc: archivo;

BEGIN
	asignar(arc);
	reset(arc);
	leerFile(arc);
	close(arc);
END.

