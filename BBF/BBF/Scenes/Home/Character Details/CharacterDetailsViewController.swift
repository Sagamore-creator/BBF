//  Created by Lech Lipnicki on 2021-03-01.
//

import UIKit

final class CharacterDetailsViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var characterDetailsView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var birthdayLabel: UILabel!
    @IBOutlet private weak var quotesTableView: UITableView!

    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViews()
    }

    // MARK: - Actions

    @IBAction private func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Setup Views

extension CharacterDetailsViewController {

    private func configureView() {
        if let characterName = character?.name,
           let characterBirthday = character?.birthday {
            nameLabel.text = characterName
            birthdayLabel.text = "Birthday\n\(characterBirthday)"
        }
    }

    private func configureViews() {
        view.backgroundColor = color(.white)
        navigationView.backgroundColor = color(.darkGray)
        characterDetailsView.backgroundColor = color(.lightGray)
        quotesTableView.backgroundColor = color(.white)
        quotesTableView.tableFooterView = UIView()
        titleLabel.textColor = color(.white)
        titleLabel.text = "Character Detail"

        quotesTableView.roundCorners(
            [.allCorners],
            cornerRadius: .rounded
        )

        closeButton.styleButton(
            title: "x",
            titleColor: .darkGray,
            backgroundColor: .white
        )

        closeButton.roundCorners(
            [.topRight, .bottomLeft],
            cornerRadius: .rounded
        )
    }
}
