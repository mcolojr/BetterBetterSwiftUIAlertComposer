//
//  View+Extensions.swift
//  AlertComposer
//
//  Created by Michael Colonna on 5/13/25.
//

import SwiftUI

extension View {
    
    /// A modifier to a button to indicate it performs the principal action if specified;
    /// - Note: Ignored on watchOS.
    @ViewBuilder
    func performsPrincipalAction(if condition: Bool) -> some View {
        if condition {
            #if !os(watchOS)
            self.keyboardShortcut(.defaultAction)
            #else
            self
            #endif
        } else {
            self
        }
    }
}
