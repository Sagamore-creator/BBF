//  Created by Lech Lipnicki on 2021-02-27.
//

import UIKit

enum Color: Int {
    case green
    case gray
    case darkGray
    case lightGray
    case black
    case white
    case red
    case backgroundMain
    case clear

    func colorValue(alpha: CGFloat = 1.0) -> UIColor? {
        switch self {
        case .green:
            return UIColor(hexString: "016933")
        case .gray:
            return UIColor(hexString: "E9E9EA")
        case .darkGray:
            return UIColor(hexString: "555555")
        case .lightGray:
            return UIColor(hexString: "F6F6F6")
        case .black:
            return .black
        case .white:
            return .white
        case .red:
            return .red
        case .backgroundMain:
            return UIColor(hexString: "535454")
        case .clear:
            return .clear
        }
    }
}

func color(_ color: Color) -> UIColor? {
    color.colorValue()
}
