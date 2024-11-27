# Guide to Reproduce this Desktop Arch install

## Git And Remote GitHub Repos
Install openssh package. enable/start the ssh-agent.service with systemd. 
It should be a user unit (systemctl --user). Generate SSH key using the 
guide here [Generating new SSH key...](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
Run `eval "$(ssh-agent)"` and then `ssh-add path-to-private-key`. Then add
the public key to GitHub. This should make pushing and pulling from remote
repositories work. If it doesn't, make sure ssh-agent is running and re-run
`eval "$(ssh-agent)"`.

