[github]
  user = chg1f

[user]
  name = chg1f
  email = chongiofai@gmail.com

[core]
  sshCommand = ssh -i ~/.ssh/gh.id_rsa

[init]
  defaultBranch = main


# vim: ft=gitconfig
