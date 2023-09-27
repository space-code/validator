//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// A non empty validation rule.
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
