$ErrorActionPreference = "Stop"

function Main {
    "This script creates a zip file that contains all files changed between two commits."
    "Commits can be specified as commit IDs (SHA) or as branch names."
    "For example: 'master' or 'ff39683ed6'"
    ""

    $git_dir = Read-Host -Prompt "Git directory"
    $to_commit = Read-Host -Prompt "Commit to deploy"
    $from_commit = Read-Host -Prompt "Previously deployed commit"

    pushd $git_dir
    try {
        $datestr = "{0:yyMMdd-HHmmss}" -f (get-date)
        $export_filename = "export_$datestr.zip"

        # All files that have been changed, excluding deleted files
        $changed_files = git diff --name-only "$from_commit" "$to_commit" --diff-filter=d
        
        # Deleted files, for listing
        $deleted_files = git diff --name-only "$from_commit" "$to_commit" --diff-filter=D

        # Create the export
        git archive --output="$export_filename" $to_commit $changed_files

        ""
        "Created $export_filename in $git_dir"

        if ($deleted_files) {
            "Deleted files:"
            foreach ($filename in $deleted_files) {
                " - $filename"
            }
        }

    } finally {
        popd
    }
}

Main
