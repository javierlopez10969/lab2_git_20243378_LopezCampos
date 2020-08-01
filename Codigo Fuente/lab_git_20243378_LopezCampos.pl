%Laboratorio número 2 paradigmas de programación
%Autor : Javier López ; RUN : 20.243.278-2
%Fecha de Inicio : 08 / 06 / 2020
%Para ejecutar el programa 
% [lab_git_20243378_LopezCampos].

%Dominio:
% RepoInput  : Variable del tipo Repositorio
% RepoOutput : Variable del tipo Repositorio
% Lista : Posible variable del tipo Repositorio
% Archivo : Variable del tip String
% [X | Y] = representación de una lista, X cabeza, Y cola


%Predicados:
%  crear_archivo(RepoInput,Archivo,RepoOutput).
%  verificarInput(Lista).



%Base de Conocimientos 

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

 %Reglas y hechos

%Creador de la hora y fecha mediante los functor get_time y convert_time
%Variable de Entrada
%Un string de Salida
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
%crear_Commit([X|Y],Mensaje,Commit):-Commit = string_concat(Mensaje,"\n",S),[S,[X|Y]|[]].

%Predicados de Pertenencia

%Todos son para comprobar la identidad del repositorio en cada función.
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
verificarInputStatus(Lista):-
							is_list(Lista), longitud(Lista, L) , L = 8,
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

/*
%Borrar
borrar(X,[X|Y],Y).
borrar(X,[Z|L],[Z|M]):-borrar(X,L,M).
%L = [1,2,3,4],borrar(1,L,Lf).

%Caso borde llege a uno
borrarN(0,[_|Y],Y).
borrarN(N,[Z|L],[Z|M]):- N1 is N-1,borrarN(N1,L,M).
%L=[a,b,c,d,e,f],borrarN(3,L,F).
*/
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
%ENTRADAS : NombreRepo = string Autor = string RepoOutput = Repositorio
%Salida : Repositorio 

%Ejemplo de uso :  gitInit(“lab3”, “Constanza Zarate”, RepoOutput).
%Al ser init, es decir el incio de creación no se requiere las ramas
gitInit(NombreRepo, Autor, RepoOutput):-string(NombreRepo),string(Autor),getTime(T),
										RepoOutput = [NombreRepo,T,Autor,"master",[],[],[],[]].
%Ejemplo de uso:
%gitInit("Mylab","Juanjo",R).
%gitInit("Unity Prject","PlayDead",Rep).
%gitInit("libreria.h","Linus",R1).

%----------------------------------------------------------------------------------------------------------------------------------------------

%gitAdd: Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un repositorio de entrada RepoInput tal que en RepoOutput se mueven los archivos 
%desde la zona Workspace a la zona Index. Puede hacerlo con la especificación de una lista de nombres de archivos concretos (nombres como strings).
%Los archivos vienen en una lista de string
%RepoInput corresponde al repositorio de entrada a este predicado con las cuatro zonas de acuerdo a la representación escogida para este TDA. En la variable RepoOutput 
%debe retornar el resultado, esto aplica para todos los siguientes predicados que usen estas variables.
%gitAdd(RepoInput, Archivos, RepoOutput).

%Entradas : Repo]input , lista con archivso string
%SalidaS : RepoOutput


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
%gitInit("PunPun","Inio",R0),crear_archivos(R0,["Volumen01.cbr","Volumen02.cbr","Volumen4.cbr"],R1),gitAdd(R1,[],R2).

%----------------------------------------------------------------------------------------------------------------------------------------------
%gitCommit: Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un repositorio de entrada RepoInput tal
%que en RepoOutput  hay un commit con los cambios almacenados en index y especificando un mensaje descriptivo (un string) para llevarlos al LocalRepository.
%Entradas : RepoInput, Mensaje = String 
%Salidas : RepoOutput

