//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// Validates that a string is not empty.
///
/// # Example:
/// ```swift
/// let rule = NonEmptyValidationRule(error: "Field required")
/// rule.validate(input: "") // false
/// rule.validate(input: "Text") // true
/// ```
public struct NonEmptyValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    public init(error: IValidationError) {
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        !input.isEmpty
    }
}
