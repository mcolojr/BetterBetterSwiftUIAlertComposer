//
//  AlertConfiguration+UnknownError.swift
//  BetterBetterSwiftUIAlertComposer
//
//  Created by Michael Colonna on 2/23/24.
//  Copyright © 2024 Michael Colonna All rights reserved.
//

import SwiftUI

extension AlertConfiguration {
    
    /// Generates an alert configuration for handling unexpected errors with an optional retry action.
    ///
    /// - Parameter retryAction: An optional closure for the retry action. If provided, the alert will include a "Retry" button along with a "Cancel" button.
    /// If omitted, a default "OK" button is included to dismiss the alert.
    /// - Returns: An `AlertConfiguration` for unexpected errors, equipped with the specified actions.
    ///
    /// - Note: If a retry action is specified, this alert will include a "Retry" button along with a "Cancel" button. If not, the system will provide the default "Ok" button.
    static func unknownError(retryAction: (() -> Void)? = nil) -> AlertConfiguration {
        AlertConfiguration(
            title: "Unexpected Error",
            message: "An unexpected error has occurred",
            actions: Array {
                if let retryAction {
                    Action(title: "Retry", isPrimaryAction: true, action: retryAction)
                    Action(title: "Cancel", role: .cancel)
                }
                // If no actions are present, the system includes a standard “OK” action.
            }
        )
    }
}
