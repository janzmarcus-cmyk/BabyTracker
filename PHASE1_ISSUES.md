# Phase 1 GitHub Issues

This document contains all the issues that need to be created for Phase 1 tasks from `to-do.md`.

## Summary
- **Total Issues:** 6
- **Phase:** Phase 1 - Projekt-Setup und Grundkonfiguration
- All tasks are currently marked as open `[ ]` in `to-do.md`

---

## Issue 1: Task 1.1: Gradle-Projekt initialisieren

**Title:** Task 1.1: Gradle-Projekt initialisieren

**Body:**
```
Ich möchte den folgenden Task aus meiner `to-do.md` abarbeiten:

### Task Beschreibung:
- **Datei:** `build.gradle.kts` (Root-Level)
- **Logik:**
  - Definiere Kotlin Version `1.9.20`
  - Füge Classpath-Dependencies für Hilt (`com.google.dagger:hilt-android-gradle-plugin:2.48`) und Google Services hinzu
  - Konfiguriere `buildscript` Block mit Maven Central und Google Repositories
- **Output:** Funktionierendes Root-Build-Script

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die `to-do.md` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht.
```

---

## Issue 2: Task 1.2: App-Modul Build-Script konfigurieren

**Title:** Task 1.2: App-Modul Build-Script konfigurieren

**Body:**
```
Ich möchte den folgenden Task aus meiner `to-do.md` abarbeiten:

### Task Beschreibung:
- **Datei:** `app/build.gradle.kts`
- **Logik:**
  - Setze `compileSdk = 34`, `minSdk = 26`, `targetSdk = 34`
  - Aktiviere Jetpack Compose: `compose = true` mit `kotlinCompilerExtensionVersion = "1.5.4"`
  - Füge Dependencies hinzu:
    - Compose BOM: `androidx.compose:compose-bom:2023.10.01`
    - Compose UI, Material3, Navigation
    - Hilt: `com.google.dagger:hilt-android:2.48` + kapt
    - Room: `androidx.room:room-runtime:2.6.0`, `androidx.room:room-ktx:2.6.0`, ksp
    - Firebase: `com.google.firebase:firebase-firestore-ktx:24.9.1`
    - Timber: `com.jakewharton.timber:timber:5.0.1`
    - Testing: JUnit, MockK, Turbine (für Flow-Testing)
  - Konfiguriere `kapt` und `ksp` Plugins
- **Output:** Vollständiges App-Build-Script mit allen Dependencies

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die `to-do.md` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht.
```

---

## Issue 3: Task 1.3: Gradle Version Catalog erstellen

**Title:** Task 1.3: Gradle Version Catalog erstellen

**Body:**
```
Ich möchte den folgenden Task aus meiner `to-do.md` abarbeiten:

### Task Beschreibung:
- **Datei:** `gradle/libs.versions.toml`
- **Logik:**
  - Definiere `[versions]` Block mit allen Library-Versionen
  - Definiere `[libraries]` Block mit qualifizierten Artifact-Namen
  - Definiere `[plugins]` Block für AGP, Kotlin, Hilt, KSP
- **Output:** Zentralisierte Dependency-Verwaltung

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die `to-do.md` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht.
```

---

## Issue 4: Task 1.4: Android Manifest erstellen

**Title:** Task 1.4: Android Manifest erstellen

**Body:**
```
Ich möchte den folgenden Task aus meiner `to-do.md` abarbeiten:

### Task Beschreibung:
- **Datei:** `app/src/main/AndroidManifest.xml`
- **Logik:**
  - Setze Package Name: `com.babytracker`
  - Definiere `<application>` mit `android:name=".BabyTrackerApplication"`
  - Füge `INTERNET` und `ACCESS_NETWORK_STATE` Permissions hinzu
  - Deklariere MainActivity mit `android:exported="true"` und MAIN/LAUNCHER Intent-Filter
  - Setze `android:theme="@android:style/Theme.Material3.DayNight.NoActionBar"`
- **Output:** Gültiges Manifest

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die `to-do.md` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht.
```

---

## Issue 5: Task 1.5: Application-Klasse erstellen

**Title:** Task 1.5: Application-Klasse erstellen

**Body:**
```
Ich möchte den folgenden Task aus meiner `to-do.md` abarbeiten:

### Task Beschreibung:
- **Datei:** `app/src/main/java/com/babytracker/BabyTrackerApplication.kt`
- **Logik:**
  - Klasse erbt von `Application()`
  - Annotiere mit `@HiltAndroidApp`
  - Überschreibe `onCreate()` und initialisiere Timber:
    ```kotlin
    override fun onCreate() {
        super.onCreate()
        if (BuildConfig.DEBUG) {
            Timber.plant(Timber.DebugTree())
        }
    }
    ```
- **Output:** Hilt-fähige Application-Klasse

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die `to-do.md` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht.
```

---

## Issue 6: Task 1.6: Git-Ignore konfigurieren

**Title:** Task 1.6: Git-Ignore konfigurieren

**Body:**
```
Ich möchte den folgenden Task aus meiner `to-do.md` abarbeiten:

### Task Beschreibung:
- **Datei:** `.gitignore`
- **Logik:**
  - Füge Standard-Android-Ignore-Patterns hinzu: `.gradle/`, `build/`, `*.iml`, `.idea/`, `local.properties`, `.DS_Store`
  - Füge Firebase-Config hinzu: `google-services.json`
- **Output:** Sauberes Repository

### Kontext & Regeln:
- Beachte die bestehende Projektstruktur aus dem vorherigen Setup-Task.
- Nutze für die Umsetzung **GPT 5.2 Mini**.
- Wichtig: Wenn die Implementierung abgeschlossen ist, aktualisiere die `to-do.md` im Repository und markiere diesen Task als erledigt [x].

### Ziel:
Stelle sicher, dass der Code kompiliert und den Anforderungen des Tasks entspricht.
```

---

## How to Create These Issues

### Option 1: Manual Creation
Copy each issue title and body above and create them manually in the GitHub web interface at:
https://github.com/janzmarcus-cmyk/BabyTracker/issues/new

### Option 2: Using the Script
Run the provided `create_phase1_issues.sh` script after authenticating with GitHub CLI:
```bash
gh auth login
./create_phase1_issues.sh
```

### Option 3: Using GitHub REST API
You can also use the GitHub REST API with a personal access token to create these issues programmatically.
