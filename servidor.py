#!/usr/bin/env python3
"""
Servidor local simples para rodar os arquivos HTML
Use: python servidor.py
Depois acesse: http://localhost:8000
"""

import http.server
import socketserver
import os

PORT = 8000
DIRECTORY = os.path.dirname(os.path.abspath(__file__))

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)
    
    def end_headers(self):
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        self.send_header('Access-Control-Allow-Origin', '*')
        return super().end_headers()

def run_server():
    with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
        print(f"""
╔════════════════════════════════════════╗
║     SERVIDOR LOCAL INICIADO ✅         ║
╚════════════════════════════════════════╝

🌐 Acesse em: http://localhost:{PORT}
📁 Diretório: {DIRECTORY}

🔐 Login: http://localhost:{PORT}/login.html
📊 Painel: http://localhost:{PORT}/painel.html

⚠️  Para parar: Pressione Ctrl+C
""")
        httpd.serve_forever()

if __name__ == "__main__":
    try:
        run_server()
    except KeyboardInterrupt:
        print("\n\n🛑 Servidor parado.")
