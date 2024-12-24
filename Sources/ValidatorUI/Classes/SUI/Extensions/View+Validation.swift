//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import SwiftUI
import ValidatorCore

#if swift(>=5.10)
    // swiftlint:disable:next prefixed_toplevel_constant
    private nonisolated(unsafe) let validator = Validator()
#else
    // swiftlint:disable:next prefixed_toplevel_constant
    private let validator = Validator()
#endif

public extension View {
    /// Validate a binding item using a set of validation rules and perform an action based on
    /// the validation result.
    ///
    /// This function takes a binding item, a validation rule, and a closure to handle
    /// the validation result.
    /// It validates the wrapped value of the binding item against the specified rule and then
    /// invokes the provided action with the result.
    ///
    /// - Parameters:
    ///   - item: The binding item to validate.
    ///   - rule: A validation rule to apply to the item's value.
    ///   - action: A closure that takes a `ValidationResult` as its parameter.
    ///             This closure is called with the validation result after the validation is performed.
    ///
    /// - Returns: A view that can be modified further or used in your SwiftUI hierarchy.
    func validation<T>(
        _ item: Binding<T>,
        rule: some IValidationRule<T>,
        action: @escaping (ValidationResult) -> Void
    ) -> some View {
        validation(item, rules: [rule], action: action)
    }

    /// Validate a binding item using a set of validation rules and perform an action based on
    /// the validation result.
    ///
    /// This function takes a binding item, an array of validation rules, and a closure to handle
    /// the validation result.
    /// It validates the wrapped value of the binding item against the specified rules and then
    /// invokes the provided action with the result.
    ///
    /// - Parameters:
    ///   - item: The binding item to validate.
    ///   - rules: An array of validation rules to apply to the item's value.
    ///   - action: A closure that takes a `ValidationResult` as its parameter.
    ///             This closure is called with the validation result after the validation is performed.
    ///
    /// - Returns: A view that can be modified further or used in your SwiftUI hierarchy.
    func validation<T>(
        _ item: Binding<T>,
        rules: [any IValidationRule<T>],
        action: @escaping (ValidationResult) -> Void
    ) -> some View {
        let result = validator.validate(input: item.wrappedValue, rules: rules)
        action(result)
        return self
    }
}
