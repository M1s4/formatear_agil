
@echo off
setlocal EnableDelayedExpansion 

:menu
mode 80,35
cls
color 0E
echo.
echo Respadar Usuarios Windows....
echo                                             ***By:M1s4***
echo 1)Normal
echo 2)Personalizado 
echo 3)Instrucciones
echo.
set /p op=Escoge una Opcion(numero): 
if "%op%"=="1" (goto Norm)
if "%op%"=="2" (goto Pers)
if "%op%"=="3" (goto Inst)

::Algo salio mal! Escribe el numero de la opcion que quieras
echo. el numero "%op%" no es una opcion correcta e_e
pause
goto menu
exit


:Inst
mode 105,20
cls
color 0E
echo.
echo La Opcion: 
echo.
echo        *Normal: Pide la ruta donde se colocara el Respaldo (ejemplo "c:\respaldo", sin comillas xD) Crea respaldo de todos los usuarios que se encuentran en windows  
echo                 las carpetas que respaldason Escritorio, Documentos, Musica, Videos, Imagenes, Outloock, Descargas.
echo.
echo        *Personalizado: Se listaran y escogeran los usuarios a respaldar unos por uno, despues se pedira la ruta del backup
echo                       creandose dentro una carpeta con la fecha del dia y dentro el respaldo. 
pause
pause>nul
goto menu
exit


:Norm
mode 80,35
cls
color A
echo.
set /p ruta=ruta del respaldo (Ejemplo "E:\respaldo, M: " sin comillas)
set raiz=!ruta!
setx RutaNorm !raiz!
setx CarpF %date:~0,2%-%date:~3,2%-%date:~8,2% 
echo la ruta que escribio fue "%raiz%" 
mkdir "%raiz%\%CarpF%"
goto CopNorm
exit

:CopNorm
cls
Color A
cd "c:\users"
dir > "c:\%userprofile%\desktop\us3rs.txt"
cd "c:\%userprofile%\desktop"
for /f "tokens=*" %%i in (us3rs.txt) do (
robocopy "c:\users\%%i\desktop" "%RutaNorm%\%%i\desktop"
robocopy "c:\users\%%i\download" "%RutaNorm%\%%i\download"
robocopy "c:\users\%%i\documents" "%RutaNorm%\%%i\documents"
robocopy "c:\users\%%i\images" "%RutaNorm%\%%i\images"
robocopy "c:\users\%%i\music" "%RutaNorm%\%%i\music"
robocopy "c:\users\%%i\videos" "%RutaNorm%\%%i\videos"
robocopy "c:\users\%%i\AppData\Roming\Microsoft\outlook" "%RutaNorm%\%%i\outlook")
echo Se termino de copiar los archivos 
start "%RutaNorm%"
pause
goto Fin
exit


:Fin
echo Se termino de copiar los archivos 
pause
cls
echo.
echo.
echo.
echo 1)Volver al menu    2)salir
echo.
echo.
set /p opc=Que desea hacer?
if "%opc%"=="1" (goto menu)
if "%opc%"=="2" (goto salir)
::Error de escritura, Por favor escriba de forma correcta el usuario :)
pause
goto Fin
exit

:Pers
cls
echo.
echo.
echo.
echo.
set /p ruta=ruta del respaldo (Ejemplo "E:\respaldo, M: " sin comillas): 
set raiz=!ruta!
setx RutaPers !raiz!
echo se guardo la ruta %raiz%
setx CarpF %date:~0,2%-%date:~3,2%-%date:~8,2% 
mkdir "%raiz%\%CarpF%"



echo.
pause
cls
echo.
dir "c:\users"
echo.
echo. 
set /p nomb=Escriba el usuario que desea respaldar: 
setx user !nomb!
echo.
echo.
echo 1)Agregar_otro_usuario  2)Comenzar_a_copiar
set /p opcion=Escoga una opcion(escriba el numero): 
if "%opcion%"=="1" (goto CopPers)
if "%opcion%"=="2" (goto SegCop)

::Algo salio mal! Escribe el numero de la opcion que quieras
echo. el numero "%op%" no es una opcion correcta e_e
pause
goto Pers
exit


:CopPers
cls
Color 0E
echo.
dir "c:\users"
echo.
set /p nomb=escribe el usuario: 
setx nomb1 !nomb!
set /p op1=Desea agregar otro usuario (S/N)?: 
if "%op1%"=="s" (echo !nomb! >> "%userprofile%\desktop\ListUser.txt" && goto CopPers)
if "%op1%"=="n" (setx user2 %nomb%  && goto CopPers2)
::Error de escritura, Por favor escriba de forma correcta el usuario :)
pause
goto CopPers
exit


:CopPers2
cd "c:\%userprofile%\desktop"
for /f "tokens=*" %%i in (ListUser.txt) do (
robocopy "c:\users\%%i\desktop" "%RutaPers%\%%i\desktop"
robocopy "c:\users\%%i\download" "%RutaPers%\%%i\download"
robocopy "c:\users\%%i\documents" "%RutaPers%\%%i\documents"
robocopy "c:\users\%%i\images" "%RutaPers%\%%i\images"
robocopy "c:\users\%%i\music" "%RutaPers%\%%i\music"
robocopy "c:\users\%%i\videos" "%RutaPers%\%%i\videos"
robocopy "c:\users\%%i\AppData\Roming\Microsoft\outlook" "%RutaPers%\%%i\outlook")
echo.
echo.
echo.
echo Se termino de copiar los archivos 
start "%RutaPers%"
pause
goto Fin


:salir
msg *Buen dia :)
exit
