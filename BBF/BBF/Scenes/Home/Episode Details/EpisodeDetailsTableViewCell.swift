//  Created by Lech Lipnicki on 2021-03-07.
//

import UIKit

final class EpisodeDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!

    func configureCell(with characterName: String) {
        nameLabel.text = characterName
    }
}
