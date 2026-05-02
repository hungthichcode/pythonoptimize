# ============================================================
# Python Manager - PowerShell Script - FULL VERSION
# ============================================================

$script:Language = "VI"

# ============================================================
# LANGUAGE STRINGS
# ============================================================
function Get-Text {
    param([string]$Key)
    
    $texts = @{
        "VI" = @{
            "title"                   = "TRINH QUAN LY PYTHON"
            "subtitle"                = "Cong cu cai dat va quan ly Python & Libraries"
            "menu_install_python"     = "Cai dat Python"
            "menu_uninstall_python"   = "Go cai dat Python"
            "menu_install_lib_custom" = "Cai dat Library Tuy chon"
            "menu_install_lib_all"    = "Cai dat toan bo Library"
            "menu_language"           = "Tuy chinh ngon ngu"
            "menu_exit"               = "Thoat"
            "select_option"           = "Chon tuy chon"
            "invalid_option"          = "Tuy chon khong hop le! Vui long thu lai."
            "press_enter"             = "Nhan Enter de tiep tuc..."
            "select_version"          = "Nhap so phien ban muon cai"
            "download_installing"     = "Dang tai va cai dat"
            "install_success"         = "Cai dat thanh cong!"
            "install_failed"          = "Cai dat that bai!"
            "uninstall_confirm"       = "Ban co chac muon go cai dat Python khong? (Y/N)"
            "uninstalling"            = "Dang go cai dat Python..."
            "uninstall_success"       = "Go cai dat thanh cong!"
            "uninstall_failed"        = "Khong tim thay Python de go cai dat!"
            "select_groups"           = "Nhap so nhom muon cai (vi du: 1,3,5)"
            "installing_groups"       = "Dang cai dat cac nhom da chon..."
            "installing_all"          = "Dang cai dat toan bo Library..."
            "install_all_confirm"     = "Cai dat toan bo Library co the mat nhieu thoi gian. Tiep tuc? (Y/N)"
            "select_lang"             = "Chon ngon ngu / Select Language"
            "time_vn"                 = "Gio Viet Nam"
            "back"                    = "Quay lai"
            "group_installed"         = "Da cai dat xong nhom"
            "all_done"                = "Hoan tat!"
            "python_versions"         = "DANH SACH PHIEN BAN PYTHON"
            "lib_groups"              = "DANH SACH NHOM LIBRARY"
            "no_python"               = "Chua cai Python"
            "current_python"          = "Python hien tai"
            "user_info"               = "Nguoi dung"
        }
        "EN" = @{
            "title"                   = "PYTHON MANAGER"
            "subtitle"                = "Python & Libraries Installation Tool"
            "menu_install_python"     = "Install Python"
            "menu_uninstall_python"   = "Uninstall Python"
            "menu_install_lib_custom" = "Install Custom Libraries"
            "menu_install_lib_all"    = "Install All Libraries"
            "menu_language"           = "Language Settings"
            "menu_exit"               = "Exit"
            "select_option"           = "Select option"
            "invalid_option"          = "Invalid option! Please try again."
            "press_enter"             = "Press Enter to continue..."
            "select_version"          = "Enter version number to install"
            "download_installing"     = "Downloading and installing"
            "install_success"         = "Installation successful!"
            "install_failed"          = "Installation failed!"
            "uninstall_confirm"       = "Are you sure you want to uninstall Python? (Y/N)"
            "uninstalling"            = "Uninstalling Python..."
            "uninstall_success"       = "Uninstallation successful!"
            "uninstall_failed"        = "Python not found to uninstall!"
            "select_groups"           = "Enter group numbers to install (e.g.: 1,3,5)"
            "installing_groups"       = "Installing selected groups..."
            "installing_all"          = "Installing all libraries..."
            "install_all_confirm"     = "Installing all libraries may take a long time. Continue? (Y/N)"
            "select_lang"             = "Chon ngon ngu / Select Language"
            "time_vn"                 = "Vietnam Time"
            "back"                    = "Go Back"
            "group_installed"         = "Group installed"
            "all_done"                = "All Done!"
            "python_versions"         = "PYTHON VERSION LIST"
            "lib_groups"              = "LIBRARY GROUPS LIST"
            "no_python"               = "Python not installed"
            "current_python"          = "Current Python"
            "user_info"               = "User"
        }
    }
    return $texts[$script:Language][$Key]
}

