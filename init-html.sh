#!/bin/sh

# access url:
# $user@$host:~/.repo/$1.git
init_bare_git_repo() {
    bare_git_dir="${HOME}/.repo/${1}.git"
    git init --bare $bare_git_dir
    echo "#!/bin/sh" > $bare_git_dir/hooks/post-receive
    echo "git --work-tree=${PWD}/html/${1} checkout -f" >> $bare_git_dir/hooks/post-receive
    chmod +x $bare_git_dir/hooks/post-receive
}

# hff@www.hufeifei.cn:~/.repo/www.hufeifei.cn.git
init_bare_git_repo www.hufeifei.cn
init_bare_git_repo blog.hufeifei.cn
