//  Created by Lech Lipnicki on 2021-02-27.
//

import UIKit

final class LoginViewController: ViewController {

    @IBOutlet private weak var titleLogoView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var loginView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        changeInterfaceAccordingTo(loginSegmentedControl.selectedSegmentIndex)
    }

    // MARK: - Actions

    @IBAction private func loginSegmentedControlIndexChanged(_ sender: UISegmentedControl) {
        changeInterfaceAccordingTo(loginSegmentedControl.selectedSegmentIndex)
    }

    // MARK: Submit Button Actions

    @objc private func handleLogin() { //validation then login
        do {
            try AccountManager.loginAccount(
                username: usernameTextField.text,
                password: passwordTextField.text
            )
            proceedToHomeView()
        } catch {
            if let error = error as? AccountManager.ErrorMessage {
                print(error)
                // showFailureAlert(message: error.description) // Make Alert with message
            }
        }
    }

    @objc private func handleRegister() { //validation, register then login
        do {
            try AccountManager.registerAccount(
                username: usernameTextField.text,
                password: passwordTextField.text,
                confirmPassword: confirmPasswordTextField.text
            )
            proceedToHomeView()
        } catch {
            if let error = error as? AccountManager.ErrorMessage {
                print(error) // Make Alert with message
            }
        }
    }
}

// MARK: - Setup Views

extension LoginViewController {

    private func changeInterfaceAccordingTo(_ index: Int) {
        removeTargets(
            from: [submitButton,
                   usernameTextField,
                   passwordTextField,
                   confirmPasswordTextField],
            for: .allEvents
        )

        switch index {
        case 0:
            changeInterfaceOnLoginSelected()
        case 1:
            changeInterfaceOnRegisterSelected()
        default:
            break
        }
    }

    @objc private func changeSubmitButtonOnLoginSelected() {
        guard
            let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty
        else {
            submitButton.disableButton()
            return
        }
        submitButton.enableButton()
    }

    @objc private func changeSubmitButtonOnRegisterSelected() {
        guard
            let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let confirmPassword = confirmPasswordTextField.text,
            !confirmPassword.isEmpty
        else {
            submitButton.disableButton()
            return
        }
        submitButton.enableButton()
    }

    private func changeInterfaceOnLoginSelected() {
        confirmPasswordTextField.isHidden = true
        confirmPasswordTextField.text = nil

        submitButton.styleButton(
            title: "Login",
            titleColor: .white,
            backgroundColor: .gray,
            isEnabled: false
        )

        submitButton.addTarget(
            self,
            action: #selector(handleLogin),
            for: .touchUpInside
        )

        addTargets(
            for: [usernameTextField, passwordTextField],
            with: #selector(changeSubmitButtonOnLoginSelected),
            for: .editingChanged
        )
    }

    private func changeInterfaceOnRegisterSelected() {
        confirmPasswordTextField.isHidden = false

        submitButton.styleButton(
            title: "Register",
            titleColor: .white,
            backgroundColor: .gray,
            isEnabled: false
        )

        submitButton.addTarget(
            self,
            action: #selector(handleRegister),
            for: .touchUpInside
        )

        addTargets(
            for: [usernameTextField,
                  passwordTextField,
                  confirmPasswordTextField],
            with: #selector(changeSubmitButtonOnRegisterSelected),
            for: .editingChanged
        )
    }

    private func configureViews() {
        view.backgroundColor = color(.white)
        titleLabel.textColor = color(.darkGray)
        titleLogoView.backgroundColor = color(.white)
        loginView.backgroundColor = color(.lightGray)
        loginView.roundCorners([.allCorners])
        loginSegmentedControl.backgroundColor = color(.gray)
        loginSegmentedControl.selectedSegmentTintColor = color(.darkGray)

        loginSegmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: color(.lightGray)!],
            for: .selected
        )

        loginSegmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: color(.darkGray)!],
            for: .normal
        )

        submitButton.roundCorners(
            [.bottomLeft, .bottomRight],
            cornerRadius: .rounded
        )
    }
}

// MARK: - Helpers

private extension LoginViewController {

    func removeTargets(from UIControls: [UIControl], for event: UIControl.Event) {
        for UIControl in UIControls {
            UIControl.removeTarget(nil, action: nil, for: event)
        }
    }

    func addTargets(
        for textFields: [UITextField],
        with action: Selector,
        for event: UIControl.Event
    ) {
        for textField in textFields {
            textField.addTarget(self, action: action, for: event)
        }
    }
}
