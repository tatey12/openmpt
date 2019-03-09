@echo off

set BATCH_DIR=%~dp0
cd %BATCH_DIR%
cd ..\..

set MY_DIR=%CD%

call "build\auto\setup_arguments.cmd" %1 %2 %3 %4 %5 %6

call build\auto\setup_vs_any.cmd

call build\auto\helper_get_svnversion.cmd
call build\auto\helper_get_openmpt_version.cmd

set MPT_REVISION=%OPENMPT_VERSION%-%SVNVERSION%



cmd /c build\auto\update_package_template.cmd || goto error
cd bin || goto error
rmdir /s /q openmpt
mkdir openmpt
mkdir openmpt\pkg.win
mkdir openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%-Setup.exe              openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%-Setup.exe
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%-Setup.exe.digests      openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%-Setup.exe.digests
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%-Setup-x64.exe          openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%-Setup-x64.exe
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%-Setup-x64.exe.digests  openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%-Setup-x64.exe.digests
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%.zip                    openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%.zip
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%.zip.digests            openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%.zip.digests
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%-legacy.zip             openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%-legacy.zip
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%-legacy.zip.digests     openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%-legacy.zip.digests
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%-x64.zip                openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%-x64.zip
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%-x64.zip.digests        openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%-x64.zip.digests
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%-x64-legacy.zip         openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%-x64-legacy.zip
copy /y ..\installer\OpenMPT-%OPENMPT_VERSION%-x64-legacy.zip.digests openmpt\pkg.win\%OPENMPT_VERSION_MAJORMAJOR%.%OPENMPT_VERSION_MAJOR%\OpenMPT-%OPENMPT_VERSION%-%SVNVERSION%-x64-legacy.zip.digests
..\build\tools\7zip\7z.exe a -ttar openmpt-pkg.tar openmpt || goto error
rmdir /s /q openmpt
cd .. || goto error



goto noerror

:error
cd "%MY_DIR%"
exit 1

:noerror
cd "%MY_DIR%"
exit 0
