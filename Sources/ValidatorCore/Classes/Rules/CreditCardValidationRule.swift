//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

/// Validates credit card numbers using card type prefixes and the Luhn algorithm.
/// Supports Visa, MasterCard, Amex, JCB, and UnionPay.
/// The validation checks both the prefix/length of the card and the Luhn checksum.
///
/// # Example:
/// ```swift
/// let rule = CreditCardValidationRule(types: [.visa, .masterCard], error: "Invalid card")
/// rule.validate(input: "4111 1111 1111 1111") // true for Visa
/// ```
public struct CreditCardValidationRule: IValidationRule {
    // MARK: Types

    /// Represents the supported credit card types.
    /// Each type has specific prefix and length rules.
    public enum CardType: String, Sendable, CaseIterable {
        /// Visa cards start with 4 and have 13, 16, or 19 digits.
        case visa
        /// MasterCard cards start with 51–55 and have 16 digits.
        case masterCard
        /// American Express cards start with 34 or 37 and have 15 digits.
        case amex
        /// JCB cards start with 3528–3589 and have 16 digits.
        case jcb
        /// UnionPay cards start with 62 and have 16–19 digits.
        case unionPay
    }

    public typealias Input = String

    // MARK: Properties

    /// Allowed card types for validation.
    public let types: [CardType]

    /// Validation error returned if the card is invalid.
    public let error: IValidationError

    // MARK: Initialization

    /// Initializes a credit card validation rule.
    ///
    /// - Parameters:
    ///   - types: The allowed card types. Defaults to all supported card types.
    ///   - error: The validation error to return if input fails validation.
    public init(types: [CardType] = CardType.allCases, error: IValidationError) {
        self.types = types
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        let sanitized = input.replacingOccurrences(of: " ", with: "")

        guard sanitized.allSatisfy(\.isNumber) else { return false }

        guard types.contains(where: { matches(cardNumber: sanitized, type: $0) }) else { return false }

        return isValidLuhn(sanitized)
    }

    // MARK: Private

    private func matches(cardNumber: String, type: CardType) -> Bool {
        switch type {
        case .visa:
            cardNumber.hasPrefix("4") && (cardNumber.count == 13 || cardNumber.count == 16 || cardNumber.count == 19)
        case .masterCard:
            (cardNumber.hasPrefix("51") || cardNumber.hasPrefix("52") ||
                cardNumber.hasPrefix("53") || cardNumber.hasPrefix("54") ||
                cardNumber.hasPrefix("55")) && cardNumber.count == 16
        case .amex:
            (cardNumber.hasPrefix("34") || cardNumber.hasPrefix("37")) && cardNumber.count == 15
        case .jcb:
            (cardNumber.hasPrefix("3528") || cardNumber.hasPrefix("3589")) && cardNumber.count == 16
        case .unionPay:
            cardNumber.hasPrefix("62") && (cardNumber.count >= 16 && cardNumber.count <= 19)
        }
    }

    private func isValidLuhn(_ cardNumber: String) -> Bool {
        let reversedDigits = cardNumber.reversed().map { Int(String($0)) ?? 0 }
        var sum = 0

        for (index, digit) in reversedDigits.enumerated() {
            if !index.isMultiple(of: 2) {
                let doubled = digit * 2
                sum += doubled > 9 ? doubled - 9 : doubled
            } else {
                sum += digit
            }
        }

        return sum.isMultiple(of: 10)
    }
}
