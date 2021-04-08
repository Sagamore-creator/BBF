//  Created by Lech Lipnicki on 2021-03-01.
//

import Foundation

struct Character: Decodable {
    let characterId: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let image: String
    let status: String
    let nickname: String
    let appearance: [Int]

    private enum CodingKeys: String, CodingKey {
        case characterId = "char_id"
        case name
        case birthday
        case occupation
        case image = "img"
        case status
        case nickname
        case appearance
    }
}
