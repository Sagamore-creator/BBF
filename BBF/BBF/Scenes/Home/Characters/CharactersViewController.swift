//  Created by Lech Lipnicki on 2021-03-03.
//

import UIKit
import CoreData

final class CharactersViewController: ViewController {

    private var characters: [Character] = []
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var charactersTableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCharacters()
        configureViews()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        activityIndicator.show()

        APIManager().getCharacters() { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(characters):
                    self?.populateDatabase(with: characters)
                    self?.activityIndicator.hide()
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
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
    }
}

// MARK: - Core Data Model manipulation methods

private extension CharactersViewController {

    func saveCharacter() {
        do {
            try context?.save()
        } catch {
            print("\(error.localizedDescription)")
        }
    }

    func loadCharacters() {
        guard let context = context else { return }

        let request: NSFetchRequest<Character> = Character.fetchRequest()

        do {
            characters = try context.fetch(request)
        } catch {
            print("\(error.localizedDescription)")
        }
        charactersTableView.reloadData()
    }

    func populateDatabase(with characters: [CharacterResponse]) {
        guard let context = context else { return }

        for character in characters {
            let newCharacter = Character(context: context)
            newCharacter.characterId = Int16(character.characterId)
            newCharacter.name = character.name
            newCharacter.birthday = character.birthday
            newCharacter.nickname = character.nickname
            newCharacter.status = character.status

            self.characters.append(newCharacter)
            self.saveCharacter()
        }
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
        
        guard
            let characterCell = cell as? CharactersTableViewCell,
            let characterName = character.name
        else {
            return cell
        }
        characterCell.configureCell(with: characterName)

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
