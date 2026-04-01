@echo off
REM Servidor local para os arquivos HTML/JavaScript
REM Duplo clique para executar

title Servidor Local - Login/Painel
color 0A

echo.
echo ╔════════════════════════════════════════╗
echo ║  INICIANDO SERVIDOR LOCAL              ║
echo ╚════════════════════════════════════════╝
echo.

python servidor.py

if errorlevel 1 (
    echo.
    echo ❌ ERRO: Python nao foi encontrado!
    echo.
    echo Instale Python de: https://www.python.org/downloads/
    echo Marque a opção "Add Python to PATH"
    echo.
    pause
    exit /b 1
)
