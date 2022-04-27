### Contains git hooks and git helpers scripts

#### Git hooks

- prepare-commit-msg
    
    If the current branch name is prefixed with the Jira issue id then it automatically adds the Jira issue id at the start of the commit message followed by `:`

#### Git scripts

- pull-main-branches.sh

    Automatically loop over all the main branches (undeleatable branches, like test, staging, prod, ecc) and pull them: when it finishes, it goes back to the checked out branch before starting the script

- remove-merged-branch.sh

    Locally remove the current branch that has already been merged remotely (through pull request usually): if any error results then the script exits doing nothing, otherwise the selected main branch is checked out
