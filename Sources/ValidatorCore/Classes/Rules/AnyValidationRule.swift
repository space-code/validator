//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

public struct AnyValidationRule<Input>: IValidationRule {
    // MARK: Properties

    private let validationClosure: (Input) -> Bool

    public var error: IValidationError

    // MARK: Initialization

    public init<Rule: IValidationRule>(_ rule: Rule) where Rule.Input == Input {
        validationClosure = rule.validate
        error = rule.error
    }

    // MARK: IValidationRule

    public func validate(input: Input) -> Bool {
        validationClosure(input)
    }
}
