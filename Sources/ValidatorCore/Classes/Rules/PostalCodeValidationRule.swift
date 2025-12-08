//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import Foundation

// MARK: - PostalCodeValidationRule

/// A validation rule used to verify postal/ZIP codes for different countries.
///
/// `PostalCodeValidationRule` validates user input based on predefined
/// country-specific postal code formats using regular expressions.
///
/// # Example:
/// ```swift
/// let rule = PostalCodeValidationRule(country: .uk, error: "Invalid postal code")
/// rule.validate(input: "SW1A 1AA") // true
/// rule.validate(input: "123456") // false
/// ```
///
public struct PostalCodeValidationRule: IValidationRule {
    // MARK: Types

    // swiftlint:disable identifier_name
    /// Supported countries with unique postal code formats.
    public enum Country {
        case us
        case uk
        case ca
        case de
        case fr
        case it
        case es
        case nl
        case be
        case ch
        case at
        case au
        case nz
        case jp
        case cn
        case `in`
        case br
        case mx
        case ar
        case za
        case ru
        case pl
        case se
        case no
        case dk
        case fi
        case pt
        case gr
        case cz
        case ie
        case sg
        case kr
        case il
        case tr
    }

    // swiftlint:enable identifier_name

    // MARK: Properties

    /// The country format to validate against.
    public let country: Country

    /// Validation error returned when validation fails.
    public let error: IValidationError

    // MARK: Initialization

    /// Creates a new postal code validation rule.
    ///
    /// - Parameters:
    ///   - country: The country whose postal code format should be used.
    ///   - error: Error object returned when validation fails.
    public init(country: Country, error: IValidationError) {
        self.country = country
        self.error = error
    }

    // MARK: ValidationRule

    public func validate(input: String) -> Bool {
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedInput.isEmpty {
            return false
        }

        if input != trimmedInput {
            return false
        }

        let pattern = getPattern(for: country)

        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }

        let range = NSRange(location: 0, length: input.utf16.count)
        return regex.firstMatch(in: input, options: [], range: range) != nil
    }

    // MARK: Private Methods

    // swiftlint:disable function_body_length cyclomatic_complexity
    private func getPattern(for country: Country) -> String {
        switch country {
        case .us:
            #"^\d{5}(-\d{4})?$"#

        case .ca:
            #"^[ABCEGHJ-NPRSTVXY]\d[ABCEGHJ-NPRSTV-Z] \d[ABCEGHJ-NPRSTV-Z]\d$"#

        case .mx:
            #"^\d{5}$"#

        case .br:
            #"^\d{5}-\d{3}$"#

        case .ar:
            #"^([A-Z]\d{4}([A-Z]{3})?|\d{4})$"#

        case .uk:
            #"^[A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}$"#

        case .de:
            #"^\d{5}$"#

        case .fr:
            #"^\d{5}$"#

        case .it:
            #"^\d{5}$"#

        case .es:
            #"^\d{5}$"#

        case .nl:
            #"^\d{4} [A-Z]{2}$"#

        case .be:
            #"^\d{4}$"#

        case .ch:
            #"^\d{4}$"#

        case .at:
            #"^\d{4}$"#

        case .pt:
            #"^\d{4}-\d{3}$"#

        case .gr:
            #"^\d{3} \d{2}$"#

        case .ie:
            #"^[A-Z]\d{2} [A-Z0-9]{4}$"#

        case .se:
            #"^\d{3} \d{2}$"#

        case .no:
            #"^\d{4}$"#

        case .dk:
            #"^\d{4}$"#

        case .fi:
            #"^\d{5}$"#

        case .ru:
            #"^\d{6}$"#

        case .pl:
            #"^\d{2}-\d{3}$"#

        case .cz:
            #"^\d{3} \d{2}$"#

        case .jp:
            #"^\d{3}-\d{4}$"#

        case .cn:
            #"^\d{6}$"#

        case .in:
            #"^\d{6}$"#

        case .sg:
            #"^\d{6}$"#

        case .kr:
            #"^\d{5}$"#

        case .il:
            #"^\d{7}$"#

        case .tr:
            #"^\d{5}$"#

        case .au:
            #"^\d{4}$"#

        case .nz:
            #"^\d{4}$"#

        case .za:
            #"^\d{4}$"#
        }
    }
    // swiftlint:enable function_body_length cyclomatic_complexity
}
