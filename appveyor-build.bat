REM Set up Visual Studio x64 environment
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"

REM Install Open*IO libraries
vcpkg install opencolorio
vcpkg install openimageio

REM Integrate libraries
cd c:\tools\vcpkg
vcpkg integrate install
cd %APPVEYOR_BUILD_FOLDER%
cmake -DCMAKE_TOOLCHAIN_FILE=c:/tools/vcpkg/scripts/buildsystems/vcpkg.cmake ...

REM Run cmake
cmake -G "NMake Makefiles" .

REM Build with JOM
C:\Qt\Tools\QtCreator\bin\jom.exe

REM Check if this build should set up a debugging session
IF "%ENABLE_RDP%"=="1" (
    powershell -command  "$blockRdp = $true; iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/appveyor/ci/master/scripts/enable-rdp.ps1'))"
)
