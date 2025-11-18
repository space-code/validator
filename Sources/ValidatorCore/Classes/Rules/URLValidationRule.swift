//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import Foundation

/// A url validation rule.
public struct URLValidationRule: IValidationRule {
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
        guard let url = URL(string: input) else { return false }
        return url.isFileURL || (url.host != nil && url.scheme != nil)
    }
}
