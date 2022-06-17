! /bin/bash


# Install KDE Plasma environment
cd ~
sudo dnf -y group install "KDE Plasma Workspaces"

# Install programs

# Install Chrome 
sudo dnf install fedora-workstation-repositories
sudo dnf install config-manager --set-enable google-chrome
sudo dnf install google-chrome-stable

# Install OnlyOffice
sudo dnf install snapd
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install onlyoffice-desktopeditors

# Install Foxit PDF Reader (Adobe Acrobate Pro alternative)
cd ~/Downloads
wget http://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader.enu.setup.2.4.4.0911.x64.run.tar.gz
tar xzvf FoxitReader*.tar.gz
sudo chmod a+x FoxitReader*.run
sudo ./FoxitReader*.run
rm FoxitReader*.tar.gz
rm FoxitReader*.run
cd ..

# Install Wine
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/35/winehq.repo
sudo dnf -y install winehq-stable

# Install WineTricks
cd ~/Downloads
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
sudo mv winetricks /usr/local/bin/
cd ~

# Install 7Zip
sudo yum install p7zip p7zip-plugins

# Install VLC Media Player
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf group update core
sudo dnf install vlc

# Install Amarok (iTunes alternative) with Phonon Backends?
sudo yum install amarok
sudo yum install phonon-backend-vlc
# Multimedia post-install
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# Install PhotoGIMP (Photoshop alternative)
sudo dnf install gimp

# Install RawTherapee (Lightroom alternative)
sudo dnf install rawtherapee -y

# Install Kdenlive (Premiere alternative)
sudo dnf install kdenlive

# Install Inkscape (Illustrator alternative)
sudo dnf install inkscape


# Install development enviroments

# Install Git
Sudo yum install git
sudo dnf install curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel asciidoc xmlto docbook2X
sudo ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi
git clone https://git.kernel.org/pub/scm/git/git.git
# Step 4 "To Build Git and install it under /usr, run make:" has errors (on my current machine); next two commands for this step commented out due to the errors
# make all doc prefix=/usr
# sudo make install install-doc install-html install-man prefix=/usr

# Install C++/C# Environments
sudo dnf install gcc-c++
sudo dnf install dotnet-sdk-6.0
sudo dnf install aspnetcore-runtime-6.0
sudo dnf install dotnet-runtime-6.0

# Install Java - OpenJDK
sudo dnf install java-latest-open-jdk.x86_64
sudo dnf install java-latest-openjdk-devel.x86_64


# Install programs for university

# Install VS Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code

# Programs below this point have wizards to go through.

# Install Autodesk Eagle PCB Design
sudo wget -c https://trial2.autodesk.com/NET17SWDLD/2017/EGLPRM/ESD/Autodesk_EAGLE_9.6.2_English_Linux_64bit.tar.gz -O - | tar -xz
cd eagle*
# Nouveau (Open Source driver for nVidia cards) may cause sporadic crashes during the login procedure.
# Enable software rendering in libGL by setting LIBGL_ALWAYS_SOFTWARE to 1.
export LIBGL_ALWAYS_SOFTWARE=1
# Create if statement to verify that ./eagle runs properly. Run it if it functions correctly.
# If output of failed install contains "Could not initialize GLX" and Bash echo $? == 134 then
# run QT_XCB_GL_INTEGRATION=xcb_egl ./eagle
./eagle || QT_XCB_GL_INTEGRATION=xcb_egl ./eagle
cd ..
sudo rm Autodesk*.tar.gz
# Create directory for Autodesk Eagle
sudo mv eagle* /etc


# Message to stat what other programs must be installed. As well as a reminder to set up Git.
echo Programs and apps to manually or add to script install:
echo MatLab, SMath, Xilinx ISE, PSpice
echo
echo Also, Git still needs to be setup.
