g++ "$1.cpp" -o "$1.exe"

./"$1.exe" < "$1.txt"

rm "$1.exe"