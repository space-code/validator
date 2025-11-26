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

    /// The current result of the validation.
    /// Updated whenever the value changes or rules are applied.
    @State private var validationResult: ValidationResult = .valid

    /// The value to validate, wrapped as a `Binding` so changes are observed automatically.
    @Binding private var item: T

    /// A closure that constructs a SwiftUI view from a list of validation errors.
    @ViewBuilder private let content: ([any IValidationError]) -> ErrorView

    /// The array of validation rules applied to the binding value.
    public let rules: [any IValidationRule<T>]

    /// Creates a new instance of the `ValidationViewModifier`.
    ///
    /// - Parameters:
    ///   - item: The binding value to validate.
    ///   - rules: The array of validation rules to apply.
    ///   - content: A closure that builds a custom error view from the validation errors.
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

    /// Modifies the view to include validation logic and error messages below the content.
    ///
    /// - Parameter content: The original view content.
    ///
    /// - Returns: A view containing the original content and validation messages.
    public func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
                .validation($item, rules: rules) { result in
                    DispatchQueue.main.async {
                        validationResult = result
                    }
                }
            validationMessageView
        }
    }

    // MARK: Private

    private var validationMessageView: some View {
        switch validationResult {
        case .valid:
            EmptyView().eraseToAnyView()
        case let .invalid(errors):
            content(errors).eraseToAnyView()
        }
    }
}
