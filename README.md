# Quiz App - Math Edition 🧮

A Flutter quiz application featuring mathematical questions with LaTeX rendering, leaderboards, and score tracking.

[⬇️ Download the latest APK](app-production-release.apk)

## Note
**This App Shows a unicorn as Splash screen because this project was originally genreated thorugh [very_good_cli](https://cli.vgv.dev/)**

## ⚠️ Disclaimer

This code is submitted as a task for a job application. **Rubizcode is not authorized to use this code in production or for any commercial purposes without explicit written permission from the author.**

## Features ✨

- **Math Quiz**: Interactive quiz with LaTeX-rendered mathematical equations
- **Timer System**: Timed questions with visual countdown
- **Leaderboard**: Top scores with podium display for top 3 players
- **Score Persistence**: Local storage using Hive for score history
- **Responsive UI**: Adaptive design using ScreenUtil
- **Theme Support**: Light/dark theme with persistent preferences

## Tech Stack 🛠️

- **Flutter**: 3.32.8
- **State Management**: Riverpod
- **Local Storage**: Hive
- **Navigation**: GoRouter
- **UI**: ScreenUtil, SVG support, Lottie animations
- **Math Rendering**: LaTeX support

## Getting Started 🚀

### Prerequisites

- Flutter SDK (stable channel)
- FVM (Flutter Version Management) - recommended

### Setup with FVM

1. Install FVM if you haven't already:

```sh
dart pub global activate fvm
```

2. Install the Flutter version specified in the project:

```sh
fvm install
```

3. Use the project's Flutter version:

```sh
fvm use 3.32.8
```

4. Get dependencies:

```sh
fvm flutter pub get
```

5. Run the app:

```sh
fvm flutter run
```

### Setup without FVM

1. Ensure you have Flutter version 3.32.8 installed:
2. Get dependencies:

```sh
flutter pub get
```

3. Run the app:

```sh
flutter run
```

## Running Tests 🧪

```sh
flutter test --test-randomize-ordering-seed random
```

## Project Structure 📁

```
lib/
├── core/                 # Core utilities, extensions, themes
├── feature/
│   └── quiz/            # Quiz feature module
│       ├── domain/      # Entities, repositories, use cases
│       └── presentation/ # Pages, widgets, providers
└── assets/
    ├── questions.json   # Quiz questions data
    ├── fonts/          # Custom fonts
    ├── lotties/        # Lottie animations
    └── svgs/           # SVG assets
```

## Configuration 📝

- **Questions**: Edit `assets/questions.json` to modify quiz content
- **Themes**: Customize themes in `lib/core/theme/`
- **FVM**: Flutter version managed via `.fvmrc`

## Key Dependencies 📦

```yaml
dependencies:
  flutter_riverpod: ^2.6.1 # State management
  hive_flutter: ^1.1.0 # Local storage
  go_router: ^15.1.3 # Navigation
  flutter_screenutil: ^5.9.3 # Responsive UI
  latext: ^0.5.1 # LaTeX rendering
  lottie: ^3.3.1 # Animations
  flutter_svg: ^2.2.0 # SVG support
```

## Development 🔧

This project follows clean architecture principles with:

- **Domain Layer**: Entities, repositories, use cases
- **Presentation Layer**: Pages, widgets, state management
- **Core Layer**: Shared utilities, themes, extensions

Built with Very Good Analysis for code quality and best practices.

## Task List

    - [x] HomeScreen: App title + “Start Quiz” button
    - [x] HomeScreen: “Leaderboard” button
    - [x] Funtionality: Load questions from assets/questions.json
    - [x] Funtionality: LaTeX/Math equations in both questions and answers
    - [x] QuizGame: Show 1 question at a time with 4 multiple‐choice answers
    - [x] QuizGame: User taps to select an answer (lock once selected)
    - [x] QuizGame: “Next” button to move to the next question
    - [x] QuizGame: “Progress indicator (e.g., Q2/10)
    - [x] Result: Final score out of total
    - [x] Result: Option to enter player name
    - [x] Result: Save score to local leaderboard
    - [x] Leaderboard: Show top scores (player name + score)
    - [x] Leaderboard: Sort by highest score first
    - [x] Leaderboard: Persistent storage (Hive)
    - [x] Nice‐to‐Have: 15 second timer for each question
    - [x] Nice‐to‐Have: Animations between question transitions
    - [ ] Nice‐to‐Have: Category selection before starting quiz
    - [x] Nice‐to‐Have: Dark mode support
    - [x] Nice‐to‐Have: Unit tests for score calculation
    - [x] Nice‐to‐Have: Simple CI running flutter analyze and flutter test
    - [x] Requirements: Works entirely offline
    - [x] Requirements: Supports LaTeX rendering
    - [x] Requirements: Data persists between app restarts
    - [x] Requirements: Any state management solution is fine (riverpod for statemanagement and dependency injection)
    - [x] Requirements: Clean, responsive UI (Used Neobrutalism Inspired design patterns)
