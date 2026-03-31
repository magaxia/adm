@echo off
REM =====================================================
REM SERVIDOR HTTP EM POWERSHELL PURO (sem Python/Node)
REM =====================================================
cd /d "%~dp0"
powershell -NoProfile -Command "
$Port = 8000
$Path = Get-Location

$Listener = [System.Net.HttpListener]::new()
$Listener.Prefixes.Add(\"http://localhost:$Port/\")
$Listener.Start()

Write-Host ''
Write-Host '╔════════════════════════════════════╗' -ForegroundColor Green
Write-Host '║  ✅ SERVIDOR RODANDO               ║' -ForegroundColor Green
Write-Host '╚════════════════════════════════════╝' -ForegroundColor Green
Write-Host ''
Write-Host \"Acesse: http://localhost:$Port/\" -ForegroundColor Yellow
Write-Host 'Ctrl+C para parar' -ForegroundColor Cyan
Write-Host ''

while (\$true) {
    try {
        \$Context = \$Listener.GetContext()
        \$Request = \$Context.Request
        \$Response = \$Context.Response
        
        \$FilePath = \$Request.RawUrl.TrimStart('/')
        if (\$FilePath -eq '' -or \$FilePath -eq '/') { \$FilePath = 'index.html' }
        \$FilePath = Join-Path \$Path \$FilePath
        
        if (Test-Path \$FilePath -PathType Leaf) {
            \$Bytes = [IO.File]::ReadAllBytes(\$FilePath)
            \$Response.ContentLength64 = \$Bytes.Length
            \$Response.OutputStream.Write(\$Bytes, 0, \$Bytes.Length)
        } else {
            \$Response.StatusCode = 404
        }
        \$Response.OutputStream.Close()
    } catch {
        Write-Host \"Erro: \$_\" -ForegroundColor Red
    }
}
"
pause
