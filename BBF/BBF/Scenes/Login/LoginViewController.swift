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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }

    // MARK: - Actions

    @IBAction private func loginSegmentedControlIndexChanged(_ sender: UISegmentedControl) {
        changeInterfaceAccordingTo(loginSegmentedControl.selectedSegmentIndex)
    }

    // MARK: Submit Button Actions

    @objc private func handleLogin() {
        do {
            try AccountManager.loginAccount(
                username: usernameTextField.text,
                password: passwordTextField.text
            )
            proceedToHomeView()
        } catch {
            if let error = error as? AccountManager.ErrorMessage {
                print(error.description) // showAlert(message: error.description)
            }
        }
    }

    @objc private func handleRegister() {
        do {
            try AccountManager.registerAccount(
                username: usernameTextField.text,
                password: passwordTextField.text,
                confirmPassword: confirmPasswordTextField.text
            )
            proceedToHomeView()
        } catch {
            if let error = error as? AccountManager.ErrorMessage {
                print(error.description) // showAlert(message: error.description)
            }
        }
    }
}

// MARK: - Setup Views

private extension LoginViewController {

    func changeInterfaceAccordingTo(_ index: Int) {
        removeTargets(
            from: [submitButton,
                   usernameTextField,
                   passwordTextField,
                   confirmPasswordTextField],
            for: .allEvents
        )

        switch index {
        case 0:
            onLogin()
        case 1:
            onRegister()
        default:
            break
        }
    }

    @objc func buttonOnLogin() {
        guard
            let username = usernameTextField.text,
            username.isNotEmpty,
            let password = passwordTextField.text,
            password.isNotEmpty
        else {
            submitButton.disableButton()
            return
        }
        submitButton.enableButton()
    }

    @objc func buttonOnRegister() {
        guard
            let username = usernameTextField.text,
            username.isNotEmpty,
            let password = passwordTextField.text,
            password.isNotEmpty,
            let confirmPassword = confirmPasswordTextField.text,
            confirmPassword.isNotEmpty
        else {
            submitButton.disableButton()
            return
        }
        submitButton.enableButton()
    }

    func onLogin() {
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
            with: #selector(buttonOnLogin),
            for: .editingChanged
        )
    }

    func onRegister() {
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
            with: #selector(buttonOnRegister),
            for: .editingChanged
        )
    }

    func configureViews() {
        view.backgroundColor = color(.lightGray)
        titleLabel.textColor = color(.darkGray)
        titleLogoView.backgroundColor = color(.lightGray)
        loginView.backgroundColor = color(.lightGray)
        loginView.roundCorners([.allCorners])
        loginSegmentedControl.backgroundColor = color(.gray)
        loginSegmentedControl.selectedSegmentTintColor = color(.green)

        loginSegmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: color(.lightGray)!],
            for: .selected
        )

        loginSegmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: color(.darkGray)!],
            for: .normal
        )

        submitButton.roundCorners(
            [.allCorners],
            cornerRadius: .rounded
        )
    }

    func signIn() {
        let loggedInAccount = AccountManager.defaultsManager.getLoggedInAccount()
        if loggedInAccount != nil {
            proceedToHomeView()
        }
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
