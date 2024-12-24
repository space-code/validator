//
// Validator
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

#if hasFeature(RetroactiveAttribute)
    extension String: @retroactive Error {}
#endif

// MARK: - String + IValidationError

extension String: IValidationError {
    public var message: String { self }
}
