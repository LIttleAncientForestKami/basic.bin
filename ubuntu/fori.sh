#!/bin/bash
function usage() {
  cat <<EOF
  $0 ile komenda
    gdzie
      ile: ile powtórzeń komendy wykonujemy
      komenda: polecenie powłoki, czy to ls -la czy mvn validate -q jakie w pętli będziemy wywoływać
  
  Jeśli komenda zawiera spacje, należy podać ją w cudzysłowiu, o tak: "mvn validate -q".
EOF
  exit 1
}

if [[ $# < 2 ]]; then
  printf "Potrzebuję dwu parametrów."
  usage
fi

for i in $(seq $1); do 
  figlet $i
  `$2`
done
