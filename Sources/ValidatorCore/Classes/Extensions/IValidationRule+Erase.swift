//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

public extension IValidationRule {
    func eraseToAnyValidationRule() -> AnyValidationRule<Input> {
        AnyValidationRule(self)
    }
}
