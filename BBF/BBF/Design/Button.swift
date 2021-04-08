//  Created by Lech Lipnicki on 2021-02-27.
//

import UIKit

extension UIButton {

    func styleButton(
        title: String,
        titleColor: Color = .black,
        backgroundColor: Color = .clear,
        borderColor: Color = .clear,
        isEnabled: Bool? = nil
    ) {
        setTitle(title, for: .normal)
        setTitleColor(color(titleColor), for: .normal)
        self.backgroundColor = color(backgroundColor)
        layer.borderColor = color(borderColor)?.cgColor
        layer.borderWidth = buttonBorderWidth
        tintColor = color(titleColor)
        self.isEnabled = isEnabled ?? true

        if let titleLabel = titleLabel
        {
            titleLabel.textAlignment = .center
        }
    }
}
