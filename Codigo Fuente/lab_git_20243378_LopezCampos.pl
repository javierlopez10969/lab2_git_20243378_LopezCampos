%Laboratorio número 2 paradigmas de programación
%Autor : Javier López ; RUN : 20.243.278-2
%Fecha de Inicio : 08 / 06 / 2020
%Para ejecutar el programa 
% [lab_git_20243378_LopezCampos].

%Base de Conocimientos 

%Reglas y hechos

%TDA Git
%REPRESENTACIÓN

%TDA debe considerar al menos 
%el nombre del repositorio git
%su fecha/hora de creación
%las 4 zonas de trabajo:
%-workspace
%-index
%-localRepository
%-remoteRepository

%Constructores

/*
Creamos espacio para una lista de 8 elementos
1.-Nombre del repositorio :
2.-Fecha de creación: 2020/05/20 15:40:10
3.-Autor: Juanito Perez
4.-rama actual: master
5.-Archivos en workspace:
a1.txt
asd.dat
blablabla.jpg
6.-Archivos en Index:
7.-Commits en local repository:[12AB1EFF] 'mensaje de ejemplo del primer commit'
a1.txt
[AAA8B1CCF] 'otro mensaje para segundo commit, se agrega
archivo asd.dat y blablabla.jpg'
asd.dat
blablabla.jpg
8.-Commits en remote repository:
[12AB1EFF] 'mensaje de ejemplo del primer commit'
a1.txt
*/
 
%Creador de la hora y fecha mediante los functor get_time y convert_time
getTime(Tiempo):-
	get_time(T),
	convert_time(T,Tiempo).

%Creador de archivos


%Predicados de Pertenencia
%Verifica el tipo de lista con los nombres de archivos

%Predicado que verifica la aridad correcta del repositorio, y compruebe que no este vacío el workspace
verificarInputAdd(Lista):- is_list(Lista), longitud(Lista, L) , L = 8,not(nth0(4,Lista,[])),true.
%False cases
%R1 = ["Mylab", "Tue Jul 21 16:56:35 2020", "Juanjo", "master", ["Samuel.txt","Jackson.pdf"], [], [], [],[]],verificarInputAdd(R1).
%R1 = ["Mylab", "Tue Jul 21 16:56:35 2020", "Juanjo", "master", ["Samuel.txt","Jackson.pdf"], [], [], [],[],[]],verificarInputAdd(R1).
%R1 = ["Mylab", "Tue Jul 21 16:56:35 2020", "Juanjo", "master", ["Samuel.txt","Jackson.pdf"], [], []],verificarInputAdd(R1).
%True Case
%R1 = ["Mylab", "Tue Jul 21 16:56:35 2020", "Juanjo", "master", ["Samuel.txt","Jackson.pdf"], [], [],[]],verificarInputAdd(R1).
%verificarInputAdd(["Mylab", "Tue Jul 21 16:56:35 2020", "Juanjo", "master", ["Samuel.txt","Jackson.pdf"], [], [],[]]).



%Predicado que verifica si corresponde a una lista de strings
es_Lista_String([]).
es_Lista_String([X|Y]):- string(X), es_Lista_String(Y).

%Predicado que verifica si es una lista tiene todos sus elementos en otra lista
%X elemento que se quiere verificar si se encuentra en la lista [A|B]
elemento_is_inside([],[_|_]):-!.
elemento_is_inside([X|Y],[A|B]):-member(X,[A|B]),elemento_is_inside(Y,[A|B]),!.
/*
R1 = ["Samuel.txt","Jackson.pdf"] , Arch = ["Samuel.txt","Jackson.pdf"],elemento_is_inside(Arch,R1).
elemento_is_inside(["Samuel.txt","Jackson.pdf"],["Samuel.txt","Jackson.pdf"] ).
elemento_is_inside(["Samuel.txt"],["Samuel.txt","Jackson.pdf"] ).
elemento_is_inside(["Samuel.txt","Jackson.pdf","KK.krit"],["Samuel.txt","Jackson.pdf"] ).
*/
%Selectores

%Modificadores 
% Operadores de listas 

%Borrar
borrar(X,[X|Y],Y).
borrar(X,[Z|L],[Z|M]):-borrar(X,L,M).
%L = [1,2,3,4],borrar(1,L,Lf).

%Caso borde llege a uno
borrarN(0,[_|Y],Y).
borrarN(N,[Z|L],[Z|M]):- N1 is N-1,borrarN(N1,L,M).
%L=[a,b,c,d,e,f],borrarN(3,L,F).

appendF(X,[Z|[]],[Z|[X|[]]]).
appendF(X,[Z|L],[Z|M]):-append2(X,L,M).
%L=[1,2,3],appendF(2,L,Lf).

insertar(E,L,[E|L]).
insertar(E,[X,Y],[X|Z]):-insertar(E,Y,Z).
%L=[a,b,c,d,e,f],insertar(n,L,F).

insertarN(0,E,[X|Y],[E|[X|Y]]).
insertarN(N,E,[X|Y],[X|Z]):-N1 is N-1,insertarN(N1,E,Y,Z).
%L=[a,b,c,d,e,f],insertarN(3,[2,3,4],L,F).

