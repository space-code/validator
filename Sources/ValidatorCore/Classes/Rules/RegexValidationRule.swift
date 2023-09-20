//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// A regular expression validation rule.
public struct RegexValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The regular expression pattern.
    public let pattern: String
    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    public init(pattern: String, error: IValidationError) {
        self.pattern = pattern
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        let range = NSRange(location: .zero, length: input.count)
        if let regex = try? NSRegularExpression(pattern: pattern) {
            return regex.firstMatch(in: input, range: range) != nil
        }
        return false
    }
}
