//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// A prefix validation rule.
public struct PrefixValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The prefix.
    public let prefix: Input

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    public init(prefix: Input, error: IValidationError) {
        self.prefix = prefix
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        input.hasPrefix(prefix)
    }
}
