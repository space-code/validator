# Contributing to Validator

First off, thank you for considering contributing to Validator! It's people like you that make Validator such a great tool.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
  - [Development Setup](#development-setup)
  - [Project Structure](#project-structure)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Improving Documentation](#improving-documentation)
  - [Submitting Code](#submitting-code)
- [Development Workflow](#development-workflow)
  - [Branching Strategy](#branching-strategy)
  - [Commit Guidelines](#commit-guidelines)
  - [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
  - [Swift Style Guide](#swift-style-guide)
  - [Code Quality](#code-quality)
  - [Testing Requirements](#testing-requirements)
- [Community](#community)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to nv3212@gmail.com.

## Getting Started

### Development Setup

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/space-code/validator.git
   cd validator
   ```

3. **Set up the development environment**
   ```bash
   # Install mise (if not already installed)
   curl https://mise.run | sh
   
   # Install project dependencies
   mise install
   ```

4. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

5. **Open the project in Xcode**
   ```bash
   open Package.swift
   ```

### Project Structure

```
validator/
├── Sources/
│   ├── ValidatorCore/          # Core validation logic
│   │   └── Classes/
│   │       ├── Core/           # Core validator classes and protocols
│   │       ├── Extensions/     # Core extensions
│   │       └── Rules/          # Built-in validation rules
│   └── ValidatorUI/            # UI integrations
│       └── Classes/
│           ├── Extensions/     # Shared UI extensions
│           ├── SUI/            # SwiftUI modifiers and components
│           └── UIKit/          # UIKit extensions and helpers
├── Tests/
    ├── ValidatorCoreTests/     # Core logic tests
    └── ValidatorUITests/       # UI integration tests
```

## How Can I Contribute?

### Reporting Bugs

Before creating a bug report, please check the [existing issues](https://github.com/space-code/validator/issues) to avoid duplicates.

When creating a bug report, use our [bug report template](.github/ISSUE_TEMPLATE/bug_report.md) and include:

- **Clear title** - Describe the issue concisely
- **Reproduction steps** - Detailed steps to reproduce the bug
- **Expected behavior** - What you expected to happen
- **Actual behavior** - What actually happened
- **Environment** - OS, Xcode version, Swift version
- **Code samples** - Minimal reproducible example
- **Screenshots** - If applicable

**Example:**
```markdown
**Title:** LengthValidationRule fails with empty string when min is 0

**Steps to reproduce:**
1. Create a LengthValidationRule with min: 0
2. Validate an empty string
3. Expected: .valid, Actual: .invalid
```

### Suggesting Features

We love feature suggestions! Use our [feature request template](.github/ISSUE_TEMPLATE/feature_request.md) and include:

- **Problem statement** - What problem does this solve?
- **Proposed solution** - How should it work?
- **Alternatives** - What alternatives did you consider?
- **Use cases** - Real-world scenarios
- **API design** - Example code showing usage

### Improving Documentation

Documentation improvements are always welcome:

- **Code comments** - Add/improve inline documentation
- **API documentation** - Enhance DocC documentation
- **README** - Fix typos, add examples
- **Guides** - Write tutorials or how-to guides
- **Translations** - Help translate documentation

Use our [documentation template](.github/ISSUE_TEMPLATE/documentation.md) for documentation issues.

### Submitting Code

1. **Check existing work** - Look for related issues or PRs
2. **Discuss major changes** - Open an issue for large features
3. **Follow coding standards** - See [Coding Standards](#coding-standards)
4. **Write tests** - All code changes require tests
5. **Update documentation** - Keep docs in sync with code
6. **Create a pull request** - Use our [PR template](.github/PULL_REQUEST_TEMPLATE.md)

## Development Workflow

### Branching Strategy

We follow a simplified Git Flow:

- **`main`** - Main development branch (default, all PRs target this branch)
- **`feature/*`** - New features
- **`fix/*`** - Bug fixes
- **`docs/*`** - Documentation updates
- **`refactor/*`** - Code refactoring
- **`test/*`** - Test improvements

**Branch naming examples:**
```bash
feature/email-validation-rule
fix/length-validator-edge-case
docs/update-swiftui-guide
refactor/validator-core-architecture
test/add-regex-validator-tests
```

### Commit Guidelines

We use [Conventional Commits](https://www.conventionalcommits.org/) for clear, structured commit history.

**Format:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation changes
- `style` - Code style (formatting, missing semicolons)
- `refactor` - Code refactoring
- `test` - Adding or updating tests
- `chore` - Maintenance tasks (dependencies, tooling)
- `perf` - Performance improvements
- `ci` - CI/CD changes

**Scopes:**
- `core` - ValidatorCore changes
- `ui` - ValidatorUI changes
- `uikit` - UIKit integration
- `swiftui` - SwiftUI integration
- `rules` - Validation rules
- `deps` - Dependencies

**Examples:**
```bash
feat(rules): add email validation rule

Add EmailValidationRule with support for RFC 5322 compliant validation.
Includes comprehensive test coverage for edge cases.

Closes #123

---

fix(core): handle nil input in validator

Previously, the validator would crash with nil input.
Now returns .invalid with appropriate error message.

Fixes #456

---

docs(swiftui): add form validation examples

Add comprehensive examples for FormFieldManager usage
including error handling and state management patterns.

---

test(rules): increase coverage for LengthValidationRule

Add tests for:
- Unicode character handling
- Emoji counting
- Empty string edge cases
```

**Commit message rules:**
- Use imperative mood ("add" not "added")
- Don't capitalize first letter
- No period at the end
- Keep subject line under 72 characters
- Separate subject from body with blank line
- Reference issues in footer

### Pull Request Process

1. **Update your branch**
   ```bash
   git checkout main
   git pull upstream main
   git checkout feature/your-feature
   git rebase main
   ```

2. **Run tests and checks**
   ```bash
   # Run all tests
   swift test
   
   # Check code formatting
   mise run lint
   ```

3. **Push to your fork**
   ```bash
   git push origin feature/your-feature
   ```

4. **Create pull request**
   - Use our [PR template](.github/PULL_REQUEST_TEMPLATE.md)
   - Target the `main` branch
   - Link related issues
   - Request review from maintainers

5. **Review process**
   - Address review comments
   - Keep PR up to date with dev branch
   - Squash commits if requested
   - Wait for CI to pass

6. **After merge**
   ```bash
   # Clean up local branch
   git checkout main
   git pull upstream main
   git branch -d feature/your-feature
   
   # Clean up remote branch
   git push origin --delete feature/your-feature
   ```

## Coding Standards

### Swift Style Guide

We follow the [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/) and [Ray Wenderlich Swift Style Guide](https://github.com/raywenderlich/swift-style-guide).

**Key points:**

1. **Naming**
   ```swift
   // ✅ Good
   func validate(input: String) -> ValidationResult
   let isValid: Bool
   
   // ❌ Bad
   func check(str: String) -> Bool
   let valid: Bool
   ```

2. **Protocols**
   ```swift
   // ✅ Good - Use "I" prefix for protocols
   protocol IValidationRule {
       associatedtype Input
       func validate(input: Input) -> Bool
   }
   
   // ❌ Bad
   protocol ValidationRule { }
   ```

3. **Access Control**
   ```swift
   // ✅ Good - Explicit access control
   public struct EmailValidationRule: IValidationRule {
       private let pattern: String
       
       public init(pattern: String) {
           self.pattern = pattern
       }
   }
   ```

4. **Documentation**
   ```swift
   /// Validates email addresses using RFC 5322 compliant regex.
   ///
   /// This validator checks for valid email format including:
   /// - Local part validation
   /// - Domain validation
   /// - TLD requirements
   ///
   /// - Parameters:
   ///   - pattern: Custom regex pattern (optional)
   ///   - error: Error to return on validation failure
   ///
   /// - Example:
   /// ```swift
   /// let rule = EmailValidationRule(error: "Invalid email")
   /// let result = validator.validate(input: "user@example.com", rule: rule)
   /// ```
   public struct EmailValidationRule: IValidationRule {
       // Implementation
   }
   ```

### Code Quality

- **No force unwrapping** - Use optional binding or guards
- **No force casting** - Use conditional casting
- **No magic numbers** - Use named constants
- **Single responsibility** - One class, one purpose
- **DRY principle** - Don't repeat yourself
- **SOLID principles** - Follow SOLID design

**Example:**
```swift
// ✅ Good
private enum ValidationConstants {
    static let minLength = 8
    static let maxLength = 128
}

guard let email = input as? String else {
    return .invalid([ValidationError(message: "Invalid input type")])
}

// ❌ Bad
let email = input as! String
if email.count < 8 || email.count > 128 {
    return .invalid([ValidationError(message: "Invalid")])
}
```

### Testing Requirements

All code changes must include tests:

1. **Unit tests** - Test individual components
2. **Integration tests** - Test component interactions
3. **Edge cases** - Test boundary conditions
4. **Error handling** - Test failure scenarios

**Coverage requirements:**
- New code: minimum 80% coverage
- Modified code: maintain or improve existing coverage
- Critical paths: 100% coverage

**Test structure:**
```swift
import XCTest
@testable import ValidatorCore

final class EmailValidationRuleTests: XCTestCase {
    var sut: EmailValidationRule!
    
    override func setUp() {
        super.setUp()
        sut = EmailValidationRule(error: "Invalid email")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Valid Email Tests
    
    func testValidateWithValidEmail_ReturnsTrue() {
        // Given
        let email = "user@example.com"
        
        // When
        let result = sut.validate(input: email)
        
        // Then
        XCTAssertTrue(result)
    }
    
    // MARK: - Invalid Email Tests
    
    func testValidateWithInvalidEmail_ReturnsFalse() {
        // Given
        let email = "invalid.email"
        
        // When
        let result = sut.validate(input: email)
        
        // Then
        XCTAssertFalse(result)
    }
    
    // MARK: - Edge Cases
    
    func testValidateWithEmptyString_ReturnsFalse() {
        XCTAssertFalse(sut.validate(input: ""))
    }
}
```

## Community

- **Discussions** - Join [GitHub Discussions](https://github.com/space-code/validator/discussions)
- **Issues** - Track [open issues](https://github.com/space-code/validator/issues)
- **Pull Requests** - Review [open PRs](https://github.com/space-code/validator/pulls)

## Recognition

Contributors are recognized in:
- GitHub contributors page
- Release notes
- Project README (for significant contributions)

## Questions?

- Check [existing issues](https://github.com/space-code/validator/issues)
- Search [discussions](https://github.com/space-code/validator/discussions)
- Ask in [Q&A discussions](https://github.com/space-code/validator/discussions/categories/q-a)
- Email the maintainer: nv3212@gmail.com

---

Thank you for contributing to Validator! 🎉

Your efforts help make this project better for everyone.