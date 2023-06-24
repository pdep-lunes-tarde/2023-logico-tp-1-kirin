% ## Punto 1: empleados

% Una empresa está buscando candidatos para varios de sus sectores. Se sabe que:

% - Roque es contador, honesto y ambicioso.
% - Ana es ingeniera y honesta, pero no es ambiciosa.
% - Cecilia es abogada.

% a) Escribí una base de conocimiento que permita consultarla de la siguiente forma:

% ? honesto(ana).
% true.

% Hechos

candidato(roque, contador).
candidato(roque, honesto).
candidato(roque, ambicioso).

candidato(ana, ingeniera).
candidato(ana, honesto).

candidato(cecilia, abogada).

trabajo(roque, utn).
trabajo(cecilia, utn).

% Reglas

honesto(Empleado) :-
  candidato(Empleado, honesto).

% Ahora queremos saber qué empleados pueden servir para un sector dado.

% Sabiendo lo que declaramos en el punto a) y además que Roque y Cecilia trabajaron en la utn,

% b) desarrollá un predicado `puedeAndar/2` que relaciona a un sector con un empleado si este puede trabajar allí. Considerar que:

% - en contaduria solo pueden trabajar contadores honestos
% - en ventas solo pueden trabajar ambiciosos que tienen experiencia (gente que haya trabajado en algun lugar antes)
% - y lucia siempre puede trabajar en ventas 

ambicioso(Empleado):-
  candidato(Empleado, ambicioso).

puedeAndar(Empleado,contaduria):-
  candidato(Empleado, contador),
  candidato(Empleado, honesto).

puedeAndar(Empleado,ventas):-
  candidato(Empleado, ambicioso),
  trabajo(Empleado, _).

puedeAndar(lucia,ventas).


:- begin_tests(punto_1).

test(un_contador_honesto_puede_trabajar_en_contaduria, nondet):-
    puedeAndar(roque, contaduria).

test(una_persona_con_experiencia_y_ambicion_puede_trabajar_en_ventas, nondet):-
    puedeAndar(roque, ventas).

test(lucia_puede_trabajar_en_ventas, nondet):-
    puedeAndar(lucia, ventas).

:- end_tests(punto_1).


% ## Punto 2: el asesinato de Tia Agatha

% Para este punto, no es necesario que escriban tests sobre quien es el asesino (sí sobre a quien odiaría c/u), dejemos que el programa lo descubra por nosotros :).

% ? asesino(agatha, Asesino).
% Asesino = ???

% **Nota:** No agregues información que no se provea en el enunciado. Al asumir ciertas cosas que no se explicitan podés llegar a un resultado distinto del esperado.

% Hechos

% - Tía Agatha, el carnicero y Charles son las únicas personas que viven en la mansion.
viveEnMansion(agatha).
viveEnMansion(carnicero).
viveEnMansion(charles).

% - Agatha odia a todos los que viven en la mansión, excepto al carnicero.
odia(agatha,charles).
odia(agatha,agatha).

% - Charles odia a todas las personas de la mansión que no son odiadas por la tía Agatha.
odia(charles,carnicero).

% - El carnicero odia a las mismas personas que odia tía Agatha. 
odia(carnicero,charles).
odia(carnicero,agatha).

% - Quien no es odiado por el carnicero (carnicero) y vive en la mansión, es más rico que tía Agatha
masRicoQue(agatha,carnicero).

% Reglas

% - Un asesino siempre odia a su víctima y nunca es más rico que ella. El asesino de la tía Agatha, además, vive en la mansión Dreadbury.
asesino(agatha, Asesino):-
    odia(Asesino,agatha),
    viveEnMansion(Asesino),
    not(masRicoQue(agatha,Asesino)).

:- begin_tests(punto_2).

test(las_personas_que_son_odiadas_por_agatha, nondet):-
    odia(agatha,charles),
    odia(agatha,agatha).

test(las_personas_que_son_odiadas_por_charles, nondet):-
    odia(charles,carnicero).

test(las_personas_que_son_odiadas_por_el_carnicero, nondet):-
    odia(carnicero,charles),
    odia(carnicero,agatha).

:- end_tests(punto_2).