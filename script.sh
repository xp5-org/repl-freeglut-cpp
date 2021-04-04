#   ███████╗███████╗████████╗██╗   ██╗██████╗     
#   ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗    
#   ███████╗█████╗     ██║   ██║   ██║██████╔╝    
#   ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝     
#   ███████║███████╗   ██║   ╚██████╔╝██║         
#   ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝
#######################################################################
#      set up paths, the paths move around on repl                    #
#######################################################################
replrootpath=$PWD
cdate=$(date +%Y%m%dT%H%M%s)
export DISPLAY=:0.0
backuptargetname=$target_file$cdate
backupsourcename=$source_file$cdate
examplebasepath=$replrootpath/freeglut-3.2.1/progs/demos/

# name your files here - this is your own thing to edit/complile in C++ 
source_file=$replrootpath/'triangle.cpp'
target_file=$replrootpath/'triangle'


# check if freeglut3-dev is installed on host
# install it if one of the library files is missing
# see output of >ldd triangle< from shell for more info
if [ ! -f /home/runner/.apt/usr/lib/x86_64-linux-gnu/libglut.so.3 ]
then
  printf '\n%s\n' "library not installed, installing freeglut3-dev"
  install-pkg freeglut3-dev
fi




#     ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗██╗     ███████╗    ██╗████████╗
#    ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║██║     ██╔════╝    ██║╚══██╔══╝
#    ██║     ██║   ██║██╔████╔██║██████╔╝██║██║     █████╗      ██║   ██║   
#    ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║██║     ██╔══╝      ██║   ██║   
#    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ██║███████╗███████╗    ██║   ██║   
#     ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝    ╚═╝   ╚═╝   
##################################################################################
##     performs versioning, checks mtime on file to see                         ##
##     if cpp src file is modified newer than compiled binary                   ##
##     if so then move it to backup dir and remake with g++                     ##
##################################################################################
printf '\n%s\n' "Checking if source mtime is newer than main binary"
if [ "$source_file" -nt "$target_file" ]
then
    printf '%s\n\n' "$source_file is newer than $target_file , moving old to $newtargetname and compiling"
    mv $target_file backup/$backuptargetname
    cp $source_file backup/$backupsourcename
    g++ $source_file -lglut -lGL -o $target_file
    chmod 744 ./$target_file
fi




#   ███████╗████████╗ █████╗ ██████╗ ████████╗
#   ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝
#   ███████╗   ██║   ███████║██████╔╝   ██║   
#   ╚════██║   ██║   ██╔══██║██╔══██╗   ██║   
#   ███████║   ██║   ██║  ██║██║  ██║   ██║   
#   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
#################################################################################
#                 if we made it this far, start your program                    #
#################################################################################
printf '\n%s\n' "starting binary"
$target_file
echo "done"



