# find-Asus-BMC-IP
A powershell script to find the IP of your Asus BMC/iKVM (for WRX80E)

# Installation
This only works on windows, so download the ZIP and extract it into it's own directory

# Usage
Use either the batch file or the PS1 file, you need both, but only need to execute one.

If you use the PS1 scipt, make sure you run `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` before every time you run it to allow the script to execute.

### find-BMC.bat
`find-BMC.bat 192.168.10` - find BMC in your IP range \
`find-BMC.bat 192.168.10 500` - find BMC in your IP range w/ 500ms timeout

### find-BMC.ps1
`.\Find-BMC.ps1 -IPRange "192.168.10"` - find BMC in your IP range \
`.\Find-BMC.ps1 -IPRange "10.0.5" -Timeout 500` - find BMC in your IP range w/ 500ms timeout
