Set-Theme robbyrussell
Set-Prompt
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
$ENV:EDITOR = "nvim"

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
    $file = Exec-In-Context $HOME { Get-DotFiles | Invoke-Fzf -Preview "bat --color=always --style numbers {}" }
    if ([string]::IsNullOrEmpty($File)) { return }
    $file = [System.IO.Path]::Join($HOME, $file)
    nvim ($file)
}

function Commit-DotFiles {
    $files = Exec-In-Context $HOME { 
        Git-DotFiles ls-files -m 
        | Invoke-Fzf -Preview "/usr/bin/git --git-dir=$HOME/git/dotfiles --work-tree=$HOME diff --color=always {}" -Multi
    }
    if ([string]::IsNullOrEmpty($Files)) { return }
    Exec-In-Context $HOME { &Git-DotFiles add @($files) }
    Git-DotFiles commit
}
