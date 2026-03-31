@echo off
REM Servidor HTTP simples em PowerShell (não precisa Python)
echo Iniciando servidor HTTP na porta 8000...
echo.
echo Acesse: http://localhost:8000
echo.
powershell -Command "cd '%cd%'; $PSVersionTable.PSVersion; $listener = New-Object System.Net.HttpListener; $listener.Prefixes.Add('http://localhost:8000/'); $listener.Start(); Write-Host '✅ Servidor rodando em http://localhost:8000'; while ($listener.IsListening) { $context = $listener.GetContext(); $request = $context.Request; $response = $context.Response; $filename = $request.Url.LocalPath.TrimStart('/'); if ($filename -eq '') { $filename = 'index.html' } $filepath = Join-Path '.' $filename; if (Test-Path $filepath) { $bytes = [System.IO.File]::ReadAllBytes($filepath); $response.ContentLength64 = $bytes.Length; $response.OutputStream.Write($bytes, 0, $bytes.Length) } else { $response.StatusCode = 404; $html = 'Arquivo nao encontrado'; $bytes = [System.Text.Encoding]::UTF8.GetBytes($html); $response.ContentLength64 = $bytes.Length; $response.OutputStream.Write($bytes, 0, $bytes.Length) }; $response.OutputStream.Close() }"
pause