# ============================================================
# UTILITY FUNCTIONS
# ============================================================
function Get-VietnamTime  { return [System.DateTime]::UtcNow.AddHours(7) }
function Get-WindowsBuild { return [int](Get-WmiObject -Class Win32_OperatingSystem).BuildNumber }
function Get-WindowsArch  {
    $arch = (Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture
    if ($arch -like "*64*") { return 64 } else { return 32 }
}

# ============================================================
# ASCII ART BANNER
# ============================================================
function Show-AsciiBanner {
    $nmhruby = @(
        " ███╗   ██╗███╗   ███╗██╗  ██╗██████╗ ██╗   ██╗██████╗ ██╗   ██╗"
        " ████╗  ██║████╗ ████║██║  ██║██╔══██╗██║   ██║██╔══██╗╚██╗ ██╔╝"
        " ██╔██╗ ██║██╔████╔██║███████║██████╔╝██║   ██║██████╔╝ ╚████╔╝ "
        " ██║╚██╗██║██║╚██╔╝██║██╔══██║██╔══██╗██║   ██║██╔══██╗  ╚██╔╝  "
        " ██║ ╚████║██║ ╚═╝ ██║██║  ██║██║  ██║╚██████╔╝██████╔╝   ██║   "
        " ╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝    ╚═╝   "
    )
    $python = @(
        "      ██████╗ ██╗   ██╗████████╗██╗  ██╗ ██████╗ ███╗   ██╗      "
        "      ██╔══██╗╚██╗ ██╔╝╚══██╔══╝██║  ██║██╔═══██╗████╗  ██║      "
        "      ██████╔╝ ╚████╔╝    ██║   ███████║██║   ██║██╔██╗ ██║      "
        "      ██╔═══╝   ╚██╔╝     ██║   ██╔══██║██║   ██║██║╚██╗██║      "
        "      ██║        ██║      ██║   ██║  ██║╚██████╔╝██║ ╚████║      "
        "      ╚═╝        ╚═╝      ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝      "
    )
    $colors1 = @("Red","Yellow","Green","Cyan","Blue","Magenta")
    $colors2 = @("Magenta","Blue","Cyan","Green","Yellow","Red")

    Write-Host ""
    Write-Host ("  " + "═" * 68) -ForegroundColor DarkCyan
    for ($i = 0; $i -lt $nmhruby.Count; $i++) {
        Write-Host ("  " + $nmhruby[$i]) -ForegroundColor $colors1[$i]
    }
    Write-Host ""
    for ($i = 0; $i -lt $python.Count; $i++) {
        Write-Host ("  " + $python[$i]) -ForegroundColor $colors2[$i]
    }
    Write-Host ("  " + "═" * 68) -ForegroundColor DarkCyan
    Write-Host ""
}

# ============================================================
# HEADER TINH (dung cho sub-menu) - Chi hien thi HH:mm
# ============================================================
function Show-Header {
    Clear-Host
    $vnTime   = Get-VietnamTime
    # ✅ SUA 1: Chi lay gio:phut, bo giay
    $timeStr  = $vnTime.ToString("HH:mm")
    $dateStr  = $vnTime.ToString("dd/MM/yyyy")
    $os       = Get-WmiObject -Class Win32_OperatingSystem
    $osInfo   = $os.Caption
    $osArch   = $os.OSArchitecture
    $userName = $env:USERNAME
    $langText = if ($script:Language -eq "VI") { "Tieng Viet" } else { "English" }

    Write-Host ""
    Write-Host "  ╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║         🐍  $(Get-Text 'title')  🐍                         ║" -ForegroundColor Yellow
    Write-Host "  ╠══════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
    Write-Host "  ║  🕐 $(Get-Text 'time_vn'): $timeStr       📅 $dateStr                   ║" -ForegroundColor Green
    Write-Host "  ║  💻 OS  : $($osInfo.PadRight(51).Substring(0,[Math]::Min(51,$osInfo.Length)))║" -ForegroundColor Blue
    Write-Host "  ║  🖥️  Arch: $($osArch.PadRight(51).Substring(0,[Math]::Min(51,$osArch.Length)))║" -ForegroundColor Blue
    Write-Host "  ║  👤 $(Get-Text 'user_info'): $($userName.PadRight(53).Substring(0,[Math]::Min(53,$userName.Length)))║" -ForegroundColor Magenta
    Write-Host "  ║  🌐 Lang : $($langText.PadRight(51).Substring(0,[Math]::Min(51,$langText.Length)))║" -ForegroundColor White
    Write-Host "  ╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

# ============================================================
# MAIN MENU VOI DONG HO - Chi HH:mm, cap nhat moi 60 giay
# ============================================================
function Show-MainMenu {
    while ($true) {
        Clear-Host

        $os       = Get-WmiObject -Class Win32_OperatingSystem
        $osInfo   = $os.Caption
        $osArch   = $os.OSArchitecture
        $userName = $env:USERNAME
        $langText = if ($script:Language -eq "VI") { "Tieng Viet" } else { "English" }

        # ASCII BANNER
        Show-AsciiBanner

        # HEADER
        Write-Host "  ╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "  ║         🐍  $(Get-Text 'title')  🐍                         ║" -ForegroundColor Yellow
        Write-Host "  ╠══════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan

        # Ghi nho dong dong ho de cap nhat
        $clockLineRow = $Host.UI.RawUI.CursorPosition.Y
        # ✅ SUA 2: Placeholder chi co HH:mm, bo :ss
        Write-Host "  ║  🕐 $(Get-Text 'time_vn'): --:--       📅 --/--/----                   ║" -ForegroundColor Green

        Write-Host "  ║  💻 OS  : $($osInfo.PadRight(51).Substring(0,[Math]::Min(51,$osInfo.Length)))║" -ForegroundColor Blue
        Write-Host "  ║  🖥️  Arch: $($osArch.PadRight(51).Substring(0,[Math]::Min(51,$osArch.Length)))║" -ForegroundColor Blue
        Write-Host "  ║  👤 $(Get-Text 'user_info'): $($userName.PadRight(53).Substring(0,[Math]::Min(53,$userName.Length)))║" -ForegroundColor Magenta
        Write-Host "  ║  🌐 Lang : $($langText.PadRight(51).Substring(0,[Math]::Min(51,$langText.Length)))║" -ForegroundColor White
        Write-Host "  ╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host ""

        # MENU
        Write-Host "  ╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "  ║                      📋 MENU CHINH                          ║" -ForegroundColor Yellow
        Write-Host "  ╠══════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
        Write-Host "  ║                                                              ║" -ForegroundColor Cyan
        Write-Host "  ║   [1]  📦  $(Get-Text 'menu_install_python')                          ║" -ForegroundColor White
        Write-Host "  ║   [2]  🗑️   $(Get-Text 'menu_uninstall_python')                        ║" -ForegroundColor White
        Write-Host "  ║   [3]  🎯  $(Get-Text 'menu_install_lib_custom')                   ║" -ForegroundColor White
        Write-Host "  ║   [4]  🚀  $(Get-Text 'menu_install_lib_all')                      ║" -ForegroundColor White
        Write-Host "  ║   [5]  🌐  $(Get-Text 'menu_language')                             ║" -ForegroundColor White
        Write-Host "  ║   [0]  ❌  $(Get-Text 'menu_exit')                                       ║" -ForegroundColor Red
        Write-Host "  ║                                                              ║" -ForegroundColor Cyan
        Write-Host "  ╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  $(Get-Text 'select_option') (0-5): " -ForegroundColor Cyan -NoNewline

        # ✅ SUA 3: Background Job chi output HH:mm, cap nhat moi 60 giay
        $clockJob = Start-Job -ScriptBlock {
            while ($true) {
                $vnTime = [System.DateTime]::UtcNow.AddHours(7)
                Write-Output "$($vnTime.ToString('HH:mm'))|$($vnTime.ToString('dd/MM/yyyy'))"
                Start-Sleep -Seconds 60
            }
        }

        $inputBuffer = ""

        while ($true) {
            # Cap nhat dong ho HH:mm
            $jobOutput = Receive-Job -Job $clockJob
            if ($jobOutput) {
                $latest = ($jobOutput | Select-Object -Last 1)
                $parts  = $latest -split "\|"
                if ($parts.Count -eq 2) {
                    $savedCursor = $Host.UI.RawUI.CursorPosition
                    $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates(0, $clockLineRow)
                    # ✅ Hien thi HH:mm, bo :ss
                    Write-Host "  ║  🕐 $(Get-Text 'time_vn'): $($parts[0])       📅 $($parts[1])                   ║" -ForegroundColor Green -NoNewline
                    $Host.UI.RawUI.CursorPosition = $savedCursor
                }
            }

            # Doc phim
            if ([Console]::KeyAvailable) {
                $key = [Console]::ReadKey($true)
                if ($key.Key -eq "Enter") {
                    Stop-Job   -Job $clockJob
                    Remove-Job -Job $clockJob
                    Write-Host ""
                    break
                }
                elseif ($key.Key -eq "Backspace") {
                    if ($inputBuffer.Length -gt 0) {
                        $inputBuffer = $inputBuffer.Substring(0, $inputBuffer.Length - 1)
                        Write-Host "`b `b" -NoNewline
                    }
                }
                else {
                    $char = $key.KeyChar.ToString()
                    if ($char -match "^[0-5]$") {
                        $inputBuffer += $char
                        Write-Host $char -NoNewline -ForegroundColor Yellow
                    }
                }
            }
            Start-Sleep -Milliseconds 200
        }

        # XU LY LUA CHON
        switch ($inputBuffer.Trim()) {
            "1" { Show-InstallPython }
            "2" { Show-UninstallPython }
            "3" { Show-InstallCustomLib }
            "4" { Show-InstallAllLib }
            "5" { Show-LanguageSettings }
            "0" {
                Clear-Host
                Write-Host ""
                Write-Host "  👋 Cam on da su dung Python Manager!" -ForegroundColor Green
                Write-Host "  🐍 Chuc ban code vui ve!" -ForegroundColor Yellow
                Write-Host ""
                Start-Sleep -Seconds 2
                return
            }
            default {
                Write-Host "  ❌ $(Get-Text 'invalid_option')" -ForegroundColor Red
                Start-Sleep -Seconds 1
            }
        }
    }
}

# ============================================================
# MENU 1: CAI DAT PYTHON
# ============================================================
function Show-InstallPython {
    Show-Header

    $winBuild = Get-WindowsBuild
    $winArch  = Get-WindowsArch

    $currentPython = ""
    try {
        $pv = python --version 2>&1
        if ($pv -match "Python") { $currentPython = $pv.ToString().Trim() }
    } catch {}

    Write-Host "  ╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
    Write-Host "  ║           📦 $(Get-Text 'python_versions')                   ║" -ForegroundColor Yellow
    Write-Host "  ╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
    Write-Host ""

    if ($currentPython) {
        Write-Host "  🐍 $(Get-Text 'current_python'): $currentPython" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️  $(Get-Text 'no_python')" -ForegroundColor Red
    }
    Write-Host "  💻 Windows Build: $winBuild | Architecture: $($winArch)-bit" -ForegroundColor Gray
    Write-Host ""

    $pythonVersions = @(
        @{ Num="1";  Ver="3.13.1";  MinBuild=19041; Notes="Moi nhat 2025";          Url="https://www.python.org/ftp/python/3.13.1/python-3.13.1-amd64.exe"   }
        @{ Num="2";  Ver="3.12.8";  MinBuild=17763; Notes="On dinh - Khuyen nghi";  Url="https://www.python.org/ftp/python/3.12.8/python-3.12.8-amd64.exe"   }
        @{ Num="3";  Ver="3.11.11"; MinBuild=17763; Notes="LTS - Rat on dinh";      Url="https://www.python.org/ftp/python/3.11.11/python-3.11.11-amd64.exe" }
        @{ Num="4";  Ver="3.10.16"; MinBuild=14393; Notes="Pho bien";               Url="https://www.python.org/ftp/python/3.10.16/python-3.10.16-amd64.exe" }
        @{ Num="5";  Ver="3.9.21";  MinBuild=14393; Notes="Tuong thich rong";       Url="https://www.python.org/ftp/python/3.9.21/python-3.9.21-amd64.exe"   }
        @{ Num="6";  Ver="3.8.20";  MinBuild=10240; Notes="Ho tro den 2024";        Url="https://www.python.org/ftp/python/3.8.20/python-3.8.20-amd64.exe"   }
        @{ Num="7";  Ver="3.7.17";  MinBuild=7601;  Notes="Cu - Khong khuyen nghi"; Url="https://www.python.org/ftp/python/3.7.17/python-3.7.17-amd64.exe"   }
        @{ Num="8";  Ver="3.6.15";  MinBuild=7601;  Notes="EOL - Rat cu";           Url="https://www.python.org/ftp/python/3.6.15/python-3.6.15-amd64.exe"   }
        @{ Num="9";  Ver="3.5.10";  MinBuild=7601;  Notes="EOL - Khong ho tro";     Url="https://www.python.org/ftp/python/3.5.10/python-3.5.10-amd64.exe"   }
        @{ Num="10"; Ver="3.4.10";  MinBuild=7601;  Notes="EOL - Rat cu";           Url="https://www.python.org/ftp/python/3.4.10/python-3.4.10.msi"         }
        @{ Num="11"; Ver="2.7.18";  MinBuild=7601;  Notes="EOL - Legacy";           Url="https://www.python.org/ftp/python/2.7.18/python-2.7.18.amd64.msi"   }
    )

    Write-Host "  ┌──────┬───────────────┬──────────────────────────────────────────┐" -ForegroundColor Cyan
    Write-Host "  │  STT │    Phien ban  │  Ghi chu & Tuong thich                   │" -ForegroundColor Cyan
    Write-Host "  ├──────┼───────────────┼──────────────────────────────────────────┤" -ForegroundColor Cyan

    foreach ($pv in $pythonVersions) {
        $compat    = if ($winBuild -ge $pv.MinBuild) { "OK" } else { "NO" }
        $isRec     = if ($pv.Ver -eq "3.12.8") { "*" } else { " " }
        $numPad    = $pv.Num.PadLeft(3)
        $verPad    = $pv.Ver.PadRight(13)
        $notesFull = "$isRec [$compat] $($pv.Notes)"
        $notesPad  = $notesFull.PadRight(40)

        $color = if ($winBuild -lt $pv.MinBuild)                          { "DarkGray" }
                 elseif ($pv.Ver -eq "3.12.8" -or $pv.Ver -eq "3.11.11") { "Green"    }
                 elseif ($pv.Ver -eq "3.13.1")                            { "Yellow"   }
                 else                                                       { "White"    }

        Write-Host "  │ $numPad  │ $verPad │ $notesPad │" -ForegroundColor $color
    }

    Write-Host "  └──────┴───────────────┴──────────────────────────────────────────┘" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  * = Khuyen nghi | [OK] = Tuong thich | [NO] = Khong tuong thich" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  [0] $(Get-Text 'back')" -ForegroundColor Red
    Write-Host ""

    $choice = Read-Host "  $(Get-Text 'select_version') (1-11, 0 de quay lai)"
    if ($choice -eq "0") { return }

    $selectedVersion = $pythonVersions | Where-Object { $_.Num -eq $choice }

    if ($null -eq $selectedVersion) {
        Write-Host "  ❌ $(Get-Text 'invalid_option')" -ForegroundColor Red
        Start-Sleep -Seconds 2; return
    }
    if ($winBuild -lt $selectedVersion.MinBuild) {
        Write-Host "  ❌ Phien ban nay khong tuong thich voi Windows cua ban!" -ForegroundColor Red
        Read-Host "  $(Get-Text 'press_enter')"; return
    }

    Write-Host ""
    Write-Host "  📦 $(Get-Text 'download_installing') Python $($selectedVersion.Ver)..." -ForegroundColor Cyan
    Write-Host "  🔗 $($selectedVersion.Url)" -ForegroundColor Gray
    Write-Host ""

    $tempFile = "$env:TEMP\python_installer_$($selectedVersion.Ver).exe"
    try {
        Write-Host "  ⬇️  Dang tai xuong..." -ForegroundColor Yellow
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($selectedVersion.Url, $tempFile)
        Write-Host "  ✅ Tai xuong hoan tat!" -ForegroundColor Green
        Write-Host "  🔧 Dang cai dat..." -ForegroundColor Yellow

        $process = Start-Process -FilePath $tempFile `
                                 -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_test=0" `
                                 -Wait -PassThru

        if ($process.ExitCode -eq 0) {
            Write-Host "  ✅ $(Get-Text 'install_success') Python $($selectedVersion.Ver)" -ForegroundColor Green
        } else {
            Write-Host "  ❌ $(Get-Text 'install_failed') (Code: $($process.ExitCode))" -ForegroundColor Red
        }
        Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
    } catch {
        Write-Host "  ❌ Loi: $_" -ForegroundColor Red
        Write-Host "  🌐 Vui long tai thu cong: $($selectedVersion.Url)" -ForegroundColor Yellow
    }

    Write-Host ""
    Read-Host "  $(Get-Text 'press_enter')"
}

# ============================================================
# MENU 2: GO CAI DAT PYTHON
# ============================================================
function Show-UninstallPython {
    Show-Header

    Write-Host "  ╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Red
    Write-Host "  ║              🗑️  GO CAI DAT PYTHON                           ║" -ForegroundColor Red
    Write-Host "  ╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Red
    Write-Host ""

    $pythonInstalls = @()
    $uninstallPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    foreach ($path in $uninstallPaths) {
        try {
            $items = Get-ItemProperty $path -ErrorAction SilentlyContinue |
                     Where-Object { $_.DisplayName -like "*Python*" -and $_.DisplayName -notlike "*Launcher*" }
            $pythonInstalls += $items
        } catch {}
    }

    if ($pythonInstalls.Count -eq 0) {
        Write-Host "  ⚠️  $(Get-Text 'uninstall_failed')" -ForegroundColor Yellow
        Read-Host "  $(Get-Text 'press_enter')"; return
    }

    Write-Host "  📋 Cac phien ban Python da cai:" -ForegroundColor Cyan
    Write-Host ""
    $i = 1
    foreach ($py in $pythonInstalls) {
        Write-Host "  [$i] $($py.DisplayName) - $($py.DisplayVersion)" -ForegroundColor White
        $i++
    }
    Write-Host "  [0] $(Get-Text 'back')" -ForegroundColor Gray
    Write-Host ""

    $confirm = Read-Host "  $(Get-Text 'uninstall_confirm')"
    if ($confirm -notmatch "^[Yy]$") { return }

    Write-Host ""
    Write-Host "  🗑️  $(Get-Text 'uninstalling')" -ForegroundColor Yellow

    foreach ($py in $pythonInstalls) {
        Write-Host "  🔧 Dang go: $($py.DisplayName)..." -ForegroundColor Gray
        try {
            if ($py.UninstallString) {
                $cmd = $py.UninstallString -replace '"', ''
                if ($cmd -like "*.exe*") {
                    Start-Process -FilePath $cmd -ArgumentList "/uninstall /quiet" -Wait
                } else {
                    Start-Process "msiexec.exe" -ArgumentList "/x $($py.PSChildName) /quiet" -Wait
                }
                Write-Host "  ✅ Da go: $($py.DisplayName)" -ForegroundColor Green
            }
        } catch {
            Write-Host "  ❌ Loi: $_" -ForegroundColor Red
        }
    }

    Write-Host ""
    Write-Host "  🧹 Dang don dep PATH..." -ForegroundColor Yellow
    $mp = [System.Environment]::GetEnvironmentVariable("PATH","Machine")
    $up = [System.Environment]::GetEnvironmentVariable("PATH","User")
    [System.Environment]::SetEnvironmentVariable("PATH",($mp -split ";" | Where-Object {$_ -notlike "*Python*"}) -join ";","Machine")
    [System.Environment]::SetEnvironmentVariable("PATH",($up -split ";" | Where-Object {$_ -notlike "*Python*"}) -join ";","User")

    Write-Host "  ✅ $(Get-Text 'uninstall_success')" -ForegroundColor Green
    Write-Host "  💡 Vui long khoi dong lai may tinh de hoan tat." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "  $(Get-Text 'press_enter')"
}

# ============================================================
# LIBRARY GROUPS DATA
# ============================================================
function Get-LibraryGroups {
    return @(
        @{ Num="1";  Name="📊 Data Science & ML";      NameVI="📊 Khoa hoc du lieu & ML";      Packages="numpy pandas matplotlib seaborn scikit-learn scipy statsmodels" }
        @{ Num="2";  Name="🤖 Deep Learning";           NameVI="🤖 Hoc sau";                     Packages="tensorflow keras torch torchvision transformers" }
        @{ Num="3";  Name="📓 Jupyter & IDE Tools";     NameVI="📓 Jupyter & Cong cu IDE";       Packages="jupyter notebook jupyterlab ipython" }
        @{ Num="4";  Name="🌐 Web Scraping & HTTP";     NameVI="🌐 Web Scraping & HTTP";         Packages="requests beautifulsoup4 scrapy selenium httpx aiohttp" }
        @{ Num="5";  Name="🖥️ Web Framework";           NameVI="🖥️ Framework Web";               Packages="flask django fastapi uvicorn gunicorn" }
        @{ Num="6";  Name="🗄️ Database";                NameVI="🗄️ Co so du lieu";               Packages="sqlalchemy pymysql psycopg2-binary pymongo redis" }
        @{ Num="7";  Name="🖼️ Image Processing";        NameVI="🖼️ Xu ly hinh anh";              Packages="pillow opencv-python imageio" }
        @{ Num="8";  Name="📈 Visualization";           NameVI="📈 Truc quan hoa du lieu";        Packages="plotly dash bokeh altair" }
        @{ Num="9";  Name="🧪 Testing & Code Quality";  NameVI="🧪 Kiem thu & Chat luong code";  Packages="pytest black flake8 pylint isort mypy" }
        @{ Num="10"; Name="🛠️ Utilities";               NameVI="🛠️ Tien ich";                    Packages="tqdm rich click typer python-dotenv arrow dateparser pydantic" }
        @{ Num="11"; Name="📝 NLP";                     NameVI="📝 Xu ly ngon ngu tu nhien";      Packages="nltk spacy gensim" }
        @{ Num="12"; Name="📁 File Processing";         NameVI="📁 Xu ly tep tin";               Packages="xlrd openpyxl xlwt reportlab" }
        @{ Num="13"; Name="🔐 Security & Network";      NameVI="🔐 Bao mat & Mang";              Packages="cryptography paramiko fabric" }
        @{ Num="14"; Name="📨 Message Queue";           NameVI="📨 Hang doi tin nhan";           Packages="celery pika kafka-python" }
    )
}

# ============================================================
# MENU 3: CAI DAT LIBRARY TUY CHON
# ============================================================
function Show-InstallCustomLib {
    Show-Header
    $groups = Get-LibraryGroups

    Write-Host "  ╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║           📦 $(Get-Text 'lib_groups')                        ║" -ForegroundColor Cyan
    Write-Host "  ╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    foreach ($group in $groups) {
        $name   = if ($script:Language -eq "VI") { $group.NameVI } else { $group.Name }
        $numPad = $group.Num.PadLeft(2)
        Write-Host "  [$numPad] $name" -ForegroundColor White
        Write-Host "       └─ $($group.Packages)" -ForegroundColor DarkGray
        Write-Host ""
    }

    Write-Host "  [0] $(Get-Text 'back')" -ForegroundColor Red
    Write-Host ""
    Write-Host "  💡 Vi du nhap: 1,3,5 de cai nhom 1, 3 va 5" -ForegroundColor Yellow
    Write-Host ""

    $choice = Read-Host "  $(Get-Text 'select_groups')"
    if ($choice -eq "0") { return }

    try { python --version 2>&1 | Out-Null } catch {
        Write-Host "  ❌ Python chua duoc cai dat!" -ForegroundColor Red
        Read-Host "  $(Get-Text 'press_enter')"; return
    }

    $selectedNums = $choice -split "," | ForEach-Object { $_.Trim() }
    Write-Host ""
    Write-Host "  📦 $(Get-Text 'installing_groups')" -ForegroundColor Cyan
    Write-Host ""

    foreach ($num in $selectedNums) {
        $group = $groups | Where-Object { $_.Num -eq $num }
        if ($null -eq $group) {
            Write-Host "  ⚠️  Nhom $num khong ton tai, bo qua..." -ForegroundColor Yellow
            continue
        }
        $name = if ($script:Language -eq "VI") { $group.NameVI } else { $group.Name }
        Write-Host "  🔧 Dang cai: $name" -ForegroundColor Yellow

        foreach ($pkg in ($group.Packages -split " ")) {
            Write-Host "     ⬇️  $pkg..." -ForegroundColor DarkCyan -NoNewline
            pip install $pkg 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) { Write-Host " ✅" -ForegroundColor Green }
            else                      { Write-Host " ❌" -ForegroundColor Red   }
        }
        Write-Host "  ✅ $(Get-Text 'group_installed'): $name" -ForegroundColor Green
        Write-Host ""
    }

    Write-Host "  🎉 $(Get-Text 'all_done')" -ForegroundColor Green
    Write-Host ""
    Read-Host "  $(Get-Text 'press_enter')"
}

