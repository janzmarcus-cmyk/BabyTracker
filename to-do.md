# BabyTracker - Comprehensive Development Plan

## 1. Projekt-Metadaten

### Projekt-Zusammenfassung
BabyTracker ist eine Android-Anwendung für Eltern zur Erfassung und Visualisierung von Baby-Fütterungen. Die App ermöglicht das Tracking von Milchmengen (ml), Milchtyp (Muttermilch/Formula), Zeitstempel und bietet ein Dashboard mit gestapeltem Balkendiagramm. Die Daten werden zwischen Partnern über Firebase Firestore synchronisiert, mit Offline-Support durch Room Database.

### Tech-Stack
- **Sprache:** Kotlin 1.9+
- **Build-System:** Gradle 8.x mit Kotlin DSL
- **Min SDK:** 26 (Android 8.0)
- **Target SDK:** 34 (Android 14)
- **Compose:** Jetpack Compose 1.5+ (Material 3)
- **Architektur:** MVVM mit ViewModel + StateFlow/Flow
- **Dependency Injection:** Hilt (Dagger-Hilt)
- **Local Database:** Room 2.6+
- **Remote Database:** Firebase Firestore
- **Navigation:** Jetpack Navigation Compose
- **Charts:** Vico Chart Library oder MPAndroidChart mit Compose-Wrapper
- **Testing:** JUnit 4, Mockito/MockK, Espresso, Compose UI Testing
- **Code Quality:** Detekt, ktlint
- **Version Control:** Git + GitHub

---

## 2. Verzeichnisstruktur

```
BabyTracker/
├── app/
│   ├── build.gradle.kts
│   ├── proguard-rules.pro
│   └── src/
│       ├── main/
│       │   ├── AndroidManifest.xml
│       │   ├── java/com/babytracker/
│       │   │   ├── BabyTrackerApplication.kt
│       │   │   ├── di/
│       │   │   │   ├── AppModule.kt
│       │   │   │   ├── DatabaseModule.kt
│       │   │   │   └── FirebaseModule.kt
│       │   │   ├── data/
│       │   │   │   ├── model/
│       │   │   │   │   ├── FeedingEntry.kt
│       │   │   │   │   ├── MilkType.kt
│       │   │   │   │   └── SyncStatus.kt
│       │   │   │   ├── local/
│       │   │   │   │   ├── BabyTrackerDatabase.kt
│       │   │   │   │   ├── FeedingDao.kt
│       │   │   │   │   └── Converters.kt
│       │   │   │   ├── remote/
│       │   │   │   │   ├── FirestoreService.kt
│       │   │   │   │   └── FirestoreConstants.kt
│       │   │   │   ├── repository/
│       │   │   │   │   ├── FeedingRepository.kt
│       │   │   │   │   └── FeedingRepositoryImpl.kt
│       │   │   │   └── sync/
│       │   │   │       ├── SyncManager.kt
│       │   │   │       └── SyncWorker.kt
│       │   │   ├── domain/
│       │   │   │   ├── model/
│       │   │   │   │   ├── DailyFeedingSummary.kt
│       │   │   │   │   └── FeedingStats.kt
│       │   │   │   └── usecase/
│       │   │   │       ├── AddFeedingUseCase.kt
│       │   │   │       ├── GetDailyFeedingsUseCase.kt
│       │   │   │       ├── GetFeedingStatsUseCase.kt
│       │   │   │       └── ShareProjectUseCase.kt
│       │   │   ├── ui/
│       │   │   │   ├── theme/
│       │   │   │   │   ├── Color.kt
│       │   │   │   │   ├── Theme.kt
│       │   │   │   │   └── Type.kt
│       │   │   │   ├── components/
│       │   │   │   │   ├── StackedBarChart.kt
│       │   │   │   │   ├── DateNavigationBar.kt
│       │   │   │   │   ├── AddFeedingButton.kt
│       │   │   │   │   └── FeedingDialog.kt
│       │   │   │   ├── home/
│       │   │   │   │   ├── HomeScreen.kt
│       │   │   │   │   ├── HomeViewModel.kt
│       │   │   │   │   └── HomeUiState.kt
│       │   │   │   ├── addfeed/
│       │   │   │   │   ├── AddFeedingScreen.kt
│       │   │   │   │   ├── AddFeedingViewModel.kt
│       │   │   │   │   └── AddFeedingUiState.kt
│       │   │   │   ├── share/
│       │   │   │   │   ├── ShareProjectScreen.kt
│       │   │   │   │   ├── ShareProjectViewModel.kt
│       │   │   │   │   └── ShareProjectUiState.kt
│       │   │   │   └── navigation/
│       │   │   │       ├── NavGraph.kt
│       │   │   │       └── Screen.kt
│       │   │   └── util/
│       │   │       ├── DateUtils.kt
│       │   │       ├── NetworkMonitor.kt
│       │   │       └── Result.kt
│       │   └── res/
│       │       ├── values/
│       │       │   ├── strings.xml
│       │       │   └── colors.xml
│       │       └── drawable/
│       │           └── ic_launcher.xml
│       ├── androidTest/
│       │   └── java/com/babytracker/
│       │       ├── data/
│       │       │   └── local/
│       │       │       └── FeedingDaoTest.kt
│       │       └── ui/
│       │           └── HomeScreenTest.kt
│       └── test/
│           └── java/com/babytracker/
│               ├── data/
│               │   └── repository/
│               │       └── FeedingRepositoryTest.kt
│               ├── domain/
│               │   └── usecase/
│               │       └── AddFeedingUseCaseTest.kt
│               └── ui/
│                   └── home/
│                       └── HomeViewModelTest.kt
├── build.gradle.kts
├── settings.gradle.kts
├── gradle.properties
├── gradle/
│   └── wrapper/
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── .gitignore
├── README.md
└── to-do.md
```

---

## 3. Globale Constraints

