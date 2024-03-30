Detta är en inlämningsuppgift där vi skulle skriva ett PowerShell-skript för att starta två virtuella maskiner på Hyper-V. Därefter ska vi skapa konton, samt radera och ta bort filer i den delade nätverksresursen.

Inga inloggningsuppgifter behövs eftersom de är hårdkodade i skriptet. Skriptet använder inloggningen som skapas av .xml-filen.

Skapa ISO fil med min unattend.xml

Lägg in VM Mappen i C:\ på host maskinen.

skriptet hard hard-kodat in credentials som kommer med .xml filen. 2.1 Även hard-kodat user1 och user2 creds.

Run as admin .\Masterscript

Svara på promptsen enligt hänvisningar från skriptet. 4.1 Gå endast vidare med skriptet efter du manuellt loggat in på båda maskinerna via GUIn på vid boot up. Det ända nackdelen.

Sedan körs hela processen. Skapar filer, kopierer filer och sedan tar bort filerna via win10-b med user2 som login.
