@echo off
:: Given a name and type, we'll build a VM for the user

:: params
:: %1 - Name
:: %2 - Type of VM
:: %3 - image name to use (ubuntu version)

:: fail if parameters are blank
IF "%1"=="" GOTO help
IF "%2"=="" GOTO help


:: DEFAULTS
SET cloudinit=%~dp0\multipass-cloudinit.yaml
SET name=%1
SET image=%3

:: CMD's case statement
GOTO %2

:nano
    SET cpu=1
    SET mem=1g
    SET disk=10gb

    GOTO launch

:std
    SET cpu=1
    SET mem=2g
    SET disk=10gb
    
    GOTO launch

    @REM @REM ECHO Building standard sized VM (1cpu x 2g x 25g) %1 / Importing keys / updating files, Stand by...
    @REM @REM multipass launch --name %1 --cpus=1 --memory=2g --disk=25gb %3 --cloud-init multipass-cloudinit.yaml
    @REM GOTO cleanup
:big
    SET cpu=2
    SET mem=4g
    SET disk=10gb
    
    GOTO launch

    @REM ECHO Building big sized VM (2cpu x 4g x 50g) %1 / Importing keys / updating files, Stand by...
    @REM multipass launch --name %1 --cpus=2 --memory=4g --disk=50gb %3 --cloud-init multipass-cloudinit.yaml
    @REM GOTO cleanup
:huge
    SET cpu=4
    SET mem=8g
    SET disk=50gb
    
    GOTO launch

    @REM ECHO Building HUGE sized VM (4cpu x 8g x 50g) %1 / Importing keys / updating files, Stand by...
    @REM multipass launch --name %1 --cpus=4 --memory=8g --disk=50gb %3 --cloud-init multipass-cloudinit.yaml
    @REM GOTO cleanup

:: if we get here, we don't have a type to launch
:fail
    GOTO help

:launch
    ECHO Building (%cpu% x %mem% x %disk%) named %name%
    multipass launch --name %name% --cpus=%cpu% --memory=%mem% --disk=%disk% --cloud-init %cloudinit%  %image%
    
GOTO end

:help
    ECHO.
    ECHO buildvm.cmd {name} {size}
    ECHO {name} - name of the VM
    ECHO {size} - nano(1cpu x 1gb x 25gb) std(1x2x25) big(2x4x50), huge(4x8x50)
    ECHO {version} - Version of Ubuntu to use from "mp find"
    ECHO.
:end