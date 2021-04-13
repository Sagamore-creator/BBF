//  Created by Lech Lipnicki on 2021-03-06.
//

import Foundation

struct AccountManager {

    private static var validate = Validate()
    static var loggedInAccount: Account?
    static var defaultsManager = UserDefaultsManager()
}

// MARK: - Login and Register

extension AccountManager {

    static func registerAccount(
        username: String?,
        password: String?,
        confirmPassword: String?
    ) throws {
        guard
            let username = username,
            let password = password,
            let confirmPassword = confirmPassword
        else {
            throw ErrorMessage.unknownError
        }
        try validate.registration(
            username: username,
            password: password,
            confirmPassword: confirmPassword
        )

        var account = Account(username: username, password: password)
        defaultsManager.saveAccount(&account)
        loggedInAccount = account
        defaultsManager.saveLoggedInAccount(loggedInAccount)
    }

    static func loginAccount(
        username: String?,
        password: String?
    ) throws {
        guard let username = username, let password = password else {
            throw ErrorMessage.unknownError
        }
        try validate.login(username: username, password: password)
    }
}

// MARK: - Validation

extension AccountManager {

    final class Validate {

        func registration(
            username: String,
            password: String,
            confirmPassword: String
        ) throws {
            guard checkIfCredentialsNotEmpty(
                    username: username,
                    password: password,
                    confirmPassword: confirmPassword
            ) else {
                throw ErrorMessage.missingValues
            }

            guard checkUsernameSyntax(name: username) else {
                throw ErrorMessage.wrongUsernameSyntax
            }

            guard checkPasswordSyntax(password: password) else {
                throw ErrorMessage.wrongPasswordSyntax
            }

            guard checkPasswordMatching(password: password, confirmPassword: confirmPassword) else {
                throw ErrorMessage.passwordsDontMatch
            }

            guard !ifAccountExists(with: username) else {
                throw ErrorMessage.accountAlreadyExists
            }
        }

        func login(username: String, password: String) throws {
            guard let accounts = defaultsManager.getAccounts() else {
                throw ErrorMessage.accountNotFound
            }

            for account in accounts where account.username == username {
                guard password == defaultsManager.keyChain.getPassword(for: account.username) else {
                    throw ErrorMessage.wrongPassword
                }
            }
        }

        // MARK: Private methods

        private func checkUsernameSyntax(name: String) -> Bool {
            let nameRegex = "^\\w{3,16}$" // min 3 max 16 characters
            let trimmedString = name.trimmingCharacters(in: .whitespaces)
            let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
            let isValidateName = validateName.evaluate(with: trimmedString)
            return isValidateName
        }

        private func checkPasswordSyntax(password: String) -> Bool {
            let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$" // min 8 chars, 1 letter, 1 number
            let trimmedString = password.trimmingCharacters(in: .whitespaces)
            let validatePassword = NSPredicate(format:"SELF MATCHES %@", passRegEx)
            let isValidPassword = validatePassword.evaluate(with: trimmedString)
            return isValidPassword
        }

        private func checkPasswordMatching(password: String, confirmPassword: String) -> Bool {
            password == confirmPassword ? true : false
        }

        private func checkIfCredentialsNotEmpty(
            username: String,
            password: String,
            confirmPassword: String
        ) -> Bool {
            username.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty ? true : false
        }

        private func ifAccountExists(with username: String) -> Bool {
            guard let accounts = defaultsManager.getAccounts() else {
                return false
            }
            return accounts.contains { $0.username == username }
        }
    }
}

// MARK: - Errors

extension AccountManager {

    enum ErrorMessage: Error {
        case missingValues
        case accountAlreadyExists
        case wrongUsernameSyntax
        case wrongPassword
        case wrongPasswordSyntax
        case passwordsDontMatch
        case accountNotFound
        case unknownError

        var description: String {
            switch self {
            case .missingValues:
                return "Missing required values."
            case .accountAlreadyExists:
                return "This username is already taken."
            case .wrongUsernameSyntax:
                return "Username length must be 3-16 characters."
            case .wrongPassword:
                return "Incorrect password!"
            case .wrongPasswordSyntax:
                return "Password must have min 8 symbols, 1 letter, 1 number."
            case .passwordsDontMatch:
                return "Passwords doesn't match"
            case .accountNotFound:
                return "Account with this username is not found."
            case .unknownError:
                return "Unknown Error occurred!"
            }
        }
    }
}
