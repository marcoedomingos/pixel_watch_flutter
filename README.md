# Pixel Watch Flutter

A high-fidelity Pixel Watch simulation built with Flutter, focusing on scalable architecture and reactive design.

## Usage as a Package

This project can be imported as a Flutter package.

### 1. Add Dependency
Add this to your `pubspec.yaml`:
```yaml
dependencies:
  smart_watch:
    path: ../pixel_watch_flutter # or git url
```

### 2. Initialize
Call the initialization function in your `main.dart`:
```dart
import 'package:smart_watch/smart_watch.dart' as watch;

void main() async {
  await watch.init();
  runApp(const MyApp());
}
```

### 3. Use Components
```dart
import 'package:smart_watch/smart_watch.dart';

// Use the WatchBaseLayout or individual features
WatchBaseLayout(
  child: HomePage(),
)
```

## Architecture

The project follows a **Feature-First Organization** pattern, now structured as a **reusable Flutter package**. Each feature is self-contained, encapsulating its own logic, data handling, and UI components.

### Project Structure
- `lib/`: Core package logic and feature modules.
  - `smart_watch.dart`: Main entry point and public API.
  - `features/`: Independent modules (Clock, Weather, etc.).
  - `core/`: Global shared logic and DI.
  - `commons/`: Shared design system and widgets.
- `example/`: A standalone Flutter app demonstrating how to use the package.

## Key Features

### 🕒 Synchronized Clock
Powered by a centralized `ClockBloc`, the watch maintains a unified time source. All clock faces and UI elements are perfectly synchronized across the entire application without redundant timers.

### 🌤️ Weather Integration
Fully integrated with the OpenWeatherMap API.
- Automatic geolocation support.
- Real-time current weather data.
- 5-day daily forecast display.

### 💓 Heart Rate Monitor
Real-time BPM sensing utilizing the device camera.
- Animated pulse effect synchronized with measurements.
- Transition animations for smooth BPM value updates.

### 📱 Responsive Watch UI
- **WatchFrame**: A physical metaphor for the watch hardware, including side buttons and bracelets.
- **WatchScreen**: Handles the digital display logic, including splash transitions and content clipping.
- **Custom Router**: Internal navigation system specifically designed for circular watch displays.

## Tech Stack
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Networking**: [weather](https://pub.dev/packages/weather) (OpenWeather API)
- **Hardware**: [geolocator](https://pub.dev/packages/geolocator), [heart_bpm](https://pub.dev/packages/heart_bpm)

## Getting Started

1. **Clone the repo**
2. **Setup API Keys**: Add your OpenWeatherMap API key in `lib/features/weather/data/weather_remote_datasource.dart`.
3. **Install dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

## Design System
The project utilizes **Context Extensions** for a declarative design approach:
- `context.width` / `context.height`: Screen-relative sizing.
- `context.primaryBlack` / `context.creamWhite`: Theme-consistent color access.
- `WatchBaseLayout`: A standardized wrapper for circular watch UI components.
