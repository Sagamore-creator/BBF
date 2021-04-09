//  Created by Lech Lipnicki on 2021-03-01.
//

import UIKit

final class HomeViewController: ViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var episodesButton: UIButton!
    @IBOutlet private weak var charactersButton: UIButton!
    @IBOutlet private weak var quotesButton: UIButton!
    @IBOutlet private weak var logoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    @IBAction private func episodesButtonTapped(_ sender: Any) {
        proceedToEpisodesView()
    }
    @IBAction private func charactersButtonTapped(_ sender: Any) {
        proceedToCharactersView()
    }
    @IBAction private func quotesButtonTapped(_ sender: Any) {
        //        proceedToQuotesView()
    }

    @IBAction private func logoutButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Setup Views

extension HomeViewController {
    
    private func configureViews() {
        titleLabel.text = "Breaking Bad Fan"
        usernameLabel.text = AccountManager.loggedInAccount?.username

        episodesButton.styleButton(
            title: "Episodes",
            titleColor: .white,
            backgroundColor: .darkGray,
            borderColor: .gray
        )

        charactersButton.styleButton(
            title: "Characters",
            titleColor: .white,
            backgroundColor: .darkGray,
            borderColor: .gray
        )

        quotesButton.styleButton(
            title: "Quotes",
            titleColor: .white,
            backgroundColor: .darkGray,
            borderColor: .gray
        )
    }
}