### 3.1 Coding Standards
- **Naming Conventions:**
  - Klassen: PascalCase (z.B. `FeedingRepository`)
  - Funktionen/Variablen: camelCase (z.B. `getFeedingEntries`)
  - Konstanten: SCREAMING_SNAKE_CASE (z.B. `MAX_RETRY_ATTEMPTS`)
  - Composables: PascalCase mit "Screen" oder "Component" Suffix (z.B. `HomeScreen`, `StackedBarChart`)
- **Package-Struktur:** Strikte Trennung nach Feature/Layer (data, domain, ui)
- **Kotlin Best Practices:**
  - Nutze `data class` für Models mit automatischen equals/hashCode
  - Bevorzuge `sealed class` für Zustandsrepräsentation
  - Nutze `Flow` statt LiveData für reaktive Streams
  - Bevorzuge `inline value class` für Type-Safety bei Primitiven
- **Compose Best Practices:**
  - State Hoisting: UI-Komponenten erhalten State als Parameter
  - Keine ViewModel-Referenzen in wiederverwendbaren Composables
  - Nutze `remember` und `rememberSaveable` korrekt
  - Separate Vorschau-Funktionen mit `@Preview` Annotation

### 3.2 Error-Handling-Strategie
- **Custom Exceptions:**
  ```kotlin
  sealed class BabyTrackerException(message: String) : Exception(message) {
      class DatabaseException(message: String, cause: Throwable? = null) : BabyTrackerException(message)
      class NetworkException(message: String, cause: Throwable? = null) : BabyTrackerException(message)
      class ValidationException(message: String) : BabyTrackerException(message)
      class FirebaseException(message: String, cause: Throwable? = null) : BabyTrackerException(message)
  }
  ```
- **Result Wrapper:**
  ```kotlin
  sealed class Result<out T> {
      data class Success<T>(val data: T) : Result<T>()
      data class Error(val exception: BabyTrackerException) : Result<Nothing>()
      object Loading : Result<Nothing>()
  }
  ```
- **Repository Layer:** Alle Exceptions fangen und in `Result.Error` wrappen
- **ViewModel Layer:** Result-States in UI-States transformieren
- **UI Layer:** Error-Messages nutzerfreundlich anzeigen (Snackbar, Dialog)

### 3.3 Logging-Vorgaben
- **Logging-Library:** Timber
- **Log-Levels:**
  - `Timber.d()` für Debug-Informationen (z.B. State-Changes)
  - `Timber.i()` für wichtige App-Ereignisse (z.B. Sync erfolgreich)
  - `Timber.w()` für Warnungen (z.B. Retry-Logik)
  - `Timber.e()` für Fehler mit Throwable
- **Naming:** Logs müssen Kontext enthalten (z.B. `"[FeedingRepository] Fetching entries for date: $date"`)
- **Sensitive Data:** Keine personenbezogenen Daten in Production-Logs

### 3.4 Testing-Requirements
- **Unit Tests:**
  - Alle UseCases müssen zu 100% getestet sein
  - Repository-Tests mit Fake/Mock DAOs und Firestore
  - ViewModel-Tests mit `UnconfinedTestDispatcher` für Coroutinen
- **Integration Tests:**
  - Room DAO Tests mit In-Memory-Datenbank
  - Repository-Tests mit echtem Room DB
- **UI Tests:**
  - Compose UI Tests für kritische Screens (HomeScreen, AddFeedingScreen)
  - Navigation-Tests für alle Flows
- **Code Coverage:** Mindestens 80% für domain- und data-Layer
- **Test-Naming:** `methodName_stateUnderTest_expectedBehavior` (z.B. `addFeeding_withValidInput_returnsSuccess`)

### 3.5 Dependency-Management
- **Version Catalogs:** Nutze `libs.versions.toml` für zentrale Dependency-Verwaltung
- **Keine Hardcoded Versions** in build.gradle.kts

### 3.6 Offline-First-Strategie
- **Schreiboperationen:** Immer zuerst in Room schreiben, dann asynchron zu Firestore syncen
- **Leseoperationen:** Primär aus Room lesen, Firestore als Sync-Quelle
- **Conflict Resolution:** Last-Write-Wins mit Timestamp-Vergleich

---
## 4. Task-Liste

### Phase 1: Projekt-Setup und Grundkonfiguration

#### [ ] Task 1.1: Gradle-Projekt initialisieren
- **Datei:** `build.gradle.kts` (Root-Level)
- **Logik:**
  - Definiere Kotlin Version `1.9.20`
  - Füge Classpath-Dependencies für Hilt (`com.google.dagger:hilt-android-gradle-plugin:2.48`) und Google Services hinzu
  - Konfiguriere `buildscript` Block mit Maven Central und Google Repositories
- **Output:** Funktionierendes Root-Build-Script

#### [ ] Task 1.2: App-Modul Build-Script konfigurieren
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

#### [x] Task 1.3: Gradle Version Catalog erstellen
- **Datei:** `gradle/libs.versions.toml`
- **Logik:**
  - Definiere `[versions]` Block mit allen Library-Versionen
  - Definiere `[libraries]` Block mit qualifizierten Artifact-Namen
  - Definiere `[plugins]` Block für AGP, Kotlin, Hilt, KSP
- **Output:** Zentralisierte Dependency-Verwaltung

#### [ ] Task 1.4: Android Manifest erstellen
- **Datei:** `app/src/main/AndroidManifest.xml`
- **Logik:**
  - Setze Package Name: `com.babytracker`
  - Definiere `<application>` mit `android:name=".BabyTrackerApplication"`
  - Füge `INTERNET` und `ACCESS_NETWORK_STATE` Permissions hinzu
  - Deklariere MainActivity mit `android:exported="true"` und MAIN/LAUNCHER Intent-Filter
  - Setze `android:theme="@android:style/Theme.Material3.DayNight.NoActionBar"`
- **Output:** Gültiges Manifest

#### [ ] Task 1.5: Application-Klasse erstellen
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

#### [ ] Task 1.6: Git-Ignore konfigurieren
- **Datei:** `.gitignore`
- **Logik:**
  - Füge Standard-Android-Ignore-Patterns hinzu: `.gradle/`, `build/`, `*.iml`, `.idea/`, `local.properties`, `.DS_Store`
  - Füge Firebase-Config hinzu: `google-services.json`
