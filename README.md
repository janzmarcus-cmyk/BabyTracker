# Project: BabyTracker (Android App)

## Core Features
- **Feeding Logs:** Enter amount (ml), type (breast milk / formula), and timestamp (default: now).
- **Home Screen Dashboard:**
    - Display a **Stacked Bar Chart** for the current day showing total intake split by milk type.
    - Show the total amount as a large number above the chart.
    - **Navigation:** Horizontal swipe (ViewPager2) to switch days + Arrows in the top bar to open a DatePicker (Calendar).
    - **Action:** A prominent "Add Feeding" button below the chart, always accessible.
- **Data Sharing:** - Use **Firebase Firestore** for real-time synchronization between partners.
    - Implement a "Join via Invite Code" or "Share Project" feature so both parents see the same data.
    - Offline support: Data should be saved locally first (Room DB) and synced when online.

## Visuals & UX
- Modern, sleek Material 3 design with "Pastel" or "Calm" color palettes.
- Intuitive, one-handed usage (important for parents!).
- Use **Jetpack Compose** for all UI components.

## Technical Requirements
- Language: Kotlin
- Architecture: MVVM with ViewModel and StateFlow
- Database: Room (Local) + Firestore (Sync)
