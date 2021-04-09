//  Created by Lech Lipnicki on 2021-03-06.
//

import Foundation

struct KeychainManager {

    private let keyChain = KeychainSwift()

    func savePassword(_ password: String, for username: String) {
        keyChain.set(password, forKey: username)
    }

    func getPassword(for username: String) -> String? {
        keyChain.get(username)
    }
}
