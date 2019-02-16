;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here

rem stuff from cmder default configs
pwd=cd
clear=cls
history=cat "%CMDER_ROOT%\config\.history"
unalias=alias /d $1
cmderr=cd /d "%CMDER_ROOT%"
rem open epxlorer here
e.=explorer .

rem Easier navigation: .., ..., ...., ....., ~ and -
..=cd ..
...=cd ../..
....=cd ../../..
.....=cd ../../../..

rem Ensure VIM and lazy git
vi=vim $*
g=git $*

rem List files colorized in long format
l=ls -lF --color --show-control-chars $*
ls=ls -lF --color --show-control-chars $*
rem List all files colorized in long formation
la=ls -lAF --color --show-control-chars $*
rem List only directories
lsd=ls -lF --color | grep --color=never '^d' $*

rem Colorize `grep` output
grep=grep --color=auto $*

rem Get the week number
week=date +%V

rem Intuitive map function
rem For example, to list all directories that contain a certain file:
rem find . -name .gitattributes | map dirname
map=xargs -n1 $*

rem Reload the shell (i.e. invoke as a login shell)
reload=exec ${SHELL} -l

rem Print public key to screen
pubkey=cat ~/.ssh/id_rsa.pub

rem Print each PATH entry on a separate line
path='echo -e ${PATH//:/\\n}'