//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// Validates that a string is a valid email address.
/// Uses a regular expression conforming to RFC 5322 (simplified).
///
/// # Example:
/// ```swift
/// let rule = EmailValidationRule(error: "Invalid email")
/// rule.validate(input: "user@example.com") // true
/// ```
public struct EmailValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// Validation error returned if the email is invalid.
    public let error: IValidationError

    // MARK: Initialization

    /// Initializes an email validation rule.
    ///
    /// - Parameters:
    ///   - error: The validation error to return if input fails validation.
    public init(error: IValidationError) {
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        let range = NSRange(location: .zero, length: input.count)
        if let regex = try? NSRegularExpression(
            // swiftlint:disable:next line_length
            pattern: "^(?!\\.)(?!.*\\.\\.)[A-Z0-9a-z._%+-]+(?<!\\.)@[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?(?:\\.[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?)*\\.[A-Za-z]{2,64}$",
            options: [.caseInsensitive]
        ) {
            return regex.firstMatch(in: input, range: range) != nil
        }
        return false
    }
}
