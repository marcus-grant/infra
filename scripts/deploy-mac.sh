#!/bin/bash

export PLAYDIR='/tmp/macansible'

# If there are ansible errors about permissions try this brew reported fix
# You should change the ownership of these directories to your user.
# sudo chown -R $(whoami) /opt/homebrew /opt/homebrew/Cellar /opt/homebrew/Frameworks /opt/homebrew/bin /opt/homebrew/etc /opt/homebrew/include /opt/homebrew/lib /opt/homebrew/opt /opt/homebrew/sbin /opt/homebrew/share /opt/homebrew/share/zsh /opt/homebrew/share/zsh/site-functions
# And make sure that your user has write permission.
# chmod u+w /opt/homebrew /opt/homebrew/Cellar /opt/homebrew/Frameworks /opt/homebrew/bin /opt/homebrew/etc /opt/homebrew/include /opt/homebrew/lib /opt/homebrew/opt /opt/homebrew/sbin /opt/homebrew/share /opt/homebrew/share/zsh /opt/homebrew/share/zsh/site-functions

export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"
xcode-select --install
sudo pip3 install --upgrade pip
sudo pip3 install ansible
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo chown -R $(whoami) /usr/local/Cellar
sudo chown -R $(whoami) /usr/local/var/homebrew
sudo chown -R $(whoami) /usr/local/Frameworks /usr/local/Homebrew /usr/local/bin /usr/local/etc /usr/local/include /usr/local/lib /usr/local/opt /usr/local/sbin /usr/local/share /usr/local/share/zsh /usr/local/share/zsh/site-functions
chmod u+w /usr/local/Frameworks /usr/local/Homebrew /usr/local/bin /usr/local/etc /usr/local/include /usr/local/lib /usr/local/opt /usr/local/sbin /usr/local/share /usr/local/share/zsh /usr/local/share/zsh/site-functions
/opt/homebrew/bin/brew install git
mkdir -p $PLAYDIR
git clone https://github.com/marcus-grant/infra $PLAYDIR
cd $PLAYDIR
if [ ! $PLAYDIR in "$(which python3)" ]; then
    if [ ! -d $PLAYDIR/venv ]; then
        python3 -m venv $PLAYDIR/venv
    fi
    source $PLAYDIR/venv/bin/activate
    pip install -r $PLAYDIR/requirements.txt
fi

ansible-galaxy install -r $PLAYDIR/requirements.yml
ansible-playbook mac.yml

rm -rf $PLAYDIR
unset PLAYDIR
deactivate