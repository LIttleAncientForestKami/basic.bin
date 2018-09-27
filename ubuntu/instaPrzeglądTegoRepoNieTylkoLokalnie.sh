set -e
echo Próba postawienia serwera na webricku
git instaweb -d webrick -p 5885
echo Port 5885
ip -c -4 -h -br addr
echo W schowku jest IP z portem
ip -4 -br a | grep -v DOWN | awk '{print $3 ":5885"}' > tnij
xclip -selection clipboard < tnij
rm tnij
echo Stopuj jak skończysz przez git instaweb --stop
