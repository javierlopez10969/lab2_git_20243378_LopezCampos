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

%Predicados Constructores

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

%Creador de archivo para agregarlos al workspace
crear_archivo(RepoInput,Archivo,RepoOutput):-
												verificarInputCrearArchivo(RepoInput),
												string(Archivo),
												nth0(4,RepoInput,Workspace),
												insertarF(Archivo,Workspace,NewWorkspace),
												intercambiarN(4,NewWorkspace,RepoInput,RepoOutput),!.
%Ejemplo de uso
%gitInit("PunPun","Inio",RepositorioInicial),crear_archivo(RepositorioInicial,"Volumen01.cbr",Rep),crear_archivo(Rep,"Volumen2.cbr",Rep01).
crear_archivos(RepoInput,[X|[]],RepoOutput):-
											string(X),
											crear_archivo(RepoInput,X,RepoOutput),!.
crear_archivos(RepoInput,[X|Y],RepoOutput):-
											string(X),
											crear_archivo(RepoInput,X,NewInput),
											crear_archivos(NewInput,Y,RepoOutput).
%gitInit("PunPun","Inio",RepositorioInicial),crear_archivos(RepositorioInicial,["Volumen01.cbr","Volumen02.cbr","Volumen4.cbr"],RF ).

%Creador de commit
crear_Commit([X|Y],Mensaje,Commit):-Commit = [Mensaje,[X|Y]|[]].

%Predicados de Pertenencia

%Predicado que verifica la aridad correcta del repositorio
verificarInputCrearArchivo(Lista):- 
									is_list(Lista),
									longitud(Lista, L) , L = 8,
									nth0(0,Lista,NombreRepo),string(NombreRepo),
									nth0(1,Lista,Fecha),string(Fecha),
									nth0(2,Lista,Autor),string(Autor),
									nth0(3,Lista,Branch),string(Branch),
									nth0(4,Lista,Workspace),is_list(Workspace),
									nth0(5,Lista,Index),is_list(Index),
									nth0(6,Lista,LocalRepository),is_list(LocalRepository),
									nth0(7,Lista,RemoteRepository),is_list(RemoteRepository),
									true.
%Predicado que verifica la aridad correcta del repositorio, y compruebe que no este vacío el workspace
verificarInputAdd(Lista):- 
							is_list(Lista),
							longitud(Lista, L) , L = 8,
							not(nth0(4,Lista,[])),
							nth0(0,Lista,NombreRepo),string(NombreRepo),
							nth0(1,Lista,Fecha),string(Fecha),
							nth0(2,Lista,Autor),string(Autor),
							nth0(3,Lista,Branch),string(Branch),
							nth0(4,Lista,Workspace),is_list(Workspace),
							nth0(5,Lista,Index),is_list(Index),
							nth0(6,Lista,LocalRepository),is_list(LocalRepository),
							nth0(7,Lista,RemoteRepository),is_list(RemoteRepository),
							true.
%Predicado que verifica la aridad correcta del repositorio, y compruebe que no este vacío el workspace ni el index
verificarInputCommit(Lista):- 
							is_list(Lista), longitud(Lista, L) , L = 8,
							not(nth0(4,Lista,[])),not(nth0(5,Lista,[])),
							nth0(0,Lista,NombreRepo),string(NombreRepo),
							nth0(1,Lista,Fecha),string(Fecha),
							nth0(2,Lista,Autor),string(Autor),
							nth0(3,Lista,Branch),string(Branch),
							nth0(4,Lista,Workspace),is_list(Workspace),
							nth0(5,Lista,Index),is_list(Index),
							nth0(6,Lista,LocalRepository),is_list(LocalRepository),
							nth0(7,Lista,RemoteRepository),is_list(RemoteRepository),
							true.
%Predicado que verifica la identidad de un respositorio con commits para ser enviados a remote repository
verificarInputPush(Lista):- 
							is_list(Lista), longitud(Lista, L) , L = 8,
							not(nth0(4,Lista,[])),not(nth0(6,Lista,[])),
							nth0(0,Lista,NombreRepo),string(NombreRepo),
							nth0(1,Lista,Fecha),string(Fecha),
							nth0(2,Lista,Autor),string(Autor),
							nth0(3,Lista,Branch),string(Branch),
							nth0(4,Lista,Workspace),is_list(Workspace),
							nth0(5,Lista,Index),is_list(Index),
							nth0(6,Lista,LocalRepository),is_list(LocalRepository),
							nth0(7,Lista,RemoteRepository),is_list(RemoteRepository),
							true.
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

insertarF(X,[],[X|[]]):-!.
insertarF(X,[Z|[]],[Z|[X|[]]]):-!.
insertarF(X,[Z|L],[Z|M]):-insertarF(X,L,M).
%L=[1,2,3],appendF(2,L,Lf).

insertar(E,L,[E|L]).
insertar(E,[X,Y],[X|Z]):-insertar(E,Y,Z).
%insertarF("Hola",[],Salida),insertarF("NAda más",Salida,Salida2).

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
%RepoInput corresponde al repositorio de entrada a este predicado con las cuatro zonas de acuerdo a la representación escogida para este TDA. En la variable RepoOutput 
%debe retornar el resultado, esto aplica para todos los siguientes predicados que usen estas variables.
%gitAdd(RepoInput, Archivos, RepoOutput).



