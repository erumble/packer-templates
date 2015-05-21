#!/bin/bash -eux
#
# Clones rbenv and ruby-build, and adds rbenv to the PATH
# Don't run it as root or with sudo... bad things may happen

# die horribly if git isn't installed
if ! command -v git >/dev/null 2>&1; then 
  echo "Do you even git?"
  exit 1
fi

# make a hash in bash!
declare -A clone_me
clone_me+=(
  ["${HOME}/.rbenv"]="https://github.com/sstephenson/rbenv.git"
  ["${HOME}/.rbenv/plugins/ruby-build"]="https://github.com/sstephenson/ruby-build.git"
)

# clone all the things!
for dir in ${!clone_me[@]}; do
  if [[ ! -d $dir ]]; then
    git clone ${clone_me[$dir]} ${dir}
  else
    pushd $dir
    if [[ ! -d ".git" ]]; then
      git init
      git remote add origin ${clone_me[$dir]}
    fi
    git pull origin master
  fi
done

# add stuff to the bash_profile, what could go wrong?
bash_profile="${HOME}/.bash_profile"
if ! command -v rbenv >/dev/null 2>&1; then
  echo 'export PATH="${HOME}/.rbenv/bin:$PATH"' >> $bash_profile
  echo 'eval "$(rbenv init -)"' >> $bash_profile
fi