- **Output:** Sauberes Repository

---

### Phase 2: Data Layer - Models und Enums

#### [ ] Task 2.1: MilkType Enum erstellen
- **Datei:** `app/src/main/java/com/babytracker/data/model/MilkType.kt`
- **Logik:**
  - Definiere `enum class MilkType` mit Werten: `BREAST_MILK`, `FORMULA`
  - Füge Property `displayName: String` hinzu (z.B. "Muttermilch", "Formula")
- **Output:** Type-Safe Enum für Milchtypen

#### [ ] Task 2.2: SyncStatus Enum erstellen
- **Datei:** `app/src/main/java/com/babytracker/data/model/SyncStatus.kt`
- **Logik:**
  - Definiere `enum class SyncStatus` mit Werten: `PENDING`, `SYNCED`, `FAILED`
- **Output:** Enum für Sync-Status-Tracking

#### [ ] Task 2.3: FeedingEntry Entity erstellen
- **Datei:** `app/src/main/java/com/babytracker/data/model/FeedingEntry.kt`
- **Logik:**
  - Annotiere mit `@Entity(tableName = "feeding_entries")`
  - Properties:
    - `@PrimaryKey val id: String = UUID.randomUUID().toString()`
    - `val amountMl: Int` (Validierung: > 0)
    - `val milkType: MilkType`
    - `val timestamp: Long` (Unix Epoch Milliseconds)
    - `val syncStatus: SyncStatus = SyncStatus.PENDING`
    - `val projectId: String` (für Multi-User-Sharing)
  - Füge TypeConverter für `MilkType` und `SyncStatus` hinzu
- **Output:** Room-kompatible Entity-Klasse

#### [ ] Task 2.4: Room Type Converters erstellen
- **Datei:** `app/src/main/java/com/babytracker/data/local/Converters.kt`
- **Logik:**
  - Klasse mit `@TypeConverters` Annotation
  - Implementiere:
    - `@TypeConverter fun fromMilkType(value: MilkType): String = value.name`
    - `@TypeConverter fun toMilkType(value: String): MilkType = MilkType.valueOf(value)`
    - Analog für `SyncStatus`
- **Output:** Type-Converter für Room

---

### Phase 3: Data Layer - Local Database (Room)

#### [ ] Task 3.1: FeedingDao Interface erstellen
- **Datei:** `app/src/main/java/com/babytracker/data/local/FeedingDao.kt`
- **Logik:**
  - Annotiere Interface mit `@Dao`
  - Methoden:
    - `@Insert(onConflict = OnConflictStrategy.REPLACE) suspend fun insert(entry: FeedingEntry)`
    - `@Query("SELECT * FROM feeding_entries WHERE projectId = :projectId AND timestamp >= :startOfDay AND timestamp < :endOfDay ORDER BY timestamp DESC") fun getEntriesForDay(projectId: String, startOfDay: Long, endOfDay: Long): Flow<List<FeedingEntry>>`
    - `@Query("SELECT * FROM feeding_entries WHERE syncStatus = :status") suspend fun getEntriesByStatus(status: SyncStatus): List<FeedingEntry>`
    - `@Update suspend fun update(entry: FeedingEntry)`
    - `@Query("DELETE FROM feeding_entries WHERE id = :id") suspend fun deleteById(id: String)`
- **Output:** DAO mit typisierten Queries

#### [ ] Task 3.2: Room Database erstellen
- **Datei:** `app/src/main/java/com/babytracker/data/local/BabyTrackerDatabase.kt`
- **Logik:**
  - Abstakte Klasse erbt von `RoomDatabase()`
  - Annotiere mit `@Database(entities = [FeedingEntry::class], version = 1, exportSchema = false)`
  - Annotiere mit `@TypeConverters(Converters::class)`
  - Deklariere: `abstract fun feedingDao(): FeedingDao`
- **Output:** Database-Definition

#### [ ] Task 3.3: Database Dependency Injection Modul
- **Datei:** `app/src/main/java/com/babytracker/di/DatabaseModule.kt`
- **Logik:**
  - Annotiere mit `@Module` und `@InstallIn(SingletonComponent::class)`
  - Provider-Methode:
    ```kotlin
    @Provides
    @Singleton
    fun provideDatabase(@ApplicationContext context: Context): BabyTrackerDatabase {
        return Room.databaseBuilder(
            context,
            BabyTrackerDatabase::class.java,
            "baby_tracker_db"
        )
        .fallbackToDestructiveMigration()
        .build()
    }
    ```
  - Provider für DAO:
    ```kotlin
    @Provides
    fun provideFeedingDao(database: BabyTrackerDatabase): FeedingDao = database.feedingDao()
    ```
- **Output:** Hilt-Modul für Database

---

### Phase 4: Data Layer - Remote (Firebase Firestore)

#### [ ] Task 4.1: Firestore Constants definieren
- **Datei:** `app/src/main/java/com/babytracker/data/remote/FirestoreConstants.kt`
- **Logik:**
  - Object mit konstanten Collection-Namen:
    ```kotlin
    object FirestoreConstants {
        const val COLLECTION_PROJECTS = "projects"
        const val COLLECTION_FEEDINGS = "feedings"
        const val FIELD_AMOUNT_ML = "amountMl"
        const val FIELD_MILK_TYPE = "milkType"
        const val FIELD_TIMESTAMP = "timestamp"
        const val FIELD_PROJECT_ID = "projectId"
    }
    ```
- **Output:** Zentralisierte Firestore-Strings

#### [ ] Task 4.2: FirestoreService erstellen
- **Datei:** `app/src/main/java/com/babytracker/data/remote/FirestoreService.kt`
- **Logik:**
  - Klasse mit Constructor-Injection: `class FirestoreService @Inject constructor(private val firestore: FirebaseFirestore)`
  - Methoden:
    - `suspend fun addFeeding(entry: FeedingEntry): Result<Unit>` - nutzt `firestore.collection().document().set()` mit `await()`, catcht Exceptions und returned `Result.Error` bei Fehler
    - `suspend fun getFeedingsForProject(projectId: String): Result<List<FeedingEntry>>` - Query mit `whereEqualTo("projectId", projectId)`, mappt Snapshots zu Entities
    - `fun observeFeedingsForProject(projectId: String): Flow<List<FeedingEntry>>` - nutzt `callbackFlow` mit Firestore SnapshotListener für Realtime-Updates
    - `suspend fun createProject(): Result<String>` - generiert neue Project-ID und erstellt Firestore-Dokument
  - Error-Handling: Wrappe alle Firestore-Exceptions in `BabyTrackerException.FirebaseException`
