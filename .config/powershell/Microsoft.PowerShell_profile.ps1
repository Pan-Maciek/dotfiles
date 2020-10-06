Set-Theme robbyrussell
Set-Prompt
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

function Get-Config-Files {
    /usr/bin/git --git-dir=$HOME/git/dotfiles --work-tree=$HOME ls-tree -r master --name-only
}

function Edit-Config {
    /usr/bin/git --git-dir=$HOME/git/dotfiles --work-tree=$HOME ls-tree -r master --name-only | fzf
}