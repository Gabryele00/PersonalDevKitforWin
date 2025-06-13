# 🛠️ PowerShell Tech Toolkit

> **Una cassetta degli attrezzi polivalente per tecnici informatici e amministratori di sistema.**

Un toolkit PowerShell completo che raggruppa i migliori strumenti di terze parti in un'interfaccia unificata e user-friendly. Perfetto per manutenzione, ottimizzazione e ripristino di sistemi Windows.

![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## ✨ Caratteristiche

- **🔧 Menu interattivo** - Interfaccia colorata e intuitiva
- **⚡ All-in-one** - Tutti gli strumenti essenziali in un unico script
- **🛡️ Controlli di sicurezza** - Verifica privilegi amministratore
- **📦 Package management** - Chocolatey integrato
- **🔄 Automazione** - Esegui tutto in sequenza automatica
- **❌ Gestione errori** - Operazioni sicure con error handling

## 🎯 Funzionalità

### 🔑 Attivazione Windows
- Integrazione con **Microsoft Activation Scripts (MAS)**
- Attivazione sicura e automatica

### 🧹 Chris Titus Tech Utility
- **Debloating** Windows
- **Ottimizzazioni** di sistema
- **Tweaks** per prestazioni

### 🛡️ Windows Security
- Configurazione **Windows Security** (non Defender)
- Abilitazione **Smart Screen**
- Configurazione **Firewall**

### 🔧 DISM + SFC Cleanup
- **Pulizia componenti** sistema
- **Controllo salute** immagine
- **Scansione e ripristino** file di sistema
- Sequenza completa **DISM → SFC**

### 🧽 Pulizia Sistema
- Rimozione **file temporanei**
- Pulizia **Prefetch**
- Svuotamento **Cestino**
- **Flush DNS**

### 🌐 Ottimizzazione Rete
- Reset **stack TCP/IP**
- Reset **Winsock**
- **Release/Renew IP**
- Ottimizzazioni connettività

### 📦 Chocolatey Manager
- **Installazione automatica** Chocolatey
- **Pacchetti essenziali** preconfigurati
- **Pacchetti sviluppatore** per dev environment
- **Gestione completa** package (install/update/remove)

### 📊 Diagnostica Sistema
- **Informazioni hardware**
- **Stato sistema operativo**
- **Analisi spazio disco**

## 🚀 Installazione e Uso

### Prerequisiti
- **Windows 10/11**
- **PowerShell 5.0+**
- **Privilegi Amministratore**

### Setup Policy Esecuzione
```powershell
# Opzione 1: Bypass temporaneo (consigliata)
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# Opzione 2: Esecuzione una tantum
PowerShell.exe -ExecutionPolicy Bypass -File ".\tech_toolkit.ps1"

# Opzione 3: Permanente per utente corrente
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Esecuzione
```powershell
# Clona il repository
git clone https://github.com/tuousername/powershell-tech-toolkit.git

# Entra nella directory
cd powershell-tech-toolkit

# Esegui come amministratore
.\tech_toolkit.ps1
```

## 📋 Menu Principale

```
============================================
        TOOLKIT TECNICO POWERSHELL        
         Cassetta degli Attrezzi          
============================================

1. Attivazione Windows (MAS)
2. Chris Titus Tech Utility
3. Configurazione Windows Security
4. DISM + SFC System Cleanup
5. Pulizia Completa Sistema
6. Ottimizzazione Rete
7. Chocolatey Package Manager
8. Info Sistema
9. Esegui Tutto (Sequenza Completa)

0. Esci
```

## ⚠️ Disclaimer

Questo toolkit utilizza strumenti di terze parti:
- **[Microsoft Activation Scripts](https://github.com/massgravel/Microsoft-Activation-Scripts)** - Attivazione Windows
- **[Chris Titus Tech Utility](https://christitus.com/win)** - Debloating e ottimizzazioni
- **[Chocolatey](https://chocolatey.org/)** - Package manager

Utilizzare responsabilmente e in conformità con i termini di licenza di ciascun strumento.

## 🔐 Sicurezza

- ✅ Verifica privilegi amministratore
- ✅ Gestione errori per ogni operazione
- ✅ Conferma per operazioni critiche
- ✅ Log delle operazioni eseguite

## 🤝 Contributi

I contributi sono benvenuti! Per favore:
1. Fai **fork** del progetto
2. Crea un **branch** per la tua feature
3. Fai **commit** delle modifiche
4. Apri una **Pull Request**

## 📝 License

Questo progetto è rilasciato sotto licenza **MIT**. Vedi il file `LICENSE` per i dettagli.

## 👨‍💻 Autore

Sviluppato con ❤️ da un tecnico informatico per tecnici informatici.

---

**⭐ Se questo toolkit ti è stato utile, lascia una stella su GitHub!**

## 📞 Supporto

Per problemi o suggerimenti, apri una **Issue** su GitHub.

---

*"L'efficienza è una forma di rispetto. Per sé e per gli altri."*
