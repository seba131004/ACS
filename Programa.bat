:Start
title ACS
@echo off
cls
goto Inicio

:Inicio
cls
echo.
echo.
echo                      __
echo                     / /\
echo                    / /  \
echo                   / / /\ \
echo                  / / /\ \ \
echo                 / /_/__\ \ \
echo                /________\ \ \
echo                \___________\/
echo.
echo                  Bienvenido
echo.
echo.
echo.
echo //Presione una tecla para continuar.
pause>nul
goto Windows

:Windows
set sistema=.
cls
echo //Indique en que disco esta instalado el sistema operativo.
echo.
echo //Ejemplo:"C"(Sin las comillas)
echo.
echo.
set /p sistema=//:
if %sistema%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto Windows
	)
md %sistema%:\ACS
attrib +h %sistema%:\ACS
goto Menu

:Menu
set opc=.
cls
echo //Que deseas hacer?
echo.
echo //1.Crear tarea.
echo //2.Eliminar tarea.
echo //3.Salir.
echo.
set /p opc=//Ingrese el numero de una opcion:
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para volver al menu.
pause>nul
goto Menu
	)
if %opc%==1 (goto Nombre)
if %opc%==2 (goto Eliminar)
if %opc%==3 (goto Salir) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para volver al menu.
pause>nul
goto Menu
	)
cls 
echo ERROR
pause>nul
exit

:Nombre
set NombreDeTarea=.
cls
echo //Como quieres que se llame la tarea?
echo.
echo //No utilizar caracteres raros o separados.
echo.
echo.
set /p NombreDeTarea=//Ingrese el nuevo nombre de la tarea:
if %NombreDeTarea%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto Nombre
	)
goto Crear

:Crear
set RutaDeOrigen=.
cls
echo //Que quieres copiar?
echo.
echo //Ejemplo:"C:\Documents\" (Sin las comillas).
echo //No utilizar caracteres raros o separados.
echo.
echo.
set /p RutaDeOrigen=//Ingrese la ruta:
if %RutaDeOrigen%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto Crear
	)
goto Crear1

:Crear1
set RutaDeDestino=.
cls
echo //Donde quieres alojar la copia?
echo.
echo //Ejemplo:"D:\Documents\" (Sin las comillas).
echo //No utilizar caracteres raros o separados.
echo.
echo.
set /p RutaDeDestino=//Ingrese la ruta:
if %RutaDeDestino%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto Crear
	)
goto Fecha

:Fecha
set Cuando=.
cls
echo //Cada cuanto quieres que se ejecute el programa?
echo.
echo //Cada:
echo //1.Minuto.
echo //2.Hora.
echo //3.Dia.
echo //4.Semana.
echo //5.Mes.
echo.
set /p Cuando=//Ingrese el numero de una opcion:
if %Cuando%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto Fecha
	)
if %Cuando%==1 (set Cuando=MINUTE&goto FechaMinuto)
if %Cuando%==2 (set Cuando=HOURLY&goto FechaHora)
if %Cuando%==3 (set Cuando=DAILY&goto FechaDia)
if %Cuando%==4 (set Cuando=WEEKLY&goto FechaSemana)
if %Cuando%==5 (set Cuando=MONTHLY&goto FechaMes) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto Fecha
	)
cls 
echo ERROR
pause>nul
exit

:FechaMinuto
set opc=.
cls
echo //Quieres  que el proceso de copiado se vea?
echo.
echo.
echo.
set /p opc=//(S/N):
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMinuto
	)
if %opc%==s (set ver=true&goto FechaMinuto2)
if %opc%==n (set ver=false&goto FechaMinuto2) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMinuto
	)

:FechaMinuto2
set opc=.
cls
echo //Desea terminar de crear la tarea?
echo.
echo.
echo.
set /p opc=//(S/N):
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMinuto2
	)
if %opc%==s (
if %ver%==true goto FechaMinuto2True
if %ver%==false goto FechaMinuto2False
	) 
if %opc%==n (
cls
echo //Se cancelo el creado de la tarea.
echo.
echo.
echo.
echo //Presione una tecla para volver al menu.
pause>nul
goto Menu
    ) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMinuto2
	)

:FechaMinuto2True
cls
@echo xcopy %RutaDeOrigen% %RutaDeDestino% /E /C /Y>%sistema%:\ACS\%NombreDeTarea%.bat
schtasks /CREATE /SC %Cuando% /TN %NombreDeTarea% /TR %sistema%:\ACS\%NombreDeTarea%.bat
pause>nul
goto Menu

:FechaMinuto2False
cls
@echo xcopy %RutaDeOrigen% %RutaDeDestino% /E /C /Y>%sistema%:\ACS\%NombreDeTarea%.bat
@echo set objshell = createobject("wscript.shell")>%sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
@echo objshell.run "%sistema%:\ACS\%NombreDeTarea%.bat",vbhide>>%sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
schtasks /CREATE /SC %Cuando% /TN %NombreDeTarea% /TR %sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
pause>nul
goto Menu

