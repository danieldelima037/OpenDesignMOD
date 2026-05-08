@echo off
setlocal enabledelayedexpansion

cd /d %~dp0

echo Iniciando servidor ...
cscript //nologo "%~dp0start-server.vbs"
echo Servidor iniciando, aguardando porta 17573 ...

set "PORT=17573"
set /a "ATTEMPT=0"

:wait_loop
set /a ATTEMPT+=1

powershell -NoProfile -Command "try { $t = New-Object System.Net.Sockets.TcpClient; $t.Connect('127.0.0.1',%PORT%); $t.Close(); exit 0 } catch { exit 1 }" >NUL 2>&1

echo tentativa !ATTEMPT!

if !errorlevel!==0 (
    echo Porta pronta! Abrindo navegador ...
    powershell -NoProfile -Command "Start-Process 'http://127.0.0.1:%PORT%'"
    timeout /t 5 /nobreak > NUL
    exit /b 0
)

if !ATTEMPT! geq 90 (
    echo ERRO: Tempo limite esgotado.
    pause
    exit /b 1
)

timeout /t 1 /nobreak > NUL
goto :wait_loop
