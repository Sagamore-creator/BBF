//  Created by Lech Lipnicki on 2021-03-03.
//

import UIKit

final class CharactersTableViewCell: UITableViewCell {

    @IBOutlet private weak var characterNameLabel: UILabel!

    func configureCell(with characterName: String) {
        characterNameLabel.text = characterName
    }
}
