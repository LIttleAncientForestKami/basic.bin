#!/bin/bash
function guards() {
  if ! command mvn -h 2>/dev/null 1&>2; then
    echo "Zainstaluj Mavena, jest wymagany do fajnych Mavenowych wtyczek :P. Instalacja np. przez sdkmana: 'sdk i maven'"
    exit 2
  fi
  if ! command toilet -h 2>/dev/null 1&>2; then
    echo "Zainstaluj toilet, jest wymagany do ASCII-komunikatów. Jeśli nie chcesz, zmień w skrypcie wywołania 'toilet' na 'printf' albo 'echo'. Program zadziała, po prostu znacznie gorzej."
    exit 2
  fi
}

function pluginGroups() {
  cat <<XML
  <pluginGroups>
    <!-- pomchecker-maven-plugin:1.9.0:check-bom or follow https://kordamp.org/pomchecker/pomchecker-maven-plugin/index.html -->
    <pluginGroup>org.kordamp.maven</pluginGroup>
    <!-- mvn sortpom-maven-plugin:verify or follow https://github.com/Ekryd/sortpom/issues/58 -->
    <pluginGroup>com.github.ekryd.sortpom</pluginGroup>
    <!-- buildplan:list -->
    <pluginGroup>fr.jcgay.maven.plugins</pluginGroup>
    <!-- dependency-checker:check -->
    <pluginGroup>org.owasp</pluginGroup>
    <!-- security-versions:check -->
    <pluginGroup>com.redhat.victims.maven</pluginGroup>
    <!-- sonar:sonar or follow https://docs.sonarqube.org/9.7/analyzing-source-code/scanners/sonarscanner-for-maven/ -->
    <pluginGroup>org.sonarsource.scanner.maven</pluginGroup>
  </pluginGroups>
XML
}

function settings() {
  if [[ -a ~/.m2/settings.xml ]]; then
    echo Plik settings istnieje. Polecam wrzucić doń poniższe grupy wtyczek, jeśli to jeszcze nie jest zrobione.
    pluginGroups
  else 
    echo Plik settings NIE istnieje. Wszystkie wtyczki muszą być odpalane z grupami.
    exit 1
  fi
}

function usage() {
  NAME=$(basename $0)
  cat <<USAGE
  $NAME to program do przypomnienia fajnych wtyk Mavena. Może je odpalić, lub tylko wypisać.
  Użycie:
    $NAME [-s|-l|-h]
  gdzie 
    brak parametru powoduje odpalenie każdej z wtyczek,
    -s sprawdzi plik .m2/settings.xml pod kątem grup wtyczek,
    -l poda tylko listę wtyczek, nie odpali ich,
    -h wyświetla tę wiadomość i kończy pracę programu.
  
  TIP: Odpalanie Mavena bez wiadomości o pobieraniu plików: (downloading, downloaded, etc.)
  mvn komenda -B -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn
  mvn komenda --no-transfer-progress
  Drugie jest od wersji 3.6.1 i daje szansę na kolorki, które przy -B znikają
USAGE
  exit 1
}

