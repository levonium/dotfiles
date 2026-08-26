[[ $- != *i* ]] && return

# Resolve current git branch (or short SHA on detached HEAD) + lightweight status flags
git_prompt() {
  # short branch or short SHA; bail if not in a repo
  local ref
  ref=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) \
    || ref=$(git rev-parse --short HEAD 2>/dev/null) \
    || return 0

  # porcelain is cheap; collect once
  local st
  st="$(git status --porcelain 2>/dev/null)"

  # flags: + staged, * modified/deleted (unstaged), % untracked
  local f_staged f_mod f_untracked
  [ -n "$st" ] && {
    echo "$st" | grep -qE '^[MADRC]' && f_staged='+'
    echo "$st" | grep -qE '^.[MD]'   && f_mod='*'
    echo "$st" | grep -qE '^\?\?'   && f_untracked='%'
  }

  printf '🔀 [%s%s%s%s] ' "$ref" "${f_staged}" "${f_mod}" "${f_untracked}"
}

# Colors (non-printing sequences wrapped in \[ \])
BBlue='\[\e[01;34m\]'
BRed='\[\e[01;31m\]'
Reset='\[\e[00m\]'

# Host/user/dir + git segment
set_prompt() {
  PS1='${debian_chroot:+($debian_chroot)} \u@\h 🗁  '"${BBlue}"'\W '"${BRed}"'$(git_prompt)'"${Reset}"' \$ '

  case "$TERM" in
    xterm*|rxvt*)
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
      ;;
  esac
}
set_prompt

