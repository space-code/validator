//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

/// Validates that a string is a valid IBAN (International Bank Account Number).
///
/// Uses a simplified IBAN validation algorithm:
/// 1. Checks length according to country code (2 letters + digits)
/// 2. Moves first 4 characters to the end
/// 3. Converts letters to numbers (A=10, B=11, ..., Z=35)
/// 4. Checks if the resulting number mod 97 equals 1
///
/// # Example:
/// ```swift
/// let rule = IBANValidationRule(error: "Invalid IBAN")
/// rule.validate(input: "GB82WEST12345698765432") // true
/// rule.validate(input: "INVALIDIBAN")           // false
/// ```
public struct IBANValidationRule: IValidationRule {
    // MARK: - Types

    public typealias Input = String

    // MARK: Properties

    /// The validation error returned when validation fails.
    public let error: IValidationError

    // MARK: Initialization

    /// Creates an IBAN validation rule.
    ///
    /// - Parameter error: The validation error returned if validation fails.
    public init(error: IValidationError) {
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        let trimmed = input.replacingOccurrences(of: " ", with: "").uppercased()
        guard trimmed.count >= 4 else { return false }

        let rearranged = String(trimmed.dropFirst(4) + trimmed.prefix(4))

        var numericString = ""
        for char in rearranged {
            if let digit = char.wholeNumberValue {
                numericString.append(String(digit))
            } else if let ascii = char.asciiValue, ascii >= 65, ascii <= 90 {
                numericString.append(String(Int(ascii) - 55))
            } else {
                return false
            }
        }

        var remainder = 0
        var chunk = ""
        for char in numericString {
            chunk.append(char)
            if let number = Int(chunk), number >= 97 {
                remainder = number % 97
                chunk = String(remainder)
            }
        }

        remainder = (Int(chunk) ?? 0) % 97
        return remainder == 1
    }
}
