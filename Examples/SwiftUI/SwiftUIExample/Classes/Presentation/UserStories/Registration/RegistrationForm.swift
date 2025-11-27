//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import Combine
import SwiftUI
import ValidatorCore
import ValidatorUI

final class RegistrationForm: ObservableObject {
    // MARK: Properties

    @Published var manager = FormFieldManager()

    @FormField(
        rules: [
            LengthValidationRule(min: 2, max: 50, error: "Invalid name length"),
        ],
        debounce: 0.8
    )
    var firstName = ""

    @FormField(
        rules: [
            LengthValidationRule(min: 2, max: 50, error: "Invalid name length"),
        ],
        debounce: 0.8
    )
    var lastName = ""

    @FormField(
        rules: [
            EmailValidationRule(error: "Invalid email"),
        ],
        debounce: 0.8
    )
    var email = ""

    lazy var firstNameContainer = _firstName.validate(manager: manager)
    lazy var lastNameContainer = _lastName.validate(manager: manager)
    lazy var emailContainer = _email.validate(manager: manager)
}
