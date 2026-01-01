#!/bin/bash
set -e

BRANCH="gh-pages"
TARGET_DIR="/workspaces/dbt-analytics-incremental-dd/dbt-transform/dbt_project/target"

echo "Generating dbt docs..."
dbt docs generate --project-dir /workspaces/dbt-analytics-incremental-dd/dbt-transform/dbt_project --profiles-dir /workspaces/dbt-analytics-incremental-dd/dbt-transform/dbt_project

# Ensure required files exist BEFORE touching gh-pages
if [ ! -f "$TARGET_DIR/index.html" ] || \
   [ ! -f "$TARGET_DIR/manifest.json" ] || \
   [ ! -f "$TARGET_DIR/catalog.json" ] ; then
    echo "ERROR: dbt docs were not generated correctly. Aborting."
    exit 1
fi

# Remember current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $CURRENT_BRANCH"

# Create gh-pages branch if missing
if ! git show-ref --verify --quiet refs/heads/$BRANCH; then
    echo "Creating orphan branch $BRANCH..."
    git checkout --orphan $BRANCH
else
    echo "Switching to $BRANCH..."
    git checkout $BRANCH
fi

# Copy only required dbt docs files
echo "Copying new docs..."
cp "$TARGET_DIR/index.html" .
cp "$TARGET_DIR/manifest.json" .
cp "$TARGET_DIR/catalog.json" .
# cp -r "$TARGET_DIR/assets" .


# Commit and push
git add index.html manifest.json catalog.json
git commit -m "Update dbt docs"
git push -u origin $BRANCH

# Now it's safe to delete files
echo "Clearing old docs..."
git rm -rf .


# # Return to original branch
# git checkout $CURRENT_BRANCH

echo "Docs published successfully!"