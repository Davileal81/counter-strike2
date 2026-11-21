Counter‑Strike 2 – Otimização de Sistema (Windows)
⚠️ Aviso
Este projeto contém um script Batch que altera configurações do Windows, como o plano de energia, serviços e o registro.
Execute-o apenas com privilégio de administrador e antes de jogar.
Faça backup do registro (regedit) e crie pontos de restauração do sistema caso queira desfazer as alterações.

📦 Visão geral
Objetivo: Melhorar a latência e estabilidade de Counter‑Strike 2 (CS2) em PCs Windows.
Como funciona:
Ajusta o plano de energia para “Alto desempenho”.
Desativa serviços que consomem CPU/memória enquanto o jogo roda.
Inicia o CS2 com prioridade High.
Limpa o buffer de memória do Windows (opcional, requer reinicialização).
Tecnologias:
Batch (.bat) – script de automação do Windows.
PowerShell – para chamar powercfg.
Regedit (reg.exe) – alteração de entradas de registro.
Comandos internos do Windows (net, taskkill, start).
🛠️ Pré‑requisitos
Item	Descrição	Link
Windows 10/11	O script foi testado em ambos.	—
Conta com privilégios de administrador	Necessária para executar reg.exe, net e powershell.	—
Steam	O caminho do executável cs2.exe pode variar. Ajuste o script se o CS2 estiver em outro local.	—
🚀 Instalação
Clone o repositório (ou faça o download do ZIP):

git clone https://github.com/SeuUsuario/CS2-Optimiza.git
Abra a pasta onde está o script cs2_optimiza.bat.

Edite o caminho do CS2 (se necessário)

start "" "C:\Program Files\Steam\steamapps\common\Counter-Strike 2\cs2.exe" -high
Altere para o local correto do seu jogo.

▶️ Como usar
Clique com o botão direito no arquivo cs2_optimiza.bat → “Executar como administrador”.

Executar como administrador

O script fará as seguintes etapas:

Ativar plano de energia “Alto desempenho”.
Parar serviços desnecessários (wuauserv, bits, dhcp, dnscache).
Encerrar qualquer instância anterior do CS2.
Iniciar o CS2 com prioridade alta.
Ajustar LargeSystemCache (necessita reiniciar o PC).
Após a mensagem de “Otimização concluída! Inicie o CS2.”, abra o jogo normalmente.

Recomendação: execute o script antes de abrir o CS2.

🔁 Reativar serviços (opcional)
Caso queira desfazer a desativação de serviços:

Crie um arquivo chamado cs2_reativa_servicos.bat com o conteúdo abaixo:

@echo off
setlocal
echo Reativando serviços...
net start wuauserv
net start bits
net start dhcp
net start dnscache
echo Serviços reativados.
pause
endlocal
Execute como administrador.

🐛 Solução de Problemas
Problema	Possível causa	Solução
O script não abre o CS2	Caminho incorreto do executável	Verifique o caminho no start "" "...cs2.exe" -high.
O PC fica com lentidão depois de executar	Alteração de LargeSystemCache não aplicada	Reinicie o computador.
Serviços não reativam	O script cs2_reativa_servicos.bat não foi executado com admin	Execute com privilégios de administrador.
O CS2 não inicia	Prioridade alta pode causar conflitos em alguns PCs	Abra o Gerenciador de Tarefas e ajuste manualmente a prioridade para “Normal”.
📚 Contribuindo
Fork este repositório.
Crie um branch com a sua feature: git checkout -b feature/nome-da-feature.
Faça commits claros e concisos.
Abra um Pull Request e aguarde revisão.
📄 Licença
MIT © 2026 – davIA

👾 Sobre o projeto
Autor: davIA
Data de criação: 21/11/2026
Contato: seuemail@example.com
Exemplo do script completo
@echo off
setlocal

:: Modo de energia – Alto desempenho
echo Ajustando o plano de energia para “Alto desempenho”...
powershell -Command "powercfg -setactive SCHEME_MIN"

:: Desativar serviços
echo Desativando serviços desnecessários...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop dhcp >nul 2>&1
net stop dnscache >nul 2>&1

:: Prioridade do processo
echo Definindo prioridade do CS2 para “High”...
taskkill /f /im cs2.exe >nul 2>&1
start "" "C:\Program Files\Steam\steamapps\common\Counter-Strike 2\cs2.exe" -high

:: Limpar buffer de vídeo (opcional)
echo Ajustando a configuração de memória (necessita reinicialização)...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul 2>&1
echo Reinicie o PC para aplicar esta alteração.

echo Otimização concluída! Inicie o CS2.
pause
endlocal