- **Output:** Service-Layer für Firestore-Operationen

#### [ ] Task 4.3: Firebase Dependency Injection Modul
- **Datei:** `app/src/main/java/com/babytracker/di/FirebaseModule.kt`
- **Logik:**
  - Annotiere mit `@Module` und `@InstallIn(SingletonComponent::class)`
  - Provider:
    ```kotlin
    @Provides
    @Singleton
    fun provideFirestore(): FirebaseFirestore = FirebaseFirestore.getInstance()
    ```
- **Output:** Hilt-Modul für Firebase

---

### Phase 5: Data Layer - Repository

#### [ ] Task 5.1: Repository Interface definieren
- **Datei:** `app/src/main/java/com/babytracker/data/repository/FeedingRepository.kt`
- **Logik:**
  - Interface mit Methoden:
    - `suspend fun addFeeding(amountMl: Int, milkType: MilkType, timestamp: Long): Result<Unit>`
    - `fun getDailyFeedings(projectId: String, date: LocalDate): Flow<List<FeedingEntry>>`
    - `suspend fun syncPendingEntries(): Result<Unit>`
    - `suspend fun createOrJoinProject(inviteCode: String?): Result<String>`
  - Alle Suspend-Funktionen returnen `Result<T>`
- **Output:** Repository-Kontrakt

#### [ ] Task 5.2: Repository Implementation
- **Datei:** `app/src/main/java/com/babytracker/data/repository/FeedingRepositoryImpl.kt`
- **Logik:**
  - Klasse mit Constructor-Injection: `FeedingDao`, `FirestoreService`, `SharedPreferences` (für Project-ID)
  - `addFeeding`:
    1. Validiere `amountMl > 0`, werfe `ValidationException` sonst
    2. Erstelle `FeedingEntry` mit aktueller `projectId` aus SharedPreferences
    3. Schreibe in Room: `dao.insert(entry)`
    4. Versuche Sync: `firestoreService.addFeeding(entry)`, bei Erfolg update `syncStatus = SYNCED`, bei Fehler bleibe `PENDING`
    5. Logge mit Timber
    6. Return `Result.Success(Unit)` oder `Result.Error`
  - `getDailyFeedings`:
    1. Berechne `startOfDay` und `endOfDay` als Unix Timestamps aus `LocalDate`
    2. Return `dao.getEntriesForDay(projectId, startOfDay, endOfDay)`
  - `syncPendingEntries`:
    1. Hole alle Entries mit `syncStatus = PENDING`
    2. Für jeden Entry: versuche Firestore-Upload, update Status bei Erfolg
    3. Return `Result.Success` wenn >= 1 erfolgreich, sonst `Result.Error`
  - `createOrJoinProject`:
    1. Wenn `inviteCode == null`: generiere neue Project-ID via `firestoreService.createProject()`
    2. Wenn `inviteCode != null`: validiere und join existierendes Projekt
    3. Speichere Project-ID in SharedPreferences
- **Output:** Vollständige Repository-Implementierung

#### [ ] Task 5.3: Repository Dependency Injection
- **Datei:** `app/src/main/java/com/babytracker/di/AppModule.kt`
- **Logik:**
  - Annotiere mit `@Module` und `@InstallIn(SingletonComponent::class)`
  - Provider:
    ```kotlin
    @Provides
    @Singleton
    fun provideFeedingRepository(
        dao: FeedingDao,
        firestoreService: FirestoreService,
        @ApplicationContext context: Context
    ): FeedingRepository {
        val sharedPrefs = context.getSharedPreferences("app_prefs", Context.MODE_PRIVATE)
        return FeedingRepositoryImpl(dao, firestoreService, sharedPrefs)
    }
    ```
- **Output:** Hilt-Binding für Repository

---

### Phase 6: Domain Layer - Use Cases

#### [ ] Task 6.1: AddFeedingUseCase erstellen
- **Datei:** `app/src/main/java/com/babytracker/domain/usecase/AddFeedingUseCase.kt`
- **Logik:**
  - Klasse mit Constructor-Injection: `FeedingRepository`
  - Methode: `suspend operator fun invoke(amountMl: Int, milkType: MilkType, timestamp: Long = System.currentTimeMillis()): Result<Unit>`
  - Implementierung:
    1. Validiere Input (amountMl > 0 && amountMl < 500, timestamp <= now)
    2. Delegiere an Repository: `repository.addFeeding(amountMl, milkType, timestamp)`
    3. Logge Erfolg/Fehler mit Timber
- **Output:** Use Case mit Validierung

#### [ ] Task 6.2: GetDailyFeedingsUseCase erstellen
- **Datei:** `app/src/main/java/com/babytracker/domain/usecase/GetDailyFeedingsUseCase.kt`
- **Logik:**
  - Klasse mit Constructor-Injection: `FeedingRepository`
  - Methode: `operator fun invoke(projectId: String, date: LocalDate): Flow<List<FeedingEntry>>`
  - Implementierung: Return `repository.getDailyFeedings(projectId, date)`
- **Output:** Use Case für Daten-Fetching

#### [ ] Task 6.3: GetFeedingStatsUseCase erstellen
- **Datei:** `app/src/main/java/com/babytracker/domain/usecase/GetFeedingStatsUseCase.kt`
- **Logik:**
  - Klasse mit Constructor-Injection: `FeedingRepository`
  - Methode: `operator fun invoke(projectId: String, date: LocalDate): Flow<DailyFeedingSummary>`
  - Implementierung:
    1. Hole Flow von `GetDailyFeedingsUseCase`
    2. Transformiere mit `.map`:
       - Berechne `totalBreastMilk = entries.filter { it.milkType == BREAST_MILK }.sumOf { it.amountMl }`
       - Berechne `totalFormula = entries.filter { it.milkType == FORMULA }.sumOf { it.amountMl }`
       - Return `DailyFeedingSummary(totalBreastMilk, totalFormula, entries.size)`
