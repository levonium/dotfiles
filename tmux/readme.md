# TMUX

## To-do:
- [ ] can we add tabs/button/any indicators for tmux sessions

How do I use tmux? What do I need to be able to do?

## create sessions (tmux new-session)
in any directory I can run `tms` and it will start a new session or if a session exists it will attach it.

## "close" sessions (tmux detach)
this doesn't require anything special, use the keybinding `PREFIX d`

## "open" sessions (tmux attach)
`tms` handles this as well

## list sessions (tmux list)
`tml` will list all sessions

## save and restore sessions (---)
by default the sessions are in-memory only, and I don't want to use a plugin, so here's our workaround:
- to save sessions I can run `tmsave` and
- to restore them I can run `tmrestore`
- these are aliases that call `~/.tmux/tmuxsave.sh` and `~/.tmux/tmuxrestore.sh` scripts
- these scrips are part of the dotfiles repo

---

Because tmux session names are the names of the project directories, I can run `tms $NAME` from anywhere and it will lunch that session if it exists.

