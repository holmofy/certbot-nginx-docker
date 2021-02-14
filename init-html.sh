#!/bin/sh

init_bare_git_repo() {
    bare_git_dir="~/.${1}.git"
    git init --bare $bare_git_dir
    echo "#!/bin/sh" > $bare_git_dir/hooks/post_receive
    echo "git --work-tree=${PWD}/html/${1} checkout -f" >> $bare_git_dir/hooks/post_receive
    chmod +x $bare_git_dir/hooks/post_receive
}

init_bare_git_repo www.hufeifei.cn
init_bare_git_repo blog.hufeifei.cn
