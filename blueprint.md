# Kawaï Fluid App Blueprint

## Overview

A Flutter application that displays a beautiful and interactive fluid-like animation using shaders. The app will feature a modern and "kawaï" aesthetic, with a focus on visual appeal and user interaction.

## Style, Design, and Features (Current)

*   **Visuals:**
    *   A real-time fluid animation background created with a GLSL shader.
    *   A "kawaï" color palette with pink and purple tones.
    *   An interactive heart shape that follows the user's mouse/touch input.
    *   Sparkle effects to enhance the visual appeal.
*   **Theme:**
    *   A dark theme by default.
    *   A theme toggle button (light/dark mode).
    *   Custom fonts using `google_fonts`.
*   **Architecture:**
    *   State management with `provider`.
    *   Shader rendering with the `shader_buffers` package.
    *   Navigation with `go_router`.

## Plan for New Features

### 1. UI/UX Revamp based on "KawaiiFLUID" Logo

To create a more cohesive and branded user experience, I will update the application's UI to match the visual identity of the provided logo.

*   **New Color Scheme:** The app's theme will be updated to use the soft blue and white colors from the logo, creating a light, clean, and friendly aesthetic.
*   **Live Shader Previews:** The gallery will be enhanced to show live, animated thumbnails of each shader instead of static text cards. This provides a much better user experience, allowing users to see the effects at a glance.
*   **UI Component Styling:** The `AppBar`, `BottomNavigationBar`, and other UI elements will be restyled to align with the new color palette and the "kawaï" theme.
*   **Typography:** I will select a font from `google_fonts` that is more rounded and playful to match the logo's style.

### 2. Gallery Page

I will create a "Gallery" page that will display a collection of different shaders.

*   **Content:**
    *   A grid view of shader thumbnails.
    *   Tapping on a thumbnail will navigate to a detail page displaying the selected shader in full screen.
*   **Shaders:**
    *   I will create 2-3 new shaders with different visual effects (e.g., a "galaxy" shader, a "fire" shader).
*   **Navigation:**
    *   I will add a bottom navigation bar to switch between the Home and Gallery pages.

### 3. Settings Page

I will create a "Settings" page that will allow users to customize the fluid animation in real-time.

*   **Controls:**
    *   **Complexity:** A slider to control the complexity of the fluid simulation.
    *   **Speed:** A slider to adjust the speed of the animation.
    *   **Toggle Heart:** A switch to show or hide the heart shape.
    *   **Toggle Sparkles:** A switch to enable or disable the sparkles.
*   **Navigation:**
    *   I will add a settings icon to the `AppBar` on the Home Page to navigate to the Settings Page.
