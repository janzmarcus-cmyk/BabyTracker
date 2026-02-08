# BabyTracker Dev Container

This directory contains the Dev Container configuration for the BabyTracker Android application. Dev Containers provide a consistent, reproducible development environment using Docker.

## What's Included

### Development Tools
- **Java Development Kit (JDK) 17**: Required for Kotlin and Android development
- **Android SDK**: 
  - Platform Tools
  - API levels 26 (Android 8.0 - Min SDK) to 34 (Android 14 - Target SDK)
  - Build Tools 33.0.2 and 34.0.0
  - Android Emulator with system images
- **Gradle 8.5**: Build automation tool (Kotlin DSL support)
- **ktlint**: Kotlin linter for code quality
- **Git & GitHub CLI**: Version control and GitHub integration
- **Node.js LTS**: For Firebase tools and other utilities

### VS Code Extensions
- **Kotlin Language Support**: Syntax highlighting, IntelliSense, and debugging
- **Java Extension Pack**: Complete Java development support
- **Gradle for Java**: Gradle build integration
- **Firebase Tools**: Firebase integration and deployment
- **GitLens**: Enhanced Git capabilities
- **EditorConfig**: Consistent coding styles
- **Code Spell Checker**: Catch typos in code and comments

### Environment Variables
- `ANDROID_HOME`: Android SDK root directory
- `ANDROID_SDK_ROOT`: Android SDK root directory (alternative name)
- `JAVA_HOME`: Java installation directory
- `PATH`: Includes Android SDK tools, platform-tools, and emulator

## Usage

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop) installed
- [Visual Studio Code](https://code.visualstudio.com/) installed
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed in VS Code

### Getting Started

1. **Open the Project in Dev Container**
   - Open the project folder in VS Code
   - Press `F1` and select "Dev Containers: Reopen in Container"
   - Wait for the container to build and setup to complete (first time may take 10-15 minutes)

2. **Verify Setup**
   ```bash
   # Check Java version
   java -version
   
   # Check Gradle version
   gradle --version
   
   # Check Android SDK
   echo $ANDROID_HOME
   sdkmanager --list_installed
   
   # Check ktlint
   ktlint --version
   ```

3. **Start Development**
   ```bash
   # When the Android project is initialized, you can:
   
   # Build the project
   ./gradlew build
   
   # Run tests
   ./gradlew test
   
   # Run instrumented tests (requires emulator or device)
   ./gradlew connectedAndroidTest
   
   # Check code quality
   ./gradlew detekt
   ktlint --format
   ```

### Firebase Setup

The project uses Firebase Firestore for data synchronization. To set it up:

1. Create a Firebase project at https://console.firebase.google.com
2. Add an Android app to your Firebase project
3. Download the `google-services.json` file
4. Place it in the `app/` directory of the project
5. The file is git-ignored and won't be committed

### Using Android Emulator

The container is configured with `--privileged` flag to support Android emulator:

```bash
# List available system images
sdkmanager --list

# Create an AVD (Android Virtual Device)
avdmanager create avd -n test_device -k "system-images;android-34;google_apis;x86_64"

# Start the emulator
emulator -avd test_device &

# List connected devices
adb devices
```

### Testing

```bash
# Run unit tests
./gradlew test

# Run unit tests with coverage
./gradlew testDebugUnitTest

# Run instrumented tests (requires emulator or device)
./gradlew connectedAndroidTest

# Run specific test class
./gradlew test --tests "com.babytracker.data.repository.FeedingRepositoryTest"
```

### Code Quality

```bash
# Run Detekt static analysis
./gradlew detekt

# Format code with ktlint
ktlint --format "**/*.kt"

# Check code style without formatting
ktlint "**/*.kt"
```

## Project Structure

Based on the project's to-do.md, the expected structure is:

```
BabyTracker/
├── .devcontainer/           # Dev Container configuration (this directory)
├── app/                     # Android application module
│   ├── src/
│   │   ├── main/           # Main source code
│   │   ├── test/           # Unit tests
│   │   └── androidTest/    # Instrumented tests
│   ├── build.gradle.kts    # App-level build configuration
│   └── google-services.json # Firebase config (not in git)
├── build.gradle.kts         # Root build configuration
├── settings.gradle.kts      # Gradle settings
├── gradle.properties        # Gradle properties
└── README.md               # Project documentation
```

## Tech Stack

- **Language**: Kotlin 1.9+
- **Build System**: Gradle 8.x with Kotlin DSL
- **Min SDK**: 26 (Android 8.0)
- **Target SDK**: 34 (Android 14)
- **UI Framework**: Jetpack Compose with Material 3
- **Architecture**: MVVM with ViewModel and StateFlow
- **Dependency Injection**: Hilt (Dagger-Hilt)
- **Local Database**: Room 2.6+
- **Remote Database**: Firebase Firestore
- **Navigation**: Jetpack Navigation Compose
- **Testing**: JUnit 4, Mockito/MockK, Espresso, Compose UI Testing
- **Code Quality**: Detekt, ktlint

## Troubleshooting

### Container Build Issues
- **Problem**: Container takes too long to build
  - **Solution**: First build downloads Android SDK components, which is large. Subsequent builds are much faster.

- **Problem**: Out of disk space
  - **Solution**: Clean up Docker images and containers: `docker system prune -a`

### Android SDK Issues
- **Problem**: sdkmanager command not found
  - **Solution**: Restart the terminal or reload VS Code window to refresh environment variables

- **Problem**: License acceptance issues
  - **Solution**: Run `sdkmanager --licenses` and accept all licenses

### Gradle Issues
- **Problem**: Gradle daemon issues
  - **Solution**: Kill Gradle daemons: `./gradlew --stop`

- **Problem**: Dependency resolution failures
  - **Solution**: Clear Gradle cache: `rm -rf ~/.gradle/caches/`

## Customization

### Adding More Android API Levels
Edit `.devcontainer/setup.sh` and add more platforms to the sdkmanager command:
```bash
"platforms;android-35" \
```

### Adding VS Code Extensions
Edit `.devcontainer/devcontainer.json` and add extension IDs to the `extensions` array.

### Changing Java Version
Edit the `features` section in `.devcontainer/devcontainer.json`:
```json
"ghcr.io/devcontainers/features/java:1": {
    "version": "21",
    "jdkDistro": "ms"
}
```

## Resources

- [Dev Containers Documentation](https://containers.dev/)
- [Android Development Documentation](https://developer.android.com/docs)
- [Kotlin Documentation](https://kotlinlang.org/docs/home.html)
- [Jetpack Compose Documentation](https://developer.android.com/jetpack/compose)
- [Firebase Documentation](https://firebase.google.com/docs)

## Contributing

When modifying the dev container configuration:
1. Test changes locally before committing
2. Document any new tools or extensions added
3. Update this README with any configuration changes
4. Consider backwards compatibility with existing setups
