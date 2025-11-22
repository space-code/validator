//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import ValidatorCore

// MARK: - IUIValidatable

@MainActor
public protocol IUIValidatable: AnyObject {
    associatedtype Input

    /// The input value.
    var inputValue: Input { get }

    /// Validates an input value.
    ///
    /// - Parameters:
    ///   - rule: The validation rule.
    ///
    /// - Returns: A validation result.
    func validate(rule: some IValidationRule<Input>) -> ValidationResult

    /// Validates an input value.
    ///
    /// - Parameters:
    ///   - rules: The validation rules array.
    ///
    /// - Returns: A validation result.
    func validate<T>(rules: [any IValidationRule<T>]) -> ValidationResult where T == Input

    /// Validates an input value.
    ///
    /// - Parameter isEnabled: The
    func validateOnInputChange(isEnabled: Bool)
}

private nonisolated(unsafe) var kValidationRules: UInt8 = 0
private nonisolated(unsafe) var kValidationHandler: UInt8 = 0

// swiftlint:disable:next prefixed_toplevel_constant
private nonisolated(unsafe) let validator = Validator()

public extension IUIValidatable {
    @discardableResult
    func validate(rule: some IValidationRule<Input>) -> ValidationResult {
        let result = validator.validate(input: inputValue, rule: rule)
        validationHandler?(result)
        return result
    }

    @discardableResult
    func validate(rules: [any IValidationRule<Input>]) -> ValidationResult {
        let result = validator.validate(input: inputValue, rules: rules)
        validationHandler?(result)
        return result
    }

    func add(rule: some IValidationRule<Input>) {
        validationRules.append(rule)
    }

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

    var validationHandler: ((ValidationResult) -> Void)? {
        get {
            objc_getAssociatedObject(self, &kValidationHandler) as? ((ValidationResult) -> Void)
        }
        set {
            if let newValue {
                objc_setAssociatedObject(self, &kValidationHandler, newValue as AnyObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
