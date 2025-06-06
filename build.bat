@echo off
setlocal enabledelayedexpansion

:: Verifica se o vcpkg está configurado
if not defined VCPKG_ROOT (
    echo VCPKG_ROOT nao definido. Configurando...
    set "VCPKG_ROOT=C:\vcpkg"
)

:: Verifica se o diretório build existe, se não, cria
if not exist "build" mkdir build

:: Configura o CMake com vcpkg
echo Configurando CMake...
cmake -B build -S . ^
    -DCMAKE_TOOLCHAIN_FILE="%VCPKG_ROOT%/scripts/buildsystems/vcpkg.cmake" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DUSE_STATIC_LIBS=ON ^
    -DFRAMEWORK_SOUND=ON ^
    -DFRAMEWORK_GRAPHICS=ON ^
    -DFRAMEWORK_XML=ON ^
    -DFRAMEWORK_NET=ON ^
    -DBOT_PROTECTION=OFF

if errorlevel 1 (
    echo Erro na configuracao do CMake
    exit /b 1
)

:: Compila o projeto
echo Compilando...
cmake --build build --config Release

if errorlevel 1 (
    echo Erro na compilacao
    exit /b 1
)

echo.
echo Compilacao concluida com sucesso!
echo O executavel esta em: build\Release\otclient.exe
echo.
echo Lembre-se de copiar os arquivos necessarios:
echo - modules/
echo - data/
echo - init.lua
echo - otclientrc.lua
echo.
pause 