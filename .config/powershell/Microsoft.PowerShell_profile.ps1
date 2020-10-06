Set-Theme robbyrussell
Set-Prompt
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

function Git-DotFiles {
    /usr/bin/git --git-dir=$HOME/git/dotfiles --work-tree=$HOME @Args
}

function Sync-DotFiles {
    Git-DotFiles pull
    Git-DotFiles push
}

function Get-DotFiles {
    $Prev = Get-Location
    Set-Location $HOME

    $Files = Git-DotFiles ls-tree -r master --name-only

    Set-Location $Prev
    $Files
}

function Edit-DotFiles {
    $Prev = Get-Location
    Set-Location $HOME

    $File = Get-DotFiles | Invoke-Fzf
    if ([string]::IsNullOrEmpty($File)) {
        Set-Location $Prev
        return 
    }
    $File = [System.IO.Path]::Join($HOME, $File)
    nvim ($File)

    Set-Location $Prev
}