//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import SwiftUI
import ValidatorCore

public struct FormValidationViewModifier<ErrorView: View>: ViewModifier {
    // MARK: Properties

    /// The result of the validation.
    @State private var validationResult: ValidationResult = .valid

    /// A container for form validation logic.
    private let validationContainer: any IFormValidationContainer

    /// A custom parameter attribute that constructs views from closures.
    @ViewBuilder private let content: ([any IValidationError]) -> ErrorView

    // MARK: Initialization

    public init(
        validationContainer: any IFormValidationContainer,
        @ViewBuilder content: @escaping ([any IValidationError]) -> ErrorView
    ) {
        self.validationContainer = validationContainer
        self.content = content
    }

    // MARK: ViewModifier

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
