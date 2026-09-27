# ~/.bashrc — interactive shell config only.
# Environment (PATH, DOTNET_ROOT, umask) lives in ~/.profile so GUI apps,
# scripts and non-interactive shells see it too.

case $- in *i*) ;; *) return ;; esac

_has_cmd() { command -v "$1" >/dev/null 2>&1; }

# --- Shell behaviour -------------------------------------------------------
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=200000
HISTTIMEFORMAT='%F %T '          # timestamps in the fallback bash history
shopt -s histappend checkwinsize globstar

[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# --- Tool manager (early, so later `command -v` finds mise-managed tools) -
_has_cmd mise && eval "$(mise activate bash)"

# --- 1Password SSH agent (don't clobber a forwarded agent over SSH) --------
if [[ -z ${SSH_CONNECTION:-} && -S $HOME/.1password/agent.sock ]]; then
    export SSH_AUTH_SOCK=$HOME/.1password/agent.sock
fi

# --- Colours ---------------------------------------------------------------
if _has_cmd dircolors; then
    if [[ -r ~/.dircolors ]]; then eval "$(dircolors -b ~/.dircolors)"
    else eval "$(dircolors -b)"; fi
fi
# Readable dirs on dark backgrounds
LS_COLORS+=':ow=01;33:tw=01;36:di=01;36'
export LS_COLORS

# --- Aliases ---------------------------------------------------------------
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias l='ls -l'
if _has_cmd eza; then
    alias ll='eza --long --all --group-directories-first'
    alias lt='eza --long --sort=modified'
    alias la='eza --long --all --total-size'
else
    alias ll='ls -Al --group-directories-first'
    alias lt='ls -ltr'
fi

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# --- Completion ------------------------------------------------------------
if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        . /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion
    fi
fi

# Generated completions are cached and only regenerated when the binary
# changes, instead of spawning kubectl/uv/uvx on every new shell.
_comp_cache=${XDG_CACHE_HOME:-$HOME/.cache}/bash-completions
mkdir -p "$_comp_cache"
_cached_completion() {   # usage: _cached_completion <tool> <generator cmd...>
    local tool=$1 bin f; shift
    bin=$(command -v "$tool") || return 0
    f=$_comp_cache/$tool.bash
    if [[ ! -s $f || $bin -nt $f ]]; then
        "$@" >"$f" 2>/dev/null || { rm -f "$f"; return 0; }
    fi
    . "$f"
}
_cached_completion kubectl kubectl completion bash
_cached_completion uv      uv generate-shell-completion bash
_cached_completion uvx     uvx --generate-shell-completion bash
unset -f _cached_completion; unset _comp_cache

if _has_cmd kubectl; then
    alias k=kubectl
    complete -o default -F __start_kubectl k
fi
_has_cmd terraform && complete -C "$(command -v terraform)" terraform
[[ -x /snap/aws-cli/current/bin/aws_completer ]] && \
    complete -C /snap/aws-cli/current/bin/aws_completer aws

# --- Prompt and hooks: keep this block LAST and in this order --------------
# bash-preexec first so starship and atuin share it instead of fighting
# over the DEBUG trap; zoxide last as its docs recommend.
[[ -f ~/.bash-preexec.sh ]] && . ~/.bash-preexec.sh

if _has_cmd starship; then
    _win_title() { printf '\e]0;%s@%s: %s\a' "$USER" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"; }
    starship_precmd_user_func=_win_title
    eval "$(starship init bash)"
fi
_has_cmd atuin  && eval "$(atuin init bash)"
_has_cmd zoxide && eval "$(zoxide init bash)"
