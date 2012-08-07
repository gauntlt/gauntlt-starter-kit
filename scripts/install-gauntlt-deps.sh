## shell script to prepare Gauntlt Getting Started environment

RUBY_VER='1.9.3-p194'

# required distro packages
sudo apt-get -y install nmap curl libcurl3-dev rbenv libyaml-dev \
  libxml2-dev libxslt-dev

# rbenv ENV vars
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

# download and build ruby
mkdir $HOME/tmp && cd $HOME/tmp
#wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-${RUBY_VER}.tar.gz
wget http://mirrors.ibiblio.org/pub/mirrors/ruby/ruby-${RUBY_VER}.tar.gz
tar xzvf ruby-${RUBY_VER}.tar.gz
cd ruby-${RUBY_VER}
./configure --prefix=$HOME/.rbenv/versions/${RUBY_VER}
make
make install

# use the new ruby
rbenv global ${RUBY_VER}
echo ruby is `which ruby`

# gherkin syntax highlighting in vim for .attack files
mkdir -p ~/.vim/syntax
wget https://raw.github.com/tpope/vim-cucumber/master/syntax/cucumber.vim \
  -O ~/.vim/syntax/gherkin.vim
echo "syn on" >> ~/.vimrc
echo "au Bufread,BufNewFile *.attack set filetype=gherkin" >> ~/.vimrc
