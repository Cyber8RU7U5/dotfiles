#!/usr/bin/fish

echo "Cloning repo to temporary folder"
git clone -b master https://github.com/Cyber8RU7U5/dotfiles.git /tmp/dotfiles
echo "Removing .git directory"
rm -rf /tmp/dotfiles/.git
echo "Copying to ~/.config"
cp -r /tmp/dotfiles/* ~/.config
echo "Removing temporary folder"
rm -rf /tmp/dotfiles
echo -e "\n-----------------------------------------------\n Done updating! Please relog or reboot \n-----------------------------------------------\n"
