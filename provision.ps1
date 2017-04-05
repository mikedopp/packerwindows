# Runs after Windows Updates have been applied and WinRM started

Install-Module WindowsBox.AutoLogon -Force
Install-Module WindowsBox.Compact -Force
Install-Module WindowsBox.Explorer -Force
Install-Module WindowsBox.Hibernation -Force
Install-Module WindowsBox.RDP -Force
Install-Module WindowsBox.UAC -Force
Install-Module WindowsBox.VagrantAccount -Force
Install-Module WindowsBox.VMGuestTools -Force

Disable-AutoLogon
Disable-UAC
Enable-RDP
Set-ExplorerConfiguration
Disable-Hibernation
Set-VagrantAccount
Install-VMGuestTools

if ($env:devtools -eq $true) {
  # Install Linux subsystem
  Install-Module WindowsBox.DevMode -Force
  Enable-DevMode

  # Install chocolatey and use it to install dev tools
  Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression

  choco install powershell-packagemanagement -y
  choco install visualstudio2017community -y
  choco install visualstudio2017-workload-netcoretools -y
  choco install visualstudio2017-workload-netweb -y
  choco install visualstudio2017-workload-node -y
  choco install visualstudio2017-workload-azure -y
  choco install visualstudio2017-workload-nativedesktop -y
  choco install visualstudio2017-workload-manageddesktop -y
  choco install resharper -y
  choco install notepadplusplus.install -y
  choco install googlechrome -y
  choco install git.install -y
  choco install beyondcompare -y
  choco install fiddler4 -y
  choco install sql-server-management-studio -y
  choco install nodejs.install -y
  choco install cloudfoundry-cli -y
  choco install nuget.commandline -y
  choco install soapui -y

  # Create a default PowerShell profile and add the msbuild.exe to the PATH
  '$env:PATH="$env:PATH;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin"' | Out-File "$env:USERPROFILE\Documents\WindowsPowerShell\profile.ps1"
}

# Final cleanup
Optimize-DiskUsage
