# ============================================
# TOOLKIT TECNICO POWERSHELL
# Cassetta degli attrezzi polivalente
# ============================================

# Verifica privilegi amministratore
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERRORE: Questo script richiede privilegi di amministratore!" -ForegroundColor Red
    Write-Host "Riavvia PowerShell come amministratore e riprova." -ForegroundColor Yellow
    Read-Host "Premi INVIO per uscire"
    exit
}

function Show-Menu {
    Clear-Host
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "        TOOLKIT TECNICO POWERSHELL        " -ForegroundColor Cyan
    Write-Host "         Cassetta degli Attrezzi          " -ForegroundColor Cyan
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Attivazione Windows (MAS)" -ForegroundColor Green
    Write-Host "2. Chris Titus Tech Utility" -ForegroundColor Green
    Write-Host "3. Configurazione Windows Security" -ForegroundColor Green
    Write-Host "4. DISM + SFC System Cleanup" -ForegroundColor Green
    Write-Host "5. Pulizia Completa Sistema" -ForegroundColor Green
    Write-Host "6. Ottimizzazione Rete" -ForegroundColor Green
    Write-Host "7. Chocolatey Package Manager" -ForegroundColor Green
    Write-Host "8. Info Sistema" -ForegroundColor Green
    Write-Host "9. Esegui Tutto (Sequenza Completa)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "0. Esci" -ForegroundColor Red
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
}

