# Pixel Watch Flutter

A high-fidelity Pixel Watch simulation built with Flutter, focusing on scalable architecture and reactive design.

## Architecture

The project follows a **Feature-First Organization** pattern. Each feature is self-contained, encapsulating its own logic, data handling, and UI components. This ensures high scalability and modularity.

### Project Structure
- `lib/features/`: Contains independent modules (Clock, Weather, Heart Rate, etc.).
  - `logic/`: BLoC state management and feature-specific logic.
  - `data/`: Repositories, data sources, and use cases.
  - `ui/`: Pages and reusable feature-specific widgets.
- `lib/core/`: Global shared logic, including dependency injection.
- `lib/commons/`: Shared design system (colors, layout helpers, and global widgets).

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