:FechaHora
set opc=.
cls
echo //Quieres  que el proceso de copiado se vea?
echo.
echo.
echo.
set /p opc=//(S/N):
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaHora
	)
if %opc%==s (set ver=true&goto FechaHora2)
if %opc%==n (set ver=false&goto FechaHora2) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaHora
	)

:FechaHora2
set opc=.
cls
echo //Desea terminar de crear la tarea?
echo.
echo.
echo.
set /p opc=//(S/N):
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaHora2
	)
if %opc%==s (
if %ver%==true goto FechaHora2True
if %ver%==false goto FechaHora2False
	) 
if %opc%==n (
cls
echo //Se cancelo el creado de la tarea.
echo.
echo.
echo.
echo //Presione una tecla para volver al menu.
pause>nul
goto Menu
	) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaHora2
	)

:FechaHora2True
cls
@echo xcopy %RutaDeOrigen% %RutaDeDestino% /E /C /Y>%sistema%:\ACS\%NombreDeTarea%.bat
schtasks /CREATE /SC %Cuando% /TN %NombreDeTarea% /ST 00:00 /TR %sistema%:\ACS\%NombreDeTarea%.bat
pause>nul
goto Menu

:FechaHora2False
cls
@echo xcopy %RutaDeOrigen% %RutaDeDestino% /E /C /Y>%sistema%:\ACS\%NombreDeTarea%.bat
@echo set objshell = createobject("wscript.shell")>%sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
@echo objshell.run "%sistema%:\ACS\%NombreDeTarea%.bat",vbhide>>%sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
schtasks /CREATE /SC %Cuando% /TN %NombreDeTarea% /ST 00:00 /TR %sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
pause>nul
goto Menu

:FechaDia
set hora=.
cls
echo //A que hora quieres que se ejecute la tarea?
echo.
echo //"HH:MM:SS"(24 horas).
echo //Ejemplo:"13:10:00" equivalente a "1:10 PM".
echo.
echo.
set /p hora=//Ingrese la hora:
if %hora%==. (
cls
echo //Por favor ingrezar texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaDia
	)
goto FechaDia2

:FechaDia2
set opc=.
cls
echo //Quieres  que el proceso de copiado se vea?
echo.
echo.
echo.
set /p opc=//(S/N):
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaDia2
	)
if %opc%==s (set ver=true&goto FechaDia3)
if %opc%==n (set ver=false&goto FechaDia3) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaDia2
	)

:FechaDia3
set opc=.
cls
echo //Desea terminar de crear la tarea?
echo.
echo.
echo.
set /p opc=//(S/N):
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaDia3
	)
if %opc%==s (
if %ver%==true goto FechaDia3True
if %ver%==false goto FechaDia3False
	) 
if %opc%==n (
cls
echo //Se cancelo el creado de la tarea.
echo.
echo.
echo.
echo //Presione una tecla para volver al menu.
pause>nul
goto Menu
	) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaDia3
	)

:FechaDia3True
cls
@echo xcopy %RutaDeOrigen% %RutaDeDestino% /E /C /Y>%sistema%:\ACS\%NombreDeTarea%.bat
schtasks /CREATE /SC %Cuando% /TN %NombreDeTarea% /ST %hora% /TR %sistema%:\ACS\%NombreDeTarea%.bat
pause>nul
goto Menu

:FechaDia3False
cls
@echo xcopy %RutaDeOrigen% %RutaDeDestino% /E /C /Y>%sistema%:\ACS\%NombreDeTarea%.bat
@echo set objshell = createobject("wscript.shell")>%sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
@echo objshell.run "%sistema%:\ACS\%NombreDeTarea%.bat",vbhide>>%sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
schtasks /CREATE /SC %Cuando% /TN %NombreDeTarea% /ST %hora% /TR %sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
pause>nul
goto Menu

:FechaSemana
set opc=.
cls
echo //En que dia de la semana se va a ejecutar la tarea?
echo.
echo //1.Lunes.
echo //2.Martes.
echo //3.Miercoles.
echo //4.Jueves.
echo //5.Viernes.
echo //6.Sabado.
echo //7.Domingo.
echo.
set /p opc=//Ingrese el numero de una de las opciones:
if %opc%==. (
echo //Por favor ingrezar texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
	)
if %opc%==1 (set dia=MON&goto FechaSemana2)
if %opc%==2 (set dia=TUE&goto FechaSemana2)
if %opc%==3 (set dia=WED&goto FechaSemana2)
if %opc%==4 (set dia=THU&goto FechaSemana2)
if %opc%==5 (set dia=FRI&goto FechaSemana2)
if %opc%==6 (set dia=SAT&goto FechaSemana2)
if %opc%==7 (set dia=SUN&goto FechaSemana2) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaSemana
	)

:FechaSemana2
set hora=.
cls
echo //A que hora quieres que se ejecute la tarea?
echo.
echo //"HH:MM:SS"(24 horas).
echo //Ejemplo:"13:10:00" equivalente a "1:10 PM".
echo.
echo.
set /p hora=//Ingrese la hora:
if %hora%==. (
cls
echo //Por favor ingrezar texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaSemana2
	)
goto FechaSemana3

