//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import SwiftUI
import ValidatorCore

struct ErrorView: View {
    // MARK: Properties

    let errors: [any IValidationError]

    // MARK: View

    var body: some View {
        errors.first.map {
            Text($0.message)
                .font(.caption)
                .foregroundStyle(.red)
        }
    }
}
