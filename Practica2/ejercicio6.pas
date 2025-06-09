{
   6. Se reciben archivos de los distintos municipios, contiene:
   código de localidad
   código de cepa
   cantidad de casos activos
   cantidad de casos recuperados
   cantidad de casos fallecidos
   
   archivo maestro:
	cod localidad
	nombre localidad
	codigo cepa
	nombre ceppa
	cant casos activos
	cant casos nuevos
	cant recuperados
	cant fallecidos
	
	se debe realizar el procedimiento que permita actualizar
	el maestro con los detalles recibidos (10)
	
	todos los archivos están ordenados por código de localidad
	y código de cepa
   
   
   Para actualizar:
   al número de fallecidos y de recuperados se les SUMA los del
   detalle
   los casos activos y nuevos se actualizan con el valor recibido
   en el detalle.
   
   realizar declaraciones necesarias, el programa principal y
   los procedimientos que requiera para la actualización
   
   informar cantidad de localidades con más de 50 casos activos
   (pueden haber sido o no actualizadas)
}


program untitled;

const
	valor = 9999;
	
type
	
	municipio = record
		cod_loc: integer;
		nombre_loc: String[30];
		cod_cepa: integer;
		nombre_cepa: String[30];
		casos_act: integer;
		casos_nue: integer;
		casos_rec: integer;
		casos_fall: integer;
	end;
	
	maestro = file of municipio;
	
	dato = record
		cod_loc: integer;
		cod_cepa: integer;
		casos_act: integer;
		casos_nue: integer;
		casos_rec: integer;
		casos_fall: integer;
	end;
	
	detalle = file of dato;
	
	archivos = array[1..10] of detalle;
	registros = array[1..10] of dato;
	
	// se asigna nombre a cada archivo
	procedure asignar(var det: archivos, var mae: maestro);
	var
		i: integer;
		nombre: String;
	begin
		assign(mae, 'maestro.dat');
		for i:=1 to 10 do
		begin
			str(i, nombre);
			assign(det[i], 'detalle' + nombre + '.dat');
		end;
	end;
	
	// avanza en el archivo detalle
	// cuando llega al final actualiza el cod al valor alto
	leer(var det: detalle; var reg: venta);
	begin
		if not EOF(det) then
			read(det, regd);
		else
			regd.cod := valor;
	end;
	
	procedure minimo(var vd: archivos; var vr: registros; var min: dato);
	var
		i, pos: integer;
	begin
		pos := 1;
		min.cod := valor // inicializa en max
		for i:= 1 to 10 do // se itera sobre los registros
		begin
			if (vr[i].cod_loc < min.cod_loc) or ((vr[i].cod_loc = min-cod_loc) and (vr[i].cod_cepa < min.cod_cepa)) then
			begin
				min:= vr[i];
				pos:= i;
			end;
		end;
		if (min.cod_loc <> valor) then
			leer(vec[pos), vr[pos));
	end;
	
	procedure actualizar(var mae: maestro; var vd: registros);
	var
		min: dato;
		vr: registros;
		regm: municipio;
		i: integer;
	begin
		reset(mae);
		for i:= 1 to 10 do
		begin
			reset(vd[i]);
			leer(vd[i], vr[i]);
		end;
		minimo(vd, vr,min);
		
		while(min.cod <> valor) do
		begin
			read(mae, regm);
			
			// busca en el maestro que coincida con el código
			// de localidad
			while min.cod_loc <> regm.cod_loc do
				read(mae, regm);
				
			while min.cod_loc = regm.cod_loc do
			begin
				while min.cod_cepa <> regm.cod_cepa do
					read(mae, regm);
					while (min.cod_loc = regm.cod_loc) and (min.cod_cepa = regm.cod_cepa) do
					begin
							regm.casos_fall:= regm.casos_fall + casos_fall;
                            regm.casos_rec:= regm.casos_rec + min.casos_rec;
                            // cantCasosLocalidad:= cantCasosLocalidad + min.cantActivos;
                            regm.casos_act:= min.casos_act;
                            regm.casos_nue:= min.casos_nue;
                            minimo(vd, vr, min);
                    end;
						
BEGIN
	
	
END.

