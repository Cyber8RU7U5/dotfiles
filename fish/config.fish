if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    source ~/.config/fish/alias.fish
end

set PATH $PATH /home/$(whoami)/.config/puppet/applications
set PATH $PATH /home/$(whoami)/.local/bin
