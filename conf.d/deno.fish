set -x DENO_INSTALL "$HOME/.deno"
set -x PATH $PATH "$DENO_INSTALL/bin"

function _deno_install
    curl -fsSL "https://deno.land/x/install/install.sh" | sh
end

function _deno_completions
    deno completions fish >"$HOME/.config/fish/completions/deno.fish"
end

function _on_deno_install --on-event deno_install
    if not test -f "$DENO_INSTALL/bin/deno"
        _deno_install
    end

    _deno_completions
end

function _on_postexec_deno_upgrade --on-event fish_postexec
    if string match -qr '^deno upgrade$' $argv
        _deno_completions
    end
end
