![A powerful, type-safe validation framework for Swift](https://raw.githubusercontent.com/space-code/validator/main/Resources/validator.png)

<h1 align="center" style="margin-top: 0px;">validator</h1>

<p align="center">
<a href="https://github.com/space-code/validator/blob/main/LICENSE"><img alt="Licence" src="https://img.shields.io/cocoapods/l/service-core.svg?style=flat"></a> 
<a href="https://swiftpackageindex.com/space-code/validator"><img alt="Swift Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Fvalidator%2Fbadge%3Ftype%3Dswift-versions"/></a> 
<a href="https://swiftpackageindex.com/space-code/validator"><img alt="Platform Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Fvalidator%2Fbadge%3Ftype%3Dplatforms"/></a> 
<a href="https://github.com/space-code/validator/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/space-code/validator/actions/workflows/ci.yml/badge.svg?branch=main"></a>
<a href="https://github.com/apple/swift-package-manager" alt="Validator on Swift Package Manager" title="Validator on Swift Package Manager"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" /></a>
<a href="https://codecov.io/gh/space-code/validator" >  <img src="https://codecov.io/gh/space-code/validator/graph/badge.svg?token=3B8FE96372"/>  </a>
</p>

## Description
Validator is a modern, lightweight Swift framework that provides elegant and type-safe input validation. Built with Swift's powerful type system, it seamlessly integrates with both UIKit and SwiftUI, making form validation effortless across all Apple platforms.

## Features

✨ **Type-Safe Validation** - Leverages Swift's type system for compile-time safety  
🎯 **Rich Rule Set** - Built-in validators for common use cases  
🔧 **Extensible** - Easy to create custom validation rules  
📱 **UIKit Integration** - First-class support for UITextField and other UIKit components  
🎨 **SwiftUI Native** - Property wrappers and view modifiers for declarative validation  
📋 **Form Management** - Validate multiple fields with centralized state management  
⚡ **Lightweight** - Minimal footprint with zero dependencies  
🧪 **Well Tested** - Comprehensive test coverage  

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage](#usage)
  - [Core Validation](#core-validation)
  - [UIKit Integration](#uikit-integration)
  - [SwiftUI Integration](#swiftui-integration)
  - [Form Validation](#form-validation)
- [Built-in Validators](#built-in-validators)
- [Custom Validators](#custom-validators)
- [Examples](#examples)
- [Communication](#communication)
- [Contributing](#contributing)
    - [Development Setup](#development-setup)
    - [Code of Conduct](#code-of-conduct)
- [License](#license)

## Requirements

| Platform  | Minimum Version |
|-----------|----------------|
| iOS       | 16.0+          |
| macOS     | 13.0+          |
| tvOS      | 16.0+          |
| watchOS   | 9.0+           |
| visionOS  | 1.0+           |
| Xcode     | 15.3+          |
| Swift     | 5.10+          |

## Usage

The package contains two libraries: `ValidatorCore` encompasses all validation logic and predefined validators, while `ValidatorUI` implements extensions for integrating the validator into UI objects. It supports both `SwiftUI` and `UIKit`.

## Installation

### Swift Package Manager

Add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/space-code/validator.git", from: "1.3.0")
]
```

Or add it through Xcode:

1. File > Add Package Dependencies
2. Enter package URL: `https://github.com/space-code/validator.git`
3. Select version requirements

## Quick Start

```swift
import ValidatorCore

let validator = Validator()
let result = validator.validate(
    input: "user@example.com",
    rule: RegexValidationRule(
        pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
        error: "Invalid email address"
    )
)

switch result {
case .valid:
    print("✅ Valid input")
case .invalid(let errors):
    print("❌ Validation failed: \(errors.map(\.message))")
}
```

## Usage

The framework provides two main libraries:

- **ValidatorCore** - Core validation logic and predefined validators
- **ValidatorUI** - UI integration for UIKit and SwiftUI

### Core Validation

Validate any input with the `Validator` class:

```swift
import ValidatorCore

let validator = Validator()
let result = validator.validate(
    input: "password123",
    rule: LengthValidationRule(
        min: 8,
        error: "Password must be at least 8 characters"
    )
)
```

### UIKit Integration

Import `ValidatorUI` to add validation to UIKit components:

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

### SwiftUI Integration

#### Single Field Validation

Use the `.validation()` modifier for simple field validation:

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

Or use `.validate()` with a custom error view:

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

### Form Validation

Manage multiple fields with `FormFieldManager`:

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

## Built-in Validators

| Validator | Description | Example |
|-----------|-------------|---------|
| `LengthValidationRule` | Validates string length (min/max) | `LengthValidationRule(min: 3, max: 20, error: "Length must be 3-20 characters")` |
| `NonEmptyValidationRule` | Ensures string is not empty or blank | `NonEmptyValidationRule(error: "Field is required")` |
| `PrefixValidationRule` | Validates string prefix | `PrefixValidationRule(prefix: "https://", error: "URL must start with https://")` |
| `SuffixValidationRule` | Validates string suffix | `SuffixValidationRule(suffix: ".com", error: "Domain must end with .com")` |
| `RegexValidationRule` | Pattern matching validation | `RegexValidationRule(pattern: "^\\d{3}-\\d{4}$", error: "Invalid phone format")` |
| `URLValidationRule` | Validates URL format | `URLValidationRule(error: "Please enter a valid URL")` |
| `CreditCardValidationRule` | Validates credit card numbers (Luhn algorithm) | `CreditCardValidationRule(error: "Invalid card number")` |
| `EmailValidationRule` | Validates email format | `EmailValidationRule(error: "Please enter a valid email")` |
| `CharactersValidationRule` | Validates that a string contains only characters from the allowed CharacterSet | `CharactersValidationRule(characterSet: .letters, error: "Invalid characters")` |
| `NilValidationRule` | Validates that value is nil | `NilValidationRule(error: "Value must be nil")`
| `PositiveNumberValidationRule` | Validates that value is positive | `PositiveNumberValidationRule(error: "Value must be positive")`

## Custom Validators

Create custom validation rules by conforming to `IValidationRule`:

```swift
import ValidatorCore

struct EmailDomainValidationRule: IValidationRule {
    typealias Input = String
    
    let allowedDomains: [String]
    let error: IValidationError
    
    init(allowedDomains: [String], error: IValidationError) {
        self.allowedDomains = allowedDomains
        self.error = error
    }
    
    func validate(input: String) -> Bool {
        guard let domain = input.split(separator: "@").last else {
            return false
        }
        return allowedDomains.contains(String(domain))
    }
}

// Usage
let rule = EmailDomainValidationRule(
    allowedDomains: ["company.com", "company.org"],
    error: "Only company email addresses are allowed"
)
```

### Composing Validators

Combine multiple validators for complex validation logic:

```swift
// Define reusable validation rules
let lengthRule = LengthValidationRule(
    min: 8,
    max: 128,
    error: "Password must be 8-128 characters"
)

let uppercaseRule = RegexValidationRule(
    pattern: ".*[A-Z].*",
    error: "Must contain uppercase letter"
)

let lowercaseRule = RegexValidationRule(
    pattern: ".*[a-z].*",
    error: "Must contain lowercase letter"
)

let numberRule = RegexValidationRule(
    pattern: ".*[0-9].*",
    error: "Must contain number"
)

let specialCharRule = RegexValidationRule(
    pattern: ".*[!@#$%^&*(),.?\":{}|<>].*",
    error: "Must contain special character"
)

// UIKit: Pass all rules to your text field
passwordField.add(rules: [
    lengthRule,
    uppercaseRule,
    lowercaseRule,
    numberRule,
    specialCharRule
])

// SwiftUI: Use in validation modifier
SecureField("Password", text: $password)
    .validation($password, rules: [
        lengthRule,
        uppercaseRule,
        lowercaseRule,
        numberRule,
        specialCharRule
    ]) { result in
        if case .invalid(let errors) = result {
            self.passwordErrors = errors
        }
    }
```

## Examples

You can find usage examples in the [Examples](./Examples/) directory of the repository.  

These examples demonstrate how to integrate the package, configure validation rules,  
and build real-world user interfaces using `ValidatorCore` and `ValidatorUI`.

## Communication

- 🐛 **Found a bug?** [Open an issue](https://github.com/space-code/validator/issues/new?template=bug_report.md)
- 💡 **Have a feature request?** [Open an issue](https://github.com/space-code/validator/issues/new?template=feature_request.md)
- ❓ **Questions?** [Start a discussion](https://github.com/space-code/validator/discussions)
- 🔒 **Security issue?** Email nv3212@gmail.com

## Contributing

We love contributions! Please read our [Contributing Guide](CONTRIBUTING.md) to learn about our development process, how to propose bugfixes and improvements, and how to build and test your changes.

### Development Setup

Bootstrap the development environment:

```bash
mise install
```

### Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Author

**Nikita Vasilev**
- Email: nv3212@gmail.com
- GitHub: [@ns-vasilev](https://github.com/ns-vasilev)

## License

Validator is released under the MIT license. See [LICENSE](LICENSE) for details.

---

<div align="center">

**[⬆ back to top](#validator)**

Made with ❤️ by [space-code](https://github.com/space-code)

</div>
