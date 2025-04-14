:: WINDOWS 11
@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul
cls

:: Define caminho e nome do arquivo
set "outputDir=S:\2-VERIFICAR SISTEMA\RelatoriosTI"
set "outputFile=%outputDir%\relatorio_%COMPUTERNAME%.txt"

:: Coleta IP
set "IP="
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /i "IPv4"') do (
    set "IP=%%A"
)

:: Coleta chave do produto com PowerShell
set "CHAVE="
for /f "delims=" %%K in ('powershell -command "(Get-WmiObject -query \"select * from SoftwareLicensingService\").OA3xOriginalProductKey"') do (
    set "CHAVE=%%K"
)

:: Coleta serial da BIOS com PowerShell
set "SERIAL="
for /f "delims=" %%S in ('powershell -command "Get-CimInstance Win32_BIOS | Select-Object -ExpandProperty SerialNumber"') do (
    set "SERIAL=%%S"
)

:: Coleta informações de usuários conectados
set "USERS="
for /f "skip=1 delims=" %%U in ('query user 2^>nul') do (
    set "USERS=!USERS!%%U

)

:: Exibe na tela
echo Nome do Computador: %COMPUTERNAME%
echo.
echo IPv4: !IP!
echo.
echo Chave do Produto: !CHAVE!
echo.
echo Serial Number: !SERIAL!
echo.
echo Usuários Conectados:
echo !USERS!
echo ===============================
echo Nenhuma alteração foi feita!!
echo          TI    
echo ===============================
echo.

:: Pergunta se deseja salvar
choice /m "Deseja salvar o relatório em %outputDir%?"

:: Se NÃO (N), encerra o script
if errorlevel 2 (
    echo.
    echo O relatório NÃO foi salvo.
    echo.
    pause
    goto :EOF
)

:: Cria a pasta se não existir 
if not exist "%outputDir%" mkdir "%outputDir%"

:: Salva no arquivo
(
    echo Nome do Computador: %COMPUTERNAME%
    echo.
    echo IPv4: !IP!
    echo.
    echo Chave do Produto: !CHAVE!
    echo.
    echo Serial da BIOS: !SERIAL!
    echo.
    echo Usuários Conectados:
    echo !USERS!
    echo.
    echo ===============================
    echo Nenhuma alteração foi feita!!
    echo          TI    
    echo ===============================
    echo.
) > "%outputFile%"

echo.
echo Relatório salvo em: %outputFile%
echo.
pause
