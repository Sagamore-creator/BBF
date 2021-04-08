//  Created by Lech Lipnicki on 2021-02-27.
//

import UIKit

extension UIView {

    func roundCorners(
        _ corners: UIRectCorner,
        cornerRadius: CornerRadius = .rounded
    ) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius.rawValue, height: cornerRadius.rawValue)
        )

        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
