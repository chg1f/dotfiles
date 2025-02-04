[user]
  name = chg1f
  email = chongiofai@gmail.com

[core]
  sshCommand = ssh -i ~/.ssh/github.id_ed25519

[init]
  defaultBranch = main

# vim: ft=gitconfig