gitCommit(RepoInput, Mensaje, RepoOutput):-
											verificarInputCommit(RepoInput),
											string(Mensaje),
											nth0(5,RepoInput,Index),
											crear_Commit(Index,Mensaje,Commit),
											%write(Commit),write('\n'),
											nth0(6,RepoInput,LocalRepository),
											insertar(Commit,LocalRepository,NewLocal),
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
%Entradas : Repositorio de entrada con un commit minimo
%Salida : Repositorio 
gitPush(RepoInput, RepoOutput):-
								verificarInputPush(RepoInput),
								nth0(6,RepoInput,LocalRepository),
								nth0(7,RepoInput, RemoteRepository),
								%write(RemoteRepository),	
								recorrerLocal(LocalRepository,RemoteRepository,RepoInput,RepoOutput),!.

/*
Ejemplo de uso

1.-

gitInit("Unity Project","Playdead",R0),
crear_archivos(R0,["PlayerController.cs","EnemyPatrol.cs"],R1),
gitAdd(R1,[],R2),
gitCommit(R2,"Character controllers",R3),
gitPush(R3,Rout).

2.-

3.-


*/
%----------------------------------------------------------------------------------------------------------------------------------------------	

%git2String: Predicado que permite consultar el valor que debe tomar un String con una representación como un string posible de

%Predicado que permite concatenar una lista de elementos a un string ya existente, para eso se crea un predicado para cada zona y tranformarla a string.
%Entradas : Repositorio
%Salida : Repositorio transformado a una variable string


%Caso borde, lista de elementos vacía
workspace2String([],StringEntrada,String):-string_concat(StringEntrada,"Workspace Vacío\n",String),!.
%Caso borde, siguiente elemento vacío
workspace2String([X|[]],StringEntrada,String):-string_concat(StringEntrada,X,S),string_concat(S,"\n",String),!.
%Llamada recursiva, cuando si existe un siguiente elemnto en la lista
workspace2String([X|Y],StringEntrada,String):-string_concat(StringEntrada,X,S),string_concat(S,"\n",NewString),workspace2String(Y,NewString,String).

%Predicado que hace lo mismo que workspace2String, solo que en un caso borde necesita decir Index Vacío

%Caso borde, lista de elementos vacía
index2String([],StringEntrada,String):-string_concat(StringEntrada,"Index Vacío\n",String),!.
%Caso borde, siguiente elemento vacío
index2String([X|[]],StringEntrada,String):-string_concat(StringEntrada,X,S),string_concat(S,"\n",String),!.
%Llamada recursiva, cuando si existe un siguiente elemnto en la lista
index2String([X|Y],StringEntrada,String):-string_concat(StringEntrada,X,S),string_concat(S,"\n",NewString),index2String(Y,NewString,String).

%Predicado que transforma local repository a un string

%Caso borde, lista de elementos vacía
local2String([],StringEntrada,String):-string_concat(StringEntrada,"Local Repository Vacío\n",String),!.
local2String([X|[]],StringEntrada,String):-
										is_list(X), %preguntamos si X es una lista
										nth0(0,X,Comentario),string(Comentario), %Preguntamos si el primer elemento corresponde a un string.
										string_concat(StringEntrada,"      '",S),
										string_concat(S,Comentario,S0),%Concatenamos el comentario
										string_concat(S0,"'\n",S1),
										nth0(1,X,Workspace),is_list(Workspace),
										workspace2String(Workspace,S1,String),
										!.
local2String([X|Y],StringEntrada,String):-
										is_list(X), %preguntamos si X es una lista
										nth0(0,X,Comentario),string(Comentario), %Preguntamos si el primer elemento corresponde a un string.
										string_concat(StringEntrada,"      '",S),
										string_concat(S,Comentario,S0),%Concatenamos el comentario
										string_concat(S0,"'\n",S1),
										nth0(1,X,Workspace),is_list(Workspace),
										workspace2String(Workspace,S1,S2),
										local2String(Y,S2,String)%Llamada recursiva
										.
%Predicado que transforma remote repository a un string, funciona igual que local, solo que con  un mensaje distitno en caso de estar vacío

