set -x DENO_INSTALL "$HOME/.deno"
set -x PATH $PATH "$DENO_INSTALL/bin"

function _deno_install
    curl -fsSL https://deno.land/x/install/install.sh | sh
end

function _deno_uninstall --on-event deno_uninstall
    if test "$HOME/.config/fish/completions/deno.fish"
        rm "$HOME/.config/fish/completions/deno.fish"
    end
end

function _deno_update_completions
    deno completions fish >"$HOME/.config/fish/completions/deno.fish"
end

function _post_deno_upgrade --on-event fish_postexec
    if string match -qr '^deno upgrade$' $argv
        _deno_update_completions
    end
end

if not test -f "$DENO_INSTALL/bin/deno"
    _deno_install
    _deno_update_completions
end
