##################################################
# install Scoop
##################################################
# インストールディレクトリの設定 (user)
#$env:SCOOP='D:\Applications\Scoop'
#[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

# インストールディレクトリの設定 (global)
#$env:SCOOP_GLOBAL='D:\GlobalScoopApps'
#[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')

try {
  # Scoopのインストール確認
  get-command scoop -ErrorAction Stop
} 
catch [Exception] {
  # Scoopのインストール
  Set-ExecutionPolicy RemoteSigned -scope CurrentUser
  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

# install basic module
scoop install aria2
scoop install git
scoop install sudo

# add bucket
scoop bucket add extras
scoop bucket add versions

# Scoopのインストールディレクトリの取得
$SCOOP_ROOT = if ($env:SCOOP) {$env:SCOOP} else {"$home\scoop"}


##################################################
# install vscode
##################################################
scoop install vscode
reg import $SCOOP_ROOT\apps\vscode\current\vscode-install-context.reg  # add context menu

##################################################
# install applications
##################################################
scoop install zenhan
scoop install slack
scoop install neovim
scoop install autohotkey
scoop install slack
scoop install firefox
