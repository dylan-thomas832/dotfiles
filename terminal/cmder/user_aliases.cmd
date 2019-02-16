;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below 

;= Comment like this

;= Cmder aliases
pwd=cd
clear=cls
history=cat "%CMDER_ROOT%\config\.history"
unalias=alias /d $1
cmderr=cd /d "%CMDER_ROOT%"
;= Easier navigation
..=cd ..
...=cd ../..
....=cd ../../..
.....=cd ../../../..
;= Improve application commands
vi=vim $*
g=git $*
;= Improve less output options
l=ls -lF --color --show-control-chars $*
ls=ls -lF --color --show-control-chars $*
la=ls -lAF --color --show-control-chars $*
lsd=ls -lF --color | grep --color=never "^d"
;= Colored grep
grep=grep --color=auto $*
;= Print public key to terminal
pubkey=cat ~/.ssh/id_rsa.pub
