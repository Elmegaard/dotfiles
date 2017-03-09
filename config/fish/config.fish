#TMUX
alias tma='tmux attach-session -t'
alias tmux='tmux -2'

#PATH
set -gx GOPATH $HOME/go
set -U fish_user_paths /usr/local/texlive/2014/bin/x86_64-linux $GOPATH/bin $fish_user_paths
set -gx DOTSCRIPTS $HOME/git/LinuxConfig/laptop/scripts

# Set Browser
set -x BROWSER vivaldi-stable

# thefuck
function fuck -d "Correct your previous console command"
    set -l exit_code $status
    set -x TF_ALIAS fuck
    set -l fucked_up_command $history[1]
    thefuck $fucked_up_command | read -l unfucked_command
    if [ "$unfucked_command" != "" ]
        eval $unfucked_command
        if test $exit_code -ne 0
            history --delete $fucked_up_command
            history --merge ^ /dev/null
            return 0
        end
    end
end

#Misc aliases
alias c "clear"
alias q "exit"
alias r "ranger"
alias vim "nvim"
alias update "sudo pacman -Syu; vim -c :PlugUpdate -c :q -c :q"

#Git Config
#git config --global core.editor nvim
#git config --global merge.tool vimdiff3
#git config --global mergetool.path nvim

#Git Aliases
alias g "cd ~/git; clear; ls"
alias gpull "git pull --rebase"
alias gcommit "git commit"
alias gpush "git push"
alias gsync "git pull --rebase; git push"

#display
alias vga "xrandr --output LVDS1 --auto --primary --output VGA1 --auto --right-of LVDS1"
alias vncpres "x11vnc -ncache 10 -nap -wait 50 -noxdamage -passwd pass123edit -viewpasswd 123456 -display :0 -forever"

# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '✔'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

#prompt
set fish_color_cwd white --bold
set fish_greeting ''
function fish_prompt
        set_color green
        printf '%s' (whoami)
        printf '@'
        printf '%s'(hostname)
        set_color $fish_color_cwd
        printf ' %s' (pwd)
        set_color normal
        printf '%s\n>' (__fish_git_prompt)
       set_color normal
end

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx -- -keeptty
    end


    # bind Capslock to Escape when tapped,
    # Bind Capslock to Control when pressed
    # depends on xcape
    setxkbmap -option 'caps:ctrl_modifier'
    xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'

end

#xrdb -merge ~/.Xresources
