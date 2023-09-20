//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// A length validation rule.
public struct LengthValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    /// The minimum length.
    public let min: Int

    /// The maximum length.
    public let max: Int

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    public init(min: Int, max: Int, error: IValidationError) {
        self.min = min
        self.max = max
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        let length = input.count
        return length >= min && length <= max
    }
}
