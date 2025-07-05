# ============================================
# TOOLKIT TECNICO POWERSHELL V2
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
    Write-Host "      TOOLKIT TECNICO POWERSHELL V2       " -ForegroundColor Cyan
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
    Write-Host "8. Microsoft Malware Removal Tool (MRT)" -ForegroundColor Green
    Write-Host "9. Memory Test (MemTest86)" -ForegroundColor Green
    Write-Host "10. Info Sistema Compatto" -ForegroundColor Green
    Write-Host "11. Esegui Tutto (Sequenza Completa)" -ForegroundColor Yellow
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

function Invoke-MRT {
    Write-Host "=== MICROSOFT MALWARE REMOVAL TOOL ===" -ForegroundColor Yellow
    Write-Host "Avvio Microsoft Malware Removal Tool..." -ForegroundColor Green
    
    try {
        # Verifica se MRT è presente nel sistema
        $mrtPath = "$env:SystemRoot\System32\mrt.exe"
        if (Test-Path $mrtPath) {
            Write-Host "Avvio MRT in modalità completa..." -ForegroundColor Green
            Start-Process -FilePath $mrtPath -ArgumentList "/f" -Wait
            Write-Host "Scansione MRT completata." -ForegroundColor Green
        }
        else {
            Write-Host "MRT non trovato nel sistema." -ForegroundColor Red
            Write-Host "Prova a scaricare l'ultima versione dal sito Microsoft." -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "Errore durante l'esecuzione di MRT: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Read-Host "Premi INVIO per continuare"
}

function Invoke-MemTest {
    Write-Host "=== MEMORY TEST (MEMTEST86) ===" -ForegroundColor Yellow
    Write-Host "Preparazione per Memory Test..." -ForegroundColor Green
    
    Write-Host "OPZIONI MEMORY TEST:" -ForegroundColor Cyan
    Write-Host "1. Windows Memory Diagnostic (integrato)" -ForegroundColor Green
    Write-Host "2. Scarica MemTest86 (più completo)" -ForegroundColor Green
    Write-Host "3. Annulla" -ForegroundColor Red
    
    $memChoice = Read-Host "Seleziona opzione"
    
    switch ($memChoice) {
        "1" {
            Write-Host "Avvio Windows Memory Diagnostic..." -ForegroundColor Green
            Write-Host "Il sistema si riavvierà per eseguire il test." -ForegroundColor Yellow
            Write-Host "I risultati saranno disponibili nel log eventi dopo il riavvio." -ForegroundColor Yellow
            $confirm = Read-Host "Continuare? (S/N)"
            if ($confirm -eq "S" -or $confirm -eq "s") {
                mdsched.exe
            }
        }
        "2" {
            Write-Host "Apertura pagina download MemTest86..." -ForegroundColor Green
            Start-Process "https://www.memtest86.com/download.htm"
            Write-Host "Scarica MemTest86 e crealo su una USB avviabile." -ForegroundColor Yellow
        }
        "3" {
            Write-Host "Operazione annullata." -ForegroundColor Yellow
        }
    }
    
    Read-Host "Premi INVIO per continuare"
}

function Show-CompactSystemInfo {
    Write-Host "=== INFORMAZIONI SISTEMA COMPATTO ===" -ForegroundColor Yellow
    
    # Informazioni di base
    $computerInfo = Get-ComputerInfo
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    $cpu = Get-CimInstance -ClassName Win32_Processor
    $memory = Get-CimInstance -ClassName Win32_PhysicalMemory
    $disks = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}
    $gpu = Get-CimInstance -ClassName Win32_VideoController | Where-Object {$_.Name -notlike "*Basic*"}
    
    # Sistema Operativo
    Write-Host "SISTEMA OPERATIVO:" -ForegroundColor Green
    Write-Host "  OS: $($os.Caption) ($($os.Version))" -ForegroundColor White
    Write-Host "  Build: $($os.BuildNumber)" -ForegroundColor White
    Write-Host "  Architettura: $($os.OSArchitecture)" -ForegroundColor White
    Write-Host "  Installato: $($os.InstallDate.ToString('dd/MM/yyyy'))" -ForegroundColor White
    
    # Hardware
    Write-Host "`nHARDWARE:" -ForegroundColor Green
    Write-Host "  CPU: $($cpu.Name.Trim())" -ForegroundColor White
    Write-Host "  Core: $($cpu.NumberOfCores) fisici, $($cpu.NumberOfLogicalProcessors) logici" -ForegroundColor White
    Write-Host "  Frequenza: $([math]::Round($cpu.MaxClockSpeed/1000, 2)) GHz" -ForegroundColor White
    
    # Memoria
    $totalMemoryGB = [math]::Round(($memory | Measure-Object -Property Capacity -Sum).Sum / 1GB, 2)
    $availableMemoryGB = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
    $usedMemoryGB = [math]::Round($totalMemoryGB - $availableMemoryGB, 2)
    
    Write-Host "  RAM Totale: $totalMemoryGB GB" -ForegroundColor White
    Write-Host "  RAM Usata: $usedMemoryGB GB" -ForegroundColor White
    Write-Host "  RAM Libera: $availableMemoryGB GB" -ForegroundColor White
    
    # GPU
    Write-Host "`nSCHEDA GRAFICA:" -ForegroundColor Green
    foreach ($card in $gpu) {
        if ($card.Name -and $card.Name -notlike "*Basic*") {
            Write-Host "  GPU: $($card.Name)" -ForegroundColor White
            if ($card.AdapterRAM -and $card.AdapterRAM -gt 0) {
    $vramGB = [math]::Round($card.AdapterRAM / 1GB, 2)
     Write-Host "  VRAM: $vramGB GB" -ForegroundColor White
    } else {
     Write-Host "  VRAM: Non disponibile" -ForegroundColor Gray
     }
    
    # Storage
    Write-Host "`nSTORAGE:" -ForegroundColor Green
    foreach ($disk in $disks) {
        $sizeGB = [math]::Round($disk.Size / 1GB, 2)
        $freeGB = [math]::Round($disk.FreeSpace / 1GB, 2)
        $usedGB = [math]::Round($sizeGB - $freeGB, 2)
        $usedPercent = [math]::Round(($usedGB / $sizeGB) * 100, 1)
        
        Write-Host "  Drive $($disk.DeviceID) $sizeGB GB (Libero: $freeGB GB, Usato: $usedPercent%)" -ForegroundColor White
    }
    
    # Uptime
    $uptime = (Get-Date) - $os.LastBootUpTime
    Write-Host "`nUPTIME:" -ForegroundColor Green
    Write-Host "  Sistema avviato da: $($uptime.Days) giorni, $($uptime.Hours) ore, $($uptime.Minutes) minuti" -ForegroundColor White
    
    # Rete
    $networkAdapters = Get-NetAdapter | Where-Object {$_.Status -eq "Up" -and $_.Virtual -eq $false}
    Write-Host "`nRETE:" -ForegroundColor Green
    foreach ($adapter in $networkAdapters) {
       $speed = if ($adapter.LinkSpeed) { "$([math]::Round($adapter.LinkSpeed / 1000000, 0)) Mbps" } else { "N/A" }
        Write-Host "  $($adapter.InterfaceDescription): $speed" -ForegroundColor White
    }
    
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
        Invoke-MRT
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
        "8" { Invoke-MRT }
        "9" { Invoke-MemTest }
        "10" { Show-CompactSystemInfo }
        "11" { Invoke-FullSequence }
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
