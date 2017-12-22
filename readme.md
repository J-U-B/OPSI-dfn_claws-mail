# ![](./SRC/CLIENT_DATA/images/ClawsMailLogo.png "Claws Mail") Claws Mail #

## ToC ##

* [Paketinfo](#paketinfo)
* [Paket erstellen](#paket_erstellen)
  * [Makefile und spec.json](#makefile_und_spec)
  * [pystache](#pystache)
  * [Verzeichnisstruktur](#verzeichnisstruktur)
  * [Makefile-Parameter](#makefile_parameter)
  * [spec.json](#spec_json)
* [Installation](#installation)
* [Allgemeines](#allgemeines)
  * [Aufbau des Paketes](#paketaufbau)
  * [Nomenklatur](#nomenklatur)
  * [Unattended-Switches](#unattended_switches)
* [Lizenzen](#lizenzen)
  * [Dieses Paket](#lic_paket)
  * [claws-mail](#lic_claws-mail)
  * [psDetail](#lic_psdetail)
* [Anmerkungen/ToDo](#anmerkungen_todo)


<div id="paketinfo"></div>

Diese OPSI-Paket fuer **Claws Mail** wurde fuer das Repository des *DFN* und 
des *Max-Planck-Instituts fuer Mikrostrukturphysik* erstellt.  
Es wird versucht auf die Besonderheiten der jeweiligen Repositories einzugehen;
entsprechend werden durch ein einfaches *Makefile* aus den Quellen verschiedene
Pakete erstellt.


<div id="paket_erstellen"></div>

## Paket erstellen ##

Dieser Abschnitt beschaeftigt sich mit der Erstellung des OPSI-Paketes aus
dem Source-Paket und nicht mit dem OPSI-Paket selbst.


<div id="makefile_und_spec"></div>

### Makefile und spec.json ###

Da aus den Quellen verschiedene Versionen des Paketes mit entsprechenden Anpassungen
generiert werden sollen (intern, DFN; testing/release) wurde hierfuer ein
**<code>Makefile</code>** erstellt. Darueber hinaus steuert **<code>spec.json</code>** 
die Erstellung der Pakete.

Im Idealfall ist beim Erscheinen einer neuen Release von Claws Mail lediglich die
**<code>spec.json</code>** anzupassen.


<div id="pystache"></div>

### pystache ###

Als Template-Engine kommt **<code>pystache</code>** zum Einsatz.
Das entsprechende Paket ist auf dem Build-System aus dem Repository der verwendeten
Distribution zu installieren.

Unter Debian/Ubuntu erledigt das:
> <code>sudo apt-get install python-pystache</code>


<div id="verzeichnisstruktur"></div>

### Verzeichnisstruktur ###

Die erstellten Pakete werden im Unterverzeichnis **<code>BUILD</code>** abgelegt.

Einige Files (derzeit <code>control, preinst, postinst</code>) werden bei der Erstellung erst aus _<code>.in</code>_-Files
generiert, welche sich in den Verzeichnissen <code>SRC/OPSI</code> und <code>SRC/CLIENT_DATA</code> befinden.
Die <code>SRC</code>-Verzeichnisse sind in den OPSI-Paketen nicht mehr enthalten.


<div id="makefile_parameter"></div>

### Makefile-Parameter ###
Der vorliegende Code erlaubt die Erstellung von OPSI-Paketen fuer die Releases
gemaess der Angaben in <code>spec.json</code>. Es kann jedoch bei der Paketerstellung
ein alternatives Spec--File uebergeben werden:

> *<code>SPEC=&lt;spec_file&gt;</code>*

Das Paket kann mit *"batteries included"* erstellt werden. In dem Fall erfolgt 
der Download der Software beim Erstellen des OPSI-Paketes und nicht erst bei
dessen Installation:
> *<code>ALLINC=[true|false]</code>*

Standard ist hier die Erstellung des leichtgewichtigen Paketes (```ALLINC=false```).

OPSI erlaubt des Pakete im Format <code>cpio</code> und <code>tar</code> zu erstellen.  
Als Standard ist <code>cpio</code> festgelegt.  
Das Makefile erlaubt die Wahl des Formates ueber die Umgebungsvariable bzw. den Parameter:
> *<code>ARCHIVE_FORMAT=&lt;cpio|tar&gt;</code>*


<div id="spec_json"></div>

### spec.json ###

Haeufig beschraenkt sich die Aktualisierung eines Paketes auf das Aendern der 
Versionsnummern und des Datums etc. In einigen Faellen ist jedoch auch das Anpassen
weiterer Variablen erforderlich, die sich auf verschiedene Files verteilen.  
Auch das soll durch das Makefile vereinfacht werden. Die relevanten Variablen
sollen nur noch in <code>spec.json</code> angepasst werden. Den Rest uebernimmt *<code>make</code>*


<div id="installation"></div>

## Installation ##

Die Software selbst wird - sofern bei der Paketerstellung nicht anders vorgegeben - 
<u>nicht</u> mit diesem Paket vertrieben. Fuer die *"batteries included"*-Pakete 
entfaellt dieser Abschnitt.

Je nach Art des erstellten Paketes erfolgt bei der Installation im Depot durch 
das <code>postinst</code>-Script der Download der Software vom Hersteller (Windows, 32 und 64 Bit).  
Ein manueller Download sollte dann nicht erforderlich sein. 
Auf dem Depot-Server ist **wget** erforderlich.

Das Gesamtvolumen der herunterzuladenden Dateien betraegt ca. **55 MByte**.

Das <u>64-Bit-Paket</u> ist derzeit (*v3.15.0-1*) noch als <u>experimentell</u> gekennzeichnet.


<div id="allgemeines"></div>

## Allgemeines ##

<div id="aufbau_des_paketes"></div>

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

<div id="nomenklatur"></div>

### Nomenklatur ###
Praefixes in der Produkt-Id definieren die Art des Paketes:

* **0_** - Es handelt sich um ein Test-Paket. Beim Uebergang zur Produktions-Release
wird der Praefix entfernt.
* **dfn_** - Das Paket ist zur Verwendung im DFN-Repository vorgesehen.

Die Reihenfolge der Praefixes ist relevant; die Markierung als Testpaket ist 
stets fuehrend.

<div id="unattended_switches"></div>

### Unattended-Switches ###
Es handelt sich um ein *NSIS*-Paket mit den hier gebraeuchlichen Parametern.

siehe auch: http://www.silentinstall.org/nsis


<div id="lizenzen"></div>

## Lizenzen ##

<div id="lic_paket"></div>

###  Dieses Paket ###

Dieses OPSI-Paket steht unter der *GNU General Public License* **GPLv3**.

Ausgenommen von dieser Lizenz sind die unter **<code>bin/</code>** zu findenden
Hilfsprogramme. Diese unterliegen ihren jeweiligen Lizenzen.

<div id="lizenz_claws-mail"></div>

### claws-mail ###
Das verwendete Logo steht unter der GPLv3.
(siehe: https://de.wikipedia.org/wiki/Claws_Mail#/media/File:ClawsMailLogo.png)  
Die Variationen fuer das OPSI-Paket wurden von mir unter Verwendung weiterer
freier Grafiken erstellt

<div id="lizenz_psdetail"></div>

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


<div id="anmerkungen_todo"></div>

## Anmerkungen/ToDo ##
* Die Festlegung von *Claws Mail* als **Default-Mailer** hat im Test nicht funktioniert.
Die Umsetzung der entsprechenden Property wurde daher noch nicht implementiert
* Fuer die OPSI-Pakete wird noch ein ***Lizenzmodell*** benoetigt.

-----
Jens Boettge <<boettge@mpi-halle.mpg.de>>, 2017-12-22 14:02:53 +0100