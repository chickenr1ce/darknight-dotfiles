function yazi -d "Yazi file manager with cd-on-quit"
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    command yazi $argv --cwd-file=$tmp
    if set cwd (cat -- $tmp 2>/dev/null)
        and [ -n "$cwd" ]
        and [ "$cwd" != "$PWD" ]
        builtin cd -- $cwd
    end
    rm -f -- $tmp
end
