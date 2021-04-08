//  Created by Lech Lipnicki on 2021-02-27.
//

import UIKit

enum Icon: Int {
    case heartFilled
    case heartClear
    case calendar
    case none

    func iconValue() -> UIImage? {
        switch self {
        case .heartFilled:
            return UIImage(named: "heartFilled")
        case .heartClear:
            return UIImage(named: "heartClear")
        case .calendar:
            return UIImage(named: "calendarIcon")
        case .none:
            return nil
        }
    }
}

func icon(_ icon: Icon) -> UIImage? {
    icon.iconValue()
}
