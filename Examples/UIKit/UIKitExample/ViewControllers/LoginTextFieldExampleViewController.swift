//
// Validator
// Copyright © 2025 Space Code. All rights reserved.
//

import UIKit
import ValidatorCore
import ValidatorUI

final class LoginTextFieldExampleViewController: UIViewController {
    // MARK: - Properties

    /// UI
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

    private lazy var firstNameTextField: UITextField = {
        let textField = makeField("First Name")
        textField.validationRules = [
            LengthValidationRule(min: 2, max: 50, error: "First name should be 2–50 characters long"),
        ]
        return textField
    }()

    private lazy var lastNameTextField: UITextField = {
        let textField = makeField("Last Name")
        textField.validationRules = [
            LengthValidationRule(min: 2, max: 50, error: "Last name should be 2–50 characters long"),
        ]
        return textField
    }()

    private lazy var emailTextField: UITextField = {
        let textField = makeField("Email")
        textField.keyboardType = .emailAddress
        textField.validationRules = [
            EmailValidationRule(error: "Please enter a valid email address"),
        ]
        return textField
    }()

    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray4
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    /// Private properties
    private var isValid: Bool {
        [firstNameTextField, lastNameTextField, emailTextField]
            .allSatisfy { $0.validationResult == .valid }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
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
        for item in [firstNameTextField, lastNameTextField, emailTextField] {
            item.validationHandler = { [weak self] _ in
                guard let self else { return }
                updateSubmitButtonState()
            }
        }

        [firstNameTextField, lastNameTextField, emailTextField, submitButton]
            .forEach(stackView.addArrangedSubview)

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
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            submitButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    private func updateSubmitButtonState() {
        submitButton.isEnabled = isValid
        UIView.animate(withDuration: 0.25) {
            self.submitButton.backgroundColor = self.isValid ? .systemBlue : .systemGray4
        }
    }

    // MARK: Private

    private func makeField(_ placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder

        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.backgroundColor = UIColor.secondarySystemBackground
        textField.textColor = .label

        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always

        textField.heightAnchor.constraint(equalToConstant: 56.0).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.validateOnInputChange(isEnabled: true)

        return textField
    }

    // MARK: Notifications

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

    // MARK: - Actions

    @objc
    private func submit() {
        guard isValid else {
            let alert = UIAlertController(
                title: "The form is invalid",
                message: "Please check the highlighted fields and correct the entered information.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Got it", style: .default))

            present(alert, animated: true)
            return
        }

        let alert = UIAlertController(
            title: "Success 🎉",
            message: "Your account has been successfully created.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
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
}
