# Creating Custom Validation Rules

ValidatorCore is designed to be extensible. If the built-in validation rules do not meet your needs, you can create custom validation rules tailored to your application.

This guide will show you how to create, use, and test a custom rule.

## Step 1: Conform to IValidationRule

All validation rules in ValidatorCore conform to the IValidationRule protocol. It requires specifying the input type and implementing a validate function.

```swift
import ValidatorCore

struct ContainsDigitRule: IValidationRule<String> {
    let error: String

    func validate(input: String) -> Bool {
        if input.rangeOfCharacter(from: .decimalDigits) != nil {
            return true
        } else {
            return false
        }
    }
}
```

Explanation:
- `IValidationRule<String>` – our rule will validate strings.
- `error` – the message returned if validation fails.
- `validate(input:)` – the core logic. Here, we check if the input contains at least one digit.

## Step 2: Use Your Custom Rule

Once the rule is defined, you can use it with Validator just like any built-in rule:

```swift
let validator = Validator()
let password = "Password123"

let result = validator.validate(
    input: password,
    rule: ContainsDigitRule(error: "Password must contain at least one number")
)

switch result {
case .success:
    print("Password is valid ✅")
case .failure(let error):
    print("Password is invalid ❌: \(error.description)")
}
```

Explanation:
- The custom rule integrates seamlessly with the existing validation workflow.
- Validation result handling remains the same as with built-in rules.

## Step 3: Combining Custom and Built-in Rules

You can combine custom rules with built-in rules for more complex validation logic:

```swift
let password = "Password123"

let rules: [any IValidationRule<String>] = [
    NonEmptyValidationRule(error: "Password cannot be empty"),
    LengthValidationRule(min: 8, max: 20, error: "Password must be 8-20 characters"),
    ContainsDigitRule(error: "Password must contain at least one number")
]

let validator = Validator()

let result = validator.validate(input: password, rules: rules)
```

Explanation:
- Each rule validates one specific aspect of the input (e.g., non-empty, length, contains a digit).
- The Validator applies each rule independently.
- This approach keeps rules focused, reusable, and simple, while Validator handles iterating through multiple rules.
- You can freely mix custom and built-in rules to create comprehensive validation logic without combining rules inside the rules themselves.

## Tips for Writing Custom Rules

1. Keep rules focused – one rule should check one condition.
2. Provide meaningful error messages – users should understand why input is invalid.
3. Unit test your rules – write tests to ensure correct behavior under different input scenarios.
4. Reuse rules – if a rule is useful in multiple places, keep it generic and reusable.

## Next Steps

Experiment by creating rules for emails, passwords, usernames, or any custom format.
