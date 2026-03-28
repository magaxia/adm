@echo off
echo.
echo ======================================================================
echo  INICIANDO SERVIDOR HTTP - PRESSIONE CTRL+C PARA PARAR
echo ======================================================================
echo.
echo Acesse o sistema em: http://localhost:8000
echo.
echo Páginas disponíveis:
echo  - Login: http://localhost:8000/login.html
echo  - Usuarios: http://localhost:8000/usuarios-standalone.html
echo.
cd /d "%~dp0"
python -m http.server 8000
pause
