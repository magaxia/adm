# Inicia um servidor HTTP na porta 8000
# PowerShell Script para servir arquivos localmente

$port = 8000
$directory = Get-Location

Write-Host "=" * 60
Write-Host "🚀 INICIANDO SERVIDOR HTTP" -ForegroundColor Green
Write-Host "=" * 60
Write-Host "Porta: $port" -ForegroundColor Cyan
Write-Host "Diretório: $directory" -ForegroundColor Cyan
Write-Host ""
Write-Host "Acesse em: http://localhost:$port" -ForegroundColor Yellow
Write-Host ""
Write-Host "Páginas disponíveis:" -ForegroundColor Cyan
Write-Host "  📝 Login: http://localhost:$port/login.html" -ForegroundColor White
Write-Host "  👥 Usuários: http://localhost:$port/usuarios-standalone.html" -ForegroundColor White
Write-Host ""
Write-Host "Pressione Ctrl+C para parar o servidor" -ForegroundColor Magenta
Write-Host "=" * 60
Write-Host ""

# Verificar se Python está instalado
$pythonCheck = python --version 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Python encontrado: $pythonCheck" -ForegroundColor Green
    Write-Host ""
    python -m http.server $port
} else {
    Write-Host "❌ Python não encontrado. Tente instalar Python 3." -ForegroundColor Red
}
