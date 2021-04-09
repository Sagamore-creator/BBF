//  Created by Lech Lipnicki on 2021-03-01.
//

import UIKit

final class EpisodeDetailsViewController: UIViewController, Storyboarded {

    private var charactersList = [String]()

    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var episodeDetailsView: UIView!
    @IBOutlet private weak var episodeTitleLabel: UILabel!
    @IBOutlet private weak var seasonLabel: UILabel!
    @IBOutlet private weak var episodeNumberLabel: UILabel!
    @IBOutlet private weak var airDateLabel: UILabel!
    @IBOutlet private weak var charactersListTableView: UITableView!

    var episode: Episode?

    override func viewDidLoad() {
        super.viewDidLoad()
        charactersListTableView.delegate = self
        charactersListTableView.dataSource = self
        configureView()
        configureViews()
    }

    // MARK: - Actions

    @IBAction private func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Setup Views

private extension EpisodeDetailsViewController {

    func configureView() {
        if let episodeTitle = episode?.title,
           let episodeSeason = episode?.season,
           let episodeNumber = episode?.episode,
           let episodeAirDate = episode?.airDate,
           let episodeCharacters = episode?.characters {
            episodeTitleLabel.text = "'\(episodeTitle)'"
            seasonLabel.text = "Season \(episodeSeason)"
            episodeNumberLabel.text = "Episode \(episodeNumber)"
            airDateLabel.text = episodeAirDate
            charactersList = episodeCharacters
        }
    }
    
    func configureViews() {
        view.backgroundColor = color(.white)
        navigationView.backgroundColor = color(.darkGray)
        episodeDetailsView.backgroundColor = color(.lightGray)
        charactersListTableView.backgroundColor = color(.white)
        charactersListTableView.tableFooterView = UIView()
        titleLabel.textColor = color(.white)
        titleLabel.text = "Episode Details"

        charactersListTableView.roundCorners(
            [.allCorners],
            cornerRadius: .rounded
        )

        closeButton.styleButton(
            title: "X",
            titleColor: .darkGray,
            backgroundColor: .white
        )

        closeButton.roundCorners(
            [.allCorners],
            cornerRadius: .rounded
        )
    }
}

// MARK: - UITableViewDataSource methods

extension EpisodeDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        charactersList.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeDetailsTableViewCell", for: indexPath)

        let character = charactersList[indexPath.row]

        guard let characterCell = cell as? EpisodeDetailsTableViewCell else {
            return cell
        }

        characterCell.configureCell(characterName: character)

        return characterCell
    }
}

// MARK: - UITableViewDelegate methods

extension EpisodeDetailsViewController: UITableViewDelegate {}
