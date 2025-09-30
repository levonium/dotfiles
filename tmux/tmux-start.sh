#!/usr/bin/env bash
# Attach to or create a tmux session based on rules

arg="$1"
base="$(basename "$PWD")"

if [ -n "$arg" ]; then
    name="$arg"
    if tmux has-session -t "$name" 2>/dev/null; then
        tmux attach -t "$name"
    else
        if [ "$name" = "$base" ]; then
            tmux new-session -s "$name"
        else
            echo "tmux: session \"$name\" does not exist and current dir is \"$base\". Not creating." >&2
            exit 1
        fi
    fi
else
    name="$base"
    if tmux has-session -t "$name" 2>/dev/null; then
        tmux attach -t "$name"
    else
        tmux new-session -s "$name"
    fi
fi

