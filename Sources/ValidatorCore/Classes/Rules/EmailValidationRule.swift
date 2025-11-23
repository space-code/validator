//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// An email validation rule.
public struct EmailValidationRule: IValidationRule {
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
