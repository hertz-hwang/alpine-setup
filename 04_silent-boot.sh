### How:
#       by adding the '--quiet' flag to each '/sbin/openrc' command within '/etc/inittab'

################################################################
###                 Check root privileges                   ####
################################################################

if [ "$(id -u)" -ne 0 ]
    then echo "This script requires root privileges"
    exit 1
fi

################################################################
###                     Silencing Boot                      ####
################################################################
# sed: uses "@" as a delimiter; the '-i' flag edits the file in-place

# openrc sysinit
if grep -q "openrc sysinit --quiet" /etc/inittab; then
    echo "WARNING: the file '/etc/inittab' alredy contains the string 'openrc sysinit --quiet', as such the script will not commit any changes and it adivised to check the '/etc/inittab' integrity manually."
else
    doas sed -i 's@openrc sysinit@openrc sysinit --quiet@g' /etc/inittab
fi

# openrc boot
if grep -q "openrc boot --quiet" /etc/inittab; then
    echo "WARNING: the file '/etc/inittab' alredy contains the string 'openrc boot --quiet', as such the script will not commit any changes and it adivised to check the '/etc/inittab' integrity manually."
else
    doas sed -i 's@openrc boot@openrc boot --quiet@g' /etc/inittab
fi

# openrc default
if grep -q "openrc default --quiet" /etc/inittab; then
    echo "WARNING: the file '/etc/inittab' alredy contains the string 'openrc default --quiet', as such the script will not commit any changes and it adivised to check the '/etc/inittab' integrity manually."
else
    doas sed -i 's@openrc default@openrc default --quiet@g' /etc/inittab
fi

# openrc shutdown
if grep -q "openrc shutdown --quiet" /etc/inittab; then
    echo "WARNING: the file '/etc/inittab' alredy contains the string 'openrc shutdown --quiet', as such the script will not commit any changes and it adivised to check the '/etc/inittab' integrity manually."
else
    doas sed -i 's@openrc shutdown@openrc shutdown --quiet@g' /etc/inittab
fi

################################################################
###                 Parallelizing Boot                      ####
################################################################

### NOTE on 'Parallelize Boot':
# see: https://unix.stackexchange.com/questions/579013/how-to-improve-startup-time-of-openrc-system
#
# even tough many have reported speedups due to parallelization,
# personally I didn't experience any noticeable improvement,
# for the moment I will leave it single threaded
#
# IMPORTANT: this section is a sketch, I didn't test it not even once.
#
# INFO: when 'rc_parallel = "YES"' the aesthetic changes, the text is prompted differently.

#### RUN OPEN-RC IN PARALLEL
#if grep -q \#rc_parallel=\"NO\" /etc/rc.conf; then
#    # uses "@" as a delimiter; the '-i' flag edits the file in-place
#    doas sed -i 's@#rc_parallel="NO"@rc_parallel="YES"@g' /etc/inittab
#else
#    echo "WARNING: unable to find the string '#rc_parallel=\"NO\"'"
#fi