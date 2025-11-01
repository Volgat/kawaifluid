
# Blueprint: Kawaii Fluid - v2

## 1. Overview

**Purpose:** To transform the "Kawaii Fluid" application from a basic fluid simulation into an engaging and polished relaxation and anxiety relief app that meets Google Play Store standards.

**Core Concept:** The app will provide users with a serene, interactive experience centered around beautiful fluid dynamics, enhanced with calming sounds and a delightful user interface.

## 2. Style, Design, and Features (Current v1)

This section documents the state of the app that was rejected by Google Play.

*   **Functionality:**
    *   A single screen displaying a 2D fluid particle simulation using the Flame engine.
    *   A simple vertical list of emoji icons on the left allows users to switch between six predefined "themes" (Kawaii, Ocean, Fire, etc.).
    *   Tapping the screen creates a ripple impulse in the fluid.
*   **UI/UX:**
    *   Extremely minimalistic UI.
    *   No text, titles, or instructions.
    *   Theme selection is done via un-labelled emoji buttons in plain white circles.
    *   The entire application logic, UI, and game engine code is contained in a single `lib/main.dart` file.
*   **Design:**
    *   The background color changes with the theme.
    *   The particle colors change with the theme.
    *   No established typography or component styling.

## 3. Plan for a Richer Experience (New v2)

This section outlines the plan to address Google's feedback and create a high-quality app.

### Step 1: Foundational Restructure & UI Overhaul

*   **Project Restructuring:**
    *   **Goal:** Improve maintainability and scalability.
    *   **Action:** Decompose the single `main.dart` file into a feature-based structure:
        *   `main.dart`: App entry point, `MaterialApp` and `provider` setup.
        *   `providers/`: State management logic (e.g., `theme_provider.dart`).
        *   `models/`: Data models (e.g., `fluid_theme.dart`).
        *   `screens/`: UI for each screen (e.g., `home_screen.dart`).
        *   `widgets/`: Reusable UI components (e.g., `theme_card.dart`).
        *   `game/`: Flame engine code (`fluid_game.dart`, `fluid_particle.dart`).
*   **State Management with `provider`:**
    *   **Goal:** Manage app state efficiently and prevent abrupt UI resets.
    *   **Action:** Implement `ChangeNotifierProvider` to manage the selected fluid theme and the app's light/dark mode.
*   **Polished Theming:**
    *   **Goal:** Create a visually appealing and consistent design.
    *   **Action:**
        *   Integrate the `google_fonts` package for elegant typography.
        *   Define a complete `ThemeData` for both light and dark modes using `ColorScheme.fromSeed`. This will style the app bar, buttons, and other UI components.
*   **Redesigned Home Screen (`home_screen.dart`):**
    *   **Goal:** Replace the basic emoji list with an engaging and intuitive interface.
    *   **Action:**
        *   Add a welcoming title, such as "Choose Your Moment of Calm".
        *   Create a `ThemeCard` widget. Each card will represent a fluid theme and display its name (e.g., "Kawaii Blossom," "Ocean Waves").
        *   Arrange these cards in a visually appealing `GridView`.
        *   The main fluid simulation will remain as the interactive background.

### Step 2: Adding Engaging Content (Future Steps)

*   **Ambient Sounds:**
    *   **Goal:** Enhance the relaxing experience.
    *   **Action:** Integrate a package like `audioplayers` to play calming background music or sounds corresponding to the selected theme (e.g., gentle waves for the Ocean theme).
*   **Settings Screen:**
    *   **Goal:** Give users more control.
    *   **Action:** Create a new settings page to allow users to toggle sound, adjust graphic quality, and access information about the app.
*   **Guided Breathing Exercise:**
    *   **Goal:** Add a functional wellness feature.
    *   **Action:** Overlay a subtle, animated visual guide (e.g., a pulsing circle) on top of the fluid simulation to guide users through simple "inhale, hold, exhale" breathing exercises.

This phased approach will first address the immediate UI/UX shortcomings to meet Google Play's requirements and then build upon that foundation to create a truly valuable and engaging application.
