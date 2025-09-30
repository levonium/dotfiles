#!/usr/bin/env bash
# Save all current tmux sessions/windows/panes into a restore script

out="${1:-$HOME/.tmux-sessions.sh}"
mkdir -p "$(dirname "$out")"

{
  echo '#!/usr/bin/env bash'
  echo 'set -euo pipefail'
  echo 'TMUX=  # ensure not running inside a tmux client'
  echo

  while IFS=$'\t' read -r s curw; do
    first_win_line=$(tmux list-windows -t "$s" -F '#{window_index}	#{window_name}	#{pane_current_path}' | sort -n | head -n1)
    fw_idx=$(echo "$first_win_line" | cut -f1)
    fw_name=$(echo "$first_win_line" | cut -f2)
    fw_path=$(echo "$first_win_line" | cut -f3)

    echo "tmux new-session -d -s $(printf %q "$s") -n $(printf %q "$fw_name") -c $(printf %q "$fw_path")"

    tmux list-windows -t "$s" -F '#{window_index}	#{window_name}	#{window_layout}' | \
    while IFS=$'\t' read -r widx wname wlayout; do
      if [ "$widx" != "$fw_idx" ]; then
        wpath=$(tmux list-panes -t "$s:$widx" -F '#{pane_index}	#{pane_current_path}' | sort -n | head -n1 | cut -f2)
        echo "tmux new-window -t $(printf %q "$s") -d -n $(printf %q "$wname") -c $(printf %q "$wpath")"
      fi

      pc=$(tmux list-panes -t "$s:$widx" -F '#{pane_id}' | wc -l)
      if [ "$pc" -gt 1 ]; then
        tmux list-panes -t "$s:$widx" -F '#{pane_index}	#{pane_current_path}' | sort -n | tail -n +2 | cut -f2 | \
        while IFS= read -r ppath; do
          echo "tmux split-window -t $(printf %q "$s"):$widx -d -c $(printf %q "$ppath")"
        done
        echo "tmux select-layout -t $(printf %q "$s"):$widx $(printf %q "$wlayout")"
      fi
    done

    echo "tmux select-window -t $(printf %q "$s"):$curw"
  done < <(tmux list-sessions -F '#{session_name}	#{session_last_attached_window}')

  echo
  echo 'echo "tmux restore done."'
} > "$out"

chmod +x "$out"
echo "Saved to $out"

