//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation

// MARK: - FormFieldManager

/// A concrete implementation of `IFormFieldManager` that manages the validation state of a form.
///
/// Tracks all registered form fields, observes their validation results,
/// and exposes a single `isValid` property that represents the overall form validity.
public final class FormFieldManager: IFormFieldManager {
    // MARK: Properties

    /// A Boolean value indicating whether all registered fields are valid.
    ///
    /// Published so SwiftUI views or other observers can reactively update based on form validity.
    @Published public var isValid = false

    /// A set of cancellables for Combine subscriptions to field validation publishers.
    private var cancellables = Set<AnyCancellable>()

    /// The collection of validation containers for all registered form fields.
    private var validators: [any IFormValidationContainer] = []

    // MARK: Initialization

    /// Creates a new instance of `FormFieldManager`.
    public init() {}

    // MARK: IFormFieldManager

    /// Appends a new field validator to the manager.
    ///
    /// - Parameter validator: The validation container for a specific field.
    ///
    /// The manager subscribes to the validator's publisher so that any changes
    /// in validation results automatically trigger re-evaluation of the form's overall validity.
    public func append(validator: some IFormValidationContainer) {
        validator
            .publisher
            .sink(receiveValue: { [weak self] _ in
                self?.validate()
            })
            .store(in: &cancellables)

        validators.append(validator)

        validate()
    }

    /// Recalculates the overall form validity by checking all registered validators.
    public func validate() {
        // swiftlint:disable:next contains_over_filter_is_empty
        isValid = validators
            .filter { $0.validate() != .valid }
            .isEmpty
    }
}
