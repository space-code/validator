//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// Validates that a string represents a valid URL.
///
/// # Example:
/// ```swift
/// let rule = URLValidationRule(error: "Invalid URL")
/// rule.validate(input: "https://example.com") // true
/// rule.validate(input: "not_a_url") // false
/// ```

public struct URLValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The validation error returned if the input is not a valid URL.
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
        guard let url = URL(string: input) else { return false }
        return url.isFileURL || (url.host != nil && url.scheme != nil)
    }
}
