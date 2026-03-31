@echo off
REM =====================================================
REM INICIAR SERVIDOR HTTP - Clique duplo para rodar
REM =====================================================

color 0A
title SERVIDOR HTTP - Sistema Magaxia

echo.
echo ╔════════════════════════════════════════════════╗
echo ║     🚀 INICIANDO SERVIDOR LOCAL               ║
echo ║     http://localhost:8000                       ║
echo ╚════════════════════════════════════════════════╝
echo.
echo Aguarde enquanto configuramos...
echo.

cd /d "%~dp0"

REM Aguarda 2 segundos
timeout /t 2 /nobreak

REM Inicia servidor e abre navegador
start http://localhost:8000/login.html
python -m http.server 8000

echo.
echo ╔════════════════════════════════════════════════╗
echo ║  ✅ SERVIDOR INICIADO!                         ║
echo ║                                                 ║
echo ║  Acesse nos seus navegadores:                  ║
echo ║  • http://localhost:8000/login.html           ║
echo ║  • http://localhost:8000/painel.html          ║
echo ║                                                 ║
echo ║  Pressione Ctrl+C aqui para PARAR o servidor  ║
echo ╚════════════════════════════════════════════════╝
echo.
pause
