//
//  AlertConfiguration.swift
//  CoupleDo
//
//  Created by Mikey Colonna on 11/27/23.
//

// https://developer.apple.com/documentation/swiftui/view/alert(_:ispresented:actions:message:)-6awwp

import SwiftUI

/// A view modifier that presents an alert according to a specified `AlertConfiguration`.
///
/// This modifier monitors changes to the provided `AlertConfiguration` and automatically presents the alert
/// when the configuration changes to a non-nil value. If the `configuration` becomes `nil`, the alert is dismissed.
/// This mechanism ensures that the alert is triggered even when the content of the configuration is the same but the `id` changes.
/// This mechanism allows the alert to be dynamically triggered by updating the configuration object rather than
/// manually toggling a Boolean flag.
///
/// ## Motivation
/// SwiftUI's built-in alert presentation uses a binding to a Boolean value to show or hide alerts.
/// However, in situations where the alert's content (title, message, actions) may change dynamically, using a Boolean flag alone is insufficient and cumbersome.
/// This modifier abstracts away the need for manual state management by responding directly to changes in the configuration itself.
///
/// ## Features
/// - Automatic alert presentation based on configuration changes.
/// - Supports multiple alert actions with optional primary action indication.
/// - Automatically handles alert dismissal when the configuration becomes `nil`.
/// - Ensures smooth integration with various SwiftUI views without disrupting animations or causing unwanted updates.
///
/// ## Implementation Details
/// The modifier leverages the `onChange` view modifier to detect changes in the alert configuration.
/// It uses an internal `isPresented` state to control the visibility of the alert.
/// If the `configuration` becomes `nil`, the alert is dismissed automatically.
///
/// - Note:
///   - This modifier utilizes the `.alert(_:isPresented:presenting:actions:message:)` method for alert presentation.
///   - The alert is presented when the `configuration` changes to a non-nil value, and dismissed when it becomes `nil`.
///
/// - Parameters:
///   - configuration: An optional `AlertConfiguration` object defining the alert's title, message, and actions.
///                     If `nil`, the alert will not be displayed.
///                     If non-nil, the alert will be presented with the given title, message, and action buttons.
///
/// - Returns: A view that automatically presents an alert when the provided configuration changes.
///
/// ### Example Usage:
///
/// This example demonstrates how to use the `AlertComposerModifier` to show an alert when the configuration changes:
///
/// ```swift
/// struct ContentView: View {
///     @State private var currentAlertConfiguration: AlertConfiguration?
///
///     var body: some View {
///         VStack {
///             Button("Show Alert") {
///                 currentAlertConfiguration = AlertConfiguration(
///                     title: "Alert Title",
///                     message: "Alert message.",
///                     actions: [
///                         .init(title: "Primary action", isPrimaryAction: true, action: {
///                             // action here
///                         }),
///                         .init(title: "Cancel", role: .cancel)
///                     ]
///                 )
///             }
///             .alertComposer(currentAlertConfiguration)
///         }
///     }
/// }
/// ```
///
/// In this scenario, tapping the button changes the `currentAlertConfiguration` to a non-nil value,
/// triggering the alert to appear with the specified title, message, and actions.
/// When the configuration changes again or becomes `nil`, the alert is dismissed.
///
/// ## Note:
/// - The alert presentation is triggered based on changes to the **`id`** of the `configuration`, rather than the configuration object itself.
/// - Setting the `configuration` to `nil` indirectly dismisses the alert by setting `isPresented` to `false`.
///
/// - Warning: Avoid updating the configuration while the alert is presented, as this may lead to unintended behavior.
/// Ensure that the configuration's `id` is unique when triggered multiple times to guarantee consistent alert presentation.
/// Placing this modifier on the first view in the hierarchy is recommended to avoid animation issues.
struct AlertComposerModifier: ViewModifier {
    @State private var isPresented: Bool = false
    var configuration: AlertConfiguration?

    func body(content: Content) -> some View {
        content
            .alert(
                configuration?.title ?? "",
                isPresented: $isPresented,
                presenting: configuration
            ) { config in
                ForEach(config.actions.indices, id: \.self) { index in
                    Button(
                        config.actions[index].title,
                        role: config.actions[index].role ?? .none,
                        action: config.actions[index].action ?? { }
                    )
                    .performsPrincipalAction(if: config.actions[index].isPrimaryAction)
                }
            } message: { config in
                Text(config.message)
            }
            .onChange(of: configuration?.id) { _ in
                // Present the alert only if the configuration is not nil
                isPresented = configuration != nil
            }
    }
}


