//
//  AlertConfiguration+Permissions.swift
//  CoupleDo
//
//  Created by Mikey Colonna on 2/23/24.
//

import SwiftUI

extension AlertConfiguration {
    
    /// Creates an alert configuration for when permission is denied for specific types like camera, contacts, or notifications.
    ///
    /// This function generates a tailored alert based on the type of permission that has been denied, offering the user guidance on how to grant the necessary permissions via the Settings app.
    /// An optional dismissal action can be provided, which is executed when the user dismisses the alert by tapping the "Close" button.
    /// Additionally, a button to directly open the Settings app is included as a primary action, facilitating easy access for the user to change the permissions.
    ///
    /// - Parameters:
    ///   - type: The type of permission that has been denied (`PermissionsType`), such as camera, contacts, or notifications.
    ///   - dismissAction: An optional closure that is called when the user dismisses the alert with the title "Close". If `nil`, the alert will only include the default close action.
    ///   - openSettingsAction: A closure that opens the Settings app. Pass in the logic to open the phone's Settings app (e.g: `UIApplication.shared.open(settingsUrl)`)
    /// - Returns: An `AlertConfiguration` tailored to inform the user about the denied permission and guide them to enable it through the Settings app.
    static func permissionsDenied(for type: PermissionsType, dismissAction: (() -> Void)? = nil, openSettingsAction: @escaping (() -> Void)) -> AlertConfiguration {
        var title: LocalizedStringKey
        var message: LocalizedStringKey
        
        switch type {
        case .camera:
            title = "Camera Access Denied"
            message = "You have denied access to the camera. You can change this in the Settings app."
        case .contacts:
            title = "Contacts Access Denied"
            message = "You have denied access to contacts. You can change this in the Settings app."
        case .notifications:
            title = "Notifications Permissions Needed"
            message =  "Please enable notification permissions. You can change this in the Settings app."
        }
        
        return AlertConfiguration(
            title: title,
            message: message,
            actions: Array {
                if let dismissAction {
                    Action(title: .close, isPrimaryAction: false, action: dismissAction)
                } else {
                    Action(title: .close, role: .cancel)
                }
                
                Action(title: "Open Settings", isPrimaryAction: true, action: {
                    openSettingsAction()
                    // Would be something like:
                    /*
                     if let settingsUrl = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl)
                     }
                     */
                })
            }
        )
    }
    
    /// Generates an alert configuration for when access to a feature (camera, contacts, notifications) is restricted.
    ///
    /// This function creates an alert that informs the user of a restriction on a specific feature, which might be due to parental controls or system settings.
    /// It provides a concise message to the user, explaining the restriction and suggesting a check on system settings for possible solutions.
    /// An optional dismissal action can be provided, which is executed when the user dismisses the alert by tapping the "Ok" button.
    ///
    /// - Parameters:
    ///   - type: The type of feature access being restricted (`PermissionsType`), such as camera, contacts, or notifications.
    ///   - dismissAction: An optional closure executed upon the alert's dismissal with the title "Ok". If `nil`, a standard "OK" button is presented for the user to acknowledge the message.
    /// - Returns: An `AlertConfiguration` aimed at notifying the user about the restriction and guiding them towards potential resolution steps.
    ///
    /// Usage of this alert is particularly relevant in environments where restrictions might be imposed externally, such as through parental controls or organizational policies.
    /// It serves to inform users about the nature of the restriction and suggests a course of action, enhancing user understanding and potentially guiding them towards resolving the access issue.
    ///
    /// - Note: If no dismiss action is provided, the system includes a standard “OK” action.
    static func permissionsRestricted(for type: PermissionsType, dismissAction: (() -> Void)? = nil) -> AlertConfiguration {
        var title: LocalizedStringKey
        var message: LocalizedStringKey
        
        switch type {
        case .camera:
            title = "Camera Access Restricted"
            message = "Camera access is restricted, possibly by parental or system settings."
        case .contacts:
            title = "Contacts Access Restricted"
            message = "Contacts access is restricted, possibly by parental or system settings."
        case .notifications:
            title = "Notifications Restricted"
            message = "Notifications are restricted, possibly by parental or system settings."
        }
        
        return AlertConfiguration(
            title: title,
            message: message,
            actions: Array {
                if let dismissAction {
                    Action(title: .ok, isPrimaryAction: true, action: dismissAction)
                }
                // If no actions are present, the system includes a standard “OK” action.
            }
        )
    }
}
