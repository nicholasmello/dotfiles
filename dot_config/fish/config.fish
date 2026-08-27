if status is-interactive
    if type -q fzf
        fzf --fish | source
    end

    set -Ux EDITOR nvim
    set -Ux VISUAL nvim
end

set -gx PATH "~/.pixi/bin" $PATH
