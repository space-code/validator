//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

#if os(macOS)
    import AppKit

    extension NSTextField: IUIValidatable {
        /// The value of the text field to validate.
        /// Returns an empty string if `text` is nil.
        public var inputValue: String { stringValue }

        /// The type of input for validation.
        public typealias Input = String

        /// Enables or disables automatic validation when the text changes.
        ///
        /// - Parameter isEnabled: If true, validation is triggered on every text change.
        ///                        If false, the target-action is removed.
        public func validateOnInputChange(isEnabled: Bool) {
            if isEnabled {
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(textFieldDidChange(_:)),
                    name: NSControl.textDidChangeNotification,
                    object: self
                )
            } else {
                NotificationCenter.default.removeObserver(
                    self,
                    name: NSControl.textDidChangeNotification,
                    object: self
                )
            }
        }

        // MARK: Private

        /// Called automatically when the text field changes (if `validateOnInputChange` is enabled).
        /// Performs validation using all rules stored in `validationRules`.
        ///
        /// - Parameter notification: The notification containing the text field.
        @objc
        private func textFieldDidChange(_ notification: Notification) {
            guard notification.object as? NSTextField === self else { return }
            validate(rules: validationRules)
        }
    }
#endif
