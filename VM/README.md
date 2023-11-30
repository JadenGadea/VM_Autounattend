Inga inloggningsuppgifter behövs eftersom de är hårdkodade i skriptet. Skriptet använder inloggningen som skapas av .xml-filen.

1. Skapa ISO fil med min unattend.xml

2. Lägg in Mappen i C:\ på host maskinen.

2. skriptet hard hard-kodat in credentials som kommer med .xml filen.
	2.1 Även hard-kodat user1 och user2 creds. 

3. Run as admin .\Masterscript

4. Svara på promptsen enligt hänvisningar från skriptet.
	4.1 Gå endast vidare med skriptet efter du manuellt loggat in på båda maskinerna via GUIn på vid boot up. Det ända nackdelen.

5. Sedan körs hela processen. Skapar filer, kopierer filer och sedan tar bort filerna via win10-b med user2 som login.