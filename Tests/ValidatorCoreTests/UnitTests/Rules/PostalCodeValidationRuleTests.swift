//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

@testable import ValidatorCore
import XCTest

// swiftlint:disable file_length type_body_length
final class PostalCodeValidationRuleTests: XCTestCase {
    // MARK: - US Tests

    func test_thatUSPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .us, error: "Invalid ZIP")

        let validCodes = [
            "12345",
            "90210",
            "12345-6789",
            "00501",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatUSPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .us, error: "Invalid ZIP")

        let invalidCodes = [
            "1234",
            "123456",
            "12345-678",
            "ABCDE",
            "12345-",
            "",
            " 12345",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - UK Tests

    func test_thatUKPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .uk, error: "Invalid postcode")

        let validCodes = [
            "SW1A 1AA",
            "EC1A 1BB",
            "W1A 0AX",
            "M1 1AE",
            "B33 8TH",
            "CR2 6XH",
            "DN55 1PT",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    // MARK: - Canada Tests

    func test_thatCanadaPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .ca, error: "Invalid postal code")

        let validCodes = [
            "K1A 0B1",
            "M5W 1E6",
            "V6B 1A1",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatCanadaPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .ca, error: "Invalid postal code")

        let invalidCodes = [
            "K1A0B1",
            "K1A  0B1",
            "k1a 0b1",
            "Z1A 0B1",
            "K1A 0BB",
            "123 456",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Germany Tests

    func test_thatGermanyPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .de, error: "Invalid PLZ")

        let validCodes = [
            "10115",
            "80331",
            "20095",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    // MARK: - Netherlands Tests

    func test_thatNetherlandsPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .nl, error: "Invalid postcode")

        let validCodes = [
            "1012 AB",
            "2595 AC",
            "9999 ZZ",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatNetherlandsPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .nl, error: "Invalid postcode")

        let invalidCodes = [
            "1012AB",
            "1012 A",
            "1012 ABC",
            "10122 AB",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Japan Tests

    func test_thatJapanPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .jp, error: "Invalid postal code")

        let validCodes = [
            "100-0001",
            "530-0001",
            "060-0001",
        ]

        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    // MARK: - Brazil Tests

    func test_thatBrazilPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .br, error: "Invalid CEP")

        let validCodes = [
            "01310-100",
            "20040-020",
            "30130-010",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    // MARK: - Multiple Countries Same Format

    func test_thatFiveDigitCountriesValidateCorrectly() {
        // given
        let countries: [PostalCodeValidationRule.Country] = [.de, .fr, .it, .es, .fi, .mx, .tr, .kr]

        // then
        for country in countries {
            let rule = PostalCodeValidationRule(country: country, error: "Invalid")

            XCTAssertTrue(rule.validate(input: "12345"))
            XCTAssertFalse(rule.validate(input: "1234"))
            XCTAssertFalse(rule.validate(input: "123456"))
            XCTAssertFalse(rule.validate(input: "ABCDE"))
        }
    }

    func test_thatFourDigitCountriesValidateCorrectly() {
        // given
        let countries: [PostalCodeValidationRule.Country] = [.be, .ch, .at, .no, .dk, .au, .nz, .za]

        // then
        for country in countries {
            let rule = PostalCodeValidationRule(country: country, error: "Invalid")

            XCTAssertTrue(rule.validate(input: "1234"))
            XCTAssertFalse(rule.validate(input: "123"))
            XCTAssertFalse(rule.validate(input: "12345"))
            XCTAssertFalse(rule.validate(input: "ABCD"))
        }
    }

    // MARK: - Argentina Tests

    func test_thatArgentinaPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .ar, error: "Invalid postal code")

        let validCodes = [
            "C1425",
            "B1636",
            "C1425HOE",
            "B1636FUA",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatArgentinaPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .ar, error: "Invalid postal code")

        let invalidCodes = [
            "123",
            "12345",
            "C1425HO",
            "1425HOE",
            "CC1425HOE",
            "C1425HOEE",
            "",
            " C1425",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Portugal Tests

    func test_thatPortugalPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .pt, error: "Invalid postal code")

        let validCodes = [
            "1000-001",
            "4000-007",
            "9000-999",
        ]

        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatPortugalPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .pt, error: "Invalid postal code")

        let invalidCodes = [
            "1000001",
            "1000-01",
            "1000-0001",
            "100-001",
            "10000-001",
            "ABCD-EFG",
            "",
            " 1000-001",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Greece Tests

    func test_thatGreecePostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .gr, error: "Invalid postal code")

        let validCodes = [
            "100 00",
            "546 25",
            "999 99",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatGreecePostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .gr, error: "Invalid postal code")

        let invalidCodes = [
            "10000",
            "100  00",
            "1000 00",
            "100 000",
            "ABC DE",
            "",
            " 100 00",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Ireland Tests

    func test_thatIrelandPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .ie, error: "Invalid Eircode")

        let validCodes = [
            "A65 F4E2",
            "D02 AF30",
            "T12 X2P9",
            "V94 A6N3",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatIrelandPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .ie, error: "Invalid Eircode")

        let invalidCodes = [
            "A65F4E2",
            "A65  F4E2",
            "1A65 F4E2",
            "AA65 F4E2",
            "A65 F4E",
            "A65 F4E22",
            "a65 f4e2",
            "",
            " A65 F4E2",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Sweden Tests

    func test_thatSwedenPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .se, error: "Invalid postnummer")

        let validCodes = [
            "100 00",
            "123 45",
            "999 99",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatSwedenPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .se, error: "Invalid postnummer")

        let invalidCodes = [
            "10000",
            "100  00",
            "1000 00",
            "100 000",
            "12-345",
            "ABC DE",
            "",
            " 123 45",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Russia Tests

    func test_thatRussiaPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .ru, error: "Invalid postal code")

        let validCodes = [
            "101000",
            "344000",
            "690000",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatRussiaPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .ru, error: "Invalid postal code")

        let invalidCodes = [
            "10100",
            "1010000",
            "10-1000",
            "ABCDEF",
            "",
            " 101000",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Poland Tests

    func test_thatPolandPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .pl, error: "Invalid kod pocztowy")

        let validCodes = [
            "00-001",
            "12-345",
            "99-999",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatPolandPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .pl, error: "Invalid kod pocztowy")

        let invalidCodes = [
            "00001",
            "0-001",
            "000-001",
            "00-01",
            "00-0001",
            "AB-CDE",
            "",
            " 12-345",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Czech Republic Tests

    func test_thatCzechRepublicPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .cz, error: "Invalid PSČ")

        let validCodes = [
            "100 00",
            "250 88",
            "999 99",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatCzechRepublicPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .cz, error: "Invalid PSČ")

        let invalidCodes = [
            "10000",
            "100  00",
            "1000 00",
            "100 000",
            "100-00",
            "ABC DE",
            "",
            " 100 00",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - China Tests

    func test_thatChinaPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .cn, error: "Invalid postal code")

        let validCodes = [
            "100000",
            "200000",
            "518000",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatChinaPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .cn, error: "Invalid postal code")

        let invalidCodes = [
            "10000",
            "1000000",
            "10-0000",
            "ABCDEF",
            "",
            " 100000",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - India Tests

    func test_thatIndiaPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .in, error: "Invalid PIN code")

        let validCodes = [
            "110001",
            "400001",
            "560001",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatIndiaPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .in, error: "Invalid PIN code")

        let invalidCodes = [
            "11000",
            "1100010",
            "11-0001",
            "ABCDEF",
            "",
            " 110001",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Singapore Tests

    func test_thatSingaporePostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .sg, error: "Invalid postal code")

        let validCodes = [
            "018956",
            "238859",
            "560001",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatSingaporePostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .sg, error: "Invalid postal code")

        let invalidCodes = [
            "01895",
            "0189567",
            "01-8956",
            "ABCDEF",
            "",
            " 018956",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Israel Tests

    func test_thatIsraelPostalCodeValidatesInput_whenInputIsValid() {
        // given
        let rule = PostalCodeValidationRule(country: .il, error: "Invalid postal code")

        let validCodes = [
            "1234567",
            "9999999",
            "0000001",
        ]

        // then
        for code in validCodes {
            XCTAssertTrue(rule.validate(input: code), "Expected valid for: \(code)")
        }
    }

    func test_thatIsraelPostalCodeInvalidatesInput_whenInputIsInvalid() {
        // given
        let rule = PostalCodeValidationRule(country: .il, error: "Invalid postal code")

        let invalidCodes = [
            "123456",
            "12345678",
            "123-4567",
            "ABCDEFG",
            "",
            " 1234567",
        ]

        // then
        for code in invalidCodes {
            XCTAssertFalse(rule.validate(input: code), "Expected invalid for: \(code)")
        }
    }

    // MARK: - Edge Cases for Multiple Countries

    func test_thatSixDigitCountriesValidateCorrectly() {
        // given
        let countries: [PostalCodeValidationRule.Country] = [.ru, .cn, .in, .sg]

        // then
        for country in countries {
            let rule = PostalCodeValidationRule(country: country, error: "Invalid")

            XCTAssertTrue(rule.validate(input: "123456"), "Expected valid for \(country)")
            XCTAssertFalse(rule.validate(input: "12345"), "Expected invalid for \(country)")
            XCTAssertFalse(rule.validate(input: "1234567"), "Expected invalid for \(country)")
            XCTAssertFalse(rule.validate(input: "ABCDEF"), "Expected invalid for \(country)")
        }
    }

    func test_thatSpaceSeparatedCountriesValidateCorrectly() {
        // given
        let countries: [PostalCodeValidationRule.Country] = [.gr, .se, .cz]

        // then
        for country in countries {
            let rule = PostalCodeValidationRule(country: country, error: "Invalid")

            XCTAssertTrue(rule.validate(input: "123 45"), "Expected valid for \(country)")
            XCTAssertFalse(rule.validate(input: "12345"), "Expected invalid (no space) for \(country)")
            XCTAssertFalse(rule.validate(input: "123  45"), "Expected invalid (double space) for \(country)")
        }
    }
}

// swiftlint:enable file_length type_body_length
