[user]
  name = chg1f
  email = chongiofai@gmail.com

[core]
  sshCommand = ssh -o "ProxyCommand='/usr/bin/nc -X 5 -x 127.0.0.1:7890 %h %p'" -i ~/.ssh/github.id_ed25519

[init]
  defaultBranch = main

# vim: ft=gitconfig