intercambiarN(0,E,[_|Y],[E|Y]).
intercambiarN(N,E,[X|Y],[X|Z]):-N1 is N-1,intercambiarN(N1,E,Y,Z).
%L=[a,b,c,d,e,f],intercambiarN(3,[2,3,4],L,F).
/*
R1 = ["Mylab", "Tue Jul 21 16:56:35 2020", "Juanjo", "master", ["Samuel.txt","Jackson.pdf"], [], [], []] , Arch = ["Samuel.txt","Jackson.pdf"] ,
intercambiarN(0,Arch,R1,RepoOutput).
*/

%Implementaciones

%Calculador de longitud de cualquier lista
longitud([],0).
longitud([_|Y],N):-longitud(Y,M),N is M+1.
%X =["Samuel.txt","Jackson.pdf"],longitud(X,N).

%Predicados principales por implementar ---------------------------------------------------------------------------------------------
%----------------------------------------------------------------------------------------------------------------------------------------------

%gitinit
%Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un nombre y autor. 
%RepoOutput tendría un repositorio vacío sin commits y sin archivos en sus zonas.
%ENTRADAS : gitInit(NombreRepo, Autor, RepoOutput).

%Ejemplo de uso :  gitInit(“lab3”, “Constanza Zarate”, RepoOutput).
%Al ser init, es decir el incio de creación no se requiere las ramas
gitInit(NombreRepo, Autor, RepoOutput):-string(NombreRepo),string(Autor),getTime(T),
										RepoOutput = [NombreRepo,T,Autor,"master",[],[],[],[]].
%Ejemplo de uso:
%gitInit("Mylab","Juanjo",R).

%----------------------------------------------------------------------------------------------------------------------------------------------

%gitAdd: Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un repositorio de entrada RepoInput tal que en RepoOutput se mueven los archivos 
%desde la zona Workspace a la zona Index. Puede hacerlo con la especificación de una lista de nombres de archivos concretos (nombres como strings).
%Los archivos vienen en una lista de string




%2 casos
%la lista de archivos se encuentra vacía, hacemos un corte, ya que no queremos más opciones
gitAdd(RepoInput,[],RepoOutput):-
								verificarInputAdd(RepoInput),
								nth0(4,RepoInput,Workspace),%Obtenemos el Workspace
								intercambiarN(5,Workspace,RepoInput,RepoOutput),!.
%Caso de que no se encuentre vacía
gitAdd(RepoInput, Archivos, RepoOutput):-
										is_list(Archivos),es_Lista_String(Archivos), %Verificación de la lista de archivos
										verificarInputAdd(RepoInput),%Verificamos la aridad y el workspace del RepInput
									  	nth0(4,RepoInput,Workspace),%Obtenemos el Workspace
									  	is_list(Workspace),%Nos aseguramos que sea una lista
										longitud(Archivos,NA) , longitud(Workspace,N),
										NA =< N,
										elemento_is_inside(Archivos,Workspace),%Me aseguro que los nombres dados se encuentran dento del workspace
										intercambiarN(5,Archivos,RepoInput,RepoOutput),!.

%RepoInput corresponde al repositorio de entrada a este predicado con las cuatro zonas de acuerdo a la representación escogida para este TDA. En la variable RepoOutput 
%debe retornar el resultado, esto aplica para todos los siguientes predicados que usen estas variables.

%gitAdd(RepoInput, Archivos, RepoOutput).
%Ejemplo de uso :  gitAdd(RepoInput, [ “file1.txt”, “f2.pl”, “archivo3.docx” ], RepoOutput).
%  				   gitadd(RepoInput, [ ], RepoOutput).

%Casos que dan false
%Porque el workspace se encuentra vacío
%gitInit("Mylab","Juanjo",Ri),Arch = ["texo.txt","imagen.jpg"],gitAdd(Ri,Arch,Ro).
%gitInit("Mylab","Juanjo",R),gitAdd(R,[],Routput).
%Porque el archivo dado es incorrecto
%R1 = ["Mylab", "Tue Jul 21 16:56:35 2020", "Juanjo", "master", ["Samuel.txt","Jackson.pdf"], [], [], []] , Arch = ["Jack.pdf"] ,  gitAdd(R1,Arch,RepoOutput).


%Casos que devuelven un valor
%Git add all
%R1 = ["Mylab", "Tue Jul 21 16:56:35 2020", "Juanjo", "master", ["Samuel.txt","Jackson.pdf"], [], [], []], gitAdd(R1,[],RepoOutput).
%Git add con distintas cantidades de archivos
%R1 = ["Mylab", "Tue Jul 21 16:56:35 2020", "Juanjo", "master", ["Samuel.txt","Jackson.pdf"], [], [], []] , Arch = ["Jackson.pdf"] ,  gitAdd(R1,Arch,RepoOutput).
%R1 = ["Mylab", "Tue Jul 21 16:56:35 2020", "Juanjo", "master", ["Samuel.txt","Jackson.pdf"], [], [], []] , Arch = ["Samuel.txt","Jackson.pdf"] ,  gitAdd(R1,Arch,RepoOutput).
%----------------------------------------------------------------------------------------------------------------------------------------------




%----------------------------------------------------------------------------------------------------------------------------------------------



%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------
