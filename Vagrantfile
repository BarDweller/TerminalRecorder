Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/xenial64"

  config.vm.provider "virtualbox" do |vb|
    #   # Display the VirtualBox GUI when booting the machine
    #   vb.gui = true
    #
    #   # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end
 
  #fix 'stdin is not a tty' output.
  config.vm.provision :shell, inline: "(grep -q -E '^mesg n$' /root/.profile && sed -i 's/^mesg n$/tty -s \\&\\& mesg n/g' 
/root/.profile && echo 'Ignore the previous error about stdin not being a tty. Fixing it now...') || exit 0;"

  #For oracle jdk, curl, xvfb, ffmpeg
  config.vm.provision :shell, inline: "echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections"
  config.vm.provision :shell, inline: "echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections"
  config.vm.provision :shell, inline: "apt-get install --reinstall apt-transport-https ca-certificates && apt-add-repository ppa:webupd8team/java && apt-get update && apt-get -y install oracle-java8-installer curl xvfb ffmpegi x11-apps rxvt-unicode fonts-inconsolata"

  config.vm.provision :shell, inline: "echo export PS1='user@demo:\\w$ ' >> ~/.bashrc"
  config.vm.provision :shell, inline: "echo set background=dark >> ~/.vimrc"

end
