# Product Collections - Flutter Accordion UI

A Flutter application displaying product collections with an accordion-style expandable UI.

## Project Structure

```
lib/
├── main.dart                    # App entry point, MaterialApp setup
├── models/
│   └── collection.dart          # Collection data model (title, imageUrls)
└── screens/
    └── collections_screen.dart  # Main screen with accordion logic and UI
```

## Approach

### State Management
- Used StatefulWidget with a single `expandedIndex` variable to track which collection is expanded
- `expandedIndex = -1` means no collection is expanded
- Tapping a card updates `expandedIndex` via `setState()`, ensuring only one collection is expanded at a time

### Accordion Animation
- Used `AnimatedCrossFade` widget for smooth expand/collapse transitions
- Animation duration: 300 milliseconds
- `CrossFadeState.showFirst` displays collapsed state (empty SizedBox)
- `CrossFadeState.showSecond` displays expanded state (horizontal image row)

### +N Overlay Logic
- Maximum 4 images displayed in the horizontal row
- If more images exist, a "+N" overlay appears on the last visible image
- Implemented using `Stack` widget with a semi-transparent `Container` overlay

## How to Run

1. Clone the repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Connect a device or start an emulator
5. Run `flutter run` to launch the app

## Dependencies

- Flutter SDK ^3.9.2
