//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import UIKit

extension UIView {
    func findFirstResponder() -> UIView? {
        if isFirstResponder { return self }
        for sub in subviews {
            if let found = sub.findFirstResponder() { return found }
        }
        return nil
    }
}
