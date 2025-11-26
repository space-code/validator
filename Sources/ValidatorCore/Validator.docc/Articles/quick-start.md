# Quick Start

This guide will walk you through the basics of using ValidatorCore for input validation. By the end, you’ll know how to validate common input types like strings and numbers, handle validation results, and get started with custom rules.

## Basic Usage

The core of the library is the Validator class. It allows you to validate any input against a set of predefined rules.

```swift
let validator = Validator()
```

Here we create an instance of Validator. This object will be responsible for running validation rules on your inputs.

## Validating a String

Let’s validate a username to make sure it is not empty and has a valid length.

```swift
let username = "john"

let result = validator.validate(
    input: username,
    rule: NonEmptyValidationRule(error: "Username cannot be empty")
)
```

Explanation:
- `input` – the value you want to validate.
- `rule` – an instance of a validation rule. In this case, ``NonEmptyValidationRule`` ensures that the string is not empty.
- `result` – the output of the validation, of type ``ValidationResult``.

## Handling Validation Result

You can check if the validation passed or failed:

```swift
switch result {
case .success:
    print("Validation passed ✅")
case .failure(let error):
    print("Validation failed ❌: \(error.description)")
}
```

This lets you react to validation errors and show messages to your users.

## Combining Rules

ValidatorCore allows you to combine multiple rules for a single input:

```swift
let rules: [any IValidationRule<String>] = [
    NonEmptyValidationRule(error: "Field cannot be empty"),
    LengthValidationRule(min: 3, max: 20, error: "Length must be 3-20 characters")
]

let validator = Validator()

let result = validator.validate(input: username, rules: rules)
```

Explanation:
- Each rule checks one specific condition (e.g., non-empty, length).
- The Validator applies each rule independently.
- By iterating over multiple rules, you can implement comprehensive validation without combining rules inside the rule objects themselves.
- This keeps rules focused, reusable, and simple, while Validator handles the orchestration.

## Quick Example: Email Validation

```swift
let email = "example@example.com"

let result = validator.validate(
    input: email,
    rule: EmailValidationRule(error: "Invalid email address")
)
```

ValidatorCore comes with a set of common rules, like ``EmailValidationRule``, to simplify standard input checks.

## Next Steps

You now know how to:
- Create a Validator
- Use built-in rules to validate input
- Combine multiple rules for complex validation
- Handle validation results

To go further, you can create your own custom rules tailored to your specific needs.