# ============================================================
# MENU 4: CAI DAT TOAN BO LIBRARY
# ============================================================
function Show-InstallAllLib {
    Show-Header
    $groups        = Get-LibraryGroups
    $totalPackages = ($groups | ForEach-Object { $_.Packages -split " " }).Count

    Write-Host "  ╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "  ║          📦 CAI DAT TOAN BO LIBRARY                         ║" -ForegroundColor Green
    Write-Host "  ╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "  📊 Thong ke:" -ForegroundColor Cyan
    Write-Host "  • Tong so nhom    : $($groups.Count)" -ForegroundColor White
    Write-Host "  • Tong so packages: $totalPackages"   -ForegroundColor White
    Write-Host "  • Uoc tinh        : 15-30 phut"       -ForegroundColor White
    Write-Host ""
    Write-Host "  ⚠️  CANH BAO: Qua trinh nay se tai ve nhieu GB du lieu!" -ForegroundColor Yellow
    Write-Host ""

    try {
        $pyVer = python --version 2>&1
        Write-Host "  🐍 Python: $pyVer" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ Python chua duoc cai dat!" -ForegroundColor Red
        Read-Host "  $(Get-Text 'press_enter')"; return
    }

    Write-Host ""
    $confirm = Read-Host "  $(Get-Text 'install_all_confirm')"
    if ($confirm -notmatch "^[Yy]$") { return }

    Write-Host ""
    Write-Host "  🚀 $(Get-Text 'installing_all')" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  🔧 Dang nang cap pip..." -ForegroundColor Yellow
    python -m pip install --upgrade pip 2>&1 | Out-Null
    Write-Host "  ✅ pip da duoc nang cap!" -ForegroundColor Green
    Write-Host ""

    $groupCount = 0; $successCount = 0; $failCount = 0

    foreach ($group in $groups) {
        $groupCount++
        $name = if ($script:Language -eq "VI") { $group.NameVI } else { $group.Name }
        Write-Host "  [$groupCount/$($groups.Count)] $name" -ForegroundColor Yellow

        foreach ($pkg in ($group.Packages -split " ")) {
            Write-Host "     ⬇️  $pkg..." -ForegroundColor DarkCyan -NoNewline
            pip install $pkg 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) { Write-Host " ✅" -ForegroundColor Green; $successCount++ }
            else                      { Write-Host " ❌" -ForegroundColor Red;   $failCount++    }
        }
        Write-Host ""
    }

    Write-Host "  ╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "  ║                  📊 KET QUA CAI DAT                         ║" -ForegroundColor Green
    Write-Host "  ╠══════════════════════════════════════════════════════════════╣" -ForegroundColor Green
    Write-Host "  ║  ✅ Thanh cong : $successCount packages".PadRight(63) + "║" -ForegroundColor White
    Write-Host "  ║  ❌ That bai   : $failCount packages".PadRight(63)    + "║" -ForegroundColor White
    Write-Host "  ║  📦 Tong cong  : $totalPackages packages / $($groups.Count) nhom".PadRight(63) + "║" -ForegroundColor White
    Write-Host "  ╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "  🎉 $(Get-Text 'all_done')" -ForegroundColor Green
    Write-Host ""
    Read-Host "  $(Get-Text 'press_enter')"
}