%2 casos
%la lista de archivos se encuentra vacía, hacemos un corte, ya que no queremos más opciones
gitAdd(RepoInput,[],RepoOutput):-
								verificarInputAdd(RepoInput),
								nth0(4,RepoInput,Workspace),%Obtenemos el Workspace
								intercambiarN(5,Workspace,RepoInput,RepoOutput),!.
%Caso de que no se encuentre vacía
gitAdd(RepoInput, Archivos, RepoOutput):-
										is_list(Archivos),es_Lista_String(Archivos), %Verificación de la lista de archivos
										verificarInputAdd(RepoInput),%Verificamos la aridad y el workspace del RepoInput
									  	nth0(4,RepoInput,Workspace),%Obtenemos el Workspace
									  	is_list(Workspace),%Nos aseguramos que sea una lista
										longitud(Archivos,NA) , longitud(Workspace,N),
										NA =< N,
										elemento_is_inside(Archivos,Workspace),%Me aseguro que los nombres dados se encuentran dento del workspace
										intercambiarN(5,Archivos,RepoInput,RepoOutput),!.

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
%gitCommit: Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un repositorio de entrada RepoInput tal
%que en RepoOutput  hay un commit con los cambios almacenados en index y especificando un mensaje descriptivo (un string) para llevarlos al LocalRepository.
		
gitCommit(RepoInput, Mensaje, RepoOutput):-
											verificarInputCommit(RepoInput),
											string(Mensaje),
											nth0(5,RepoInput,Index),
											crear_Commit(Index,Mensaje,Commit),
											%write(Commit),write('\n'),
											nth0(6,RepoInput,LocalRepository),
											insertarF(Commit,LocalRepository,NewLocal),
											intercambiarN(6,NewLocal,RepoInput,R),
											intercambiarN(5,[],R,RepoOutput),!.	

%ejemplo de uso: gitCommit(RepoInput, “miCommit”, RepoOutput).

%Casos Falsos
%Falso porque tiene el workspace vacío
%gitInit("PunPun","Inio",R),gitCommit(R,"Hola",Rout).
%Falso porque tiene el index vacío
%gitInit("PunPun","Inio",RepositorioInicial),crear_archivos(RepositorioInicial,["Volumen01.cbr","Volumen02.cbr","Volumen4.cbr"],R),gitCommit(R,"Hola",Rout).

%Casos Verdaderos
%Add all
%gitInit("PunPun","Inio",R0),crear_archivos(R0,["Volumen01.cbr","Volumen02.cbr","Volumen4.cbr"],R1),gitAdd(R1,[],R2),gitCommit(R2,"Primeros volumenes",Rout).
%Add algunos
%gitInit("PunPun","Inio",R0),crear_archivos(R0,["Volumen01.cbr","Volumen02.cbr","Volumen4.cbr"],R1),gitAdd(R1,["Volumen02.cbr"],R2),gitCommit(R2,"Algunos volumenes",Rout).
%gitInit("PunPun","Inio",R0),crear_archivo(R0,"Volumen01.cbr",R1),gitAdd(R1,["Volumen01.cbr"],R2),gitCommit(R2,"Primer Volumen",Rout).
%----------------------------------------------------------------------------------------------------------------------------------------------
%Predicado que permite buscar dentri del remoteRepository si se encuentra o no un commit
recorrerLocal([],_,_,_):-!.

recorrerLocal([X|[]],RemoteRepository,RepoInput,RepoOutput):-
															not(member(X,RemoteRepository)),%preguntamos si el elemento no se encuentra dentro de Remote repository
															insertarF(X,RemoteRepository,NewRemote),
															intercambiarN(7,NewRemote,RepoInput,RepoOutput).

recorrerLocal([X|Y],RemoteRepository,RepoInput,RepoOutput):-
										not(member(X,RemoteRepository)),%preguntamos si el elemento no se encuentra dentro de Remote repository
										insertarF(X,RemoteRepository,NewRemote),
										intercambiarN(7,NewRemote,RepoInput,R),
										recorrerLocal(Y,NewRemote,R,RepoOutput),!.

recorrerLocal([X|Y],RemoteRepository,RepoInput,RepoOutput):-
										member(X,RemoteRepository),%preguntamos si el elemento se encuentra dentro de Remote repository
										recorrerLocal(Y,RemoteRepository,RepoInput,RepoOutput).			
%gitPush: Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un repositorio de entrada RepoInput tal que en RepoOutput se envían 
%los commit desde el repositorio local al repositorio remoto registrado en las zonas de trabajo.
gitPush(RepoInput, RepoOutput):-
								verificarInputPush(RepoInput),
								nth0(6,RepoInput,LocalRepository),
								nth0(7,RepoInput, RemoteRepository),
								%write(RemoteRepository),	
								recorrerLocal(LocalRepository,RemoteRepository,RepoInput,RepoOutput),!.

%gitInit("Unity Project","Playdead",R0),crear_archivos(R0,["PlayerController.cs","EnemyPatrol.cs"],R1),gitAdd(R1,[],R2),gitCommit(R2,"Character controllers",R3),gitPush(R3,Rout).
%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------
