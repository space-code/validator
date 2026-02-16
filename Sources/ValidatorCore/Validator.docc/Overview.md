# ``ValidatorCore``


@Metadata {
    @TechnologyRoot
}

## Overview
 
Validator is a modern, lightweight Swift framework for type-safe input validation. It provides a flexible and elegant way to validate strings, numbers, and other data types across all Apple platforms. Built on Swift's type system, ValidatorCore forms the foundation for all validation logic, while ValidatorUI integrates seamlessly with UIKit and SwiftUI.

ValidatorCore contains all core validation rules, utilities, and mechanisms for composing rules, while remaining lightweight, extensible, and testable.

## Topics
 
### Essentials
 
- ``Validator``
- ``ValidationResult``
- ``IValidationError``
- ``IValidationRule``

### Built-in Validators

- ``CharactersValidationRule``
- ``CreditCardValidationRule``
- ``EmailValidationRule``
- ``LengthValidationRule``
- ``NonEmptyValidationRule``
- ``PrefixValidationRule``
- ``RegexValidationRule``
- ``SuffixValidationRule``
- ``URLValidationRule``
- ``NilValidationRule``
- ``PositiveNumberValidationRule``
- ``NoWhitespaceValidationRuleTests``
- ``ContainsValidationRule``
- ``EqualityValidationRule``
- ``ComparisonValidationRule``
- ``IBANValidationRule``
- ``IPAddressValidationRule``
- ``PostalCodeValidationRule``
- ``Base64ValidationRule``

### Articles

- <doc:installation>
- <doc:quick-start>
- <doc:custom-validation-rule>
