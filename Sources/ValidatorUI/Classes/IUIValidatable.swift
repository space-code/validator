//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import ValidatorCore

// MARK: - IUIValidatable

/// A protocol defining the contract for UI components that can be validated.
///
/// Conforming types are expected to provide an input value and support validation
/// using one or multiple rules. This protocol is intended to be used in a UI context,
/// where validation can optionally be triggered automatically when the input changes.
///
/// - Note: This protocol is marked with `@MainActor` to ensure all validation-related
///         operations occur on the main thread, making it safe for UI updates.
///
/// - Associated Type:
///   - `Input`: The type of the input value to be validated.
@MainActor
public protocol IUIValidatable: AnyObject {
    associatedtype Input

    /// The input value that needs to be validated.
    var inputValue: Input { get }

    /// The most recent validation result, if any.
    ///
    /// This value is updated automatically when calling `validate(rules:)`.
    /// Implementations may use this property to drive UI updates.
    var validationResult: ValidationResult? { get }

    /// Validates the input value using a single rule.
    ///
    /// - Parameter rule: A validation rule conforming to `IValidationRule`.
    ///
    /// - Returns: The result of the validation (`ValidationResult`).
    func validate(rule: some IValidationRule<Input>) -> ValidationResult

    /// Validates the input value using multiple rules.
    ///
    /// - Parameter rules: An array of validation rules.
    ///
    /// - Returns: The result of the validation (`ValidationResult`).
    func validate<T>(rules: [any IValidationRule<T>]) -> ValidationResult where T == Input

    /// Optionally triggers validation when the input changes.
    ///
    /// - Parameter isEnabled: Whether automatic validation on input change is enabled.
    func validateOnInputChange(isEnabled: Bool)
}

// MARK: - Associated Object Keys

// Keys used for storing associated objects (validation rules, handlers, and a validation result)
private nonisolated(unsafe) var kValidationRules: UInt8 = 0
private nonisolated(unsafe) var kValidationHandler: UInt8 = 0
private nonisolated(unsafe) var kValidationResult: UInt8 = 0

// Validator instance shared for UI validation
// swiftlint:disable:next prefixed_toplevel_constant
private let validator = Validator()

public extension IUIValidatable {
    /// Validates the input with a single rule and triggers the validation handler if set.
    ///
    /// - Parameter rule: The validation rule.
    ///
    /// - Returns: The validation result.
    @discardableResult
    func validate(rule: some IValidationRule<Input>) -> ValidationResult {
        let result = validator.validate(input: inputValue, rule: rule)
        validationHandler?(result)
        return result
    }

    /// Validates the input with multiple rules and triggers the validation handler if set.
    ///
    /// - Parameter rules: An array of validation rules.
    ///
    /// - Returns: The validation result.
    @discardableResult
    func validate(rules: [any IValidationRule<Input>]) -> ValidationResult {
        let result = validator.validate(input: inputValue, rules: rules)
        validationHandler?(result)
        validationResult = result
        return result
    }

    /// Adds a new validation rule to the associated list of rules for this UI element.
    ///
    /// - Parameter rule: The validation rule to add.
    func add(rule: some IValidationRule<Input>) {
        validationRules.append(rule)
    }

    /// The most recent validation result, if any.
    ///
    /// This value is updated automatically when calling `validate(rules:)`.
    /// Implementations may use this property to drive UI updates.
    private(set) var validationResult: ValidationResult? {
        get {
            (objc_getAssociatedObject(self, &kValidationResult) as? AnyObject) as? ValidationResult
        }
        set {
            objc_setAssociatedObject(
                self,
                &kValidationResult,
                newValue as ValidationResult?,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    /// The array of validation rules associated with this UI element.
    var validationRules: [any IValidationRule<Input>] {
        get {
            (objc_getAssociatedObject(self, &kValidationRules) as? AnyObject) as? [any IValidationRule<Input>] ?? []
        }
        set {
            objc_setAssociatedObject(
                self,
                &kValidationRules,
                newValue as [any IValidationRule<Input>],
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    /// The handler called after validation is performed.
    /// Can be used to update UI (e.g., show error messages).
    var validationHandler: ((ValidationResult) -> Void)? {
        get {
            objc_getAssociatedObject(self, &kValidationHandler) as? ((ValidationResult) -> Void)
        }
        set {
            if let newValue {
                objc_setAssociatedObject(
                    self,
                    &kValidationHandler,
                    newValue as AnyObject,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
