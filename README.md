# SwiftUI - BetterBetterSwiftUIAlertComposer

The **BetterBetterSwiftUIAlertComposer** is a flexible Swift package designed to simplify alert management in SwiftUI. 
It dynamically presents alerts based on setting a current alert configuration, eliminating the need for manual state management using Boolean flags.

## Why Use BetterBetterSwiftUIAlertComposer?

SwiftUI's built-in alert presentation often relies on a boolean flag to show or hide alerts. However, when alert content (title, message, actions) changes dynamically, managing alerts this way becomes cumbersome. 
**BetterBetterSwiftUIAlertComposer** solves this by using a current alert configuration-based approach, allowing alerts to be presented simply by defining and setting an alert configuration.


## Installation
Requirements:

- iOS 16+
- macOS 13+
- watchOS 9+

### Swift Package Manager
1. In **Xcode**, open your project and navigate to **File** → **Add Package Dependencies**...
2. **Paste** this repository URL:

```swift
github.com/mcolojr/BetterBetterSwiftUIAlertComposer
```

3. Click **Add Package**.

## How to Use
Import the `BetterBetterSwiftUIAlertComposer` package to your `.swift` file:

```swift
import BetterBetterSwiftUIAlertComposer
```

### Basic Alert Example

```swift
struct ContentView: View {
    @State private var currentAlertConfiguration: AlertConfiguration?

    var body: some View {
        Button("Show Alert") {
            currentAlertConfiguration = AlertConfiguration(
                title: "Success",
                message: "Operation completed successfully.",
                actions: [
                    AlertConfiguration.AlertAction(
                        title: "OK",
                        isPrimaryAction: true,
                        action: { 
                            print("OK tapped")
                        }
                    )
                ]
            )
        }
        .alertComposer(currentAlertConfiguration)
    }
}
```

### Multiple Action Alert Example

```swift
Button("Show Alert") {
    currentAlertConfiguration = AlertConfiguration(
        title: "Warning",
        message: "Are you sure you want to delete this item?",
        actions: [
            .init(
                title: "Cancel",
                role: .cancel
            ),
            .init(
                title: "Delete",
                role: .destructive,
                action: { 
                    print("Item deleted")
                }
            )
        ]
    )
}
.alertComposer(currentAlertConfiguration)
```

## Contribute
You can contribute to this project by helping to solve any [reported issues or feature requests](https://github.com/mcolojr/BetterBetterSwiftUIAlertComposer/issues) and creating a pull request.

## License
`BetterBetterSwiftAlertComposer` is released under the [MIT License](https://github.com/mcolojr/BetterBetterSwiftUIAlertComposer/blob/main/LICENSE).