:FechaSemana3
set opc=.
cls
echo //Quieres  que el proceso de copiado se vea?
echo.
echo.
echo.
set /p opc=//(S/N):
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaSemana3
	)
if %opc%==s (set ver=true&goto FechaSemana4)
if %opc%==n (set ver=false&goto FechaSemana4) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaSemana3
	)

:FechaSemana4
set opc=.
cls
echo //Desea terminar de crear la tarea?
echo.
echo.
echo.
set /p opc=//(S/N):
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaSemana4
	)
if %opc%==s (
if %ver%==true goto FechaSemana4True
if %ver%==false goto FechaSemana4False
	) 
if %opc%==n (
cls
echo //Se cancelo el creado de la tarea.
echo.
echo.
echo.
echo //Presione una tecla para volver al menu.
pause>nul
goto Menu
	) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaSemana4
	)

:FechaSemana4True
cls
@echo xcopy %RutaDeOrigen% %RutaDeDestino% /E /C /Y>%sistema%:\ACS\%NombreDeTarea%.bat
schtasks /CREATE /SC %Cuando% /TN %NombreDeTarea% /D %dia% /ST %hora% /TR %sistema%:\ACS\%NombreDeTarea%.bat
pause>nul
goto Menu

:FechaSemana4False
cls
@echo xcopy %RutaDeOrigen% %RutaDeDestino% /E /C /Y>%sistema%:\ACS\%NombreDeTarea%.bat
@echo set objshell = createobject("wscript.shell")>%sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
@echo objshell.run "%sistema%:\ACS\%NombreDeTarea%.bat",vbhide>>%sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
schtasks /CREATE /SC %Cuando% /TN %NombreDeTarea% /D %dia% /ST %hora% /TR %sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
pause>nul
goto Menu

:FechaMes
set dia=.
cls
echo //Que dia del mes quieres que se ejecute la tarea?
echo.
echo.
echo.
set /p dia=//Ingrese un numero entre 1 Y 31:
if %dia%==. (
cls
echo //Por favor ingrezar texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMes
	)
if %dia% GEQ 1 (
if %dia% LEQ 31 (goto FechaMes2) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMes
	)
	) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMes
    )

:FechaMes2
set hora=.
cls
echo //A que hora quieres que se ejecute la tarea?
echo.
echo //"HH:MM:SS"(24 horas).
echo //Ejemplo:"13:10:00" equivalente a "1:10 PM".
echo.
echo.
set /p hora=//Ingrese la hora:
if %hora%==. (
cls
echo //Por favor ingrezar texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMes2
	)
goto FechaMes3

:FechaMes3
set opc=.
cls
echo //Quieres  que el proceso de copiado se vea?
echo.
echo.
echo.
set /p opc=//(S/N):
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMes3
	)
if %opc%==s (set ver=true&goto FechaMes4)
if %opc%==n (set ver=false&goto FechaMes4) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.Presione una tecla para reintentar.
pause>nul
goto FechaMes3
	)

:FechaMes4
set opc=.
cls
echo //Desea terminar de crear la tarea?
echo.
echo.
echo.
set /p opc=//(S/N):
if %opc%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMes4
	)
if %opc%==s (
if %ver%==true goto FechaMes4True
if %ver%==false goto FechaMes4False
	) 
if %opc%==n (
cls
echo //Se cancelo el creado de la tarea.
echo.
echo.
echo.
echo //Presione una tecla para volver al menu.
pause>nul
goto Menu
	) else (
cls
echo //No es una opcion valida.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto FechaMes4
	)

:FechaMes4True
cls
@echo xcopy %RutaDeOrigen% %RutaDeDestino% /E /C /Y>%sistema%:\ACS\%NombreDeTarea%.bat
schtasks /CREATE /SC %Cuando% /TN %NombreDeTarea% /D %dia% /ST %hora% /TR %sistema%:\ACS\%NombreDeTarea%.bat
pause>nul
goto Menu

:FechaMes4False
cls
@echo xcopy %RutaDeOrigen% %RutaDeDestino% /E /C /Y>%sistema%:\ACS\%NombreDeTarea%.bat
@echo set objshell = createobject("wscript.shell")>%sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
@echo objshell.run "%sistema%:\ACS\%NombreDeTarea%.bat",vbhide>>%sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
schtasks /CREATE /SC %Cuando% /TN %NombreDeTarea% /D %dia% /ST %hora% /TR %sistema%:\ACS\Ocultar%NombreDeTarea%.vbs
pause>nul
goto Menu

:Eliminar
set NombreDeTarea=.
cls
echo //Como se llama la tarea que quieres eliminar?
echo.
echo //No utilizar caracteres raros o separados.
echo.
echo.
set /p NombreDeTarea=//Ingrese el nombre:
if %NombreDeTarea%==. (
cls
echo //Por favor ingrese texto.
echo.
echo.
echo.
echo //Presione una tecla para reintentar.
pause>nul
goto Eliminar
	)
cls
schtasks /DELETE /F /TN %NombreDeTarea%
pause>nul
goto Menu

:Salir
cls
exit