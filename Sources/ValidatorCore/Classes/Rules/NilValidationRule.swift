//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// A nil validation rule.
public struct NilValidationRule<T>: IValidationRule {
    // MARK: Types

    public typealias Input = T?

    // MARK: Properties

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    public init(error: IValidationError) {
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: T?) -> Bool {
        input == nil
    }
}
