//  Created by Lech Lipnicki on 2021-03-01.
//

import UIKit

extension UIActivityIndicatorView {

    func hide() {
        self.isHidden = true
        self.stopAnimating()
    }

    func show() {
        self.isHidden = false
        self.startAnimating()
    }
}
