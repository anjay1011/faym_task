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

### File Descriptions

| File | Purpose |
|------|---------|
| main.dart | Initializes the app with theme configuration and routes to CollectionsScreen |
| collection.dart | Data model class with title and imageUrls fields |
| collections_screen.dart | Stateful widget containing accordion state management, card UI, and image row with +N overlay |

## How to Run

1. Clone the repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Connect a device or start an emulator
5. Run `flutter run` to launch the app

## Dependencies

- Flutter SDK ^3.9.2
