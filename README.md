# Binate Digital Reusable Widgets

A Flutter package providing a collection of reusable, customizable, and production-ready widgets and utilities to accelerate your app development. This package includes widgets for animations, counters, buttons, and more, along with utility classes for network calls, toast notifications, and other common functionalities.

---

## Features

- **Widgets**:
  - Flip Counter: A customizable animated counter widget.
  - Option Selector: A widget for selecting options with animations.
  - Dotted Border: A widget for creating dashed or dotted borders.
  - Animated List Views: Prebuilt animated list views for staggered and sliding animations.
- **Utilities**:
  - Toast Notifications: Beautiful and customizable toast notifications.
  - Network Call Handler: Simplifies network call handling with error and completion callbacks.
- **Extensions**:
  - String and SizedBox extensions for enhanced functionality.

---

## Getting Started

### Prerequisites

Ensure you have the following setup:

- Flutter SDK: `>=3.7.0`
- Dart: `>=3.0.0`

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  binate_digital_reusable_widgets: ^1.0.0
```

Run the following command to fetch the package:

```bash
flutter pub get
```

---

## Usage

### 1. Flip Counter

The `FlipCounter` widget provides an animated counter with customizable styles.

```dart
import 'package:binate_digital_reusable_widgets/reusables.dart';

FlipCounter(
  value: 123.45,
  wholeDigits: 3,
  fractionDigits: 2,
  duration: Duration(milliseconds: 500),
  curve: Curves.easeInOut,
  style: TextStyle(fontSize: 24, color: Colors.black),
);
```

### 2. Option Selector

The `OptionSelector` widget allows users to select an option from a list with a clean UI.

```dart
OptionSelector<String>(
  options: ['Option 1', 'Option 2', 'Option 3'],
  selectedOption: 'Option 1',
  onOptionSelected: (option) {
    print('Selected: $option');
  },
);
```

### 3. Dotted Border

The `DottedBorder` widget creates a dashed or dotted border around any child widget.

```dart
DottedBorder(
  child: Text('Dotted Border Example'),
  color: Colors.blue,
  dashPattern: [4, 2],
  strokeWidth: 2,
  borderType: BorderType.RRect,
  radius: Radius.circular(10),
);
```

### 4. Animated List Views

#### Primary Animated List

```dart
PrimaryAnimatedList(
  children: List.generate(
    10,
    (index) => ListTile(title: Text('Item $index')),
  ),
);
```

#### Animated Separate List

```dart
AnimatedSeparateList(
  itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
  separatorBuilder: (context, index) => Divider(),
  itemCount: 10,
);
```

### 5. Toast Notifications

Use the `AppToaster` utility to show toast notifications.

```dart
AppToaster.showToast(
  'This is a success message!',
  type: ToastificationType.success,
  subTitle: 'Additional details here.',
);
```

### 6. Network Call Utility

Simplify network calls with error handling and completion callbacks.

```dart
NetworkCall.execute(
  context: context,
  call: () async {
    // Your async network call here
    return await fetchData();
  },
  onComplete: (response) {
    print('Response: $response');
  },
  onError: (error, stacktrace) {
    print('Error: $error');
  },
);
```

---

## Examples

Explore the full examples in the [examples](https://github.com/FUZAIL-GIT/binate-digital-reusables-widgets/tree/dev/examples) folder. Here's how to run them:

1. Clone the repository.
2. Navigate to the `examples` folder.
3. Run the app:

```bash
flutter run
```

---

## Extensions

### String Extension

The `capitalize` extension capitalizes the first letter of a string.

```dart
import 'package:binate_digital_reusable_widgets/extensions/string_extension.dart';

print('hello'.capitalize); // Output: Hello
```

### SizedBox Extension

Quickly create sized boxes with extensions.

```dart
import 'package:binate_digital_reusable_widgets/extensions/sizedbox_extension.dart';

SizedBox(height: 20); // Equivalent to 20.h
```

---

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request with detailed information.

---

## License

This package is licensed under the MIT License. See the [LICENSE](https://github.com/FUZAIL-GIT/binate-digital-reusables-widgets/blob/dev/LICENSE) file for details.

---

## Additional Information

For more details, visit the [documentation](https://github.com/FUZAIL-GIT/binate-digital-reusables-widgets/docs) or file an issue on the [GitHub repository](https://github.com/FUZAIL-GIT/binate-digital-reusables-widgets/issues).

Happy coding!
