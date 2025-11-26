# Quick Start

This guide will help you quickly integrate ValidatorUI into your iOS projects. ValidatorUI is a lightweight and flexible framework designed to provide type-safe input validation for both UIKit and SwiftUI components. It supports single field validation, multiple rules, real-time validation, and full form validation, making it easy to maintain clean, reliable, and user-friendly forms.

In this guide, you will learn how to:
- Add validation to a single field in UIKit and SwiftUI.
- Enable real-time validation for user input.
- Manage multiple fields in a form.
- Display validation errors with custom UI.

By following this guide, you will have a fully functional validation system up and running in your app in just a few minutes.

## UIKit Integration

UIKit integration allows you to add validation directly to standard UI components such as UITextField. Validation rules can be applied individually, and you can also listen for validation results to update the UI dynamically.

```swift
import UIKit
import ValidatorUI
import ValidatorCore

class ViewController: UIViewController {
    let emailField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add validation rules
        emailField.add(
            rule: RegexValidationRule(
                pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                error: "Please enter a valid email"
            )
        )
        
        // Enable real-time validation
        emailField.validateOnInputChange(isEnabled: true)
        
        // Handle validation results
        emailField.validationHandler = { result in
            switch result {
            case .valid:
                self.updateUI(isValid: true)
            case .invalid(let errors):
                self.showErrors(errors)
            }
        }
    }
}
```

Tips for UIKit:
- You can attach multiple rules to a single field; all rules will be evaluated when validating.
- `.validateOnInputChange(isEnabled:)` allows instant feedback to users without manually triggering validation.
- The `validationHandler` closure lets you update UI elements like borders, labels, or icons based on validation results.

## SwiftUI Integration

SwiftUI provides a more declarative approach. You can attach validation rules directly to your state variables and update the view automatically based on validation results.

### Single Field Validation

Use the `.validation()` modifier for simple field validation. This approach is perfect for short forms or single input fields.

```swift
import SwiftUI
import ValidatorUI
import ValidatorCore

struct LoginView: View {
    @State private var email = ""
    
    var body: some View {
        TextField("Email", text: $email)
            .validation($email, rules: [
                RegexValidationRule(
                    pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                    error: "Invalid email"
                )
            ]) { result in
                if case .invalid(let errors) = result {
                    print("Validation errors: \(errors)")
                }
            }
    }
}
```

For more control over error display, you can use `.validate()` with a custom view:

```swift
struct LoginView: View {
    @State private var password = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            SecureField("Password", text: $password)
                .validate(item: $password, rules: [
                    LengthValidationRule(min: 8, error: "Too short")
                ]) { errors in
                    ForEach(errors, id: \.message) { error in
                        Text(error.message)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
        }
    }
}
```

Tips for SwiftUI:
- You can chain multiple validation rules for a single field.
- Validation automatically updates the view whenever the bound state changes.
- Use custom error views to match your app’s design system.

### Form Validation

For larger forms with multiple fields, ``FormFieldManager`` helps manage all validations in one place. It tracks the state of each field and allows you to check overall form validity.

```swift
import Combine
import SwiftUI
import ValidatorUI
import ValidatorCore

class RegistrationForm: ObservableObject {
    @Published var manager = FormFieldManager()
    
    @FormField(rules: [
        LengthValidationRule(min: 2, max: 50, error: "Invalid name length")
    ])
    var firstName = ""
    
    @FormField(rules: [
        LengthValidationRule(min: 2, max: 50, error: "Invalid name length")
    ])
    var lastName = ""
    
    @FormField(rules: [
        RegexValidationRule(
            pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
            error: "Invalid email"
        )
    ])
    var email = ""
    
    lazy var firstNameContainer = _firstName.validate(manager: manager)
    lazy var lastNameContainer = _lastName.validate(manager: manager)
    lazy var emailContainer = _email.validate(manager: manager)
}

struct RegistrationView: View {
    @StateObject private var form = RegistrationForm()
    @State private var isFormValid = false

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
    
    private func submitForm() {
        print("✅ Form is valid, submitting...")
    }
}
```

Form Validation Notes:
- Use ``FormField`` property wrapper to declare each field with its rules.
- ``FormFieldManager`` tracks all fields and exposes $isValid for reactive UI updates.
- Validation containers allow you to render errors inline or in custom views.
- Submitting the form should trigger `manager.validate()` to ensure all fields are checked.

## Summary

- UIKit: Add rules directly to fields, enable real-time validation, and handle results in closures.
- SwiftUI: Use `.validation()` or `.validate()` modifiers for reactive validation.
- Forms: ``FormFieldManager`` allows managing multiple fields, tracking validity, and handling submissions.

ValidatorUI makes it easy to maintain consistent validation across your app while keeping the code clean, type-safe, and UI-friendly.
