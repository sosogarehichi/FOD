{
Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
archivo debe ser proporcionado por el usuario desde teclado.
}
program tp1.ej1;
type
	archivo = file of integer;
	
	procedure cargarFile(var arc: archivo);
	var
		num: integer;
	begin
		num := random(31);
		while (num <> 30) do
		begin
			write(arc, num);
			writeln('Carga: ', num);
			num := random(31);
		end;
		close(arc);
	end;
	
	procedure leerNombre(var arc: archivo);
	var
		nombre: string;
	begin
		write('Ingrese nombre del archivo: ');
		readln(nombre);
		assign(arc, nombre);
		rewrite(arc);
	end;
var
	arc: archivo;
	a: integer;
	
BEGIN
	Randomize;
	leerNombre(arc);
	cargarFile(arc);
	reset(arc);
	
	writeln('-------------------------------------------------------');
	while not EOF(arc) do
	begin
		read(arc, a);
		writeln(a);
	end;
	close(arc); // siempre que se interactua con el archivo hay que cerrarlo
	
END.

