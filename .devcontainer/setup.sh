#!/bin/bash
set -e

echo "🚀 Setting up BabyTracker Android Development Environment..."

# Update package lists
echo "📦 Updating package lists..."
sudo apt-get update

# Install essential tools
echo "🔧 Installing essential development tools..."
sudo apt-get install -y \
    wget \
    unzip \
    curl \
    git \
    build-essential \
    libssl-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev

# Install Android SDK
ANDROID_SDK_ROOT="/opt/android-sdk"
ANDROID_HOME="${ANDROID_SDK_ROOT}"
CMDLINE_TOOLS_VERSION="11076708"  # Latest as of creation

if [ ! -d "$ANDROID_SDK_ROOT" ]; then
    echo "📱 Installing Android SDK..."
    sudo mkdir -p "$ANDROID_SDK_ROOT"
    sudo chown -R vscode:vscode "$ANDROID_SDK_ROOT"
    
    cd /tmp
    wget -q "https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_TOOLS_VERSION}_latest.zip" -O cmdline-tools.zip
    unzip -q cmdline-tools.zip
    mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools"
    mv cmdline-tools "$ANDROID_SDK_ROOT/cmdline-tools/latest"
    rm cmdline-tools.zip
    
    # Accept licenses
    yes | "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager" --licenses || true
    
    # Install required SDK components based on to-do.md requirements
    echo "📱 Installing Android SDK components (API 26-34)..."
    "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager" \
        "platform-tools" \
        "platforms;android-34" \
        "platforms;android-33" \
        "platforms;android-26" \
        "build-tools;34.0.0" \
        "build-tools;33.0.2" \
        "emulator" \
        "system-images;android-34;google_apis;x86_64"
    
    echo "✅ Android SDK installed successfully"
else
    echo "✅ Android SDK already installed"
fi

# Install Gradle (if not already installed)
if ! command -v gradle &> /dev/null; then
    echo "🔨 Installing Gradle..."
    GRADLE_VERSION="8.5"
    cd /tmp
    wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -O gradle.zip
    sudo unzip -q gradle.zip -d /opt
    sudo ln -sf "/opt/gradle-${GRADLE_VERSION}/bin/gradle" /usr/local/bin/gradle
    rm gradle.zip
    echo "✅ Gradle ${GRADLE_VERSION} installed successfully"
else
    echo "✅ Gradle already installed: $(gradle --version | head -1)"
fi

# Install ktlint for code quality
if ! command -v ktlint &> /dev/null; then
    echo "🧹 Installing ktlint..."
    cd /tmp
    wget -q "https://github.com/pinterest/ktlint/releases/download/1.1.1/ktlint" -O ktlint
    chmod +x ktlint
    sudo mv ktlint /usr/local/bin/ktlint
    echo "✅ ktlint installed successfully"
else
    echo "✅ ktlint already installed"
fi

# Set up environment for current session
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export ANDROID_SDK_ROOT="$ANDROID_SDK_ROOT"
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator"

# Add to bashrc and zshrc for persistent environment
echo "" >> ~/.bashrc
echo "# Android SDK" >> ~/.bashrc
echo "export ANDROID_HOME=$ANDROID_SDK_ROOT" >> ~/.bashrc
echo "export ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT" >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator' >> ~/.bashrc

if [ -f ~/.zshrc ]; then
    echo "" >> ~/.zshrc
    echo "# Android SDK" >> ~/.zshrc
    echo "export ANDROID_HOME=$ANDROID_SDK_ROOT" >> ~/.zshrc
    echo "export ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT" >> ~/.zshrc
    echo 'export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator' >> ~/.zshrc
fi

# Display versions
echo ""
echo "✅ Development environment setup complete!"
echo ""
echo "📋 Installed versions:"
echo "  - Java: $(java -version 2>&1 | head -1)"
echo "  - Gradle: $(gradle --version 2>&1 | grep Gradle | head -1)"
echo "  - Android SDK: $ANDROID_SDK_ROOT"
echo "  - ktlint: $(ktlint --version 2>&1 || echo 'installed')"
echo ""
echo "🎯 Ready to develop BabyTracker!"
echo ""
echo "📝 Next steps:"
echo "  1. Create Firebase project and add google-services.json"
echo "  2. Run './gradlew build' to build the project"
echo "  3. Run './gradlew test' to run tests"
echo "  4. Use Android emulator or connect physical device for testing"
echo ""
