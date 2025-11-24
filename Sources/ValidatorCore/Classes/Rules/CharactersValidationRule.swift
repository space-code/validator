//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import Foundation

/// A characters validation rule.
public struct CharactersValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    // MARK: Properties

    public let characterSet: CharacterSet

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

    public init(characterSet: CharacterSet, error: IValidationError) {
        self.characterSet = characterSet
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        input.rangeOfCharacter(from: characterSet.inverted) == .none
    }
}
