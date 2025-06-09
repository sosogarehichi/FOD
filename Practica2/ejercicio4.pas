{
4. Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados. 
De cada producto se almacena: código del producto, nombre, descripción, stock disponible, 
stock mínimo y precio del producto. 
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se 
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo 
maestro. La información que se recibe en los detalles es: código de producto y cantidad 
vendida. Además, se deberá informar en un archivo de texto: nombre de producto, 
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por 
debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo 
procedimiento de actualización, o realizarlo en un procedimiento separado (analizar 
ventajas/desventajas en cada caso).

Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle 
puede venir 0 o N registros de un determinado producto. 
   
}


program ejercicio4;


const
	valor = 9999;

type
	
	producto = record
		cod: integer;
		nombre: String;
		descripcion: String[30];
		stock: integer;
		stock_min: integer;
		precio: real;
	end;
	
	maestro = file of producto;
	
	venta = record
		cod: integer;
		cant: integer;
	end;
	
	detalle = file of venta;
	
	archivos = array[1..30] of detalle;
	registros = array[1..30] of venta;
	
	// usando el vector de archivos se le asigna a
	// cada archivo det un nombre según su pos
	procedure asignar_detalle(var det: archivos);
	var
		i: integer;
		nombre: String;
	begin
		for i=1 to 30 do
		begin
			nombre:= 'Detalle' + IntToStr(i) + '.dat';
			assign(det[i], nombre);
		end;
	end;
	
	procedure leer(var det: detalle; var regd: venta);
	begin
		if not EOF(det) then
			read(det, regd);
		else
			regd.cod := valor;
	end;

	procedure minimo(var vd: archivos; var vr: registros; var min: venta);
	var
		pos, i: integer;
	begin
		pos:= 1;
		min.cod:= valor; // se inicializa el max
		for i:= 1 to 30 do // iteración sobre los registros
		begin
			if (vr[i].cod < min.cod) then
			begin
				min:= vr[i];
				pos:= i; // guarda la posición en el vector
			end;
		end;
		// si el min no es el valor alto
		if (min.cod <> valor) then
		begin
			// se lee el sig dato del archivo detalle que quede con
			// el minimo
			leer(vd[pos], vr[pos]);
		end;
	end;
		
		procedure actualizar(var mae: maestro; var vd: archivos; var arc_txt: Text);
		var
			min: venta;
			vr: registros;
			prod: producto;
			i: integer;
		begin
			reset(mae);
			assign(arc_txt, 'stock_minimo.txt');
			rewrite(arc_txt);
			// lee el 1er registro de cada archivo det
			for i:= 1 to 30 do
			begin
				reset(vd[i]);
				leer(vd[i], vr[i]);
			end;
			
			minimo(vd, vr, min);
			// mientras el cod sea distinto de valor
			// significa que no se llegó al final de ese archivo
			// avanza en el maestrp
			while (min.cod <> valor) do
			begin
				read(mae, prod);
				// mientras:
				// código sea distinto de valor = no se llegó al fin del detalle
				// y el producto del detalle y el maestro sean el mismo
				// actualiza el stock
				while (min.cod <> valor) and (min.cod = prod.cod) do
				begin
					prod.stock:= prod.stock - min.cant;
					minimo(vd, vr, min);
				end;
				seek(mae, filepos(mae)-1);
				write(mae, prod);

				if (prod.stock < prod.stock_min) then
				begin
					writeln(arc_txt, 'Código producto: ', prod.cod);
					writeln(arc_txt, 'Producto: ',prod.nombre);
					writeln(arc_txt, 'Precio: ', prod.precio);
					writeln(arc_txt, 'Stock actual: ', prod.stock);
					writeln(arc_txt, 'Stock min: ', prod.stock_min);
					writeln(arc_txt, '-----------------------');
				end;
			end;
			for i:= 1 to 30 do
				close(vd[i]);
			close(mae);
			close(arc_txt);
		end;
			
BEGIN
	
	
END.

