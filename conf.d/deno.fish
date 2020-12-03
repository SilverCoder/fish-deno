set -x DENO_INSTALL "$HOME/.deno"
set -x PATH $PATH "$DENO_INSTALL/bin"

set DENO_COMPLETIONS_FILE "$HOME/.config/fish/completions/deno.fish"

function _deno_install
    curl -fsSL "https://deno.land/x/install/install.sh" | sh
end

function _deno_uninstall
    if test -f "$DENO_COMPLETIONS_FILE"
        rm "$DENO_COMPLETIONS_FILE"
    end
end

function _deno_completions
    deno completions fish >"$DENO_COMPLETIONS_FILE"
end

function _on_deno_install --on-event deno_install
    if not test -f "$DENO_INSTALL/bin/deno"
        _deno_install
    end

    _deno_completions
end

function _on_deno_uninstall --on-event deno_uninstall
    _deno_uninstall
end

function _on_postexec_deno_upgrade --on-event fish_postexec
    if string match -qr '^deno upgrade$' $argv
        _deno_completions
    end
end
