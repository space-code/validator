//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// Validates that a string represents a valid UUID.
///
/// # Example:
/// ```swift
/// let rule = UUIDValidationRule(error: "Invalid UUID")
/// rule.validate(input: "47273ec2-e638-4702-8325-dcf82ed6a95b") // true
/// rule.validate(input: "47273ec2") // false
/// ```
public struct UUIDValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The validation error returned if the input is not a valid UUID.
    public let error: IValidationError

    // MARK: Initialization

    /// Initializes a URL validation rule.
    ///
    /// - Parameter error: The validation error returned if input fails validation.
    public init(error: IValidationError) {
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        UUID(uuidString: input) != nil
    }
}
