//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

final class IPAddressValidationRuleTests: XCTestCase {
    // MARK: Tests

    func test_thatIPv4ValidationRuleValidatesInput_whenInputIsValid() {
        // given
        let rule = IPAddressValidationRule(version: .v4, error: "Invalid IPv4")

        let validIPs = [
            "192.168.0.1",
            "0.0.0.0",
            "255.255.255.255",
            "127.0.0.1",
            "10.10.10.10",
        ]

        // then
        for ip in validIPs {
            let result = rule.validate(input: ip)
            XCTAssertTrue(result, "Expected valid for: \(ip)")
        }
    }

    func test_thatIPv4ValidationRuleInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = IPAddressValidationRule(version: .v4, error: "Invalid IPv4")

        let invalidIPs = [
            "256.256.256.256",
            "192.168.0",
            "192.168.0.1.1",
            "abc.def.ghi.jkl",
            "999.10.10.10",
            "",
            "   ",
        ]

        // then
        for ip in invalidIPs {
            let result = rule.validate(input: ip)
            XCTAssertFalse(result, "Expected invalid for: \(ip)")
        }
    }

    func test_thatIPv6ValidationRuleValidatesInput_whenInputIsValid() {
        // given
        let rule = IPAddressValidationRule(version: .v6, error: "Invalid IPv6")

        let validIPs = [
            "2001:0db8:85a3:0000:0000:8a2e:0370:7334",
            "abcd:1234:5678:9abc:def0:0000:0000:1111",
            "FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF",
        ]

        // then
        for ip in validIPs {
            let result = rule.validate(input: ip)
            XCTAssertTrue(result, "Expected valid for: \(ip)")
        }
    }

    func test_thatIPv6ValidationRuleInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = IPAddressValidationRule(version: .v6, error: "Invalid IPv6")

        let invalidIPs = [
            "2001:db8:::1",
            "12345::",
            "GGGG:0000:0000:0000:0000:0000:0000:0000",
            "2001:db8:85a3",
            "",
            " ",
        ]

        // then
        for ip in invalidIPs {
            let result = rule.validate(input: ip)
            XCTAssertFalse(result, "Expected invalid for: \(ip)")
        }
    }

    func test_thatIPv4ValidationRuleInvalidatesInput_whenOctetsAreOutOfRange() {
        // given
        let rule = IPAddressValidationRule(version: .v4, error: "Invalid IPv4")

        let invalidIPs = [
            "256.0.0.1",
            "0.256.0.1",
            "0.0.256.1",
            "0.0.0.256",
            "-1.0.0.0",
            "192.-168.0.1",
            "300.300.300.300",
        ]

        // then
        for ip in invalidIPs {
            let result = rule.validate(input: ip)
            XCTAssertFalse(result, "Expected invalid for: \(ip)")
        }
    }

    func test_thatIPv4ValidationRuleInvalidatesInput_whenFormatIsIncorrect() {
        // given
        let rule = IPAddressValidationRule(version: .v4, error: "Invalid IPv4")

        let invalidIPs = [
            "192.168.0",
            "192.168",
            "192",
            "192.168.0.1.5",
            "192.168.0.1.5.6",
            "192..168.0.1",
            ".192.168.0.1",
            "192.168.0.1.",
            "192 .168.0.1",
            "192.168. 0.1",
            "192,168,0,1",
            "192:168:0:1",
        ]

        // then
        for ip in invalidIPs {
            let result = rule.validate(input: ip)
            XCTAssertFalse(result, "Expected invalid for: \(ip)")
        }
    }

    func test_thatIPv4ValidationRuleInvalidatesInput_whenContainsNonNumericCharacters() {
        // given
        let rule = IPAddressValidationRule(version: .v4, error: "Invalid IPv4")

        let invalidIPs = [
            "192.168.O.1",
            "192.168.0.l",
            "abc.def.ghi.jkl",
            "192.168.0.1a",
            "a192.168.0.1",
            "192.168.0x0.1",
            "192.168.0.1\n",
            "192.168.0.1\t",
        ]

        // then
        for ip in invalidIPs {
            let result = rule.validate(input: ip)
            XCTAssertFalse(result, "Expected invalid for: \(ip)")
        }
    }

    func test_thatIPv4ValidationRuleHandlesLeadingZeros() {
        // given
        let rule = IPAddressValidationRule(version: .v4, error: "Invalid IPv4")

        let ipsWithLeadingZeros = [
            "192.168.001.001",
            "010.010.010.010",
            "001.002.003.004",
        ]

        // then
        for ip in ipsWithLeadingZeros {
            let result = rule.validate(input: ip)
            XCTAssertTrue(result)
        }
    }

    func test_thatIPv6ValidationRuleValidatesInput_whenUsingShorthandNotation() {
        // given
        let rule = IPAddressValidationRule(version: .v6, error: "Invalid IPv6")

        let validIPs = [
            "::",
            "::1",
            "2001:db8::1",
            "2001:db8::8a2e:370:7334",
            "::ffff:192.0.2.1",
            "fe80::",
            "ff02::1",
        ]

        // then
        for ip in validIPs {
            let result = rule.validate(input: ip)
            XCTAssertTrue(result, "Expected valid for: \(ip)")
        }
    }

    func test_thatIPv6ValidationRuleInvalidatesInput_whenHexGroupsAreInvalid() {
        // given
        let rule = IPAddressValidationRule(version: .v6, error: "Invalid IPv6")

        let invalidIPs = [
            "GGGGG::1",
            "12345::1",
            "2001:0db8:85a3::8a2e:0370:7334:extra",
            ":::",
            "2001::db8::1",
            ":2001:db8::1",
            "2001:db8::1:",
            "02001:db8::1",
        ]

        // then
        for ip in invalidIPs {
            let result = rule.validate(input: ip)
            XCTAssertFalse(result, "Expected invalid for: \(ip)")
        }
    }

    func test_thatIPv6ValidationRuleInvalidatesInput_whenMixedCase() {
        // given
        let rule = IPAddressValidationRule(version: .v6, error: "Invalid IPv6")

        let validIPs = [
            "2001:0DB8:85A3:0000:0000:8A2E:0370:7334",
            "2001:0db8:85a3:0000:0000:8a2e:0370:7334",
            "2001:0Db8:85A3:0000:0000:8a2E:0370:7334",
        ]

        // then
        for ip in validIPs {
            let result = rule.validate(input: ip)
            XCTAssertTrue(result, "Expected valid for: \(ip)")
        }
    }

    func test_thatValidationRuleInvalidatesInput_whenContainsWhitespace() {
        // given
        let ipv4Rule = IPAddressValidationRule(version: .v4, error: "Invalid IPv4")
        let ipv6Rule = IPAddressValidationRule(version: .v6, error: "Invalid IPv6")

        let invalidIPv4s = [
            " 192.168.0.1",
            "192.168.0.1 ",
            "192 .168.0.1",
            "\t192.168.0.1",
            "192.168.0.1\n",
        ]

        let invalidIPv6s = [
            " 2001:db8::1",
            "2001:db8::1 ",
            "2001: db8::1",
            "\t2001:db8::1",
        ]

        // then
        for ip in invalidIPv4s {
            XCTAssertFalse(ipv4Rule.validate(input: ip), "Expected invalid for: '\(ip)'")
        }

        for ip in invalidIPv6s {
            XCTAssertFalse(ipv6Rule.validate(input: ip), "Expected invalid for: '\(ip)'")
        }
    }

    func test_thatIPv4ValidationRuleValidatesInput_whenUsingBoundaryValues() {
        // given
        let rule = IPAddressValidationRule(version: .v4, error: "Invalid IPv4")

        let boundaryIPs = [
            "0.0.0.0",
            "255.255.255.255",
            "127.0.0.1",
            "255.0.0.0",
            "0.255.0.0",
            "0.0.255.0",
            "0.0.0.255",
        ]

        // then
        for ip in boundaryIPs {
            let result = rule.validate(input: ip)
            XCTAssertTrue(result, "Expected valid for boundary value: \(ip)")
        }
    }

    func test_thatValidationRuleInvalidatesInput_whenInputIsEmpty() {
        // given
        let ipv4Rule = IPAddressValidationRule(version: .v4, error: "Invalid IPv4")
        let ipv6Rule = IPAddressValidationRule(version: .v6, error: "Invalid IPv6")

        // then
        XCTAssertFalse(ipv4Rule.validate(input: ""))
        XCTAssertFalse(ipv6Rule.validate(input: ""))
    }

    func test_thatValidationRuleInvalidatesInput_whenInputIsOnlyWhitespace() {
        // given
        let ipv4Rule = IPAddressValidationRule(version: .v4, error: "Invalid IPv4")
        let ipv6Rule = IPAddressValidationRule(version: .v6, error: "Invalid IPv6")

        let whitespaceStrings = [
            " ",
            "  ",
            "\t",
            "\n",
            "\r\n",
            "   \t  \n  ",
        ]

        // then
        for input in whitespaceStrings {
            XCTAssertFalse(ipv4Rule.validate(input: input), "Expected invalid for whitespace")
            XCTAssertFalse(ipv6Rule.validate(input: input), "Expected invalid for whitespace")
        }
    }
}