function list() {
  printf '\n\n%s' "Lista ciekawych wtyczek i co mogą one zrobić z naszym POMem?"
  printf "Wtyczki Mavenowe: versions oraz enforcer"
  cat <<LISTA
  poszukajmy błędów, posprawdzajmy jakość kodu
mvn checkstyle:check
mvn com.github.spotbugs:spotbugs-maven-plugin:check - więcej https://spotbugs.github.io/spotbugs-maven-plugin/
mvn pmd:pmd 
mvn pmd:check 
mvn pmd:cpd-check 
mvn sonar:sonar
  jaka wtyka na jakiej fazie? Plan budowy? -- jest też wersja na org.codehaus, chyba starsza
mvn buildplan:list
  posprzątajmy POMa by był odpowiednio uporządkowany (sortpom i tidy)
mvn sortpom:verify
mvn tidy:pom
  czy POM jest BOMem?
mvn org.kordamp.maven:pomchecker-maven-plugin:1.9.0:
  sprawdźmy podatności w zależnościach - OWASP i Redhat Victims
mvn dependency-checker:check
mvn security-versions:check
 sprawdźmy licencje z zależności, zróbmy ich listę i podajmy zależności bez licencji, wypiszmy style komentarzy, nagłówki plików itp.
mvn org.codehaus.mojo:license-maven-plugin:license-list 
mvn org.codehaus.mojo:license-maven-plugin:add-third-party
mvn org.codehaus.mojo:license-maven-plugin:comment-style-list
mvn org.codehaus.mojo:license-maven-plugin:check-file-header - requires orgName and inceptionYear

LISTA

  echo MOŻE...
  echo https://github.com/revelc/formatter-maven-plugin by formatować kod niezależnie od IDE?
  echo https://vladmihalcea.com/maven-gradle-hibernate-enhance-plugin/ by instrumentować encje JPA/Hibera dla zwiększenia wydajności odczytów i zapisów?
  echo https://github.com/kohsuke/sorcerer/blob/master/src/site/apt/index.apt by robić HTMLe z kodem Jawy i lepszą nawigacją niż JXR?
  echo https://central.sonatype.com/artifact/org.apache.httpcomponents/maven-notice-plugin/0.0.2 by generować notki i licencje?
  echo https://central.sonatype.com/artifact/org.codehaus.mojo/license-maven-plugin/2.1.0 by pościągać licencje z podprojektów i zależności?
  echo https://central.sonatype.com/artifact/org.codehaus.mojo/buildnumber-maven-plugin/3.2.0 - by mieć numery budów?
  echo https://github.com/git-commit-id/git-commit-id-maven-plugin - lub wersję Ktosa, świetnie udokumentowaną?
  echo "i jak chcesz więcej to https://central.sonatype.com/search?smo=true&q=maven+plugin"
}

guards

if [[ $# = 0 ]]; then
  echo bez parametrów, odpalam wtyczki z opcją --no-transfer-progress by nie zalać Cię komunikatami o pobieraniu połowy internetu
  przerwa="Ctrl+c? 3s"
  
  toilet "JAKOŚĆ kodu"
  mvn --no-transfer-progress checkstyle:check
  mvn --no-transfer-progress com.github.spotbugs:spotbugs-maven-plugin:check
  mvn --no-transfer-progress pmd:pmd 
  mvn --no-transfer-progress pmd:check 
  mvn --no-transfer-progress pmd:cpd-check 
  mvn --no-transfer-progress sonar:sonar
  toilet $przerwa
  sleep 3
  toilet "fazy a wtyki"
  mvn --no-transfer-progress buildplan:list
  toilet "$przerwa"
  sleep 3
  toilet "ogarnij POMa" 
  mvn --no-transfer-progress sortpom:verify
  mvn --no-transfer-progress tidy:pom
  toilet "$przerwa"
  sleep 3
  toilet "czy to BOM"
  mvn --no-transfer-progress org.kordamp.maven:pomchecker-maven-plugin:1.9.0:check-bom
  toilet "$przerwa"
  sleep 3
  toilet bezpieka
  mvn --no-transfer-progress dependency-checker:check
  mvn --no-transfer-progress security-versions:check
  toilet "$przerwa"
  sleep 3
  toilet licencje
  mvn --no-transfer-progress org.codehaus.mojo:license-maven-plugin:license-list 
  mvn --no-transfer-progress org.codehaus.mojo:license-maven-plugin:add-third-party
  mvn --no-transfer-progress org.codehaus.mojo:license-maven-plugin:comment-style-list
  mvn --no-transfer-progress org.codehaus.mojo:license-maven-plugin:check-file-header
  exit 0
fi

case $1 in
  -h) usage
    ;;
  -l) list; break
    ;;
  -s) settings
    break
    ;;
  *) echo Nieznany parametr. Wyświetlam pomoc.
    usage
esac
