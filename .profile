# set PATH so it includes Win10's bin
if [ -d "/mnt/c/home/bin" ] ; then
    PATH="/mnt/c/home/bin:$PATH"
fi

# set Scoop path
if [ -d "/mnt/c/Users/kinou/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Scoop Apps" ]; then
    PATH="$PATH:/mnt/c/Users/kinou/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Scoop Apps"
fi

# set env
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
export LIBGL_ALWAYS_INDIRECT=1

