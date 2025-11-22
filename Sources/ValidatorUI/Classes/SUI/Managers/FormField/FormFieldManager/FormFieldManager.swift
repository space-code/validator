//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Combine
import Foundation
import ValidatorCore

public final class FormFieldManager: IFormFieldManager {
    // MARK: Properties

    @Published public var isValid = false

    private var cancellables = Set<AnyCancellable>()
    private var validators: [any IFormValidationContainer] = []

    // MARK: Initialization

    public init() {}

    // MARK: IFormFieldManager

    public func append(validator: some IFormValidationContainer) {
        validator
            .publisher
            .sink(receiveValue: { [weak self] _ in
                self?.validate()
            }
            )
            .store(in: &cancellables)

        validators.append(validator)
        validate()
    }

    public func validate() {
        // swiftlint:disable:next contains_over_filter_is_empty
        isValid = validators
            .filter { $0.validate() != .valid }
            .isEmpty
    }
}
