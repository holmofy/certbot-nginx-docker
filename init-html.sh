#!/bin/sh

github_mirror=fastgit.org

# access url:
# $user@$host:~/.repo/$1.git
init_bare_git_repo() {
    bare_git_dir="${HOME}/.repo/${1}.git"
    work_tree_dir="${PWD}/html/${1}"
    mkdir -p $work_tree_dir
    git init --bare $bare_git_dir
    echo "#!/bin/sh" > $bare_git_dir/hooks/post-receive
    echo "git --work-tree=${work_tree_dir} --git-dir ${bare_git_dir} checkout -f" >> $bare_git_dir/hooks/post-receive
    chmod +x $bare_git_dir/hooks/post-receive
}

init_blog_admin() {
    repo_dir="${HOME}/.repo/admin"
    git clone "$1" "$repo_dir" && cd "$repo_dir" && sh install-theme.sh
    if ! command -v npm; then
        command -v nvm || curl -o- https://raw.${github_mirror}/nvm-sh/nvm/v0.38.0/install.sh | bash
        nvm install v14.17.0
    fi
    cd "$repo_dir" && npm install hexo-cli -g && npm install && hexo server --port "${2:-4000}" & 
}

# hff@www.hufeifei.cn:~/.repo/www.hufeifei.cn.git
init_bare_git_repo www.hufeifei.cn
init_bare_git_repo blog.hufeifei.cn

# init_blog_admin https://github.com/holmofy/blog.hufeifei.cn 4000
