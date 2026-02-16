//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import ValidatorCore

/// 1. LengthValidationRule - validates string length
let lengthRule = LengthValidationRule(min: 3, max: 20, error: "Length must be 3-20 characters")

let shortString = "ab"
let validString = "Hello"
let longString = "This is a very long string that exceeds the limit"

print("LengthValidationRule:")
print("'\(shortString)' is valid: \(lengthRule.validate(input: shortString))") // false
print("'\(validString)' is valid: \(lengthRule.validate(input: validString))") // true
print("'\(longString)' is valid: \(lengthRule.validate(input: longString))") // false
print()

/// 2. NonEmptyValidationRule - checks if string is not empty
let nonEmptyRule = NonEmptyValidationRule(error: "Field is required")

let emptyString = ""
let whitespaceString = "   "
let filledString = "Content"

print("NonEmptyValidationRule:")
print("'\(emptyString)' is valid: \(nonEmptyRule.validate(input: emptyString))") // false
print("'\(whitespaceString)' is valid: \(nonEmptyRule.validate(input: whitespaceString))") // false
print("'\(filledString)' is valid: \(nonEmptyRule.validate(input: filledString))") // true
print()

/// 3. PrefixValidationRule - validates string prefix
let prefixRule = PrefixValidationRule(prefix: "https://", error: "URL must start with https://")

let httpURL = "http://example.com"
let httpsURL = "https://example.com"
let noProtocol = "example.com"

print("PrefixValidationRule:")
print("'\(httpURL)' is valid: \(prefixRule.validate(input: httpURL))") // false
print("'\(httpsURL)' is valid: \(prefixRule.validate(input: httpsURL))") // true
print("'\(noProtocol)' is valid: \(prefixRule.validate(input: noProtocol))") // false
print()

/// 4. SuffixValidationRule - validates string suffix
let suffixRule = SuffixValidationRule(suffix: ".com", error: "Domain must end with .com")

let comDomain = "example.com"
let orgDomain = "example.org"
let noDomain = "example"

print("SuffixValidationRule:")
print("'\(comDomain)' is valid: \(suffixRule.validate(input: comDomain))") // true
print("'\(orgDomain)' is valid: \(suffixRule.validate(input: orgDomain))") // false
print("'\(noDomain)' is valid: \(suffixRule.validate(input: noDomain))") // false
print()

/// 5. RegexValidationRule - validates using regular expression
let phoneRule = RegexValidationRule(pattern: "^\\d{3}-\\d{4}$", error: "Invalid phone format")

let validPhone = "123-4567"
let invalidPhone1 = "1234567"
let invalidPhone2 = "123-456"

print("RegexValidationRule:")
print("'\(validPhone)' is valid: \(phoneRule.validate(input: validPhone))") // true
print("'\(invalidPhone1)' is valid: \(phoneRule.validate(input: invalidPhone1))") // false
print("'\(invalidPhone2)' is valid: \(phoneRule.validate(input: invalidPhone2))") // false
print()

/// 6. URLValidationRule - validates URL format
let urlRule = URLValidationRule(error: "Please enter a valid URL")

let validURL = "https://www.apple.com"
let invalidURL = "not a url"
let localURL = "file:///path/to/file"

print("URLValidationRule:")
print("'\(validURL)' is valid: \(urlRule.validate(input: validURL))") // true
print("'\(invalidURL)' is valid: \(urlRule.validate(input: invalidURL))") // false
print("'\(localURL)' is valid: \(urlRule.validate(input: localURL))") // true
print()

/// 7. CreditCardValidationRule - validates credit card number (Luhn algorithm)
let cardRule = CreditCardValidationRule(error: "Invalid card number")

let validCard = "4532015112830366" // Valid Visa test number
let invalidCard = "1234567890123456"
let shortCard = "4532"

print("CreditCardValidationRule:")
print("'\(validCard)' is valid: \(cardRule.validate(input: validCard))") // true
print("'\(invalidCard)' is valid: \(cardRule.validate(input: invalidCard))") // false
print("'\(shortCard)' is valid: \(cardRule.validate(input: shortCard))") // false
print()

/// 8. EmailValidationRule - validates email format
let emailRule = EmailValidationRule(error: "Please enter a valid email")

let validEmail = "user@example.com"
let invalidEmail1 = "user@"
let invalidEmail2 = "user.example.com"

print("EmailValidationRule:")
print("'\(validEmail)' is valid: \(emailRule.validate(input: validEmail))") // true
print("'\(invalidEmail1)' is valid: \(emailRule.validate(input: invalidEmail1))") // false
print("'\(invalidEmail2)' is valid: \(emailRule.validate(input: invalidEmail2))") // false
print()

/// 9. CharactersValidationRule - validates allowed characters
let lettersRule = CharactersValidationRule(characterSet: .letters, error: "Invalid characters")

let onlyLetters = "HelloWorld"
let withNumbers = "Hello123"
let withSpaces = "Hello World"

print("CharactersValidationRule:")
print("'\(onlyLetters)' is valid: \(lettersRule.validate(input: onlyLetters))") // true
print("'\(withNumbers)' is valid: \(lettersRule.validate(input: withNumbers))") // false
print("'\(withSpaces)' is valid: \(lettersRule.validate(input: withSpaces))") // false
print()

/// 10. NilValidationRule - validates that value is nil
let nilRule = NilValidationRule<String>(error: "Value must be nil")

let nilValue: String? = nil
let nonNilValue: String? = "Something"

print("NilValidationRule:")
print("nil value is valid: \(nilRule.validate(input: nilValue))") // true
print("non-nil value is valid: \(nilRule.validate(input: nonNilValue))") // false
print()

// MARK: - Combining Rules

print("=== Combining Multiple Rules ===")

// Example: password validation with multiple rules
let passwordLengthRule = LengthValidationRule(min: 8, max: 32, error: "Password must be 8-32 characters")
let passwordNotEmptyRule = NonEmptyValidationRule(error: "Password is required")

let passwords = ["", "123", "ValidPass123", "VeryLongPasswordThatExceedsMaximumLength"]

for password in passwords {
    let isLengthValid = passwordLengthRule.validate(input: password)
    let isNotEmpty = passwordNotEmptyRule.validate(input: password)
    let isValid = isLengthValid && isNotEmpty

    print("Password '\(password)': \(isValid ? "✅" : "❌")")
}
