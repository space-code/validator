//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import SwiftUI
import ValidatorCore

/// A  validation view modifier.
///
/// The validation view modifier automatically tracks validation errors,
/// uses the content view builder to construct an error view, and displays
/// it to the user.
///
/// ```
/// struct ContentView: View {
///    @State private var text: String = "Text"
///
///    var body: some View {
///        VStack {
///            TextField("Title", text: $text)
///                .modifier(
///                    ValidationViewModifier(
///                        item: $text,
///                        rules: [
///                            LengthValidationRule(max: 10, error: "The error message"),
///                        ],
///                        content: { errors in
///                            Text(errors.map { $0.message }.joined(separator: " "))
///                        }
///                    )
///                )
///            Spacer()
///        }
///        .padding()
///    }
/// }
/// ```
public struct ValidationViewModifier<T, ErrorView: View>: ViewModifier {
    // MARK: Properties

    /// The result of the validation.
    @State private var validationResult: ValidationResult = .valid

    /// The binding item to validate.
    @Binding private var item: T

    /// A custom parameter attribute that constructs views from closures.
    @ViewBuilder private let content: ([any IValidationError]) -> ErrorView

    /// The array of validation rules to apply to the item's value.
    public let rules: [any IValidationRule<T>]

    /// Creates a new instance of the `ValidationViewModifier`.
    ///
    /// - Parameters:
    ///   - item: The binding item to validate.
    ///   - rules: The array of validation rules to apply to the item's value.
    ///   - content: A custom parameter attribute that constructs an error view from closures.
    public init(
        item: Binding<T>,
        rules: [any IValidationRule<T>],
        @ViewBuilder content: @escaping ([any IValidationError]) -> ErrorView
    ) {
        _item = item
        self.rules = rules
        self.content = content
    }

    // MARK: ViewModifier

    public func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
                .validation($item, rules: rules) { result in
                    DispatchQueue.main.async {
                        self.validationResult = result
                    }
                }
            validationMessageView
        }
    }

    // MARK: Private

    private var validationMessageView: some View {
        switch validationResult {
        case .valid:
            return EmptyView().eraseToAnyView()
        case let .invalid(errors):
            return content(errors).eraseToAnyView()
        }
    }
}
