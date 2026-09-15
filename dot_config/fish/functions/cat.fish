function cat
    if type -q bat
        bat -p $argv
    else
        command cat $argv
    end
end
