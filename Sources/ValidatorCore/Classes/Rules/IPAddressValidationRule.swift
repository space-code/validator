//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import Foundation

/// A validation rule for checking whether the input string is a valid IPv4 or IPv6 address.
///
/// This rule supports:
/// - Standard IPv4 addresses (e.g., `192.168.1.1`)
/// - Standard and compressed IPv6 addresses (e.g., `2001:db8::1`)
///
/// The rule fails validation if:
/// - The input is empty
/// - The input contains spaces, tabs, or newlines
/// - The format does not match the expected IPv4/IPv6 specification
///
/// Example:
/// ```swift
/// let rule = IPAddressValidationRule(version: .v4, error: ValidationError("Invalid IPv4"))
/// rule.validate(input: "192.168.1.1") // true
/// ```
public struct IPAddressValidationRule: IValidationRule {
    // MARK: Types

    public typealias Input = String

    /// Specifies which IP protocol version the rule should validate.
    public enum Version {
        case v4
        case v6
    }

    // MARK: Properties

    /// The expected IP standard (IPv4 or IPv6).
    public let version: Version

    /// The validation error returned when validation fails.
    public let error: IValidationError

    // MARK: Initialization

    /// Creates an IP address validation rule.
    ///
    /// - Parameters:
    ///   - version: The expected IP protocol version (.v4 or .v6).
    ///   - error: The validation error returned if validation fails.
    public init(version: Version, error: IValidationError) {
        self.version = version
        self.error = error
    }

    // MARK: IValidationRule

    public func validate(input: String) -> Bool {
        if input.isEmpty { return false }

        if input.contains(" ") || input.contains("\t") || input.contains("\n") {
            return false
        }

        switch version {
        case .v4:
            return validateIPv4(input)
        case .v6:
            return validateIPv6(input)
        }
    }

    // MARK: Private

    /// Validates an IPv4 address using a strict regex pattern that ensures each octet is between 0–255.
    ///
    /// - Parameter input: The IPv4 string.
    ///
    /// - Returns: `true` if valid, otherwise `false`.
    private func validateIPv4(_ input: String) -> Bool {
        let pattern = #"^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\."#
            + #"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\."#
            + #"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\."#
            + #"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"#

        if let regex = try? NSRegularExpression(pattern: pattern) {
            let range = NSRange(location: 0, length: input.utf16.count)
            return regex.firstMatch(in: input, options: [], range: range) != nil
        }

        return false
    }

    /// Validates an IPv6 address using system-level parsing (`inet_pton`) and basic structural checks.
    ///
    /// Supports:
    /// - Full IPv6 addresses
    /// - Compressed forms (e.g., `::1`)
    /// - IPv4-mapped IPv6 forms (e.g., `::ffff:192.168.0.1`)
    ///
    /// - Parameter input: The IPv6 string.
    ///
    /// - Returns: `true` if valid, otherwise `false`.
    private func validateIPv6(_ input: String) -> Bool {
        let components = input.components(separatedBy: ":")

        for component in components where !component.isEmpty {
            if component.contains(".") {
                continue
            }

            if component.count > 4 {
                return false
            }

            if !component.allSatisfy(\.isHexDigit) {
                return false
            }
        }

        var addr = sockaddr_in6()
        return input.withCString { cString in
            inet_pton(AF_INET6, cString, &addr.sin6_addr) == 1
        }
    }
}
