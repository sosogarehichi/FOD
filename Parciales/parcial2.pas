
program parcial25demayo2023;

const
	valor = 9999;

type
	
	profesionaL = record
		dni: integer;
		nombre: string;
		apellido: string;
		sueldo: real;
	end;
	
	tArchivo = file of profesional;
	
	procedure crear(var arc: tArchivo; var info: Text);
	var
		p: profesional;
	begin
		while not EOF(info) do
		begin
			read(info, p.dni, p.nombre, p.apellido, p.sueldo);
			write(arc, p);
		end;
		
		close(arc);
		close(info);
	end;
	
	procedure leer(var arc: tArchivo; var p: profesional);
	begin
		if not EOF(arc) then
			read(arc, p);
		else
			p.dni = valor;
	end;
	
	procedure existeEmp(var arc: tArchivo; num: integer): integer;
	var
		ok: boolean;
		pos: integer;
		p: profesional;
	begin
		// abrimos el archivo
		reset(arc);
		
		// inicializamos el ok
		ok := false;
		
		// pos en 0
		pos := 0;
		
		// llamamos al procedure leer
		leer(arc, p);
		
		// mientras el valor sea distinto a lo que buscamos
		// y no lo hayamos encontrado
		// preguntamos si el dato coincide con lo que buscamos
		while ((p.dni <> valor) and (not ok)) do
		begin
			if (p.dni == num) then
			begin
				// indicó que se encontró
				ok := true;
				
				// guardo la pos quitandole uno (por el read)
				pos := (filepos(a) - 1);
			end;
			leer(arc, p);
		end;
		close(arc);
		existeEmp := pos;
	end;
	
	
	procedure agregar (var arc: tArchivo; p: profesional);
	var
		cabecera, nue: profesional;
	begin
		// leo empleado
		if (existeEmp(arc, nue.dni) == 0) then
		begin
			// si no existe
			reset(arc);
			read(arc, cabecera);
			if (cabecera.dni == 0) then
			begin
				// no hay espacio para reutilizar
				// debo ir al fondo
				seek(arc, filesize(a));
				write(arc, nue);
			end
			else
			begin
				// buscamos el reg marcado y leemos la cabecera
				seek(arc, (cabecera.dni * -1));
				read(arc, cabecera);
				
				// retrocedemos una pos y escribimos el nuevo
				seek(arc, filepos(a) -1);
				write(arc, nue);
				seek(arc, 0);
				write(arc, cabecera);
			end;
			close(arc);
	end;
	
	procedure escribir(var p: profesional; var bajas: Text);
	begin
		writeln(bajas, 'dni: ' p.dni);
		writeln(bajas, 'nombre: ' p.nombre);
		writeln(bajas, 'apellido: ' p.apelldo);
		writeln(bajas, 'sueldo: ' p.sueldo);
	end;
	
	// si existe se debe agregar al archivo de bajas
	procedure baja (var arc: tArchivo; dni: integer; var bajas: Text);
	var
		pos: integer; // para guardar la pos del archivo a elimianar
		cabecera, p: profesional;
	begin
		pos := existeEmp(arc, dni);
		 if (pos <> 0) then // existe el empleado a eliminar
		 begin
			reset(arc);
			read(arc, cabecera);
			seek(arc, pos);
			read(arc, p);
			escribir(p, bajas);
			seek(arc, filepos(arc) -1);
			write(arc, cabecera);
			cabecera.dni := (filepos(arc) -1) * -1;
			seek(arc, 0);
			write(arc, cabecera);
			close(arc);
		end
		else
			writeln('El empleado no existe');
		end;
	end;
			
BEGIN
	
	
END.

