# ``ValidatorUI``

@Metadata {
    @TechnologyRoot
}

## Overview

ValidatorUI is a Swift framework that builds on top of `ValidatorCore` to provide **seamless integration with user interfaces**. It simplifies input validation in **UIKit** and **SwiftUI** by connecting form fields directly to validation logic and automatically displaying validation errors.

With ValidatorUI, you can:

- Bind validation rules to UI components like `UITextField` or SwiftUI `TextField`.
- Observe validation results reactively and update the UI.
- Display validation messages in a flexible, customizable way.
- Compose complex forms with multiple fields and centralized validation management.

ValidatorUI is designed to make form validation **safe, declarative, and easy to maintain**, while leveraging the powerful core validation logic from ValidatorCore.

## Topics

### Essentials

- ``IUIValidatable``
- ``ValidationViewModifier``
- ``FormValidationViewModifier``
- ``IFormField``
- ``FormField``
- ``IFormFieldManager``
- ``FormFieldManager``
- ``IFormValidationContainer``
- ``FormValidationContainter``

### Articles

- <doc:quick-start>