- **Output:** Use Case mit Daten-Aggregation

#### [ ] Task 6.4: DailyFeedingSummary Model erstellen
- **Datei:** `app/src/main/java/com/babytracker/domain/model/DailyFeedingSummary.kt`
- **Logik:**
  - Data class mit Properties:
    - `val totalBreastMilkMl: Int`
    - `val totalFormulaMl: Int`
    - `val feedingCount: Int`
    - Computed Property: `val totalMl: Int get() = totalBreastMilkMl + totalFormulaMl`
- **Output:** Domain Model für UI

---
### Phase 7: UI Layer - Theme und Basis-Komponenten

#### [ ] Task 7.1: Material3 Color Palette definieren
- **Datei:** `app/src/main/java/com/babytracker/ui/theme/Color.kt`
- **Logik:**
  - Definiere Pastel-Farben:
    ```kotlin
    val PastelBlue = Color(0xFFAEC6CF)
    val PastelPink = Color(0xFFFFB3BA)
    val PastelMint = Color(0xFFB2E6D4)
    val LightBackground = Color(0xFFFAFAFA)
    val DarkBackground = Color(0xFF1C1C1E)
    ```
  - Definiere Custom Colors für Milchtypen:
    ```kotlin
    val BreastMilkColor = Color(0xFFFFD6A5)
    val FormulaColor = Color(0xFFA5D8FF)
    ```
- **Output:** Color-Definitionen

#### [ ] Task 7.2: Material3 Theme erstellen
- **Datei:** `app/src/main/java/com/babytracker/ui/theme/Theme.kt`
- **Logik:**
  - Definiere `LightColorScheme` und `DarkColorScheme` mit Material3-Farben
  - Implementiere `@Composable fun BabyTrackerTheme(darkTheme: Boolean = isSystemInDarkTheme(), content: @Composable () -> Unit)`
  - Nutze `MaterialTheme(colorScheme = ..., typography = Typography, content = content)`
- **Output:** App-Theme

#### [ ] Task 7.3: Typography definieren
- **Datei:** `app/src/main/java/com/babytracker/ui/theme/Type.kt`
- **Logik:**
  - Definiere `val Typography = Typography(...)` mit Material3-Defaults
  - Customizations:
    - `displayLarge` für große Zahlen (Total Amount)
    - `bodyLarge` für Listeneinträge
- **Output:** Typography-Konfiguration

---

### Phase 8: UI Layer - Reusable Components

#### [ ] Task 8.1: DateNavigationBar Composable
- **Datei:** `app/src/main/java/com/babytracker/ui/components/DateNavigationBar.kt`
- **Logik:**
  - Composable: `@Composable fun DateNavigationBar(currentDate: LocalDate, onDateChange: (LocalDate) -> Unit, modifier: Modifier = Modifier)`
  - Layout:
    - Row mit IconButton (Pfeil zurück), Text (Datum formatiert), IconButton (Pfeil vor), IconButton (Kalender)
    - Bei Klick auf Pfeile: `onDateChange(currentDate.plusDays(1/-1))`
    - Bei Klick auf Kalender: Öffne DatePickerDialog (Material3 `DatePicker` in AlertDialog)
  - State: `var showDatePicker by remember { mutableStateOf(false) }`
- **Input:** currentDate, onDateChange Callback
- **Output:** Wiederverwendbare Navigation-Bar

#### [ ] Task 8.2: StackedBarChart Composable
- **Datei:** `app/src/main/java/com/babytracker/ui/components/StackedBarChart.kt`
- **Logik:**
  - Composable: `@Composable fun StackedBarChart(breastMilkMl: Int, formulaMl: Int, modifier: Modifier = Modifier)`
  - Implementation:
    - Nutze `Canvas` Composable für Custom Drawing
    - Berechne Proportionen: `breastMilkRatio = breastMilkMl / totalMl`, `formulaRatio = formulaMl / totalMl`
    - Zeichne gestapelte Rechtecke mit `drawRect`:
      - Untere Schicht: Formula (FormulaColor), Höhe = `canvasHeight * formulaRatio`
      - Obere Schicht: Breast Milk (BreastMilkColor), Höhe = `canvasHeight * breastMilkRatio`
    - Füge Legend hinzu (Row mit farbigen Boxen und Labels)
  - Edge Case: Wenn `totalMl == 0`, zeige grauen Balken mit "Keine Daten"
- **Input:** breastMilkMl, formulaMl
- **Output:** Gestapeltes Balkendiagramm

#### [ ] Task 8.3: AddFeedingButton Composable
- **Datei:** `app/src/main/java/com/babytracker/ui/components/AddFeedingButton.kt`
- **Logik:**
  - Composable: `@Composable fun AddFeedingButton(onClick: () -> Unit, modifier: Modifier = Modifier)`
  - Implementation:
    - `FloatingActionButton` (Material3) mit Icon (Plus-Symbol)
    - `onClick` Callback delegiert an Parent
  - Style: Primary Color, Large Size
- **Input:** onClick Callback
- **Output:** FAB für Hauptaktion

#### [ ] Task 8.4: FeedingDialog Composable
- **Datei:** `app/src/main/java/com/babytracker/ui/components/FeedingDialog.kt`
- **Logik:**
  - Composable: `@Composable fun FeedingDialog(onDismiss: () -> Unit, onConfirm: (Int, MilkType) -> Unit, modifier: Modifier = Modifier)`
  - State:
    - `var amountText by remember { mutableStateOf("") }`
    - `var selectedMilkType by remember { mutableStateOf(MilkType.BREAST_MILK) }`
  - Layout (in `AlertDialog`):
    - `OutlinedTextField` für Amount (keyboardType = KeyboardType.Number)
    - Segmented Button Group für MilkType-Auswahl (Radio Buttons oder ToggleButton)
    - Buttons: "Abbrechen" (onDismiss), "Hinzufügen" (onConfirm mit Validierung)
  - Validierung: Amount muss Int > 0 sein, sonst disable "Hinzufügen"-Button
