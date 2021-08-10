##################################################
# install Scoop
##################################################
# �C���X�g�[���f�B���N�g���̐ݒ� (user)
#$env:SCOOP='D:\Applications\Scoop'
#[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

# �C���X�g�[���f�B���N�g���̐ݒ� (global)
#$env:SCOOP_GLOBAL='D:\GlobalScoopApps'
#[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')

try {
  # Scoop�̃C���X�g�[���m�F
  get-command scoop -ErrorAction Stop
} 
catch [Exception] {
  # Scoop�̃C���X�g�[��
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

# Scoop�̃C���X�g�[���f�B���N�g���̎擾
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
