# Guide to Reproduce this Desktop Arch install

## Git And Remote GitHub Repos
Install openssh package. enable/start the ssh-agent.service with systemd. 
It should be a user unit (systemctl --user). Generate SSH key using the 
guide here [Generating new SSH key...](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
Run the command `ssh-keygen -t ed25519 -C "your_email@example.com"`, you 
can see your GitHub email by typing `git config user.email`.
Run `eval "$(ssh-agent)"` and then `ssh-add path-to-private-key`. Then add
the public key to GitHub. This should make pushing and pulling from remote
repositories work. If it doesn't, make sure ssh-agent is running and re-run
`eval "$(ssh-agent)"`. If the command return a pid, this is good and it 
should work.

If it still doesn't work, make sure to have the private key under one of 
GitHub's standard names for private keys (id_rsa for example). GitHub will
sometimes only look for those and will ignore custom names. I have a symlink
in this desk-arch install to a custom named private key file.

