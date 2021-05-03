//  Created by Lech Lipnicki on 2021-03-03.
//

import UIKit
import CoreData

struct EpisodesSection {
    let season: String
    let episodes: [EpisodeResponse]
}

final class EpisodesViewController: ViewController {

    private var episodes: [Episode] = []

    private var sections = [EpisodesSection]()
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var episodesTableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        loadEpisodes()
        configureViews()
    }
    
    private func loadEpisodes() {
        activityIndicator.show()
        
        APIManager().getEpisodes() { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(episodes):
                    self?.fetchEpisodes(from: episodes)
                    self?.activityIndicator.hide()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchEpisodes(from episodes: [EpisodeResponse]) {
        let episodes = Dictionary(
            grouping: episodes,
            by: { $0.season }
        )

        let keys = episodes.keys.sorted()
        
        sections = keys.compactMap { season in
            EpisodesSection(
                season: "Season \(season)",
                episodes: episodes[season]!.sorted(by: { $0.episodeId < $1.episodeId })
            ) }

        episodesTableView.reloadData()
    }

    private func loadEpisodeDetails(with episode: EpisodeResponse) {
        let episodeDetailsVC = EpisodeDetailsViewController.instantiate()
        episodeDetailsVC.episode = episode
        episodeDetailsVC.isModalInPresentation = true
        present(episodeDetailsVC, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction private func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func filterButtonTapped(_ sender: Any) {
        presentEpisodesFilter()
    }
}

// MARK: - Setup UI

private extension EpisodesViewController {

    func configureViews() {
        navigationView.backgroundColor = color(.white)
    }
}

// MARK: - UITableViewDataSource methods

extension EpisodesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        sections[section].episodes.count
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        sections[section].season
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesTableViewCell", for: indexPath)

        let section = sections[indexPath.section]
        let episode = section.episodes[indexPath.row]
        
        guard let episodeCell = cell as? EpisodesTableViewCell else {
            return cell
        }

        episodeCell.configureCell(episodeTitle: episode.title)

        return episodeCell
    }
}

// MARK: - UITableViewDelegate methods

extension EpisodesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let episodes = sections[indexPath.section].episodes
        let episode = episodes[indexPath.row]
        loadEpisodeDetails(with: episode)
    }
}