// MARK: - AlertComposer View Extension
extension View {
    
    /// A SwiftUI view extension for dynamically presenting alerts based on configuration changes.
    ///
    /// This extension provides a convenient method to attach an alert to a view that automatically responds to changes in the alert configuration.
    /// The alert is presented whenever the configuration becomes non-nil or its `id` changes, eliminating the need to manually manage the presentation state.
    ///
    /// ## Motivation
    /// Managing alert presentation with a simple Boolean flag can be limiting when the alert content itself is dynamic or subject to frequent changes.
    /// This extension simplifies the process by leveraging an `AlertConfiguration` object, which encapsulates all the alert data.
    /// By tracking changes to the configuration's `id`, this extension ensures the alert is always up-to-date without additional state management.
    ///
    /// ## Features
    /// - Dynamically presents alerts based on configuration updates.
    /// - Supports complex alert scenarios with multiple actions.
    /// - Avoids unwanted UI updates by only reacting to a change in the alert configuration's `id`.
    /// - Provides flexibility in where the alert modifier is attached, minimizing the risk of unwanted view updates or animation disruptions.
    ///
    /// - Parameter configuration: An optional `AlertConfiguration` object that triggers the alert when non-nil or when its `id` changes.
    /// - Returns: A modified view that automatically presents an alert when the configuration `id` changes.
    ///
    /// ### Example Usage 1:
    ///
    /// In this example, the alert will be shown when the button is tapped, and the configuration is set.
    /// Subsequent changes to the configuration will update the alert accordingly.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var alertConfig: AlertConfiguration?
    ///
    ///     var body: some View {
    ///         Button("Trigger Alert") {
    ///             alertConfig = AlertConfiguration(
    ///                 title: "Alert Title",
    ///                 message: "Alert message.",
    ///                 actions: [
    ///                     .init(title: "Primary action", isPrimaryAction: true, action: {
    ///                         // action here
    ///                     }),
    ///                     .init(title: "Cancel", role: .cancel)
    ///                 ]
    ///             )
    ///         }
    ///         .alertComposer(alertConfig)
    ///     }
    /// }
    /// ```
    ///
    /// ### Example Usage 2:
    ///
    /// In this scenario, the modifier is attached to a view higher in the hierarchy to prevent unwanted view updates or animation disruptions.
    /// This is particularly important when the alert may be triggered from various parts of the UI or when the alert is expected to persist through navigation or hierarchy changes.
    ///
    /// #### Why This Approach Is Necessary:
    /// When attaching the alert composer to a deeply nested or specific view (like a button), SwiftUI may:
    /// - Trigger unwanted view updates, causing the view to be rebuilt or refreshed unexpectedly.
    /// - Disrupt animations or transitions, especially if the parent view hierarchy changes.
    /// - Make it difficult to present the alert consistently across the entire view, leading to unexpected presentation behavior.
    ///
    /// To ensure stable and predictable alert presentation, especially in complex view hierarchies, the modifier should be placed at a higher level,
    /// such as the root view or a persistent parent container. This placement avoids re-triggering the alert during UI updates.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var currentAlertConfiguration: AlertConfiguration?
    ///     @State private var showAlert = false
    ///
    ///     var body: some View {
    ///         VStack {
    ///             EmptyView()
    ///                 .alertComposer(isPresented: $showAlert, configuration: currentAlertConfiguration)
    ///
    ///             Button("Show Alert") {
    ///                 currentAlertConfiguration = .specific(title: "Error", message: "Whoops", retryAction: {
    ///                     print("Retry action triggered")
    ///                 })
    ///                 showAlert = true
    ///             }
    ///
    ///             Text("Second View")
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// - Important: Use caution when triggering alerts from deeply nested views, as this may disrupt UI responsiveness.
    /// Always attach the modifier to a **higher-level view** in the hierarchy to prevent unexpected layout changes or animation glitches.
    ///
    /// - Warning: Triggering alerts from deeply nested views may result in UI instability, such as disrupted animations or unexpected view rebuilds.
    /// To maintain consistent behavior, attach this modifier at the root level or a persistent parent view, as shown in Example Usage 2.
    func alertComposer(_ configuration: AlertConfiguration?) -> some View {
        Group {
            if let configuration = configuration {
                self.modifier(AlertComposerModifier(configuration: configuration))
            } else {
                self
            }
        }
    }
}
