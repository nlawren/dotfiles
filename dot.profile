# ~/.profile: executed by the command interpreter for login shells.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

path_prepend() { case ":$PATH:" in *":$1:"*) ;; *) [ -d "$1" ] && PATH="$1:$PATH" ;; esac; }
path_append()  { case ":$PATH:" in *":$1:"*) ;; *) [ -d "$1" ] && PATH="$PATH:$1" ;; esac; }

# atuin's installer drops a PATH snippet here
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"

# .NET for AZ-400 study
if [ -d "$HOME/.local/dotnet" ]; then
    path_append "$HOME/.local/dotnet"
    export DOTNET_ROOT="$HOME/.local/dotnet"
fi

export PATH
unset -f path_prepend path_append

# Restrictive umask by design.
umask 077
