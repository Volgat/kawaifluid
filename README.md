# Kawaiflow 🌊

*A serene and interactive fluid simulation for relaxation and anxiety relief, powered by Flutter and GLSL shaders.*

Kawaiflow offers a mesmerizing, real-time fluid art experience right on your device. Interact with the screen to create beautiful, flowing patterns and let the calming visuals wash over you. The app is designed as a digital sanctuary to help you unwind, focus, and find a moment of peace in your busy day.

## ✨ Features

- **Interactive Fluid Simulation:** Touch the screen to generate fluid flows. The simulation is rendered in real-time using powerful GLSL shaders.
- **Generative AI:** Includes an experimental feature using Google's Gemini model via Firebase AI to generate text prompts or reflections.
- **Dynamic Theming:** Seamlessly switch between a light and dark mode to suit your environment.
- **Modern UI:** Built with Material 3 design principles and custom typography using Google Fonts.
- **Cross-Platform:** Developed with Flutter for a consistent experience on both Android and the web.
- **Advanced Navigation:** Uses `go_router` for robust routing and deep linking capabilities.

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Graphics:** [GLSL](https://www.khronos.org/opengl/wiki/Core_Language_(GLSL)) (via `shader_buffers` package)
- **Generative AI:** [Firebase AI SDK (Gemini)](https://firebase.google.com/docs/vertex-ai)
- **State Management:** [Provider](https://pub.dev/packages/provider)
- **Routing:** [GoRouter](https://pub.dev/packages/go_router)
- **Styling:** [Google Fonts](https://pub.dev/packages/google_fonts)

## 🚀 Getting Started

To run this project locally, follow these steps:

1.  **Prerequisites:**
    - Ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
    - An IDE like VS Code or Android Studio.

2.  **Clone the Repository:**
    ```sh
    git clone https://github.com/Volgat/kawaifluid.git
    cd kawaifluid
    ```

3.  **Install Dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the App:**
    ```sh
    flutter run
    ```

## 📦 Android Release Build

This project is configured for generating signed release builds for the Google Play Store.

**Note:** The signing keys (`android/app/keystore/upload-keystore.jks` and `android/key.properties`) are **not** included in this repository for security reasons. To build a release version, you will need to provide your own signing configuration.

- **Build App Bundle (.aab):**
  ```sh
  flutter build appbundle --release
  ```

- **Build APK:**
  ```sh
  flutter build apk --release
  ```
