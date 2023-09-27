//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// A suffix validation rule.
public struct SuffixValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The suffix.
    public let suffix: Input

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    public init(suffix: Input, error: IValidationError) {
        self.suffix = suffix
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        input.hasSuffix(suffix)
    }
}
