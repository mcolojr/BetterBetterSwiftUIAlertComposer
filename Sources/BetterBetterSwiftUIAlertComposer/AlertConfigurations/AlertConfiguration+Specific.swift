//
//  AlertConfiguration+Specific.swift
//  BetterBetterSwiftUIAlertComposer
//
//  Created by Michael Colonna on 2/23/24.
//  Copyright © 2024 Michael Colonna All rights reserved.
//

import SwiftUI

extension AlertConfiguration {
    
    /// Constructs a basic alert configuration with a title and message.
    ///
    /// This method generates a simple alert configuration, suitable for cases where a straightforward notification is needed without custom actions.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    /// - Returns: An `AlertConfiguration` instance configured with the specified parameters.
    ///
    /// - Note: A default "OK" action is included to dismiss the alert.
    public static func specific(title: LocalizedStringKey,
                                message: LocalizedStringKey) -> AlertConfiguration {
        AlertConfiguration(
            title: title,
            message: message,
            actions: []
        )
    }
    
    /// Constructs an alert configuration with a retry action.
    ///
    /// This method is designed for scenarios where an operation might fail and the user should be given the option to retry. It includes both a "Retry" and a "Cancel" action.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - retryAction: A closure executed when the retry action is selected.
    /// - Returns: An `AlertConfiguration` instance configured with the specified parameters.
    ///
    /// - Note: This alert will include a "Retry" button along with a "Cancel" button.
    public static func specific(title: LocalizedStringKey,
                                message: LocalizedStringKey,
                                retryAction: @escaping (() -> Void)) -> AlertConfiguration {
        AlertConfiguration(
            title: title,
            message: message,
            actions: Array {
                Action(title: "Retry", isPrimaryAction: true, action: retryAction)
                Action(title: "Cancel", role: .cancel)
            }
        )
    }
    
    /// Constructs an alert configuration with a retry action.
    ///
    /// This method is designed for scenarios where an operation might fail and the user should be given the option to retry. It includes both a "Retry" and a "Cancel" action with the option to pass in a cancellation action
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - retryAction: A closure executed when the retry action is selected.
    ///   - cancelAction: An optioanl closure executed when the cancel action is cancelled.
    /// - Returns: An `AlertConfiguration` instance configured with the specified parameters.
    ///
    /// - Note: This alert will include a "Retry" button along with a "Cancel" button.
    public static func specific(title: LocalizedStringKey,
                                message: LocalizedStringKey,
                                retryAction: @escaping (() -> Void),
                                cancelAction: (() -> Void)? = nil) -> AlertConfiguration {
        AlertConfiguration(
            title: title,
            message: message,
            actions: Array {
                Action(title: "Retry", isPrimaryAction: true, action: retryAction)
                Action(title: "Cancel", role: .cancel, action: cancelAction)
            }
        )
    }
    
    /// Constructs a specific alert configuration with a primary action and an optional cancellation.
    ///
    /// This configuration allows for a customized alert with specific actions defined by the developer, providing flexibility in response to various user interactions.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - primaryAction: An optional primary action, presented only if no retry action is provided.
    ///   - includesCancelOption: Determines if a "Cancel" button is included, providing a way out without choosing either action. Defaults to `true`.
    /// - Returns: An `AlertConfiguration` instance configured with the specified parameters.
    ///
    /// - Note: This alert will include the primaryAction button along with an optional "Cancel" button.
    static func specific(title: LocalizedStringKey,
                         message: LocalizedStringKey,
                         primaryAction: Action,
                         includesCancelOption: Bool = true) -> AlertConfiguration {
        AlertConfiguration(
            title: title,
            message: message,
            actions: Array {
                primaryAction
                if includesCancelOption {
                    Action(title: "Cancel", role: .cancel)
                }
            }
        )
    }

    /// Constructs an alert configuration with both primary and secondary actions, with an optional cancellation.
    ///
    /// This method extends the customization capabilities by allowing for two defined actions.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - primaryAction: The primary action, typically used for the main action.
    ///   - secondaryAction: A secondary action for an alternative option.
    ///   - includesCancelOption: Determines if a "Cancel" button is included, providing a way out without choosing either action. Defaults to `true`.
    /// - Returns: An `AlertConfiguration` instance configured with the specified parameters.
    ///
    /// - Note: This alert will include the primaryAction button, secondary Button and an optional "Cancel" button.
    static func specific(title: LocalizedStringKey,
                         message: LocalizedStringKey,
                         primaryAction: Action,
                         secondaryAction: Action,
                         includesCancelOption: Bool = true) -> AlertConfiguration {
        AlertConfiguration(
            title: title,
            message: message,
            actions: Array {
                primaryAction
                secondaryAction
                if includesCancelOption {
                    Action(title: "Cancel", role: .cancel)
                }
            }
        )
    }
}
