//  Created by Lech Lipnicki on 2021-03-06.
//

import Foundation

struct UserDefaultsManager {

    private enum UserDefaultsManagerKey {
        static let accounts = "Accounts"
        static let loggedInAccount = "LoggedInUser"
    }

    private let userDefaults: UserDefaults = .standard
    private let keyChain = KeychainSwift()
}

// MARK: - Account handling functionality

extension UserDefaultsManager {

    // MARK: Account

    func saveAccount(_ account: inout Account) {
        var accounts = getAccounts()
        savePassword(account.password, for: account.username)
        account.password = ""
        accounts.append(account)
        saveAccounts(accounts)
    }
    
    func saveAccounts(_ accounts: [Account]) {
        let encodedAccounts = try? JSONEncoder().encode(accounts)
        userDefaults.set(encodedAccounts,forKey: UserDefaultsManagerKey.accounts)
    }

    func getAccounts() -> [Account] {
        guard
            let encodedAccounts = userDefaults.object(forKey: UserDefaultsManagerKey.accounts) as? Data
        else {
            return []
        }
        return try! JSONDecoder().decode([Account].self, from: encodedAccounts)
    }

    // MARK: LoggedInAccount

    func saveLoggedInAccount(_ account: Account?) {
        let encodedLoggedInAccount = try? JSONEncoder().encode(account)
        userDefaults.set(encodedLoggedInAccount, forKey: UserDefaultsManagerKey.loggedInAccount)
    }

    func getLoggedInAccount() -> Account? {
        guard
            let encodedLoggedInAccount = userDefaults.object(forKey: UserDefaultsManagerKey.loggedInAccount) as? Data
        else {
            return nil
        }
        return try? JSONDecoder().decode(Account.self, from: encodedLoggedInAccount)
    }

    // MARK: Password

    func savePassword(_ password: String, for username: String) {
        keyChain.set(password, forKey: username)
    }

    func getPassword(for username: String) -> String? {
        keyChain.get(username)
    }
}