# ============================================================
# MENU 5: NGON NGU
# ============================================================
function Show-LanguageSettings {
    Show-Header

    Write-Host "  ╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
    Write-Host "  ║     🌐 TUY CHINH NGON NGU / LANGUAGE SETTINGS               ║" -ForegroundColor Magenta
    Write-Host "  ╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
    Write-Host ""

    $currentLang = if ($script:Language -eq "VI") { "Tieng Viet" } else { "English" }
    Write-Host "  🌐 Ngon ngu hien tai / Current: $currentLang" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  ┌──────────────────────────────────────────┐" -ForegroundColor White
    Write-Host "  │  [1]  Tieng Viet (Vietnamese)            │" -ForegroundColor Yellow
    Write-Host "  │  [2]  English (Tieng Anh)                │" -ForegroundColor Blue
    Write-Host "  │  [0]  $(Get-Text 'back')                            │" -ForegroundColor Gray
    Write-Host "  └──────────────────────────────────────────┘" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "  $(Get-Text 'select_lang')"
    switch ($choice) {
        "1" { $script:Language = "VI"; Write-Host "  ✅ Da chuyen sang Tieng Viet!" -ForegroundColor Green; Start-Sleep 1 }
        "2" { $script:Language = "EN"; Write-Host "  ✅ Switched to English!"        -ForegroundColor Green; Start-Sleep 1 }
        "0" { return }
        default { Write-Host "  ❌ $(Get-Text 'invalid_option')" -ForegroundColor Red; Start-Sleep 1 }
    }
}

# ============================================================
# KHOI CHAY
# ============================================================
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host ""
    Write-Host "  ⚠️  Script can quyen Administrator de hoat dong day du!" -ForegroundColor Yellow
    Write-Host "  💡 Nhan chuot phai PowerShell chon 'Run as Administrator'" -ForegroundColor Cyan
    Write-Host ""
    $c = Read-Host "  Tiep tuc voi quyen hien tai? (Y/N)"
    if ($c -notmatch "^[Yy]$") { exit }
}

Show-MainMenu