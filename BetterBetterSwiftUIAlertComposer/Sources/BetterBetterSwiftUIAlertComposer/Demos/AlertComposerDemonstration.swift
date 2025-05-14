//
//  AlertComposerDemonstration.swift
//  CoupleDo
//
//  Created by Mikey Colonna on 2/23/24.
//

import SwiftUI

struct AlertComposerDemonstration: View {
    @State private var currentAlertConfiguration: AlertConfiguration?
    
    var body: some View {
        List {
            Button("Show Alert") {
                currentAlertConfiguration = .specific(title: "Title", message: "Message", retryAction: {
                    print("Retry action triggered")
                })
            }
            
            Button("Show Alert 2") {
                currentAlertConfiguration = AlertConfiguration(
                    title: "Title",
                    message: "Message",
                    actions: [
                        .init(title: "Primary action", isPrimaryAction: true, action: {
                            print("Primary action triggered")
                        }),
                        .init(title: "Secondary action", isPrimaryAction: false, action: {
                            print("Secondary action triggered")
                        }),
                        .init(title: "Delete", role: .destructive, action: {
                            print("Delete triggered")
                        }),
                        .init(title: "Cancel", role: .cancel)
                    ]
                )
            }
        }
        .alertComposer(currentAlertConfiguration)
    }
}

#Preview {
    AlertComposerDemonstration()
}
