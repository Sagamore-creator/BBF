//  Created by Lech Lipnicki on 2021-03-02.
//

import UIKit

final class EpisodesTableViewCell: UITableViewCell {

    @IBOutlet private weak var episodeTitleLabel: UILabel!

    func configureCell(episodeTitle: String) {
        episodeTitleLabel.text = episodeTitle
    }
}
