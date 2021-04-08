//  Created by Lech Lipnicki on 2021-03-06.
//

import Foundation

struct AccountManager {

    private enum AccountManagerError: Error {
        case missingValues
        case accountAlreadyExists
        case wrongPassword
        case accountNotFound

        var errorDescription: String {
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
}

// MARK: - Main functionality

extension AccountManager {

    static func registerAccount(username: String?, password: String?) throws {
        guard
            let username = username,
            let password = password,
            isNotEmptyCredentials(username: username, password: password)
        else {
            throw AccountManagerError.missingValues
        }

        guard !isAccountTaken(with: username) else {
            throw AccountManagerError.accountAlreadyExists
        }

        var account = Account(username: username, password: password)
        UserDefaultsManager().saveAccount(&account)
        loggedInAccount = account
        UserDefaultsManager().saveLoggedInAccount(loggedInAccount)
    }

    static func loginAccount() {}
}

// MARK: - Validation

extension AccountManager {

    private static func isNotEmptyCredentials(username: String, password: String) -> Bool{
        guard
            username.isNotEmpty,
            password.isNotEmpty
        else {
            return false
        }
        return true
    }

    private static func isAccountTaken(with username: String) -> Bool {
        let accounts = UserDefaultsManager().getAccounts()
        return accounts.contains { $0.username == username }
    }
}
