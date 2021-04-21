#################################
#### WSL2 Local ZSH Settings ####
#################################
# Author: Dylan Thomas

####################
### WSL2 Display ###
####################
export DISPLAY=`grep -oP "(?<=nameserver ).+" /etc/resolv.conf`:0.0
export LIBGL_ALWAYS_INDIRECT=1
