%Se conocen las principales ciudades turísticas del país y algunos de sus datos.
%ciudad(ciudad, AnioFundacion, provincia).

ciudad(mdq, 1876, bsas).
ciudad(bariloche, 1880, rionegro).
ciudad(viedma, 1776, rionegro).
ciudad(calafate, 1930, stacruz).
ciudad(lanus, 1888, bsas).

%De cada ciudad se tiene un registro de las cantidades de establecimientos de cada categoría de alojamiento. Por ejemplo, en Bariloche hay 12 hoteles y 5 hosterías.
%alojamiento(ciudad, alojamiento, cantidad).

alojamiento(bariloche, camping, 2).
alojamiento(bariloche, hotel, 12).
alojamiento(bariloche, hosteria, 5).
alojamiento(mdq, hotel, 100).
alojamiento(mdq, camping, 10).
alojamiento(mdq, residencial, 5).
alojamiento(mdq, hosteria, 5).
alojamiento(viedma, camping, 3).
alojamiento(calafate, camping, 2).
alojamiento(calafate, hosteria, 3).

%Se sabe también la capacidad máxima promedio de cada categoría de alojamiento. Por ejemplo, los hoteles tienen lugar para 50 personas máximo.

capacidad(hotel, 50).
capacidad(camping, 100).
capacidad(hosteria, 30).
capacidad(residencial, 10).

%Hay también información adicional:

provinciaGrande(bsas,0.9).
provinciaPatagonica(rionegro,2010).
provinciaPatagonica(stacruz,2003).
provinciaComun(cordoba).

montoPorLugar(10).

coeficiente(comun, 1.1).
coeficiente(2010, 1.2).
coeficiente(2009, 1.4).
coeficiente(2008, 1.5).
coeficiente(2003, 2.0). %agregado personalmente para poder obtener su coeficiente

% 1) Realizar predicados que resuelvan lo siguiente y justificar si son inversibles o no. Mostrar ejemplos de consulta.
% a)Las provincias que tengan más de una ciudad turística que se haya fundado en un siglo determinado.

mismoSiglo(Anio1, Anio2):- (Anio1 // 100) == (Anio2 // 100). % // es division entera

provinciasTuristicas(Provincia):-
    ciudad(Ciudad1, Anio1, Provincia),
    ciudad(Ciudad2, Anio2, Provincia),
    mismoSiglo(Anio1, Anio2),
    Ciudad1 \= Ciudad2.

% b)Las provincias con alguna ciudad que no disponga de lugares de alojamiento.
provinciaSinAlojamiento(Provincia):-
    ciudad(Ciudad,_, Provincia),
    not(alojamiento(Ciudad,_,_)).

% c)Las ciudades con una única categoría de alojamiento
unicoAlojamiento(Ciudad):-
    alojamiento(_, Categoria, _),
    forall(alojamiento(Ciudad,Categoria,_), ciudad(Ciudad,_,_)).

% 2)RESOLVER
% a) capacidad/3 La cantidad de lugares disponibles de una ciudad según el tipo de alojamiento
%capacidad(calafate , camping, Capacidad)
%Capacidad = 200
%(100 por cada uno de los 2 campings)

capacidad(Ciudad, Categoria, Capacidad):-
    ciudad(Ciudad, _, _),
    alojamiento(Ciudad, Categoria, Cantidad),
    capacidad(Categoria, Promedio),
    Capacidad is (Promedio * Cantidad).

% b) mayorCategoriaDeAlojamiento/2 Relaciona cada  ciudad, con la categoria de alojamiento que más lugares dispone
%mayorCategoriaDeAlojamiento(calafate , Categoria)
%Categoria = camping
%(200 para el camping contra 90 de las hosterias) 

mayorCategoriaDeAlojamiento(Ciudad, Categoria):-
    alojamiento(Ciudad, Categoria, _),
    capacidad(Ciudad, Categoria1, Capacidad),
    forall(capacidad(Ciudad, Categoria2, Capacidad1), Capacidad1 >= Capacidad).

% c)mayorCiudadCon/2 Relaciona cada  categoria de alojamiento con la ciudad que mas lugares dispone de dicha categoría. 
%mayorCiudadCon(Ciudad , camping)
%Ciudad = mdq
%(tiene más que bariloche y calafate) 

mayorCiudadCon(Ciudad, Categoria):-
    alojamiento(Ciudad, Categoria, Cantidad),
    forall(alojamiento(CiudadX, Categoria, Cantidad1), Cantidad >= Cantidad1).

% 3) La Secretaría de turismo implementa un sistema de susidios para fomentar la actividad, por el que transfiere fondos a las ciudades. El monto a transferir equivale a un monto fijo (que actualmente es de $10) por cada lugar disponible, por un coeficiente que depende de la provincia que sea: Para las provincias patagónicas el coeficiente depende del año de incorporación al sistema de subsidios, para los provincias grandes se sabe el coeficiente que le corresponde a cada una y para las provincias comunes, el coeficiente es para todos el mismo. Se desea saber cuántos fondos le corresponden a cada ciudad por cada categoría de alojamiento. 

coeficienteProvincial(Provincia, Coeficiente):-
    provinciaPatagonica(Provincia, Anio),
    coeficiente(Anio, X),
    Coeficiente is X.

coeficienteProvincial(Provincia, Coeficiente):-
    provinciaGrande(Provincia, X),
    Coeficiente is X.

coeficienteProvincial(Provincia, Coeficiente):-
    provinciaComun(Provincia),
    coeficiente(comun, X),
    Coeficiente is X.

cuantosFondos(Ciudad, Categoria, Fondos):-
    ciudad(Ciudad, _, Provincia),
    coeficienteProvincial(Provincia, Coeficiente),
    capacidad(Ciudad, Categoria, Capacidad),
    Fondos is (10 * Capacidad * Coeficiente).