- **Input:** onDismiss, onConfirm Callbacks
- **Output:** Modal Dialog für Eingabe

---

### Phase 9: UI Layer - HomeScreen

#### [ ] Task 9.1: HomeUiState definieren
- **Datei:** `app/src/main/java/com/babytracker/ui/home/HomeUiState.kt`
- **Logik:**
  - Sealed class:
    ```kotlin
    sealed class HomeUiState {
        object Loading : HomeUiState()
        data class Success(
            val currentDate: LocalDate,
            val summary: DailyFeedingSummary,
            val entries: List<FeedingEntry>
        ) : HomeUiState()
        data class Error(val message: String) : HomeUiState()
    }
    ```
- **Output:** Type-Safe UI-State

#### [ ] Task 9.2: HomeViewModel erstellen
- **Datei:** `app/src/main/java/com/babytracker/ui/home/HomeViewModel.kt`
- **Logik:**
  - Klasse erbt von `ViewModel()`, annotiere mit `@HiltViewModel`
  - Constructor-Injection: `GetDailyFeedingsUseCase`, `GetFeedingStatsUseCase`, `AddFeedingUseCase`
  - State:
    - `private val _uiState = MutableStateFlow<HomeUiState>(HomeUiState.Loading)`
    - `val uiState: StateFlow<HomeUiState> = _uiState.asStateFlow()`
    - `private val _currentDate = MutableStateFlow(LocalDate.now())`
  - Methoden:
    - `init { loadFeedingsForDate(_currentDate.value) }`
    - `private fun loadFeedingsForDate(date: LocalDate)`:
      - Setze `_uiState.value = HomeUiState.Loading`
      - Sammle Flow von `getFeedingStatsUseCase(projectId, date)` in `viewModelScope`
      - Bei Success: `_uiState.value = HomeUiState.Success(date, summary, entries)`
      - Bei Exception: `_uiState.value = HomeUiState.Error(exception.message)`
    - `fun onDateChanged(newDate: LocalDate) { _currentDate.value = newDate; loadFeedingsForDate(newDate) }`
    - `fun onAddFeedingClicked(amountMl: Int, milkType: MilkType)`:
      - Launch Coroutine: `addFeedingUseCase(amountMl, milkType)`
      - Bei Success: Refresh current date
      - Bei Error: Update UI State mit Error
- **Output:** ViewModel mit Business Logic

#### [ ] Task 9.3: HomeScreen Composable
- **Datei:** `app/src/main/java/com/babytracker/ui/home/HomeScreen.kt`
- **Logik:**
  - Composable: `@Composable fun HomeScreen(viewModel: HomeViewModel = hiltViewModel(), modifier: Modifier = Modifier)`
  - Collecte State: `val uiState by viewModel.uiState.collectAsState()`
  - Layout:
    - `Scaffold` mit `topBar` (enthält DateNavigationBar), `floatingActionButton` (AddFeedingButton)
    - Content: `when (uiState)`:
      - `Loading`: Zeige `CircularProgressIndicator` zentriert
      - `Success`: Zeige Column mit:
        - Text (displayLarge) mit `summary.totalMl` + " ml"
        - StackedBarChart mit `summary.totalBreastMilkMl`, `summary.totalFormulaMl`
        - LazyColumn mit Feeding-Einträgen (Zeit, Menge, Typ)
      - `Error`: Zeige Error-Text und Retry-Button
  - Dialog-State: `var showAddDialog by remember { mutableStateOf(false) }`
  - Bei FAB-Klick: `showAddDialog = true`
  - Wenn `showAddDialog`: Zeige `FeedingDialog` mit onConfirm = `viewModel.onAddFeedingClicked`
- **Output:** Vollständiger Home Screen

---

### Phase 10: UI Layer - Navigation

#### [ ] Task 10.1: Screen Sealed Class
- **Datei:** `app/src/main/java/com/babytracker/ui/navigation/Screen.kt`
- **Logik:**
  - Sealed class für Routes:
    ```kotlin
    sealed class Screen(val route: String) {
        object Home : Screen("home")
        object ShareProject : Screen("share_project")
    }
    ```
- **Output:** Type-Safe Navigation Routes

#### [ ] Task 10.2: NavGraph erstellen
- **Datei:** `app/src/main/java/com/babytracker/ui/navigation/NavGraph.kt`
- **Logik:**
  - Composable: `@Composable fun BabyTrackerNavGraph(navController: NavHostController, modifier: Modifier = Modifier)`
  - Implementation:
    ```kotlin
    NavHost(navController = navController, startDestination = Screen.Home.route) {
        composable(Screen.Home.route) { HomeScreen() }
        composable(Screen.ShareProject.route) { ShareProjectScreen() }
    }
    ```
- **Output:** Navigation Graph

#### [ ] Task 10.3: MainActivity erstellen
- **Datei:** `app/src/main/java/com/babytracker/MainActivity.kt`
- **Logik:**
  - Klasse erbt von `ComponentActivity()`, annotiere mit `@AndroidEntryPoint`
  - Override `onCreate`:
    ```kotlin
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            BabyTrackerTheme {
                val navController = rememberNavController()
                BabyTrackerNavGraph(navController = navController)
            }
        }
    }
    ```
- **Output:** Haupt-Activity mit Compose

---

### Phase 11: Data Sync & Background Work

#### [ ] Task 11.1: NetworkMonitor erstellen
- **Datei:** `app/src/main/java/com/babytracker/util/NetworkMonitor.kt`
- **Logik:**
  - Klasse mit Constructor-Injection: `@ApplicationContext Context`
  - Property: `val isOnline: Flow<Boolean>`
  - Implementation nutzt `ConnectivityManager.NetworkCallback` mit `callbackFlow`
  - Registriere Callback bei `collect`, unregister bei `close`
- **Output:** Reactive Network-Status

