//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import SwiftUI
import ValidatorCore

public extension View {
    func validate<T, ErrorView: View>(
        item: Binding<T>,
        rules: [any IValidationRule<T>],
        @ViewBuilder content: @escaping ([any IValidationError]) -> ErrorView
    ) -> some View {
        modifier(
            ValidationViewModifier(
                item: item,
                rules: rules,
                content: content
            )
        )
    }
}
