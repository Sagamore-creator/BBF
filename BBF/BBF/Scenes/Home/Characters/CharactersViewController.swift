//  Created by Lech Lipnicki on 2021-03-03.
//

import UIKit

final class CharactersViewController: ViewController {

    private var characters = [Character]()

    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var charactersTableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        loadCharacters()
        configureViews()
    }
    
    private func loadCharacters() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        APIManager().getCharacters() { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(characters):
                    self?.characters = characters
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    self?.charactersTableView.reloadData()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func loadCharacterDetails(with character: Character) {
        let characterDetailsVC = CharacterDetailsViewController.instantiate()
        characterDetailsVC.character = character
        characterDetailsVC.isModalInPresentation = true
        present(characterDetailsVC, animated: true, completion: nil)
    }

    // MARK: - Actions
    
    @IBAction private func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func filterButtonTapped(_ sender: Any) {
        presentCharactersFilter()
    }
}

// MARK: - Setup UI

private extension CharactersViewController {

    func configureViews() {
        navigationView.backgroundColor = color(.white)
    }
}

// MARK: - UITableViewDataSource methods

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableViewCell", for: indexPath)

        let character = characters[indexPath.row]
        
        guard let characterCell = cell as? CharactersTableViewCell else {
            return cell
        }
        
        characterCell.configureCell(characterName: character.name)
        
        return characterCell
    }
}

// MARK: - UITableViewDelegate methods

extension CharactersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        loadCharacterDetails(with: character)
    }
}
