#!/bin/bash
# Script to create GitHub issues for Phase 1 tasks from to-do.md

# Define the repository (owner/repo format)
REPO="janzmarcus-cmyk/BabyTracker"

# Task 1.1
gh issue create --repo "$REPO" --title "Task 1.1: Gradle-Projekt initialisieren" --body "Ich möchte den folgenden Task aus meiner \`to-do.md\` abarbeiten:

### Task Beschreibung:
- **Datei:** \`build.gradle.kts\` (Root-Level)
- **Logik:**
  - Definiere Kotlin Version \`1.9.20\`
  - Füge Classpath-Dependencies für Hilt (\`com.google.dagger:hilt-android-gradle-plugin:2.48\`) und Google Services hinzu
  - Konfiguriere \`buildscript\` Block mit Maven Central und Google Repositories
- **Output:** Funktionierendes Root-Build-Script

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die \`to-do.md\` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht."

echo "Created issue for Task 1.1"

# Task 1.2
gh issue create --repo "$REPO" --title "Task 1.2: App-Modul Build-Script konfigurieren" --body "Ich möchte den folgenden Task aus meiner \`to-do.md\` abarbeiten:

### Task Beschreibung:
- **Datei:** \`app/build.gradle.kts\`
- **Logik:**
  - Setze \`compileSdk = 34\`, \`minSdk = 26\`, \`targetSdk = 34\`
  - Aktiviere Jetpack Compose: \`compose = true\` mit \`kotlinCompilerExtensionVersion = \"1.5.4\"\`
  - Füge Dependencies hinzu:
    - Compose BOM: \`androidx.compose:compose-bom:2023.10.01\`
    - Compose UI, Material3, Navigation
    - Hilt: \`com.google.dagger:hilt-android:2.48\` + kapt
    - Room: \`androidx.room:room-runtime:2.6.0\`, \`androidx.room:room-ktx:2.6.0\`, ksp
    - Firebase: \`com.google.firebase:firebase-firestore-ktx:24.9.1\`
    - Timber: \`com.jakewharton.timber:timber:5.0.1\`
    - Testing: JUnit, MockK, Turbine (für Flow-Testing)
  - Konfiguriere \`kapt\` und \`ksp\` Plugins
- **Output:** Vollständiges App-Build-Script mit allen Dependencies

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die \`to-do.md\` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht."

echo "Created issue for Task 1.2"

# Task 1.3
gh issue create --repo "$REPO" --title "Task 1.3: Gradle Version Catalog erstellen" --body "Ich möchte den folgenden Task aus meiner \`to-do.md\` abarbeiten:

### Task Beschreibung:
- **Datei:** \`gradle/libs.versions.toml\`
- **Logik:**
  - Definiere \`[versions]\` Block mit allen Library-Versionen
  - Definiere \`[libraries]\` Block mit qualifizierten Artifact-Namen
  - Definiere \`[plugins]\` Block für AGP, Kotlin, Hilt, KSP
- **Output:** Zentralisierte Dependency-Verwaltung

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die \`to-do.md\` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht."

echo "Created issue for Task 1.3"

# Task 1.4
gh issue create --repo "$REPO" --title "Task 1.4: Android Manifest erstellen" --body "Ich möchte den folgenden Task aus meiner \`to-do.md\` abarbeiten:

### Task Beschreibung:
- **Datei:** \`app/src/main/AndroidManifest.xml\`
- **Logik:**
  - Setze Package Name: \`com.babytracker\`
  - Definiere \`<application>\` mit \`android:name=\".BabyTrackerApplication\"\`
  - Füge \`INTERNET\` und \`ACCESS_NETWORK_STATE\` Permissions hinzu
  - Deklariere MainActivity mit \`android:exported=\"true\"\` und MAIN/LAUNCHER Intent-Filter
  - Setze \`android:theme=\"@android:style/Theme.Material3.DayNight.NoActionBar\"\`
- **Output:** Gültiges Manifest

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die \`to-do.md\` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht."

echo "Created issue for Task 1.4"

# Task 1.5
gh issue create --repo "$REPO" --title "Task 1.5: Application-Klasse erstellen" --body "Ich möchte den folgenden Task aus meiner \`to-do.md\` abarbeiten:

### Task Beschreibung:
- **Datei:** \`app/src/main/java/com/babytracker/BabyTrackerApplication.kt\`
- **Logik:**
  - Klasse erbt von \`Application()\`
  - Annotiere mit \`@HiltAndroidApp\`
  - Überschreibe \`onCreate()\` und initialisiere Timber:
    \`\`\`kotlin
    override fun onCreate() {
        super.onCreate()
        if (BuildConfig.DEBUG) {
            Timber.plant(Timber.DebugTree())
        }
    }
    \`\`\`
- **Output:** Hilt-fähige Application-Klasse

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die \`to-do.md\` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht."

echo "Created issue for Task 1.5"

# Task 1.6
gh issue create --repo "$REPO" --title "Task 1.6: Git-Ignore konfigurieren" --body "Ich möchte den folgenden Task aus meiner \`to-do.md\` abarbeiten:

### Task Beschreibung:
- **Datei:** \`.gitignore\`
- **Logik:**
  - Füge Standard-Android-Ignore-Patterns hinzu: \`.gradle/\`, \`build/\`, \`*.iml\`, \`.idea/\`, \`local.properties\`, \`.DS_Store\`
  - Füge Firebase-Config hinzu: \`google-services.json\`
- **Output:** Sauberes Repository

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die \`to-do.md\` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht."

echo "Created issue for Task 1.6"

echo ""
echo "All Phase 1 issues created successfully!"
echo "Total: 6 issues created"
