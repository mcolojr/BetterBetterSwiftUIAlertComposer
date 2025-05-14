//
//  AlertConfiguration.swift
//  AlertComposer
//
//  Created by Michael Colonna on 5/13/25.
//

import SwiftUI

/// Represents the configuration for an alert dialog, including title, message, and actions.
///
/// Use instances of this struct to define the properties of an alert dialog that you wish to present to the user. 
/// This includes localized titles and messages, and a list of actions that the user can take in response to the alert.
/// Actions are defined by the nested `AlertConfiguration.Action` struct, which includes the action's title,
/// an optional closure to execute when the action is selected, and the action's role which influences its appearance and position in the alert dialog.
///
/// - Note: An `id` property is automatically generated to uniquely identify each alert configuration.
struct AlertConfiguration: Identifiable {
    let id: UUID = UUID()
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    var actions: [Action] = []

    /// Represents an action in an alert dialog.
    ///
    /// This struct encapsulates the title of the action, an optional closure that is called when the action is selected.
    /// The ``role`` or ``isPrimaryAction`` properties of the action can affect its appearance and placement within the alert.
    struct Action {
        /// The localized string key for the button's title
        let title: LocalizedStringKey
        
        /// The role of the button (`ButtonRole`), affecting its appearance and behavior.
        ///  Default is `.none`, which indicates a standard action. Special roles like `.cancel` or `.destructive` provide specific styling and semantics.
        ///  - Note: If a role is provided, it may override the need to specify `isPrimaryAction`.
        let role: ButtonRole?
        
        /// Indicates whether the button performs the main action of the alert, which visually distinguishes it (typically by making it bold).
        /// Applies the modifier ``.keyboardShortcut(.defaultAction)`` to the ``Button`` which indicates it performs the principal action by making it bold. Defaults to `false`.
        /// - Note: It is unnecessary to set this to `true`if a specific role is provided, as the role conveys the button's importance and function. Defaults to `false`.
        let isPrimaryAction: Bool
        
        /// An optional closure that is executed when the button is tapped. If `nil`, tapping the button will close the alert without performing any additional actions.
        let action: (() -> Void)?
        
        /// Represents an action button within an alert.
        ///
        /// This struct defines the properties of an action button to be used in an alert. It includes options for the button's title, its role in the alert (such as cancel or destructive), whether it is styled as the primary action, and a closure that executes upon tapping the button.
        ///
        /// - Parameters:
        ///   - title: The localized string key for the button's title.
        ///   - role: The role of the button (`ButtonRole`), affecting its appearance and behavior. Special roles like `.cancel` or `.destructive` provide specific styling and semantics.
        ///   - action: An optional closure that is executed when the button is tapped. If `nil`, tapping the button will close the alert without performing any additional actions.
        ///
        /// Example Usage:
        /// ```swift
        /// Action(title: "Delete", role: .destructive, action: {
        ///     // Perform the action
        /// })
        /// ```
        init(title: LocalizedStringKey, role: ButtonRole, action: (() -> Void)? = nil) {
            self.title = title
            self.role = role
            self.isPrimaryAction = false
            self.action = action
        }
        
        /// Represents an action button within an alert.
        ///
        /// This struct defines the properties of an action button to be used in an alert. It includes options for the button's title, its role in the alert (such as cancel or destructive), whether it is styled as the primary action, and a closure that executes upon tapping the button.
        ///
        /// - Parameters:
        ///   - title: The localized string key for the button's title.
        ///   - isPrimaryAction: Indicates whether the button performs the main action of the alert, which visually distinguishes it (typically by making it bold).
        ///   - action: An optional closure that is executed when the button is tapped. If `nil`, tapping the button will close the alert without performing any additional actions.
        ///
        /// Example Usage:
        /// ```swift
        /// Action(title: "Retry", isPrimaryAction: true, action: {
        ///     // Perform the action
        /// })
        /// ```
        init(title: LocalizedStringKey, isPrimaryAction: Bool, action: (() -> Void)? = nil) {
            self.title = title
            self.role = .none
            self.isPrimaryAction = isPrimaryAction
            self.action = action
        }
    }
}

extension AlertConfiguration: Equatable {
    static func == (lhs: AlertConfiguration, rhs: AlertConfiguration) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.message == rhs.message &&
        lhs.actions == rhs.actions
    }
}

extension AlertConfiguration.Action: Equatable {
    static func == (lhs: AlertConfiguration.Action, rhs: AlertConfiguration.Action) -> Bool {
        lhs.title == rhs.title &&
        lhs.role == rhs.role &&
        lhs.isPrimaryAction == rhs.isPrimaryAction
    }
}
