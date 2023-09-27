//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

extension ValidationResult: Equatable {
    public static func == (lhs: ValidationResult, rhs: ValidationResult) -> Bool {
        switch (lhs, rhs) {
        case (.valid, .valid):
            return true
        case let (.invalid(errors: lhs), .invalid(errors: rhs)):
            return lhs.map(\.message).joined() == rhs.map(\.message).joined()
        default:
            return false
        }
    }
}
