@echo off
:: Given a name and type, we'll build a VM for the user

:: params
:: %1 - Name
:: %2 - Type of VM
:: %3 - image name to use (ubuntu version)

set CI=C:\users\jmatthew\dev\scripts\multipass-cloudinit.yaml

:: fail if parameters are blank
IF "%1"=="" GOTO help
IF "%2"=="" GOTO help

:: CMD's case statement
GOTO %2

:nano
    ECHO Building nano sized VM (1cpu x 1g x 25g) %1 / Importing keys / updating files, Stand by...
    multipass launch --name %1 --cpus=1 --memory=1g --disk=25gb %3 --cloud-init %CI%
    GOTO cleanup
:std
    ECHO Building standard sized VM (1cpu x 2g x 25g) %1 / Importing keys / updating files, Stand by...
    multipass launch --name %1 --cpus=1 --memory=2g --disk=25gb %3 --cloud-init %CI%
    GOTO cleanup
:big
    ECHO Building big sized VM (2cpu x 4g x 50g) %1 / Importing keys / updating files, Stand by...
    multipass launch --name %1 --cpus=2 --memory=4g --disk=50gb %3 --cloud-init %CI%
    GOTO cleanup
:huge
    ECHO Building HUGE sized VM (4cpu x 8g x 50g) %1 / Importing keys / updating files, Stand by...
    multipass launch --name %1 --cpus=4 --memory=8g --disk=50gb %3 --cloud-init %CI%
    GOTO cleanup


:cleanup
    
GOTO end

:help
    ECHO.
    ECHO buildvm.cmd {name} {size}
    ECHO {name} - name of the VM
    ECHO {size} - nano(1cpu x 1gb x 25gb) std(1x2x25) big(2x4x50), huge(4x8x50)
    ECHO {version} - Version of Ubuntu to use from "mp find"
    ECHO.
:end