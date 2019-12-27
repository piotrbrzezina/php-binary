#!/bin/sh

getExtension()
{
  local2=$2
  librarys=$(readelf -d $1 | grep 'NEEDED' | grep -E -o '\[(.*?)\]')
  libraryPatchDest="/phpbinary/${2}${1}"
  libraryDir=$(dirname "${libraryPatchDest}")
  mkdir -p $libraryDir
  cp $1 $libraryPatchDest

  for library in $librarys
  do
    library=${library#"["}
    library=${library%"]"}
    libraryPatch=$(find / -name "$library" -xdev| head -n 1)
    if [ -n "${libraryPatch##*phpbinary*}" ]; then
      getExtension "${libraryPatch}" "${local2}"
    fi
  done
}

mkdir -p /phpbinary

getExtension /usr/local/bin/php php

extDir="$(php -d 'display_errors=stderr' -r 'echo ini_get("extension_dir");')"

for libraryPath in "$extDir"/*
do
   library=$(basename "$libraryPath")
   library=${library%".so"}
   echo $library
   extensionIni=$(find / -name "docker-php-ext-$library.ini" | head -n 1)
   if [ -n "$extensionIni" ]; then
     extensionDir=$(dirname "${extensionIni}")
     extensionPatchDest="/phpbinary/${library}${extensionDir}"
     mkdir -p $extensionPatchDest
     cp $extensionIni $extensionPatchDest
   fi
   getExtension "$libraryPath" "$library"
done