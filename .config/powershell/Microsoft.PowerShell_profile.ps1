Set-Theme robbyrussell
Set-Prompt
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

function Exec-In-Context {
    param (
        [string]$path,
        [scriptblock]$action
    )
    $prev = Get-Location
    Set-Location $path
    $result = $action.Invoke()
    Set-Location $prev
    $result
}

function Git-DotFiles {
    /usr/bin/git --git-dir=$HOME/git/dotfiles --work-tree=$HOME @Args
}

function Sync-DotFiles {
    Git-DotFiles pull
    Git-DotFiles push
}

function Get-DotFiles {
    Exec-In-Context $HOME { Git-DotFiles ls-tree -r master --name-only }
}

function Edit-DotFiles {
    $File = Exec-In-Context $HOME { Get-DotFiles | Invoke-Fzf }
    if ([string]::IsNullOrEmpty($File)) { return }
    $File = [System.IO.Path]::Join($HOME, $File)
    nvim ($File)
}