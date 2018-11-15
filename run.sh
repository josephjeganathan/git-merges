branch_off() {
    git checkout master
    git branch feature/E-00$1_feature$1
    git checkout feature/E-00$1_feature$1
}

commit_file_line() {
    echo "Line $2" >> File$1.txt
    git add .
    git commit -m "Added line $2 to file $1"
}

squash_merge() {

    echo "RUNNING SQUASH MERGE"

    squash_merge_branch() {
        git checkout master
        git merge --squash feature/E-00$1_feature$1
        git commit -m "Added feature E-00$1 feature$1"
    }
    squash_merge_branch 1
    squash_merge_branch 2
    squash_merge_branch 3
}

rebase_merge() {

    echo "RUNNING REBASE AND MERGE"

    rebase_merge_branch() {
        git checkout master
        git rebase feature/E-00$1_feature$1
        git merge feature/E-00$1_feature$1
        git commit -m "Added feature E-00$1 feature$1"
    }
    
    rebase_merge_branch 1
    rebase_merge_branch 2
    rebase_merge_branch 3
}

normal_merge(){
    
    echo "RUNNING MORMAL MERGE"
    
    normal_merge_branch() {
        git checkout master
        git merge feature/E-00$1_feature$1  -m "Added feature E-00$1 feature$1"
    }

    normal_merge_branch 1
    normal_merge_branch 2
    normal_merge_branch 3
}

delete_branches() {
    git branch -D feature/E-001_feature1
    git branch -D feature/E-002_feature2
    git branch -D feature/E-003_feature3
}

initialise() {

    rm -rf .git
    rm -rf *.txt

    git init
    echo "Git Merge" >> README.md
    git add .
    git commit -m "Initial commit"

    branch_off 1
    commit_file_line 1 1
    commit_file_line 1 2
    commit_file_line 1 3

    branch_off 2
    commit_file_line 2 1
    commit_file_line 2 2
    commit_file_line 2 3

    branch_off 3
    commit_file_line 3 1
    commit_file_line 3 2
    commit_file_line 3 3
}
while true 
do
    initialise
    echo "s - Squash merge"
    echo "r - Rebase and merge"
    echo "<any other key> - Default merge"
    read -n 1 -p "Select merge style: " mergestyle
    clear

    if [ "$mergestyle" = "s" ]; then
        squash_merge
    elif [ "$mergestyle" = "r" ]; then
        rebase_merge
    else
        normal_merge
    fi

    delete_branches

    echo "Press any key to try again..."
    read -n 1
    clear
 
done