//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

#if os(iOS)
    import UIKit

    extension UITextView: IUIValidatable {
        /// The value of the text view to validate.
        /// Returns an empty string if `text` is nil.
        public var inputValue: String {
            text ?? ""
        }

        /// The type of input for validation.
        public typealias Input = String

        /// Enables or disables automatic validation when the text changes.
        ///
        /// - Parameter isEnabled: If true, adds an observer for text changes.
        ///                        If false, removes the observer.
        public func validateOnInputChange(isEnabled: Bool) {
            if isEnabled {
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(textViewDidChangeNotification(_:)),
                    name: UITextView.textDidChangeNotification,
                    object: self
                )
            } else {
                NotificationCenter.default.removeObserver(
                    self,
                    name: UITextView.textDidChangeNotification,
                    object: self
                )
            }
        }

        // MARK: Private

        /// Called automatically when the text view changes via NotificationCenter.
        @objc
        private func textViewDidChangeNotification(_ notification: Notification) {
            guard let textView = notification.object as? UITextView, textView === self else { return }

            validate(rules: validationRules)
        }
    }
#endif
