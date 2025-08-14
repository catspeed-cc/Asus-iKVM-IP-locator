# find-Asus-BMC-IP
A powershell script to find the IP of your Asus BMC/iKVM (for WRX80E)

# Installation
This only works on windows, so download the latest release ZIP from https://github.com/catspeed-cc/find-Asus-BMC-IP/releases and extract it.

# Usage
Use either the batch file or the PS1 file, but you _need_ both - you only need to execute one of them.

If you use the PS1 scipt, make sure you run  before every time you run it to allow the script to execute.

### find-BMC.bat
- Open CMD as administrator
- `cd` to the directory where it was extracted
- `find-BMC.bat 192.168.10` - find BMC in your IP range \
- `find-BMC.bat 192.168.10 500` - find BMC in your IP range w/ 500ms timeout

### find-BMC.ps1
- Open PowerShell as administrator
- `cd` to the directory where it was extracted
- Run `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` every time before you run the script
- `.\Find-BMC.ps1 -IPRange "192.168.10"` - find BMC in your IP range \
- `.\Find-BMC.ps1 -IPRange "10.0.5" -Timeout 500` - find BMC in your IP range w/ 500ms timeout

# Extra
- The script was designed to utilize parameters because not everyone's network is the same as mine (192.168.10.*)
- The script was designed to only enable PS execution for itself for security
- Interactive version coming eventually :) At least v1.0.0 works :)
- BASH version coming ? Maybe ? :)
