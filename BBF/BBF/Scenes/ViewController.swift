//  Created by Lech Lipnicki on 2021-02-27.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Storyboards

    private lazy var HomeStoryboard: UIStoryboard = {
        UIStoryboard(name: "Home", bundle: nil)
    }()
}

// MARK: - UIViewControllers & Transitions

extension ViewController {

    private var HomeViewController: UIViewController {
        HomeStoryboard.instantiateViewController(identifier: "HomeViewController")
    }

    func proceedToHomeView() {
        modalPresentationStyle = .fullScreen
        present(HomeViewController, animated: true)
    }

    private var EpisodesViewController: UIViewController {
        HomeStoryboard.instantiateViewController(identifier: "EpisodesViewController")
    }

    func proceedToEpisodesView() {
        modalPresentationStyle = .fullScreen
        present(EpisodesViewController, animated: true)
    }

    private var CharactersViewController: UIViewController {
        HomeStoryboard.instantiateViewController(identifier: "CharactersViewController")
    }

    func proceedToCharactersView() {
        modalPresentationStyle = .fullScreen
        present(CharactersViewController,animated: true)
    }

    private var EpisodesFilterViewController: UIViewController {
        HomeStoryboard.instantiateViewController(identifier: "EpisodesFilterViewController")
    }

    func presentEpisodesFilter() {
        modalPresentationStyle = .fullScreen
        present(EpisodesFilterViewController,animated: true)
    }

    private var CharactersFilterViewController: UIViewController {
        HomeStoryboard.instantiateViewController(identifier: "CharactersFilterViewController")
    }

    func presentCharactersFilter() {
        modalPresentationStyle = .fullScreen
        present(CharactersFilterViewController,animated: true)
    }
}
