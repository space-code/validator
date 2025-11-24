//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import SwiftUI
import ValidatorCore

/// A SwiftUI `ViewModifier` that displays validation messages for a form.
///
/// This modifier observes a `validationContainer` and updates the UI automatically
/// whenever validation results change. It can display a custom error view for invalid inputs.
///
/// - Parameter ErrorView: The type of view used to display validation errors.
public struct FormValidationViewModifier<ErrorView: View>: ViewModifier {
    // MARK: Properties

    /// The current result of the validation.
    /// Updated whenever the container publishes a new validation result.
    @State private var validationResult: ValidationResult = .valid

    /// A container that holds form validation logic and publishes validation results.
    private let validationContainer: any IFormValidationContainer

    /// A closure that constructs a SwiftUI view from a list of validation errors.
    @ViewBuilder private let content: ([any IValidationError]) -> ErrorView

    // MARK: Initialization

    /// Initializes the modifier with a validation container and a custom error view builder.
    ///
    /// - Parameters:
    ///   - validationContainer: The container holding the validation logic for the form.
    ///   - content: A closure that takes an array of errors and returns a view to display them.
    public init(
        validationContainer: any IFormValidationContainer,
        @ViewBuilder content: @escaping ([any IValidationError]) -> ErrorView
    ) {
        self.validationContainer = validationContainer
        self.content = content
    }

    // MARK: ViewModifier

    /// Modifies the view to include validation error messages below the content.
    ///
    /// - Parameter content: The original view content.
    /// - Returns: A view containing the original content and validation messages.
    public func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
            validationMessageView
        }.onReceive(validationContainer.publisher) { result in
            validationResult = result
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
