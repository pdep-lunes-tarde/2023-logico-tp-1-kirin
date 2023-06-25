/* 
    swipl nombre.pl
    Comandos de swipl:
    run_tests(nombre). : correr un conjunto en específico de tests;
    run_tests.: correr todos los tests del archivo;
    halt.: salir del swipl;
    make.: recargar cambios.
*/

%   Punto 1: empleados

%   Una empresa está buscando candidatos para varios de sus sectores. Se sabe que:
    %   Roque es contador, honesto y ambicioso.
    %   Ana es ingeniera y honesta, pero no es ambiciosa.
    %   Cecilia es abogada.
contador(roque).
honesto(roque).
honesto(ana).
ambicioso(roque).
ingeniera(ana).
abogada(cecilia).

%   Sabiendo lo que declaramos en el punto a) y además que Roque y Cecilia trabajaron en la utn.
trabajarEn(roque, utn).
trabajarEn(cecilia, utn).

%   b) desarrollá un predicado puedeAndar/2 que relaciona a un sector con un empleado si este puede trabajar allí. 
    % Considerar que:
%   en contaduria solo pueden trabajar contadores honestos
%   en ventas solo pueden trabajar ambiciosos que tienen experiencia (gente que haya trabajado en algun lugar antes)
%   y lucia siempre puede trabajar en ventas

puedeAndar(Empleado, contaduria) :- 
    honesto(Empleado), 
    contador(Empleado).

puedeAndar(Empleado, ventas) :- 
    ambicioso(Empleado), 
%   experiencia.
    trabajarEn(Empleado, _).

puedeAndar(lucia, ventas). 


:- begin_tests(tp1_1).
%   Un contador honesto puede trabajar en contaduria.
test(un_contador_honesto_puede_trabajar_en_contaduria, nondet):-
    puedeAndar(roque, contaduria).

%   Un empleado ambiciosos con experiencia puede trabajar en ventas.
test(un_empleado_ambiciosos_con_experiencia_puede_trabajar_en_ventas, nondet):-
    puedeAndar(roque, ventas). 

%   Lucia siempre puede trabajar en ventas.
test(lucia_siempre_puede_trabajar_en_ventas, nondet):-
    puedeAndar(lucia, ventas). 
:- end_tests(tp1_1).


%   Punto 2: el asesinato de Tia Agatha

%   Tía Agatha, el carnicero y Charles son las únicas personas que viven en la mansion.
viveEnLaMansion(agatha).
viveEnLaMansion(carnicero).
viveEnLaMansion(charles).

%   Agatha odia a todos los que viven en la mansión, excepto al carnicero.
odiaA(agatha, Persona) :-
    viveEnLaMansion(Persona),
    Persona \= carnicero.

%   Charles odia a todas las personas de la mansión que no son odiadas por la tía Agatha.
odiaA(charles, Persona) :-
    viveEnLaMansion(Persona),
    not(odiaA(agatha, Persona)).

%   Quien no es odiado por el carnicero y vive en la mansión, es más rico que tía Agatha.
esMasRicoQue(Persona, agatha) :-
    viveEnLaMansion(Persona),
    not(odiaA(carnicero, Persona)).

%   El carnicero odia a las mismas personas que odia tía Agatha.
odiaA(carnicero, Persona) :-
    viveEnLaMansion(Persona),
    odiaA(agatha, Persona).

%   Un asesino siempre odia a su víctima y nunca es más rico que ella. El asesino de la tía Agatha, además, vive en la mansión Dreadbury.
asesino(agatha, Asesino) :-
    viveEnLaMansion(Asesino),
    odiaA(Asesino, agatha),
    not(esMasRicoQue(Asesino, agatha)).

:- begin_tests(tp1_2).
%   Las personas que son odiadas por tía Agatha.
test(las_personas_que_son_odiadas_por_tia_agatha, nondet):-
%   agatha odia a charles.
    odiaA(agatha, charles),
%   agathe odia a agathe.
    odiaA(agatha, agatha).

%   Las personas que son odiadas por charles.
test(las_personas_que_son_odiadas_por_charles, nondet):-
%   charles odia a carnicero.
    odiaA(charles, carnicero).

%   Las personas que son odiadas por el carnicero.
test(las_personas_que_son_odiadas_por_el_carnicero, nondet):-
%   el carnicero odia a charles.
    odiaA(carnicero, charles),
%   el carnicero odia a agatha.
    odiaA(carnicero, agatha).
:- end_tests(tp1_2).