%Caso borde, lista de elementos vacía
remote2String([],StringEntrada,String):-string_concat(StringEntrada,"Remote Repository Vacío\n",String),!.
%Caso borde, siguiente elemneto vacío
remote2String([X|[]],StringEntrada,String):-
										is_list(X), %preguntamos si X es una lista
										nth0(0,X,Comentario),string(Comentario), %Preguntamos si el primer elemento corresponde a un string.
										string_concat(StringEntrada,"      '",S),
										string_concat(S,Comentario,S0),%Concatenamos el comentario
										string_concat(S0,"'\n",S1),
										nth0(1,X,Workspace),is_list(Workspace),
										workspace2String(Workspace,S1,String),
										!.
remote2String([X|Y],StringEntrada,String):-
										is_list(X), %preguntamos si X es una lista
										nth0(0,X,Comentario),string(Comentario), %Preguntamos si el primer elemento corresponde a un string.
										string_concat(StringEntrada,"      '",S),
										string_concat(S,Comentario,S0),%Concatenamos el comentario
										string_concat(S0,"'\n",S1),
										nth0(1,X,Workspace),is_list(Workspace),
										workspace2String(Workspace,S1,S2),
										remote2String(Y,S2,String)%Llamada recursiva
										.
git2String(RepoInput, RepoAsString):-
									is_list(RepoInput), longitud(RepoInput, L) , L = 8,
									%Nombre del repositorio
									nth0(0,RepoInput,NombreRepo),string(NombreRepo), string_concat( "\n\n\n###### Repositorio : '",NombreRepo,S0),
									%Fecha del Repositorio
									nth0(1,RepoInput,Fecha),string(Fecha),string_concat(S0,"' ######\nFecha de creación : ",S1),string_concat(S1,Fecha,S2),
									%Autor del Repositorio
									nth0(2,RepoInput,Autor),string(Autor),string_concat(S2,"\n\nAutor: ",S3),string_concat(S3,Autor,S4),
									%Rama del repositorio
									nth0(3,RepoInput,Branch),string(Branch),string_concat(S4,"\nrama actual: ",S5),string_concat(S5,Branch,S6),
									%Workspace
									nth0(4,RepoInput,Workspace),is_list(Workspace),string_concat(S6,"\n\nArchivos en workspace:\n",S7),
									workspace2String(Workspace,S7,S8),
									%Index	
									nth0(5,RepoInput,Index),is_list(Index),string_concat(S8,"\nArchivos en Index:\n ",S9),
									index2String(Index,S9,S10),
									%LocalRepository
									nth0(6,RepoInput,LocalRepository),is_list(LocalRepository),string_concat(S10,"\nCommits en local repository:\n ",S11),
									local2String(LocalRepository,S11,S12),
									%Remote Repository
									nth0(7,RepoInput,RemoteRepository),is_list(RemoteRepository),string_concat(S12,"\nCommits en remote repository:\n ",S13),
									remote2String(RemoteRepository,S13,S14),
									string_concat(S14,"\n##### FIN DE REPRESENTACIÓN COMO STRING DEL REPOSITORIO #####\n\n\n\n",RepoAsString),!.
%Ejemplos de uso
/*
Ejemplo 1: 

gitInit("Unity Project","Playdead",R0),
crear_archivos(R0,["PlayerController.cs","EnemyPatrol.cs"],R1),
git2String(R1,Rstring),write(Rstring).


Ejemplo2 :

gitInit("Unity Project","Playdead",R0),
crear_archivos(R0,["PlayerController.cs","EnemyPatrol.cs"],R1),
gitAdd(R1,[],R2),
gitCommit(R2,"Character controllers",R3),
gitPush(R3,R4),
git2String(R4,Rstring),write(Rstring).

Ejemplo 3:

gitInit("Unity Project","Playdead",R0),
crear_archivos(R0,["PlayerController.cs","EnemyPatrol.cs"],R1),
gitAdd(R1,[],R2),
gitCommit(R2,"Character controllers",R3),
gitPush(R3,R4),
crear_archivos(R4,["Camera.cs","Sprite.png"],R5),
gitAdd(R5,["Sprite.png"],R6),
git2String(R6,Rstring),write(Rstring).

*/

