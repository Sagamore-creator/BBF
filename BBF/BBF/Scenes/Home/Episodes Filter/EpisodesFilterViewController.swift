//  Created by Lech Lipnicki on 2021-03-04.
//

import UIKit

final class EpisodesFilterViewController: ViewController {

    @IBOutlet private weak var filterView: UIView!
    @IBOutlet private weak var textFieldsView: UIView!
    @IBOutlet private weak var seasonTextField: UITextField!
    @IBOutlet private weak var startDateTextField: UITextField!
    @IBOutlet private weak var endDateTextField: UITextField!
    @IBOutlet private weak var episodeFilterTableView: UITableView!
    @IBOutlet private weak var applyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    // MARK: - Actions

    @IBAction private func applyButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }

    // MARK: - Setup Views

    private func configureViews() {
        textFieldsView.backgroundColor = color(.darkGray)
        episodeFilterTableView.backgroundColor = color(.white)
        episodeFilterTableView.tableFooterView = UIView()

        filterView.roundCorners(
            [.allCorners],
            cornerRadius: .rounded
        )

        textFieldsView.roundCorners(
            [.topLeft, .topRight],
            cornerRadius: .rounded
        )

        applyButton.styleButton(
            title: "Apply",
            titleColor: .white,
            backgroundColor: .darkGray
        )

        applyButton.roundCorners(
            [.bottomLeft, .bottomRight],
            cornerRadius: .rounded
        )
    }
}
