# Quick Start Guide - Creating Phase 1 Issues

## Option 1: Run the Automated Script (Recommended)

### Prerequisites
- GitHub CLI (`gh`) must be installed (already available in this environment)
- You need to authenticate with GitHub

### Steps

1. **Authenticate with GitHub CLI:**
   ```bash
   gh auth login
   ```
   Follow the prompts to authenticate.

2. **Run the script:**
   ```bash
   cd /home/runner/work/BabyTracker/BabyTracker
   ./create_phase1_issues.sh
   ```

3. **Verify issues were created:**
   ```bash
   gh issue list --repo janzmarcus-cmyk/BabyTracker
   ```
   Or visit: https://github.com/janzmarcus-cmyk/BabyTracker/issues

## Option 2: Manual Creation

1. Open the `PHASE1_ISSUES.md` file
2. For each issue:
   - Go to: https://github.com/janzmarcus-cmyk/BabyTracker/issues/new
   - Copy the **Title** from `PHASE1_ISSUES.md`
   - Copy the **Body** (without the backticks) from `PHASE1_ISSUES.md`
   - Click "Submit new issue"
3. Repeat for all 6 issues

## Option 3: Using GitHub API

If you prefer to use the GitHub REST API with a personal access token:

```bash
# Set your token
export GITHUB_TOKEN="your_token_here"

# Example for creating one issue
curl -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/janzmarcus-cmyk/BabyTracker/issues \
  -d '{"title":"Task 1.1: Gradle-Projekt initialisieren","body":"[copy body from PHASE1_ISSUES.md]"}'
```

## What Happens Next?

After creating these issues:
1. Each issue can be assigned to team members
2. As tasks are completed, the assignee should:
   - Update the `to-do.md` file
   - Change `[ ]` to `[x]` for the completed task
   - Close the issue
   - Reference the issue in their commit (e.g., "Fixes #123")

## Issues to be Created

1. Task 1.1: Gradle-Projekt initialisieren
2. Task 1.2: App-Modul Build-Script konfigurieren  
3. Task 1.3: Gradle Version Catalog erstellen
4. Task 1.4: Android Manifest erstellen
5. Task 1.5: Application-Klasse erstellen
6. Task 1.6: Git-Ignore konfigurieren

All issues follow the template provided in the original request with:
- Task description from `to-do.md`
- Context & rules
- Goal statement
