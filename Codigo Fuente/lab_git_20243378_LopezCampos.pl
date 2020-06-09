%Laboratorio número 2 paradigmas de programación
%Autor : Javier López ; RUN : 20.243.278-2
%Fecha de Inicio : 08 / 06 / 2020
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
%Predicados de Pertenencia
%Selectores
%Modificadores 


%Base de Conocimientos 

%Reglas y hechos


%Predicados por implementar ---------------------------------------------------------------------------------------------
%----------------------------------------------------------------------------------------------------------------------------------------------

%gitinit
%Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un nombre y autor. 
%RepoOutput tendría un repositorio vacío sin commits y sin archivos en sus zonas.
%ENTRADAS : gitInit(NombreRepo, Autor, RepoOutput).

%Ejemplo de uso :  gitInit(“lab3”, “Constanza Zarate”, RepoOutput).

%----------------------------------------------------------------------------------------------------------------------------------------------

%gitAdd: Predicado que permite consultar el valor que debe tomar RepoOutput a partir de un repositorio de entrada RepoInput tal que en RepoOutput se mueven los archivos 
%desde la zona Workspace a la zona Index. Puede hacerlo con la especificación de una lista de nombres de archivos concretos (nombres como strings).

%RepoInput corresponde al repositorio de entrada a este predicado con las cuatro zonas de acuerdo a la representación escogida para este TDA. En la variable RepoOutput 
%debe retornar el resultado, esto aplica para todos los siguientes predicados que usen estas variables.

%gitAdd(RepoInput, Archivos, RepoOutput).
%Ejemplo de uso :  gitAdd(RepoInput, [ “file1.txt”, “f2.pl”, “archivo3.docx” ], RepoOutput).
%  				   gitadd(RepoInput, [ ], RepoOutput).


%----------------------------------------------------------------------------------------------------------------------------------------------




%----------------------------------------------------------------------------------------------------------------------------------------------



%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------