#### [ ] Task 11.2: SyncManager erstellen
- **Datei:** `app/src/main/java/com/babytracker/data/sync/SyncManager.kt`
- **Logik:**
  - Klasse mit Constructor-Injection: `FeedingRepository`, `NetworkMonitor`
  - Methode: `suspend fun syncWhenOnline()`
  - Implementation:
    - Sammle `networkMonitor.isOnline`
    - Wenn `true`: Rufe `repository.syncPendingEntries()` auf
    - Logge Sync-Ergebnis
- **Output:** Sync-Orchestrator

#### [ ] Task 11.3: SyncWorker erstellen
- **Datei:** `app/src/main/java/com/babytracker/data/sync/SyncWorker.kt`
- **Logik:**
  - Klasse erbt von `CoroutineWorker`
  - Nutze Hilt Worker Injection: `@HiltWorker` mit `@AssistedInject constructor`
  - Override `suspend fun doWork(): Result`:
    - Injiziere `SyncManager`
    - Rufe `syncManager.syncWhenOnline()` auf
    - Return `Result.success()` oder `Result.retry()`
  - Periodenarbeit: Alle 15 Minuten wenn online
- **Output:** Background Sync Worker

#### [ ] Task 11.4: WorkManager Setup in Application
- **Datei:** `app/src/main/java/com/babytracker/BabyTrackerApplication.kt` (Edit)
- **Logik:**
  - In `onCreate()` nach Timber-Init:
    ```kotlin
    val syncWorkRequest = PeriodicWorkRequestBuilder<SyncWorker>(15, TimeUnit.MINUTES)
        .setConstraints(Constraints.Builder().setRequiredNetworkType(NetworkType.CONNECTED).build())
        .build()
    WorkManager.getInstance(this).enqueueUniquePeriodicWork(
        "sync_work",
        ExistingPeriodicWorkPolicy.KEEP,
        syncWorkRequest
    )
    ```
- **Output:** Automatischer Background Sync

---

### Phase 12: Share Project Feature

#### [ ] Task 12.1: ShareProjectUseCase erstellen
- **Datei:** `app/src/main/java/com/babytracker/domain/usecase/ShareProjectUseCase.kt`
- **Logik:**
  - Klasse mit Constructor-Injection: `FeedingRepository`
  - Methode: `suspend operator fun invoke(): Result<String>`
  - Implementation:
    - Hole aktuelle Project-ID aus Repository
    - Generiere Invite-Code (Base64-kodierte Project-ID)
    - Return `Result.Success(inviteCode)`
- **Output:** Use Case für Sharing

#### [ ] Task 12.2: ShareProjectScreen erstellen
- **Datei:** `app/src/main/java/com/babytracker/ui/share/ShareProjectScreen.kt`
- **Logik:**
  - Composable: `@Composable fun ShareProjectScreen(viewModel: ShareProjectViewModel = hiltViewModel())`
  - Layout:
    - Column mit:
      - Text "Projekt teilen"
      - Text mit Invite-Code (SelectionContainer für Copy)
      - Button "Code teilen" (nutzt Android Share Intent)
      - Divider
      - Text "Projekt beitreten"
      - TextField für Invite-Code-Eingabe
      - Button "Beitreten"
- **Output:** Share/Join UI

#### [ ] Task 12.3: ShareProjectViewModel erstellen
- **Datei:** `app/src/main/java/com/babytracker/ui/share/ShareProjectViewModel.kt`
- **Logik:**
  - Klasse erbt von `ViewModel()`, annotiere mit `@HiltViewModel`
  - Constructor-Injection: `ShareProjectUseCase`, `FeedingRepository`
  - State: `val inviteCode: StateFlow<String>`, `val joinStatus: StateFlow<Result<Unit>>`
  - Methoden:
    - `init { loadInviteCode() }`
    - `private fun loadInviteCode()`: Rufe UseCase auf, update State
    - `fun joinProject(code: String)`: Rufe Repository auf mit Code, update Status
- **Output:** ViewModel für Share-Feature

---

### Phase 13: Testing

#### [ ] Task 13.1: FeedingDaoTest erstellen
- **Datei:** `app/src/androidTest/java/com/babytracker/data/local/FeedingDaoTest.kt`
- **Logik:**
  - Annotiere mit `@RunWith(AndroidJUnit4::class)`
  - Setup: Erstelle In-Memory-Database in `@Before`
  - Teardown: Schließe Database in `@After`
  - Tests:
    - `@Test fun insertAndRetrieve_feedingEntry_returnsCorrectData()`: Insert Entry, query by ID, assert equals
    - `@Test fun getEntriesForDay_withMultipleDays_returnsOnlyCurrentDay()`: Insert Entries für verschiedene Tage, query für einen Tag, assert Count
    - `@Test fun updateSyncStatus_changesStatus()`: Insert Entry, update syncStatus, query, assert new Status
- **Output:** DAO Integration Tests

#### [ ] Task 13.2: FeedingRepositoryTest erstellen
- **Datei:** `app/src/test/java/com/babytracker/data/repository/FeedingRepositoryTest.kt`
- **Logik:**
  - Nutze MockK für `FeedingDao` und `FirestoreService`
  - Setup: Mock-Instanzen in `@Before`
  - Tests:
    - `@Test fun addFeeding_withValidInput_savesToRoomAndFirestore()`: Mock successful DAO insert und Firestore add, rufe Repository auf, verify beide calls
    - `@Test fun addFeeding_withInvalidAmount_returnsValidationError()`: Rufe mit `amountMl = 0` auf, assert `Result.Error` mit `ValidationException`
    - `@Test fun getDailyFeedings_returnsFlowFromDao()`: Mock DAO flow, collect und assert
    - `@Test fun syncPendingEntries_retriesFailedEntries()`: Mock DAO mit PENDING entries, mock Firestore success, verify update calls
- **Output:** Repository Unit Tests

