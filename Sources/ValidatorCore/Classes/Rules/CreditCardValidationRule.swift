//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

/// A credit card validation rule.
public struct CreditCardValidationRule: IValidationRule {
    // MARK: Types

    public enum CardType: String, Sendable, CaseIterable {
        case visa, masterCard, amex, jcb, unionPay
    }

    public typealias Input = String

    // MARK: Properties

    public let types: [CardType]

    /// The validation error.
    public let error: IValidationError

    // MARK: Initialization

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
