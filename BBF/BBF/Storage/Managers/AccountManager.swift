//  Created by Lech Lipnicki on 2021-03-06.
//

import Foundation

struct AccountManager {

    enum ErrorMessage: Error {
        case missingValues
        case accountAlreadyExists
        case wrongPassword
        case accountNotFound

        var description: String {
            switch self {
            case .missingValues:
                return "Missing required values."
            case .accountAlreadyExists:
                return "This username is already taken."
            case .wrongPassword:
                return "Incorrect password!"
            case .accountNotFound:
                return "Account with this username is not found"
            }
        }
    }

    static var loggedInAccount: Account?
    private static var defaultsManager = UserDefaultsManager()
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
            let confirmPassword = confirmPassword,
            isNotEmptyCredentials(
                username: username,
                password: password,
                confirmPassword: confirmPassword
            )
        else {
            throw ErrorMessage.missingValues
        }

        guard !isAccountTaken(with: username) else {
            throw ErrorMessage.accountAlreadyExists
        }

        var account = Account(username: username, password: password)
        defaultsManager.saveAccount(&account)
        loggedInAccount = account
        defaultsManager.saveLoggedInAccount(loggedInAccount)
    }

    static func loginAccount(username: String?, password: String?) throws {
        guard let accounts = defaultsManager.getAccounts() else {
            throw AccountManager.ErrorMessage.accountNotFound
        }

        for account in accounts where account.username == username {
            guard password == KeychainManager().getPassword(for: account.username) else {
                throw AccountManager.ErrorMessage.wrongPassword
            }
        }
    }
}

// MARK: - Validation

extension AccountManager {

    private static func isNotEmptyCredentials(
        username: String,
        password: String,
        confirmPassword: String
    ) -> Bool{
        guard
            username.isNotEmpty,
            password.isNotEmpty,
            confirmPassword.isNotEmpty
        else {
            return false
        }
        return true
    }

    private static func isAccountTaken(with username: String) -> Bool {
        guard let accounts = defaultsManager.getAccounts() else {
            return false
        }
        return accounts.contains { $0.username == username }
    }
}
