

program parcial1;

const

	valor = 9999;
type

	insumo = record
		cod: integer;
		nombre: string;
		desc: string;
		stock: integer;
		stockMin: integer;
		receta: boolean;
	end;
	
	maestro = file of insumo;
	
	venta = record
		cod: integer;
		cant: integer;
		nombreCli: string;
		domicilio: string;
	end;
	
	detalle = file of venta;
	
	archivos = array[30] of detalle;
	registros = array[30] of venta;
	
	procedure asignar(var det: archivos);
	var
		i: integer;
		nombre: string;
	begin
		// recorrer el vector de archivos detalles para asignar
		for i=1 to 30 do
		begin
			write('Ingrese nombre archivo: ');
			readln(nombre);
			assign(det[i], nombre);
		end;
	end;
	
	procedure leer (var det: detalle; var regd: venta);
	begin
		// mientas no sea el fin del archivo
		// leo
		if not EOF(det)
			read(det, regD);
		else
			// si se llega al fin cambió el valor
			reagd.cod := valor;
	end;
	
	procedure minimo(var vd: archivos; var vr: registros; var min: venta);
	var
		pos, i: integer;
	begin
		// inicializo minimo en el valor alto
		min.cod := valor;
		// mientras recorro el vector de registros...
		for i=1 to 30 do
		begin
			// comparo los registros del vector con el minimo
			// si cumple la condición
			// actualizo y guardo la posición
			if (vr[i].cod < min.cod) do
			begin
				min := vr[i];
				pos := i;
			end;
		end;
		// si mínimo es distinto al valor
		// leo el detalle de la pos guardada
		// en el registro de la pos guaradad
		if (min.cod <> valor)
			leer(vd[pos], vr[pos]);
	end;
	
	procedure actualizar(var mae: maestro; var vd: archivos; var arc_txt: Text);
	var
		min: venta;
		vr: registros;
		ins: insumo;
		i: integer;
	begin
		reset(mae);
		for i=1 to 30 do
		begin
			reset(vd[i], vr[i]);
		end;
		
		minimo(vd, vr, min);
		
		while (min.cod <> valor) do
		begin
			read(mae, ins);
			while (min.cod <> valor) and (min.cod == prod.cod) do
			begin
				ins.stock = ins.stock - min.stock;
				minimo(vd, vr, min);
				if (ins.stock < ins.stockMin) then
				begin
					writeln('Reponer insumo: ', ins.nombre);
					writeln('Descripcion: ', ins.desc);
					writeln('Stock actual: ', ins.stock);
					writeln('Mínimo: ', ins.stockMin);
				end;
				
				if (ins.receta) then
				begin
					writeln(arc_txt, 'Código: ', min.cod);
					writeln(arc_txt, 'Cantidad: ', min.cant);
					writeln(arc_txt, 'Cliente: ', min.nombreCli);
					writeln(arc_txt, 'Domicilio: ', min.domicilio);
				end;
				
			end;
			
			seek(mae, filepos(mae)-1);
			write(mae, prod);
		end;
		
		for i=1 to 30 do
			close(vd[i]);
		close(mae);
		close(arc_txt);
	end;
			
			
BEGIN
	assign(mae, 'maestro');
	
END.

