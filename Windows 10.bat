:: WINDOWS 10
@echo off
setlocal EnableDelayedExpansion
cls

:: Define caminho e nome do arquivo
set "outputDir=S:\2-VERIFICAR SISTEMA\RelatoriosTI"
set "outputFile=%outputDir%\relatoriow10_%COMPUTERNAME%.txt"

:: Coleta IP
set "IP="
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /i "IPv4"') do (
    set "IP=%%A"
)

:: Coleta chave do produto
set "CHAVE="
for /f "skip=1 delims=" %%K in ('wmic path softwarelicensingservice get OA3xOriginalProductKey') do (
    if not defined CHAVE set "CHAVE=%%K"
)

:: Coleta número de série da BIOS
set "SERIAL="
for /f "skip=1 delims=" %%S in ('wmic bios get serialnumber') do (
    if not defined SERIAL set "SERIAL=%%S"
)

:: Coleta informações da placa-mãe
set "BASEBOARD="
for /f "skip=1 delims=" %%B in ('wmic baseboard get product, Manufacturer, version, serialnumber') do (
    if not defined BASEBOARD set "BASEBOARD=%%B"
)

:: Exibe na tela
echo.
echo Nome do Computador: %COMPUTERNAME%
echo.
echo IPv4: !IP!
echo.
echo Chave do Produto: !CHAVE!
echo.
echo Numero de Serie da BIOS: !SERIAL!
echo.
echo Informacoes da Placa-mae: !BASEBOARD!
echo.
echo ===============================
echo Nenhuma alteracao foi feita!!
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
    echo Nmero de Serie da BIOS: !SERIAL!
    echo.
    echo Informacoes da Placa-mae: !BASEBOARD!
    echo.
    echo ===============================
    echo Nenhuma alteracao foi feita!!
    echo          TI    
    echo ===============================
    echo.
) > "%outputFile%"

echo.
echo Relatório salvo em: %outputFile%
echo.
pause
