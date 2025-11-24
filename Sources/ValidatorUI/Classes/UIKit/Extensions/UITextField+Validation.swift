//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

#if os(iOS)
    import UIKit

    extension UITextField: IUIValidatable {
        /// The value of the text field to validate.
        /// Returns an empty string if `text` is nil.
        public var inputValue: String { text ?? "" }

        /// The type of input for validation.
        public typealias Input = String

        /// Enables or disables automatic validation when the text changes.
        ///
        /// - Parameter isEnabled: If true, validation is triggered on every text change.
        ///                        If false, the target-action is removed.
        public func validateOnInputChange(isEnabled: Bool) {
            if isEnabled {
                addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            } else {
                removeTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            }
        }

        // MARK: Private

        /// Called automatically when the text field changes (if `validateOnInputChange` is enabled).
        /// Performs validation using all rules stored in `validationRules`.
        ///
        /// - Parameter textField: The text field triggering the action.
        @objc
        private func textFieldDidChange(_: UITextField) {
            validate(rules: validationRules)
        }
    }
#endif
