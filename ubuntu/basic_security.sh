#!/usr/bin/env bash
# Tomasz LAFK_pl Borek
# Za: https://www.redhat.com/sysadmin/more-lockdown-controls
# Następna wersja: szyldy i może motd
# Możliwy rozwój: złożonośc hasła, domyślne pozwolenia plików
# Jeszcze następna wersja: https://www.redhat.com/sysadmin/locking-down-access
# Dalsza wersja: sprawdzenie przydatnych narzędzi, jak lynis, listbugs, needrestart, etckeeper itp.

raport=""
function krowa() {
  cowsay $1
}

raport="Prosty audyt bezpieczeństwa: automontowanie urządzeń, hasło (tak: długość min i maks, NIE: czas życia, złożoność), szyldy, sudoers, opóźnienie logowania"
krowa "$raport"
sleep 3

function krok() {
  figlet -t -F metal $1
  krowa "$2"
  sleep $3
}

function sudoers() {
  krok "NOPASSWD - otwieram visudo" "jak jest NOPASSWD to usuń" 5
  sudo visudo
  raport="$raport NOPASSWD w visudo - mam nadzieję, że już usunięte jeśli jakieś było"
}

function automontowanie() {
#  echo "Autofs: https://www.kernel.org/doc/html/latest/filesystems/autofs.html"
  krok automontowanie "autofs sprawdzam i ew. wyłączam" 3
  if sudo systemctl autofs status ; then 
      krowa "jest autofs"
      sudo systemctl autofs stop
      sudo systemctl autofs disable
      raport="$raport automontowanie via autofs wyłączone"
    else 
      krowa "autofs nieznany"; 
      raport="$raport automontowanie (via autofs) nie wykryte"
  fi
}

function login_defs_sed() {
  if [[ `grep $1 /etc/login.defs` = "#$1" ]]; then
    sudo sed -i "s/#$1/$1=$2/g" /etc/login.defs
    krowa "/etc/login.defs $3 ustawione na $2($4)"
    raport="$raport /etc/login.defs $3 ustawione na $2($4)"
  fi
}

function nieudany_login_4s() {
  krok "OPÓŹNIONY LOGIN" "opóźnienie loginu powinno być ustawione na 4s" 3
  login_defs_sed FAIL_DELAY 4 "opóźnienie logowania" "s"
}

function polityka_hasel() {
  krok "HASLO - MIN i MAKS ZNAKÓW" "długość hasła pomiędzy $1 a $2" 3
  login_defs_sed PASS_MIN_LEN $1 "minimum znaków" "min"
  login_defs_sed PASS_MAX_LEN $2 "maksimum znaków" "maks"
  krowa "Nie ustawiamy długości życia hasła (NIST, SANS i inni niezalecają): https://www.sans.org/blog/the-debate-around-password-rotation-policies/"
  krowa "Nie wiem czy ustawiać złożoność hasła, bo tu różnie może być... /etc/security/pwquality.con"
  krowa "RDZ: wieloskładnikowe uwierzytelnianie, np. kluczem?"
}

function szyldy() {
  krowa "RDZ: szyldy"
  raport="$raport RDZ: szyldy"
  cat /etc/issue.net
  cat /etc/issue
  grep BANNER /etc/ssh/sshd_config
}

sudoers
automontowanie
nieudany_login_4s
polityka_hasel 12 36
szyldy

krowa "$raport"
