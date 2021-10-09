#!/bin/sh

# access url:
# $user@$host:~/.repo/$1.git
init_bare_git_repo() {
    bare_git_dir="${GIT_HOME}/repo/${1}.git"
    work_tree_dir="${PWD}/html/${1}"
    mkdir -p $work_tree_dir
    git init --bare $bare_git_dir
    echo "#!/bin/sh" > $bare_git_dir/hooks/post-receive
    echo "git --work-tree=${work_tree_dir} --git-dir ${bare_git_dir} checkout -f" >> $bare_git_dir/hooks/post-receive
    chmod +x $bare_git_dir/hooks/post-receive
}

useradd git -s /usr/bin/git-shell
GIT_HOME=/home/git

# hff@www.hufeifei.cn:~/.repo/www.hufeifei.cn.git
init_bare_git_repo www.hufeifei.cn
init_bare_git_repo blog.hufeifei.cn

chown -R git:git "${GIT_HOME}/repo"
chown -R git:git "${PWD}/html"
