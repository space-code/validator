//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

#if os(iOS)
    import UIKit

    extension UITextField: IUIValidatable {
        public var inputValue: String { text ?? "" }

        public typealias Input = String

        public func validateOnInputChange(isEnabled: Bool) {
            if isEnabled {
                addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            } else {
                removeTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            }
        }

        // MARK: Private

        @objc
        private func textFieldDidChange(_: UITextField) {
            validate(rules: validationRules)
        }
    }
#endif
