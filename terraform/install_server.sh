#! /bin/bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/tmp/init.log 2>&1

sudo apt install -y htop tmux git
sudo apt install -y golang

# Rust toolchain install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "export PATH=$PATH:~/.cargo/bin" >> /etc/environment 

# Elixir toolchain install
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
sudo apt-get update
sudo apt-get install -y elixir
mix local.hex --force 



