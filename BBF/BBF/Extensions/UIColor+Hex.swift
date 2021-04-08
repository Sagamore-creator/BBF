//  Created by Lech Lipnicki on 2021-02-27.
//

import UIKit

extension UIColor {

    convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1)
    }

    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var hexStringUpper = hexString.uppercased()

        if hexStringUpper.hasPrefix("0X") {
            let index = hexStringUpper.index(hexStringUpper.startIndex, offsetBy: 2)
            hexStringUpper = String(hexStringUpper[index...])
        } else if hexStringUpper.hasPrefix("#") {
            let index = hexStringUpper.index(hexStringUpper.startIndex, offsetBy: 1)
            hexStringUpper = String(hexStringUpper[index...])
        }

        var rgbValue: UInt64 = 0
        let scanner = Scanner(string: hexStringUpper).scanHexInt64(&rgbValue)

        guard scanner else {
            self.init()
            return nil
        }

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
