//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import SwiftUI
import ValidatorCore

public extension View {
    /// Creates a view validation modifier.
    ///
    /// - Parameters:
    ///   - item: The binding item to validate.
    ///   - rules: The array of validation rules to apply to the item’s value.
    ///   - content: A custom parameter attribute that constructs an error view from closures.
    ///
    /// - Returns: A modified view.
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

    /// Creates a view validation modifier.
    ///
    /// - Parameters:
    ///   - validationContainer: The container to validate.
    ///   - content: A custom parameter attribute that constructs an error view from closures.
    ///
    /// - Returns: A modified view.
    func validate<ErrorView: View>(
        validationContainer: any IFormValidationContainer,
        @ViewBuilder content: @escaping ([any IValidationError]) -> ErrorView
    ) -> some View {
        modifier(
            FormValidationViewModifier(
                validationContainer: validationContainer,
                content: content
            )
        )
    }
}
