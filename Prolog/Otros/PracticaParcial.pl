%bebida(Bebida, Temperatura, tipoDeBebida).
bebida(teManzanilla, caliente, te(manzanilla)).
bebida(frapuccinoOreo, frio, frapuccino([leche, cafe, chocolate, oreo])).
bebida(lagrima, caliente, cafe(2, 98)).
bebida(cortado, caliente, cafe(50, 50)).
bebida(smoothieFrutilla, frio, smoothie(frutilla)).

%Pensamos en el frapuccino de coco y dulce de leche, que valdría $75, tanto a base de crema como a base de café.
%frapuccino de coco
bebida(frapuccinoCocoCafe, frio, frapuccino([leche, cafe, coco, oreo])).
bebida(frapuccinoCocoCrema, frio, frapuccino([leche, crema, coco, oreo])).

%frapuccino de dulce de leche
bebida(frapuccinoDulceCafe, frio, frapuccino([leche, cafe, dulceDeLeche, oreo])).
bebida(frapuccinoDulceCrema, frio, frapuccino([leche, crema, dulceDeLeche, oreo])).

%También un té de frutos rojos cuyo precio sería $40.
bebida(teFrutosRojos, caliente, te(frutosRojos)).

% cafe(PorcentajeDeCafe, PorcentajeDeLeche).
% te(GustoDeTe).
% smoothie(GustoDeSmoothie).
% frapuccino(Composicion).

%precio(Bebida, Precio).
precio(teManzanilla, 70).
precio(frapuccinoOreo, 90).
precio(lagrima, 50).
precio(cortado, 35).
precio(smoothieFrutilla, 80).
precio(frapuccinoCocoCafe, 75).
precio(frapuccinoCocoCrema, 75).
precio(frapuccinoDulceCafe, 75).
precio(frapuccinoDulceCrema, 75).
precio(teFrutosRojos, 40).
%Lamentablemente no vamos a vender frapuccinos de galletitas Toddy. Por el principio de universo cerrado, no se incluye este predicado

%pedido(Cliente, Bebida).
pedido(isaacAsimov, cortado).
pedido(stephenKing, teManzanilla).
pedido(stephenKing, cortado).
pedido(neilGaiman, frapuccinoOreo).
pedido(neilGaiman, lagrima).
pedido(neilGaiman, teManzanilla).

% Las relaciones se realizan a nivel bebida y no a nivel tipoDeBebida

esCopado(Cliente):-
    compraTodoCopado(Cliente),
    not(pidioTe(Cliente)).

compraTodoCopado(Cliente):- pedido(Cliente, _),  % Agrego un generador para que sea inversible
    forall(pedido(Cliente, Bebida), bebidaCopada(Bebida)).

bebidaCopada(Bebida):- bebida(Bebida, _, cafe(_, _)).

bebidaCopada(Bebida):- bebida(Bebida, _, frapuccino(Composicion)), member(chocolate, Composicion).

bebidaCopada(Bebida):- bebida(Bebida, _, smoothie(frutilla)).

pidioTe(Cliente):-
    bebida(Bebida, _, te(_)),
    pedido(Cliente, Bebida).

esMami(Cliente):-
    forall(pedido(Cliente, Bebida), bebidaMami(Bebida)).

bebidaFria(Bebida):- 
    bebida(Bebida, frio, _).

bebidaDescafeinada(Bebida):- 
    bebida(Bebida, _, cafe(Cafe, Leche)),
    Leche > Cafe.

bebidaMami(Bebida):- 
    bebidaFria(Bebida);
    bebidaDescafeinada(Bebida).

clienteRegular(Cliente):- pedido(Cliente, _),
    findall(Precio, (pedido(Cliente, Bebida), precio(Bebida, Precio)), Precios),
    sum_list(Precios, Sum),
    Sum > 600.

precioPorTamanio(Bebida, Tamanio, Valor):-
    precio(Bebida, Precio),
    aumentoPorTamanio(Tamanio, Incremento),
    Valor is Precio * Incremento.

aumentoPorTamanio(alto, 1).
aumentoPorTamanio(grande, 1.1).
aumentoPorTamanio(venti, 1.25).
