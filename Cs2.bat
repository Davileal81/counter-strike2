@echo off
setlocal

:: ------------------------------------
:: 1. Modo de energia – Alto desempenho
:: ------------------------------------
echo Ajustando o plano de energia para “Alto desempenho”...
powershell -Command "powercfg -setactive SCHEME_MIN"

:: ------------------------------------
:: 2. Desativar serviços que podem consumir recursos
:: ------------------------------------
echo Desativando serviços desnecessários...
net stop wuauserv >nul 2>&1   :: Windows Update
net stop bits >nul 2>&1       :: Background Intelligent Transfer Service
net stop dhcp >nul 2>&1       :: Cliente DHCP
net stop dnscache >nul 2>&1   :: Cache DNS

:: ------------------------------------
:: 3. Ajustar a prioridade do processo CS2
:: ------------------------------------
echo Definindo prioridade do CS2 para “High”...
:: Se o jogo já estiver em execução, encerre-o
taskkill /f /im cs2.exe >nul 2>&1
:: Inicie o CS2 com prioridade alta
start "" "C:\Program Files\Steam\steamapps\common\Counter-Strike 2\cs2.exe" -high

:: ------------------------------------
:: 4. Limpar buffers de vídeo (opcional)
:: ------------------------------------
echo Ajustando a configuração de memória (necessita reinicialização)...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul 2>&1
echo Reinicie o PC para aplicar esta alteração.

:: ------------------------------------
:: 5. Mensagem final
:: ------------------------------------
echo Otimização concluída! Inicie o CS2.
pause
endlocal