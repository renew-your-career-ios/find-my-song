import UIKit

class SearchViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let fullTitle = "find my Song"
        titleLabel.textAlignment = .left
        
        let attributedText = NSMutableAttributedString(
            string: fullTitle,
            attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .regular)]
        )
        if let range = fullTitle.range(of: "Song") {
            let nsRange = NSRange(range, in: fullTitle)
            attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 32, weight: .bold), range: nsRange)
        }
        titleLabel.attributedText = attributedText
        
        return titleLabel
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Find your favorite song, band or album"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        //Do contrário, o ícone era criado, mas não adicionado a rightView
        DispatchQueue.main.async {
            let textField = searchBar.searchTextField
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            //Para remover o excesso de espaçamento nas laterais da searchbar
            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            ])
            
            let microphoneIcon = UIButton(type: .system)
            microphoneIcon.setImage(UIImage(systemName: "mic.fill"), for: .normal)
            microphoneIcon.tintColor = .gray
            microphoneIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            microphoneIcon.contentMode = .scaleAspectFit
            textField.rightView = microphoneIcon
            textField.rightViewMode = .always
        }
        return searchBar
    }()
    
    let segmentedControl: UISegmentedControl = {
        let items = ["Band", "Song", "Album"]
        let segmentedControl = UISegmentedControl(items: items)
        
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }()
    
    let tabBar: UITabBar = {
        let tabBar = UITabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        
        let search = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        let profile = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        let settings = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        tabBar.items = [search, profile, settings]
        tabBar.selectedItem = search
        tabBar.backgroundColor = .systemBackground
        tabBar.isTranslucent = false
        
        return tabBar
        
    }()
    
    let emptyIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square.dashed")
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let red: CGFloat = 120 / 255.0
        let green: CGFloat = 120 / 255.0
        let blue: CGFloat = 128 / 255.0
        let alpha: CGFloat = 31 / 255.0
        
        imageView.tintColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        return imageView
    }()
    
    let emptyListMessage: UILabel = {
        let label = UILabel()
        label.text = "Nothing here. Try searching for a song."
     
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let red: CGFloat = 60 / 255.0
        let green: CGFloat = 60 / 255.0
        let blue: CGFloat = 67 / 255.0
        let alpha: CGFloat = 0.3
        
        label.textColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        
        // MARK: - Stack View Principal
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -28)
        ])
        
        //MARK: TitleView
        let titleView = UIView()
        
        titleView.addSubview(titleLabel)
        
        mainStackView.addArrangedSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
        
        //MARK: SearchbarView
        let searchBarView = UIView()
        
        searchBarView.addSubview(searchBar)
        
        mainStackView.addArrangedSubview(searchBarView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 45),
            searchBar.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
        
        
        //MARK: SegmentedControlView
        let segmentedControlView = UIView()
        
        segmentedControlView.addSubview(segmentedControl)
        
        mainStackView.addArrangedSubview(segmentedControlView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: segmentedControlView.bottomAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
        
        //MARK: Segmented ContentView
        
        let contentView = UIView()
        
        contentView.addSubview(emptyIcon)
        contentView.addSubview(emptyListMessage)
        
        mainStackView.addArrangedSubview(contentView)
        
        NSLayoutConstraint.activate([
            emptyIcon.topAnchor.constraint(equalTo: segmentedControlView.bottomAnchor, constant: 200),
            emptyIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            emptyIcon.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            emptyIcon.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            emptyIcon.heightAnchor.constraint(equalToConstant: 100),
            
            emptyListMessage.topAnchor.constraint(equalTo: emptyIcon.bottomAnchor, constant: 36),
            emptyListMessage.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            emptyListMessage.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            emptyListMessage.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
        
        //MARK: TabBarView
        let tabBarView = UIView()
        
        tabBarView.addSubview(tabBar)
        
        mainStackView.addArrangedSubview(tabBarView)
        
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
