# GitHub Actions Workflows

This repository includes two GitHub Actions workflows that run automatically on pull requests:

## 1. Run Tests (`test.yml`)

**Triggers:** Pull requests and pushes to `main` and `develop` branches

**What it does:**
- Sets up Java 17 and Android SDK
- Runs all tests using `./gradlew test --continue`
  - Auto-discovers all test tasks in the project
  - Continues running even if some tests fail to get complete results
- Uploads test reports as artifacts (available for 30 days)
- Publishes test results in the PR comments

**Test Discovery:**
The `./gradlew test` command automatically discovers and runs all test tasks across all modules, including:
- Unit tests (`test`)
- Local unit tests
- Any custom test configurations

## 2. Build Android APK (`build-apk.yml`)

**Triggers:** Pull requests and pushes to `main` and `develop` branches

**What it does:**
- Sets up Java 17 and Android SDK
- Builds the debug APK using `./gradlew assembleDebug`
- Uploads the APK as an artifact (available for 30 days)
- Comments on the PR with a success message

**Downloading the APK:**
1. Go to the workflow run in the "Actions" tab
2. Scroll to the "Artifacts" section at the bottom
3. Download the `app-debug` artifact
4. Extract and install the APK on your Android device

## Making Workflows Required (Blocking PRs)

To make these workflows block pull requests when they fail:

1. Go to repository **Settings** → **Branches**
2. Add or edit a branch protection rule for `main` (and `develop` if desired)
3. Enable **"Require status checks to pass before merging"**
4. Search for and select:
   - `test` (from Run Tests workflow)
   - `build` (from Build Android APK workflow)
5. Save the protection rule

Once configured, pull requests cannot be merged unless both workflows pass successfully.

## Workflow Features

### Caching
Both workflows use Gradle caching to speed up builds by caching dependencies between runs.

### Artifacts
- **Test Reports**: HTML and XML test results are uploaded for 30 days
- **APK**: The built APK is available for download for 30 days

### Failure Handling
- Test workflow continues even if some tests fail (`--continue` flag)
- Test results are published even when tests fail (`if: always()`)
- APK build workflow shows detailed stack traces for debugging (`--stacktrace` flag)

## Local Testing

To run the same commands locally:

```bash
# Run all tests
./gradlew test

# Build debug APK
./gradlew assembleDebug
```
