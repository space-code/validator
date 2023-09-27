![Validator: xxxxx](https://raw.githubusercontent.com/space-code/validator/dev/Resources/validator.png)

<h1 align="center" style="margin-top: 0px;">validator</h1>

<p align="center">
<a href="https://github.com/space-code/validator/blob/main/LICENSE"><img alt="Liscence" src="https://img.shields.io/cocoapods/l/service-core.svg?style=flat"></a> 
<a href="https://developer.apple.com/"><img alt="Platform" src="https://img.shields.io/badge/platform-ios%20%7C%20osx%20%7C%20watchos%20%7C%20tvos-%23989898"/></a> 
<a href="https://developer.apple.com/swift"><img alt="Swift5.5" src="https://img.shields.io/badge/language-Swift5.7-orange.svg"/></a>
<a href="https://github.com/space-code/validator"><img alt="CI" src="https://github.com/space-code/validator/actions/workflows/ci.yml/badge.svg?branch=main"></a>
<a href="https://github.com/apple/swift-package-manager" alt="Validator on Swift Package Manager" title="Validator on Swift Package Manager"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" /></a>
<a href="https://codecov.io/gh/space-code/validator" >  <img src="https://codecov.io/gh/space-code/validator/graph/badge.svg?token=3B8FE96372"/>  </a>
</p>

## Description
Validator is a framework written in Swift that provides functions that can be used to validate the contents of an input value.

- [Usage](#usage)
- [Validation Rules](#validation-rules)
- [Custom Validation Rules](#custom-validation-rules)
- [Requirements](#requirements)
- [Installation](#installation)
- [Communication](#communication)
- [Contributing](#contributing)
- [Author](#author)
- [License](#license)

## Usage

The package contains two libraries: `ValidatorCore` encompasses all validation logic and predefined validators, while `ValidatorUI` implements extensions for integrating the validator into UI objects. It supports both `SwiftUI` and `UIKit`.

### Basic usage

If you need to validate some data, you can use the `Validator` object for this purpose as follows:

```swift
import ValidatorCore

let validator = Validator()
let result = validator.validate(input: "text", rule: LengthValidationRule(min: 4, error: "error text"))

switch result {
case .valid:
    print("text is valid")
case let .invalid(errors):
    // handle validation errors
    print(errors)
}
```

### UIKit

If you want to validate a user's input data, you can import `ValidatorUI` and integrate validation logic into UI components. Your UI object must conform to `IUIValidatable` prototocol that requires to define an `inputValue` and `validateOnInputChange(_:)` method.

`ValidatorUI` supports an extension for convenient integration of the validator into `UITextField` objects:

```swift
import UIKit
import ValidatorUI
import ValidatorCore

class ViewController: UIViewController {

    let textField: UITextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Adds validation rule to the text field.
        textField.add(rule: LengthValidationRule(max: 10, error: "error text"))
        /// Enables automatic validation on input change.
        textField.validateOnInputChange(isEnabled: true)
        /// Handels validation result.
        textField.validationHandler = { result in
            switch result {
            case .valid:
                print("text is valid")
            case let .invalid(errors):
                print(errors)
            }
        }
    }

    /// Setup UITextField ...
}
```

### SwiftUI

If you need to validate a single field, you can use the validation view extension and handle the validation result in a validation handler:

```swift
import SwiftUI
import ValidatorUI
import ValidatorCore

struct ContentView: View {
    @State private var text: String = ""
    
    private let validationRules: [any IValidationRule<String>] = [
        LengthValidationRule(max: 10, error: "Text error")
    ]
    
    var body: some View {
        VStack {
            TextField("Text", text: $text)
                .validation($text, rules: validationRules) { result in
                    // Handle a validation result here
                }
        }
    }
}
```

You can also use a view modifier where you can pass an error view:

```swift
import SwiftUI
import ValidatorUI
import ValidatorCore

struct ContentView: View {
    @State private var text: String = ""
    
    private let validationRules: [any IValidationRule<String>] = [
        LengthValidationRule(max: 10, error: "Text error")
    ]
    
    var body: some View {
        VStack {
            TextField("Text", text: $text)
                .validate(item: $text, rules: validationRules) { errors in
                    Text("Text is bigger than 10 characters")
                }
        }
    }
}
```

### SwiftUI Forms

`ValidatorUI` supports form validation. If your screen contains a number of input fields and you want to handle validation results in one place, you can use a validation form manager as follows:

```swift
import SwiftUI
import ValidatorUI
import ValidatorCore

class Form: ObservableObject {
    @Published
    var manager = FormFieldManager()

    @FormField(rules: [LengthValidationRule(max: 20, error: "The first name is very long")])
    var firstName: String = ""

    @FormField(rules: [LengthValidationRule(min: 5, error: "The last name is too short")])
    var lastName: String = ""
    
    lazy var firstNameValidationContainer = _firstName.validate(manager: manager)
    lazy var lastNameValidationContainer = _lastName.validate(manager: manager)
}

struct ContentView: View {
    @ObservedObject private var form = Form()

    var body: some View {
        VStack {
            TextField("First Name", text: $form.firstName)
                .validate(validationContainer: form.firstNameValidationContainer) { errors in
                    Text(errors.map { $0.message }.joined(separator: " "))
                }
            TextField("Last Name", text: $form.lastName)
                .validate(validationContainer: form.lastNameValidationContainer) { errors in
                    Text(errors.map { $0.message }.joined(separator: " "))
                }
            Button(action: { self.form.manager.validate() }, label: { Text("Validate") })

            Spacer()
        }
        .onReceive(
            form.manager.$isValid,
            perform: { value in
                if value {
                    print("The form's fields are valid")
                } else {
                    print("The form's fileds aren't valid")
                }
            }
        )
    }
}
```

## Validation Rules

| **Validator**              | **Description**                                                                     |
|----------------------------|-------------------------------------------------------------------------------------|
| **LengthValidationRule**   | To validate whether a string is matching a specific length                          |
| **NonEmptyValidationRule** | To validate whether a string is empty or blank                                      |
| **PrefixValidationRule**   | To validate whether a string contains a prefix                                      |
| **SuffixValidationRule**   | To validate whether a string contains a suffix                                      |
| **RegexValidationRule**    | To validate if a pattern is matched                                                 |

## Custom Validation Rules

To implement a custom validation rule, you can conform to the `IValidationRule` protocol, which requires defining a validation type and implementing validation logic. For example:

```swift
/// A non empty validation rule.
public struct NonEmptyValidationRule: IValidationRule {
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
        !input.isEmpty
    }
}
```

## Requirements
- iOS 16.0+ / macOS 13+ / tvOS 16.0+ / watchOS 9.0+
- Xcode 14.0
- Swift 5.7

## Installation
### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but `validator` does support its use on supported platforms.

Once you have your Swift package set up, adding `validator` as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/space-code/validator.git", .upToNextMajor(from: "1.0.0"))
]
```

## Communication
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Contributing
Bootstrapping development environment

```
make bootstrap
```

Please feel free to help out with this project! If you see something that could be made better or want a new feature, open up an issue or send a Pull Request!

## Author
Nikita Vasilev, nv3212@gmail.com

## License
validator is available under the MIT license. See the LICENSE file for more info.
