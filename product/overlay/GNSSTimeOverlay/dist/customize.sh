if [ "$API" -lt 31 ]; then
    abort "This module is for Android 12 and above!"
fi
set_perm_recursive "$MODPATH" 0 0 0755 0644
