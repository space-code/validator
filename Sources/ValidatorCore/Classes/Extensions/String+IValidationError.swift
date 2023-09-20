//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

extension String: IValidationError {
    public var message: String { self }
}
