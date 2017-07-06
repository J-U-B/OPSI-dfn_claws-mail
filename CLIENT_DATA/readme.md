# Claws Mail #

Diese OPSI-Paket fuer **Claws Mail** wurde fuer das Repository des *DFN* und 
des *Max-Planck-Instituts fuer Mikrostrukturphysik* erstellt.  
Es wird versucht auf die Besonderheitden der jeweiligen Repositories einzugehen;
entsprechend werden durch ein einfaches *Makefile* aus den Quellen verschiedene
Pakete erstellt.


## Installation ##

Bei der Installation des Paketes im Depot erfolgt im <code>postinst</code>-Script 
der Download der Software vom Hersteller (Windows, 32 Bit und 64 Bit). Ein manueller
Download sollte nicht erforderlich sein.  
Auf dem Depot-Server ist **wget** erforderlich.

Das <u>64-Bit-Paket</u> ist derzeit (*v3.15.0-1*) noch als <u>experimentell</u> gekennzeichnet.

Die Software selbst wird <u>nicht</u> mit diesem Paket vertrieben.


## Allgemeines ##

### Aufbau des Paketes ###
* **<code>variables.opsiinc</code>** - Da Variablen ueber die Scripte hinweg mehrfach
verwendet werden, werden diese (bis auf wenige Ausnahmen) zusammengefasst hier deklariert.
* **<code>product_variables.opsiinc</code>** - die producktspezifischen Variablen werden
hier definiert
* **<code>setup.opsiscript </code>** - Das Script fuer die Installation.
* **<code>uninstall.opsiscript</code>** - Das Uninstall-Script
* **<code>delsub.opsiinc</code>**- Wird von Setup und Uninstall gemeinsam verwendet.
Vor jeder Installation/jedem Update wird eine alte Version entfernt. (Ein explizites
Update-Script existiert derzeit nicht.)
* **<code>checkinstance.opsiinc</code>** - Pruefung, ob eine Instanz der Software laeuft.
Gegebenenfalls wird das Setup abgebrochen. Optional kann eine laufende Instanz 
zwangsweise beendet werden.
* **<code>checkvars.sh</code>** - Hilfsscript fuer die Entwicklung zur Ueberpruefung,
ob alle verwendeten Variablen deklariert sind bzw. nicht verwendete Variablen
aufzuspueren.
* **<code>bin/</code>** - Hilfprogramme; hier: **7zip**, **psdetail**
* **<code>images/</code>** - Programmbilder fuer OPSI

### Nomenklatur ###
Praefixes in der Produkt-Id definieren die Art des Paketes:

* **0_** - Es handelt sich um ein Test-Paket. Beim Uebergang zur Produktions-Release
wird der Praefix entfernt.
* **dfn_** - Das Paket ist zur Verwendung im DFN-Repository vorgesehen.

Die Reihenfolge der Praefixes ist relevant; die Markierung als Testpaket ist 
stets fuehrend.

### Unattended-Switches ###
Es handelt sich um ein *NSIS*-Paket mit den hier gebraeuchlichen Parametern.

siehe auch: http://www.silentinstall.org/nsis


## Anmerkungen/ToDo ##
* Die Festlegung von *Claws Mail* als **Default-Mailer** hat im Test nicht funktioniert.
Die Umsetzung der entsprechenden Property wurde daher noch nicht implementiert
* Fuer die OPSI-Pakete wird noch ein ***Lizenzmodell*** benoetigt.

## Lizenzen ##

### psdetail ###
**Autor** der Software: Jens Boettge <<boettge@mpi-halle.mpg.de>> 

Die Software **psdetail.exe**  wird als Freeware kostenlos angeboten und darf fuer 
nichtkommerzielle sowie kommerzielle Zwecke genutzt werden. Die Software
darf nicht veraendert werden; es duerfen keine abgeleiteten Versionen daraus 
erstellt werden.

Es ist erlaubt Kopien der Software herzustellen und weiterzugeben, solange 
Vervielfaeltigung und Weitergabe nicht auf Gewinnerwirtschaftung oder Spendensammlung
abzielt.

Haftungsausschluss:  
Der Auto lehnt ausdruecklich jede Haftung fuer eventuell durch die Nutzung 
der Software entstandene Schaeden ab.  
Es werden keine ex- oder impliziten Zusagen gemacht oder Garantien bezueglich
der Eigenschaften, des Funktionsumfanges oder Fehlerfreiheit gegeben.  
Alle Risiken des Softwareeinsatzes liegen beim Nutzer.

Der Autor behaelt sich eine Anpassung bzw. weitere Ausformulierung der Lizenzbedingungen
vor.

Fuer die Nutzung wird das *.NET Framework ab v3.5*  benoetigt.

### claws-mail ###
Das verwendete Logo steht unter der GPLv3.
(siehe: https://de.wikipedia.org/wiki/Claws_Mail#/media/File:ClawsMailLogo.png)  
Die Variationen fuer das OPSI-Paket wurden von mir unter Verwendung weiterer
freier Grafiken erstellt

-----
Jens Boettge <<boettge@mpi-halle.mpg.de>>, 2017-07-05 12:27:55 +0200