%----------------------------------------------------------------------------------------------------------------------------------------------
%gitPull: Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un repositorio de entrada RepoInput tal
%que en RepoOutput se mueven los cambios (commits) desde RemoteRepository hacia el LocalRepository y deja en el workspace los nuevos
%archivos contenidos en estos commits.

%gitPull(RepoInput, RepoOutput).

%----------------------------------------------------------------------------------------------------------------------------------------------	
%gitStatus: Predicado que permite consultar el valor que debe tomar un String partir de una variable de entrada RepoInput, tal que
%este string contiene la información del ambiente de trabajo de forma legible:

%Para este predicado se reutilizan reglas de git2String, pero combinandolas con otras, tales como longitud

%Entradas  Repositorio de entrada
%Salida :  Una variable tipo string como esta :

%Archivos agregados al Index
%Cantidad de commits en el Local Repository
%La rama actual en la que se encuentra el Local Repository (predeterminado: “master”)

gitStatus(RepoInput, RepoStatusStr):-
									verificarInputStatus(RepoInput),
									nth0(5,RepoInput,Index),
									string_concat("\n\nArchivos agregados al index :","\n" , S),
									index2String(Index,S,S1),
									nth0(6,RepoInput,LocalRepository),
									longitud(LocalRepository,L),
									string_concat(S1,"Cantidad de commits en localRepository : ",S2),
									string_concat(S2,L,S3),
									string_concat(S3,"\nRama Actual : ",S4),
									nth0(3,RepoInput,Branch),string_concat(S4,Branch,S5),
									string_concat(S5,"\n\n\n\n\n\n\n",RepoStatusStr)
/*
Ejemplo de uso

1
gitInit("Unity Project","Playdead",R0),
crear_archivos(R0,["PlayerController.cs","EnemyPatrol.cs"],R1),
gitAdd(R1,[],R2),
gitCommit(R2,"Character controllers",R3),
gitPush(R3,R4),
crear_archivos(R4,["Camera.cs","Sprite.png"],R5),
gitAdd(R5,["Sprite.png"],R6),
gitStatus(R6,RF),write(RF),
gitCommit(R6,"Sprite",R7),
git2String(R7,Rstring),write(Rstring).

2
gitInit("Unity Project","Playdead",R0),
gitStatus(R0,RF),write(RF).

3
gitInit("Unity Project","Playdead",R0),
crear_archivos(R0,["PlayerController.cs","EnemyPatrol.cs"],R1),
gitAdd(R1,[],R2),
gitStatus(R2,RF),write(RF).
*/									.

%----------------------------------------------------------------------------------------------------------------------------------------------

%gitLog: Predicado que permite consultar el valor que debe tomar un String partir de una variable de entrada RepoInput, tal que
%este string represente de forma legible al usuario la información de los últimos 5 commits sobre el repositorio/rama actual, se debe
%mostrar al menos el mensaje asociado a cada commit.

%Caso borde, lista de elementos vacía
local2StringLog(_,[],StringEntrada,String):-string_concat(StringEntrada,"Local Repository Vacío\n",String),!.
%Caso Borde, siguiente elemento es vacío
local2StringLog(_,[X|[]],StringEntrada,String):-
										is_list(X), %preguntamos si X es una lista
										nth0(0,X,Comentario),string(Comentario), %Preguntamos si el primer elemento corresponde a un string.
										string_concat(StringEntrada,"'",S),
										string_concat(S,Comentario,S0),%Concatenamos el comentario
										string_concat(S0,"'\n",S1),
										nth0(1,X,Workspace),is_list(Workspace),
										workspace2String(Workspace,S1,String),
										!.
%Caso Borde, N = 4, signfica que ya se han revisado 4 commits, este sería el último
local2StringLog(4,[X|_],StringEntrada,String):-
										is_list(X), %preguntamos si X es una lista
										nth0(0,X,Comentario),string(Comentario), %Preguntamos si el primer elemento corresponde a un string.
										string_concat(StringEntrada,"'",S),
										string_concat(S,Comentario,S0),%Concatenamos el comentario
										string_concat(S0,"'\n",S1),
										nth0(1,X,Workspace),is_list(Workspace),
										workspace2String(Workspace,S1,String),
										!.
