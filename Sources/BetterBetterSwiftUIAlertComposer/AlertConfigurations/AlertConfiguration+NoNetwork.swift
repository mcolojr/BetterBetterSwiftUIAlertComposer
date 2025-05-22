//
//  AlertConfigurations.swift
//  BetterBetterSwiftUIAlertComposer
//
//  Created by Michael Colonna on 2/23/24.
//  Copyright © 2024 Michael Colonna All rights reserved.
//

import SwiftUI

extension AlertConfiguration {
    
    /// Generates an alert configuration for scenarios with no network connectivity without any retry action.
    ///
    /// This variant of the no network alert provides a simple notification to the user about the lack of internet connectivity without offering an immediate action to rectify the situation.
    /// It is useful in contexts where the application does not require an immediate network connection or where automatic retry mechanisms are in place.
    ///
    /// - Returns: An `AlertConfiguration` for no network scenarios, containing only informational content without actionable buttons.
    ///
    /// - Note: By default, no actions are specified. The system will include a standard “OK” action to dismiss the alert.
    public static func noNetwork() -> AlertConfiguration {
        AlertConfiguration(
            title: "No network",
            message: "You appear to be offline. Make sure you are connected to Wi-Fi or your cellular network.",
            actions: []
        )
    }
    
    /// Creates an alert configuration for no network connectivity scenarios with a retry action.
    ///
    /// - Parameter retryAction: A closure that defines the action to take when the "Retry" button is tapped. This action is intended to attempt reconnection or refresh the content.
    /// - Returns: An `AlertConfiguration` tailored for situations where no network connection is detected, including actionable buttons for user response.
    ///
    /// This method provides a user-friendly way to notify users of network connectivity issues and offer them an immediate option to retry the operation, enhancing the application's resilience to temporary network problems.
    /// - Note: This alert will include a "Retry" button along with a "Cancel" button.
    public static func noNetwork(retryAction: @escaping () -> Void) -> AlertConfiguration {
        AlertConfiguration(
            title: "No network",
            message: "You appear to be offline. Make sure you are connected to Wi-Fi or your cellular network and try again.",
            actions: Array {
                Action(title: "Retry", isPrimaryAction: true, action: retryAction)
                Action(title: "Cancel", role: .cancel)
            }
        )
    }
}
