#!/bin/bash

echo '开始检查环境'
if [ -x "$(command -v python3)" ];then
  echo 'python3 已经安装'
else
  # shellcheck disable=SC2046
  # shellcheck disable=SC2006
  if [ -x "$(command -v brew)" ];then
    echo 'brew 已经安装'
  else
    echo 'brew 从未安装，第一次安装，需要花点时间哦！'
    /usr/bin/ruby -e "$(curl -fsSL https://cdn.jsdelivr.net/gh/ineo6/homebrew-install/install)"
    git -C "$(brew --repo)" remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git
    brew install python
    pip3 install tinify
    pip3 install tqdm
    pip3 install loguru
  fi
fi

cd $(dirname $0); pwd
echo '开始安装依赖'
rm requirements.txt
pip3 freeze > requirements.txt
pip3  install -r requirements.txt



echo '一切准备就绪！开始运行了'
python3 bin/main.py dir --recur
