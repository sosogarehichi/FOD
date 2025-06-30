
program parcialdudoso;

const
	valor = 9999;

var
	empleado = record
		dni: integer;
		nombre: string;
		apellido: string;
		edad: integer;
		domicilio: string;
		fecha: string;
	end;
	
	archivo = file of empleado;
	
	procedure leer (var arc: archivo; var e: empleado);
	begin
		if not EOF(arc) then
			read(arc, e);
		else
			e.dni:= valor;
	end;
	
	function existeEmpleado(var arc: archivo, num: integer): integer;
	var
		ok: boolean;
		pos: integer;
		e: empleado;
	begin
		reset(arc);
		ok:= false;
		pos:= 0;
		lee(arc, e);
		while (e.dni <> num) and not(ok) do
		begin
			if (e.dni == num) then
			begin
				ok:= true;
				pos:= filepos(arc) -1;
			end;
			leer(arc, e);
		end;
		close(arc);
		existeEmpleado:= pos;
	end;
	
	procedure agregar (var arc: archivo);
	var
		e, nue: empleado;
	begin
		write('Ingrese datos del empleado: ');
		readln(nue.dni);
		
		if (existeEmpleado(arc, nue.dni)) == 0) then
		begin
			reset(arc);
			read(arc, cabecera);
			if (cabeceera.dni == 0) then
			begin
				seek(arc, filesize(arc));
				write(nue);
			end
			else begin
				seek(arc, cabecera.dni * -1);
				read(arc, cabecera);
				seek(arc, filepos(arc) -1);
				write(arc, nue);
				seek(arc, 0);
				write(arc, cabecera);
			end;
		end;
		close(arc);
	end;
		
	procedure eliminar(var arc: archivo);
	var
		cabecera: empleado;
		pos, dni: integer;
	begin
		write('Ingrese dni a eliminar: ');
		readln(dni);
		
		pos := existeEmpleado(arc, dni);
		if (pos == 0) then
			writeln('Empleado no exist');
		else begin
			reset(arc);
			read(arc, cabecera);
			seek(arc, pos);
			write(arc, cabecera);
			cabecera.dni := (filepos(a) -1) * -1;
			seek(arc, 0);
			writeln(arc, cabecera);
		end
		close(arc);
	end;

BEGIN
	
	
END.