local2StringLog(N,[X|Y],StringEntrada,String):-
										is_list(X), %preguntamos si X es una lista
										nth0(0,X,Comentario),string(Comentario), %Preguntamos si el primer elemento corresponde a un string.
										string_concat(StringEntrada,"'",S),
										string_concat(S,Comentario,S0),%Concatenamos el comentario
										string_concat(S0,"'\n",S1),
										nth0(1,X,Workspace),is_list(Workspace),
										workspace2String(Workspace,S1,S2),
										N1 is N+1,
										local2StringLog(N1,Y,S2,String)%Llamada recursiva
										.
gitLog(RepoInput, RepoLogStr):- 
								string_concat("\n\n\n\n\nCommits en Local Repository : ", "\n",S),
								nth0(6,RepoInput,LocalRepository),
								local2StringLog(1,LocalRepository,S,S1),
								string_concat(S1,"\n\n\n\n\n",RepoLogStr).
/*
Ejemplo de uso

1
gitInit("Unity Project","Playdead",R0),
crear_archivos(R0,["PlayerController.cs","EnemyPatrol.cs"],R1),
gitAdd(R1,[],R2),
gitCommit(R2,"Character controllers",R3),
gitPush(R3,R4),
crear_archivos(R4,["Camera.cs","Sprite.png"],R5),
gitAdd(R5,["Sprite.png"],R6),
gitCommit(R6,"Sprite",R7),
gitLog(R7,RF),write(RF).

2 Sin commits : 

gitInit("Unity Project","Playdead",R0),
crear_archivos(R0,["PlayerController.cs","EnemyPatrol.cs"],R1),
gitAdd(R1,[],R2), gitLog(R2,Rs), write(Rs).

3
gitInit("Unity Project","Playdead",R0),
crear_archivos(R0,["PlayerController.cs","EnemyPatrol.cs"],R1),
gitAdd(R1,[],R2),
gitCommit(R2,"Character controllers",R3),gitLog(R3,Rs),write(Rs).
*/


%----------------------------------------------------------------------------------------------------------------------------------------------

%gitBranch: Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un repositorio de entrada RepoInput tal
%que en RepoOutput se contenga una nueva “rama” (flujo alternativo de los commits). De manera predeterminada, la nueva rama toma la
%historia del último commit. Las ramas deben tener un nombre, donde la rama predeterminada se llama “master”.

%gitBranch(RepoInput, NombreRama, RepoOutput).


%Ejemplo de uso: gitBranch(RepoInput, “develop”, RepoOutput).

%----------------------------------------------------------------------------------------------------------------------------------------------

% gitCheckout: Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un repositorio de entrada RepoInput
%tal que en RepoOutput la rama actual corresponde a la especificada por la variable NombreRama.

%gitBranch(RepoInput, NombreRama, RepoOutput).

%Ejemplo de uso: gitBranch(RepoInput, “develop”, RepoOutput).


%----------------------------------------------------------------------------------------------------------------------------------------------

%Ejemplos
%A continuación se muestra un ejemplo completo de uso pasando por la gran mayoría de predicados de este laboratorio:
/*

gitInit("lab3", "Juanito Perez", R0),
crear_archivos(R0,["a1.txt","asd.dat", "blablabla.jpg"],R1),
gitAdd(R1, ["a1.txt"], R2),
gitCommit(R2, "mensaje de ejemplo del primer commit", R3), 
gitPush(R3, R4),
git2String(R1, R1Str), write(R1Str),
git2String(R2, R2Str), write(R2Str),
git2String(R3, R3Str), write(R3Str),
git2String(R4, R4Str), write(R4Str),
gitStatus(R4,RF),write(RF),
gitLog(R2, RlogStr), write(RlogStr),
gitAdd(R4, [ "asd.dat", "blablabla.jpg" ], R5),git2String(R5, R5Str), write(R5Str).


*/