#### [ ] Task 13.3: AddFeedingUseCaseTest erstellen
- **Datei:** `app/src/test/java/com/babytracker/domain/usecase/AddFeedingUseCaseTest.kt`
- **Logik:**
  - Mock `FeedingRepository`
  - Tests:
    - `@Test fun invoke_withValidInput_delegatesToRepository()`: Mock repository success, rufe UseCase auf, verify repository call
    - `@Test fun invoke_withAmountTooLarge_returnsError()`: Rufe mit `amountMl = 600` auf, assert Error
    - `@Test fun invoke_withFutureTimestamp_returnsError()`: Rufe mit `timestamp = now + 1000` auf, assert Error
- **Output:** UseCase Unit Tests

#### [ ] Task 13.4: HomeViewModelTest erstellen
- **Datei:** `app/src/test/java/com/babytracker/ui/home/HomeViewModelTest.kt`
- **Logik:**
  - Nutze `UnconfinedTestDispatcher` für Coroutinen
  - Mock alle UseCases
  - Setup: Erstelle ViewModel mit Mocks in `@Before`
  - Tests:
    - `@Test fun uiState_initiallyLoading()`: Assert `uiState.value is HomeUiState.Loading`
    - `@Test fun loadFeedingsForDate_withSuccess_emitsSuccessState()`: Mock UseCase mit Flow, collect uiState, assert Success mit Daten
    - `@Test fun onDateChanged_loadsNewDate()`: Rufe `onDateChanged` auf, verify UseCase mit neuem Datum
    - `@Test fun onAddFeedingClicked_withValidInput_addsAndRefreshes()`: Mock AddFeedingUseCase success, rufe Methode auf, verify calls
- **Output:** ViewModel Unit Tests

#### [ ] Task 13.5: HomeScreenTest erstellen
- **Datei:** `app/src/androidTest/java/com/babytracker/ui/HomeScreenTest.kt`
- **Logik:**
  - Nutze `createComposeRule()`
  - Tests:
    - `@Test fun homeScreen_withSuccessState_displaysChart()`: Setze Content mit mock ViewModel (Success State), assert Chart ist displayed
    - `@Test fun homeScreen_clickAddButton_showsDialog()`: Klicke FAB, assert Dialog ist visible
    - `@Test fun homeScreen_submitDialog_callsViewModel()`: Öffne Dialog, fülle Felder, klicke Submit, verify ViewModel call (benötigt Test-ViewModel)
- **Output:** UI Tests

---

### Phase 14: Code Quality & Polish

#### [ ] Task 14.1: Detekt konfigurieren
- **Datei:** `detekt.yml` (Root)
- **Logik:**
  - Konfiguriere Regeln für:
    - Komplexität (MaxLineLength: 120, CyclomaticComplexity: 15)
    - Naming Conventions
    - Style (NoConsecutiveBlankLines, etc.)
  - Exclude: `**/test/**`, `**/androidTest/**`
- **Output:** Linting-Config

#### [ ] Task 14.2: Strings externalisieren
- **Datei:** `app/src/main/res/values/strings.xml`
- **Logik:**
  - Definiere alle UI-Strings:
    ```xml
    <string name="app_name">BabyTracker</string>
    <string name="add_feeding">Fütterung hinzufügen</string>
    <string name="amount_ml">Menge (ml)</string>
    <string name="milk_type">Milchtyp</string>
    <string name="breast_milk">Muttermilch</string>
    <string name="formula">Formula</string>
    <string name="total_intake">Gesamt-Aufnahme</string>
    ...
    ```
- **Output:** Lokalisierte Strings

#### [ ] Task 14.3: ProGuard Rules
- **Datei:** `app/proguard-rules.pro`
- **Logik:**
  - Füge Keep-Rules für:
    - Firebase Models: `-keep class com.babytracker.data.model.** { *; }`
    - Room Entities: `-keep @androidx.room.Entity class *`
    - Hilt: `-keep class dagger.hilt.** { *; }`
- **Output:** Optimized Release Build

#### [ ] Task 14.4: README.md erweitern
- **Datei:** `README.md` (Edit)
- **Logik:**
  - Füge Abschnitte hinzu:
    - **Setup Instructions:** Gradle Sync, Firebase Setup (google-services.json)
    - **Architecture:** Diagramm der Layers (Data, Domain, UI)
    - **Testing:** Wie Tests ausführen (`./gradlew test`, `./gradlew connectedAndroidTest`)
    - **Build:** Release APK erstellen
- **Output:** Vollständige Dokumentation

---

## 5. Erfolgs-Kriterien

- [ ] Alle Builds laufen ohne Fehler (`./gradlew build`)
- [ ] Alle Tests sind grün (Unit + Integration)
- [ ] App startet und zeigt Home Screen mit Mock-Daten
- [ ] Fütterung kann hinzugefügt werden und erscheint im Chart
- [ ] Datum-Navigation funktioniert (Swipe + DatePicker)
- [ ] Offline-Mode funktioniert (Einträge werden lokal gespeichert)
- [ ] Background-Sync aktiviert sich bei Netzwerk-Verfügbarkeit
- [ ] Code-Coverage >= 80% für data- und domain-Layer
- [ ] Detekt-Checks ohne Fehler
- [ ] APK kann gebaut und auf Gerät installiert werden

---

## 6. Offene Fragen / Risiken

- **Firebase-Setup:** Entwickler muss eigenes Firebase-Projekt erstellen und `google-services.json` hinzufügen
- **Chart-Library:** Entscheidung zwischen Vico (moderner, Compose-nativ) vs. MPAndroidChart (etabliert, aber View-basiert) – **Empfehlung: Vico**
- **Multi-User-Conflict-Handling:** Last-Write-Wins ist einfach, aber nicht optimal – evtl. später erweitern zu Operational Transformation
- **Authentifizierung:** Aktuell keine User-Auth – alle Partner teilen gleiche Project-ID – später evtl. Firebase Auth hinzufügen

---

## 7. Nächste Schritte nach Completion

1. User-Authentifizierung (Firebase Auth)
2. Export/Import von Daten (CSV, PDF-Report)
3. Push-Notifications für Partner ("Partner hat Fütterung hinzugefügt")
4. Erweiterte Analytics (Wöchentliche/Monatliche Trends)
5. Widget für Home Screen
