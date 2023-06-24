
% Una empresa está buscando candidatos para varios de sus sectores. Se sabe que:

% - Roque es contador, honesto y ambicioso.
% - Ana es ingeniera y honesta, pero no es ambiciosa.
% - Cecilia es abogada.

% a) Escribí una base de conocimiento que permita consultarla de la siguiente forma:

% ```prolog
% ? honesto(ana).
% true.
% ```

honesto(roque).
honesto(ana).

contador(roque).
ingeniero(ana).
abogado(cecilia).

ambicioso(roque).

trabajoEn(roque, utn).
trabajoEn(cecilia, utn).

% Ahora queremos saber qué empleados pueden servir para un sector dado.

% Sabiendo lo que declaramos en el punto a) y además que Roque y Cecilia trabajaron en la utn,

% b) desarrollá un predicado `puedeAndar/2` que relaciona a un sector con un empleado si este puede trabajar allí. Considerar que:

% - en contaduria solo pueden trabajar contadores honestos
% - en ventas solo pueden trabajar ambiciosos que tienen experiencia (gente que haya trabajado en algun lugar antes)
% - y lucia siempre puede trabajar en ventas 

puedeAndar(Empleado, contaduria):-honesto(Empleado), contador(Empleado).
puedeAndar(Empleado, ventas):-ambicioso(Empleado), trabajoEn(Empleado, _).
puedeAndar(lucia, ventas).


:- begin_tests(tp1).
test(un_contador_honesto_puede_trabajar_en_contaduria, nondet):-
    puedeAndar(roque, contaduria).
test(una_persona_ambiciosa_con_experiencia_puede_trabajar_en_ventas, nondet):-
    puedeAndar(roque, ventas).
test(lucia_puede_trabajar_en_ventas, nondet):-
    puedeAndar(lucia, ventas).
:- end_tests(tp1).



% Escribí un programa Prolog que resuelva el siguiente problema lógico:

% Un asesino siempre odia a su víctima y nunca es más rico que ella. El asesino de la tía Agatha, además, vive en la mansión Dreadbury.
% Tía Agatha, el carnicero y Charles son las únicas personas que viven en la mansion.
% Charles odia a todas las personas de la mansión que no son odiadas por la tía Agatha.
% Agatha odia a todos los que viven en la mansión, excepto al carnicero.
% Quien no es odiado por el carnicero y vive en la mansión, es más rico que tía Agatha
% El carnicero odia a las mismas personas que odia tía Agatha.
% Al programa le tengo que poder preguntar quién es el asesino de la tía Agatha, y tiene que brindar una sola respuesta, de la siguiente forma:

% ? asesino(agatha, Asesino).
% Asesino = ???
% Nota: No agregues información que no se provea en el enunciado. Al asumir ciertas cosas que no se explicitan podés llegar a un resultado distinto del esperado.


viveEnMansion(agatha).
viveEnMansion(carnicero).
viveEnMansion(charles).

odiaA(agatha, Persona) :- viveEnMansion(Persona), Persona \= carnicero.
odiaA(carnicero, Persona) :- odiaA(agatha, Persona).
odiaA(charles, Persona) :- viveEnMansion(Persona), not(odiaA(agatha, Persona)).

esMasRicoQue(agatha, Persona) :- not(odiaA(carnicero, Persona)), viveEnMansion(Persona).


asesino(Victima, Asesino):-odiaA(Asesino, Victima), viveEnMansion(Asesino), not(esMasRicoQue(agatha, Asesino)).

:- begin_tests(tp1p2).
test(personas_a_quienes_odia_agatha, nondet):-
    odiaA(agatha, charles),
    odiaA(agatha, agatha).
test(personas_a_quienes_odia_charles, nondet):-
    odiaA(charles, carnicero).
test(personas_a_quienes_odia_el_carnicero, nondet):-
    odiaA(carnicero, agatha),
    odiaA(carnicero, charles).
:- end_tests(tp1p2).