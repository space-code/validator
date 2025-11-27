//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import Combine
import SwiftUI
import ValidatorCore
import ValidatorUI

struct RegistrationView: View {
    // MARK: Properties

    @StateObject private var form = RegistrationForm()
    @State private var isFormValid = false

    // MARK: View

    var body: some View {
        Form {
            Section("Personal Information") {
                TextField("First Name", text: $form.firstName)
                    .validate(validationContainer: form.firstNameContainer) { errors in
                        ErrorView(errors: errors)
                    }

                TextField("Last Name", text: $form.lastName)
                    .validate(validationContainer: form.lastNameContainer) { errors in
                        ErrorView(errors: errors)
                    }
            }

            Section("Contact") {
                TextField("Email", text: $form.email)
                    .validate(validationContainer: form.emailContainer) { errors in
                        ErrorView(errors: errors)
                    }
            }

            Section {
                Button("Submit") {
                    form.manager.validate()
                }
                .disabled(!isFormValid)
            }
        }
        .onReceive(form.manager.$isValid) { newValue in
            isFormValid = newValue
        }
    }

    // MARK: Private

    private func submitForm() {
        print("✅ Form is valid, submitting...")
    }
}

// MARK: Preview

#Preview {
    RegistrationView()
}
