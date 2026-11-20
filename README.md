# Heating Control

A Flutter app for an educational eco-home heating dashboard and Arduino heating simulation.

The Flutter project is located in the [`app`](app) directory. Run all Flutter commands from that directory.

## Functionality

- **Boiler Control**: Turning the boiler on/off for each room
- **Underfloor Heating Control**: Managing underfloor heating in the kitchen and bathroom
- **Temperature Monitoring**: Tracking air and water temperatures
- **Automatic Mode**: Automatic boiler control based on temperature threshold values
- **Real-time Statistics**: Viewing overall home heating statistics

## Project Structure

```
app/
├── lib/
│   ├── app/                 # Application setup and theme
│   ├── data/simulation/     # Arduino simulation engine
│   ├── domain/models/       # Domain models
│   ├── features/            # Dashboard and feature screens
│   └── widgets/             # Reusable UI widgets
├── test/                    # Widget and simulation tests
├── android/                 # Android runner
├── ios/                     # iOS runner
├── web/                     # Web runner
├── linux/                   # Linux runner
├── macos/                   # macOS runner
└── windows/                 # Windows runner
```

## Getting Started

### Requirements

- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio / VS Code with the Flutter extension

### Installation

1. Clone the repository
2. Navigate to the Flutter project:
   ```bash
   cd app
   ```
3. Install dependencies:
```bash
flutter pub get
```
4. Run the application:
```bash
flutter run
```

## Usage

- **Boiler Switching**: Use the toggle switch to Turning the boiler on/off for each room
- **Underfloor Heating Control**: Manage underfloor heating independently
- **Automatic Boiler**: Press "Auto Boiler" for automatic boiler control based on temperature (threshold: 21°C)
- **View Statistics**: Check the bottom card for overall home statistics

## Educational Goal

This project was created for learning Flutter and Dart. It demonstrates:
- Variables and data types
- Control flow (if statements, for loops)
- Functions and methods
- Classes and objects
- Getters and computed properties
- State management using `setState`
- Widget composition
- Material Design UI components

## License

This is an educational project. Feel free to use it for educational purposes.