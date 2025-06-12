import UIKit
class HomeViewController: UIViewController {

    private let titleLabel = UILabel()
    private let searchBar = UISearchBar()
    private let segmentedControl = UISegmentedControl(items: ["Band", "Song", "Album"])
    private let tabBar = UITabBar()
    private let emptyIcon = UIImageView()
    private let emptyListMessage = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true

        setupTitleLabel()
        setupSearchBar()
        setupSegmentedControl()
        setupTabBar()
        setupEmptyState()
    }

    private func setupLayout() {
        let mainStack = UIStackView(arrangedSubviews: [
            titleLabel,
            searchBar,
            segmentedControl,
            emptyIcon,
            emptyListMessage
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 24
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])

        view.addSubview(tabBar)
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


    private func setupTitleLabel() {
        let fullTitle = "find my Song"
        let attributed = NSMutableAttributedString(string: fullTitle, attributes: [
            .font: UIFont.systemFont(ofSize: 32, weight: .regular)
        ])
        if let range = fullTitle.range(of: "Song") {
            attributed.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 32), range: NSRange(range, in: fullTitle))
        }
        titleLabel.attributedText = attributed
        titleLabel.textAlignment = .left
    }

    private func setupSearchBar() {
        searchBar.placeholder = "Find your favorite song, band or album"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundImage = UIImage()

        let micButton = UIButton(type: .system)
        micButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        micButton.tintColor = .gray
        micButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        searchBar.searchTextField.rightView = micButton
        searchBar.searchTextField.rightViewMode = .always
    }

    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 1
    }

    private func setupTabBar() {
        let search = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        let profile = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        let settings = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        tabBar.items = [search, profile, settings]
        tabBar.selectedItem = search
        tabBar.isTranslucent = false
    }

    private func setupEmptyState() {
        emptyIcon.image = UIImage(systemName: "square.dashed")
        emptyIcon.contentMode = .scaleAspectFit
        emptyIcon.tintColor = UIColor(red: 120/255, green: 120/255, blue: 128/255, alpha: 31/255)

        emptyListMessage.text = "Nothing here. Try searching for a song."
        emptyListMessage.font = .systemFont(ofSize: 17, weight: .semibold)
        emptyListMessage.textAlignment = .center
        emptyListMessage.numberOfLines = 0
        emptyListMessage.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.3)
    }
}

