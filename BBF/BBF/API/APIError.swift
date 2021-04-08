//  Created by Lech Lipnicki on 2021-03-01.
//

import Foundation

enum APIError: Error {
    case requestFailed(reason: String?)
    case parsingFailed
}
