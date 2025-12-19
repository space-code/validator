//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import UIKit
import ValidatorCore
import ValidatorUI

final class FeedbackTextViewExampleViewController: UIViewController {
    // MARK: - UI

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var feedbackTextView: UITextView = {
        let textView = makeTextView()
        textView.validationRules = [
            LengthValidationRule(min: 10, max: 500, error: "Feedback must be 10–500 characters long"),
        ]
        return textView
    }()

    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit Feedback", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray4
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return button
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Validation

    private var isValid: Bool {
        feedbackTextView.validationResult == .valid
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "UITextView Demo"
        view.backgroundColor = .systemBackground

        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }

    // MARK: - UI Setup

    private func configure() {
        feedbackTextView.validationHandler = { [weak self] _ in
            self?.updateSubmitButtonState()
        }

        [feedbackTextView, submitButton].forEach(stackView.addArrangedSubview)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),

            feedbackTextView.heightAnchor.constraint(equalToConstant: 160),
            submitButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    private func updateSubmitButtonState() {
        UIView.animate(withDuration: 0.25) {
            self.submitButton.backgroundColor = self.isValid ? .systemBlue : .systemGray4
        }
    }

    // MARK: - Helpers

    private func makeTextView() -> UITextView {
        let textView = UITextView()

        textView.text = ""
        textView.font = .systemFont(ofSize: 16)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.backgroundColor = UIColor.secondarySystemBackground
        textView.textColor = .label

        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false

        // Enable validation on text changes
        textView.validateOnInputChange(isEnabled: true)

        return textView
    }

    // MARK: - Keyboard Handling

    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }

        let keyboardFrame = frameValue.cgRectValue
        let bottomInset = keyboardFrame.height - view.safeAreaInsets.bottom

        scrollView.contentInset.bottom = bottomInset

        if let firstResponder = view.findFirstResponder(),
           !scrollView.frame.contains(firstResponder.frame)
        {
            scrollView.scrollRectToVisible(firstResponder.frame, animated: true)
        }
    }

    @objc
    private func keyboardWillHide(_: Notification) {
        scrollView.contentInset.bottom = .zero
    }

    // MARK: - Actions

    @objc
    private func submit() {
        guard isValid else {
            let alert = UIAlertController(
                title: "Feedback is invalid",
                message: "Please write at least 10 characters.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let alert = UIAlertController(
            title: "Thank you! 🎉",
            message: "Your feedback has been successfully submitted.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Great", style: .default))
        present(alert, animated: true)
    }
}
