#!/usr/bin/env sh

# 遇到错误就退出
set -e

# 构建
npm run docs:build

# 进入输出目录
cd docs/.vitepress/dist

# 如果你想绑定自定义域名，可创建 CNAME 文件：
# echo 'example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

# ⚠️ 把 "用户名" 和 "仓库名" 改成你的 GitHub 信息
git push -f git@github.com:用户名/仓库名.git main:gh-pages

cd -