function Invoke-WindowsActivation {
    Write-Host "=== ATTIVAZIONE WINDOWS ===" -ForegroundColor Yellow
    Write-Host "Avvio Microsoft Activation Scripts..." -ForegroundColor Green
    try {
        irm https://get.activated.win | iex
    }
    catch {
        Write-Host "Errore durante l'attivazione: $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host "Operazione completata." -ForegroundColor Green
    Read-Host "Premi INVIO per continuare"
}

function Invoke-ChrisTitusUtility {
    Write-Host "=== CHRIS TITUS TECH UTILITY ===" -ForegroundColor Yellow
    Write-Host "Avvio Chris Titus Windows Utility..." -ForegroundColor Green
    try {
        iwr -useb https://christitus.com/win | iex
    }
    catch {
        Write-Host "Errore durante il caricamento utility: $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host "Operazione completata." -ForegroundColor Green
    Read-Host "Premi INVIO per continuare"
}

function Configure-WindowsSecurity {
    Write-Host "=== CONFIGURAZIONE WINDOWS SECURITY ===" -ForegroundColor Yellow
    Write-Host "Configurazione Windows Security (non Defender)..." -ForegroundColor Green
    
    try {
        # Abilita Windows Security
        Set-MpPreference -DisableRealtimeMonitoring $false
        
        # Configura Windows Security Service
        Set-Service -Name "SecurityHealthService" -StartupType Automatic
        Start-Service -Name "SecurityHealthService"
        
        # Abilita Smart Screen
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -Value "RequireAdmin"
        
        # Configura Firewall
        Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
        
        Write-Host "Windows Security configurato correttamente." -ForegroundColor Green
    }
    catch {
        Write-Host "Errore durante la configurazione: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Read-Host "Premi INVIO per continuare"
}

function Invoke-SystemCleanup {
    Write-Host "=== DISM + SFC SYSTEM CLEANUP ===" -ForegroundColor Yellow
    
    Write-Host "1. Pulizia immagine DISM..." -ForegroundColor Green
    try {
        DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
        Write-Host "Pulizia componenti completata." -ForegroundColor Green
    }
    catch {
        Write-Host "Errore durante pulizia componenti." -ForegroundColor Red
    }
    
    Write-Host "2. Controllo salute immagine..." -ForegroundColor Green
    try {
        DISM /Online /Cleanup-Image /CheckHealth
        Write-Host "Controllo salute completato." -ForegroundColor Green
    }
    catch {
        Write-Host "Errore durante controllo salute." -ForegroundColor Red
    }
    
    Write-Host "3. Scansione salute immagine..." -ForegroundColor Green
    try {
        DISM /Online /Cleanup-Image /ScanHealth
        Write-Host "Scansione salute completata." -ForegroundColor Green
    }
    catch {
        Write-Host "Errore durante scansione salute." -ForegroundColor Red
    }
    
    Write-Host "4. Ripristino salute immagine..." -ForegroundColor Green
    try {
        DISM /Online /Cleanup-Image /RestoreHealth
        Write-Host "Ripristino salute completato." -ForegroundColor Green
    }
    catch {
        Write-Host "Errore durante ripristino salute." -ForegroundColor Red
    }
    
    Write-Host "5. Scansione SFC..." -ForegroundColor Green
    try {
        sfc /scannow
        Write-Host "Scansione SFC completata." -ForegroundColor Green
    }
    catch {
        Write-Host "Errore durante scansione SFC." -ForegroundColor Red
    }
    
    Write-Host "Sistema pulito e riparato." -ForegroundColor Green
    Read-Host "Premi INVIO per continuare"
}

function Invoke-FullCleanup {
    Write-Host "=== PULIZIA COMPLETA SISTEMA ===" -ForegroundColor Yellow
    
    Write-Host "Pulizia file temporanei..." -ForegroundColor Green
    Get-ChildItem -Path $env:TEMP -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    Get-ChildItem -Path "C:\Windows\Temp" -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    
    Write-Host "Pulizia Prefetch..." -ForegroundColor Green
    Get-ChildItem -Path "C:\Windows\Prefetch" -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    
    Write-Host "Svuotamento Cestino..." -ForegroundColor Green
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    
    Write-Host "Pulizia DNS..." -ForegroundColor Green
    ipconfig /flushdns
    
    Write-Host "Pulizia completata." -ForegroundColor Green
    Read-Host "Premi INVIO per continuare"
}

function Optimize-Network {
    Write-Host "=== OTTIMIZZAZIONE RETE ===" -ForegroundColor Yellow
    
    Write-Host "Reset stack TCP/IP..." -ForegroundColor Green
    netsh int ip reset
    
    Write-Host "Reset Winsock..." -ForegroundColor Green
    netsh winsock reset
    
    Write-Host "Flush DNS..." -ForegroundColor Green
    ipconfig /flushdns
    
    Write-Host "Release/Renew IP..." -ForegroundColor Green
    ipconfig /release
    ipconfig /renew
    
    Write-Host "Ottimizzazione rete completata." -ForegroundColor Green
    Write-Host "NOTA: Riavvio consigliato per applicare tutte le modifiche." -ForegroundColor Yellow
    Read-Host "Premi INVIO per continuare"
}

function Manage-Chocolatey {
    Write-Host "=== CHOCOLATEY PACKAGE MANAGER ===" -ForegroundColor Yellow
    
    # Verifica se Chocolatey è installato
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey non trovato. Installazione in corso..." -ForegroundColor Green
        try {
            Set-ExecutionPolicy Bypass -Scope Process -Force
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
            Write-Host "Chocolatey installato con successo!" -ForegroundColor Green
        }
        catch {
            Write-Host "Errore durante l'installazione di Chocolatey: $($_.Exception.Message)" -ForegroundColor Red
            Read-Host "Premi INVIO per continuare"
            return
        }
    }
    else {
        Write-Host "Chocolatey già installato." -ForegroundColor Green
    }
    
    do {
        Write-Host "`n=== MENU CHOCOLATEY ===" -ForegroundColor Cyan
        Write-Host "1. Installa pacchetti essenziali" -ForegroundColor Green
        Write-Host "2. Installa pacchetti sviluppatore" -ForegroundColor Green
        Write-Host "3. Cerca pacchetto" -ForegroundColor Green
        Write-Host "4. Lista pacchetti installati" -ForegroundColor Green
        Write-Host "5. Aggiorna tutti i pacchetti" -ForegroundColor Green
        Write-Host "6. Disinstalla pacchetto" -ForegroundColor Green
        Write-Host "7. Comando personalizzato" -ForegroundColor Green
        Write-Host "0. Torna al menu principale" -ForegroundColor Red
        
        $chocoChoice = Read-Host "`nSeleziona opzione"
        
        switch ($chocoChoice) {
            "1" {
                Write-Host "Installazione pacchetti essenziali..." -ForegroundColor Green
                $essentials = @("7zip", "vlc", "googlechrome", "firefox", "notepadplusplus", "winrar", "adobereader")
                foreach ($package in $essentials) {
                    Write-Host "Installando $package..." -ForegroundColor Yellow
                    choco install $package -y
                }
            }
            "2" {
                Write-Host "Installazione pacchetti sviluppatore..." -ForegroundColor Green
                $devtools = @("git", "vscode", "nodejs", "python", "putty", "winscp", "postman", "docker-desktop")
                foreach ($package in $devtools) {
                    Write-Host "Installando $package..." -ForegroundColor Yellow
                    choco install $package -y
                }
            }
            "3" {
                $searchTerm = Read-Host "Inserisci termine di ricerca"
                choco search $searchTerm
            }
            "4" {
                Write-Host "Pacchetti installati:" -ForegroundColor Green
                choco list --local-only
            }
            "5" {
                Write-Host "Aggiornamento tutti i pacchetti..." -ForegroundColor Green
                choco upgrade all -y
            }
            "6" {
                $packageName = Read-Host "Nome pacchetto da disinstallare"
                choco uninstall $packageName -y
            }
            "7" {
                $customCommand = Read-Host "Inserisci comando choco (senza 'choco')"
                Invoke-Expression "choco $customCommand"
            }
        }
        
        if ($chocoChoice -ne "0") {
            Read-Host "Premi INVIO per continuare"
        }
        
    } while ($chocoChoice -ne "0")
}
    Write-Host "=== INFORMAZIONI SISTEMA ===" -ForegroundColor Yellow
    
    Write-Host "Sistema Operativo:" -ForegroundColor Green
    Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, WindowsBuildLabEx
    
    Write-Host "`nHardware:" -ForegroundColor Green
    Get-ComputerInfo | Select-Object TotalPhysicalMemory, CsProcessors
    
    Write-Host "`nSpazio Disco:" -ForegroundColor Green
    Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | Select-Object DeviceID, @{Name="Size(GB)";Expression={[math]::Round($_.Size/1GB,2)}}, @{Name="FreeSpace(GB)";Expression={[math]::Round($_.FreeSpace/1GB,2)}}
    
    Read-Host "Premi INVIO per continuare"
}

function Invoke-FullSequence {
    Write-Host "=== ESECUZIONE SEQUENZA COMPLETA ===" -ForegroundColor Yellow
    Write-Host "ATTENZIONE: Questa operazione eseguirà tutti gli strumenti in sequenza." -ForegroundColor Red
    Write-Host "Potrebbe richiedere molto tempo. Continuare? (S/N)" -ForegroundColor Yellow
    
    $confirm = Read-Host
    if ($confirm -eq "S" -or $confirm -eq "s") {
        Invoke-WindowsActivation
        Invoke-ChrisTitusUtility
        Configure-WindowsSecurity
        Invoke-SystemCleanup
        Invoke-FullCleanup
        Optimize-Network
        Write-Host "Sequenza completa terminata!" -ForegroundColor Green
        Write-Host "Riavvio del sistema consigliato." -ForegroundColor Yellow
    }
    Read-Host "Premi INVIO per continuare"
}

# Loop principale
do {
    Show-Menu
    $choice = Read-Host "Seleziona un'opzione"
    
    switch ($choice) {
        "1" { Invoke-WindowsActivation }
        "2" { Invoke-ChrisTitusUtility }
        "3" { Configure-WindowsSecurity }
        "4" { Invoke-SystemCleanup }
        "5" { Invoke-FullCleanup }
        "6" { Optimize-Network }
        "7" { Manage-Chocolatey }
        "8" { Show-SystemInfo }
        "9" { Invoke-FullSequence }
        "0" { 
            Write-Host "Uscita dal toolkit..." -ForegroundColor Yellow
            exit 
        }
        default { 
            Write-Host "Opzione non valida!" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($choice -ne "0")