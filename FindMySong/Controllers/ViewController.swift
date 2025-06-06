//
//  Created by saulo.santos.freire on 26/03/25.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SpotifyWebViewControllerDelegate{
    
    //MARK: Computed properties
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var biometricPromptAlert: UIAlertController {
        let alert = UIAlertController(
            title: "Usar biometria?",
            message: "Você deseja usar biometria para logar da próxima vez?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Não", style: .cancel))

        alert.addAction(UIAlertAction(title: "Sim", style: .default) { _ in
            UserDefaults.standard.set(true, forKey: "prefersBiometricAuthentication")
        })

        return alert
    }
    
    private var loginErrorAlert: UIAlertController {
        let alert = UIAlertController(
            title: "Não foi possível logar",
            message: "Tente novamente mais tarde",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 1
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let titleView = UIView()
        titleView.backgroundColor = .systemBackground
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        titleStackView.spacing = 0.43
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.addSubview(titleStackView)
        titleStackView.isLayoutMarginsRelativeArrangement = true
        titleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        titleStackView.addArrangedSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 50),
            containerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -150),
            titleStackView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16),
            titleStackView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -16),
        ])
        
        mainStackView.addArrangedSubview(titleView)
        
        let buttonsView = UIView()
        buttonsView.backgroundColor = .systemBackground
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(buttonsView)
        
        let loginWithSpotifyButton = UIButton(type: .system)
        loginWithSpotifyButton.setTitle("Login with Spotify", for: .normal)
        loginWithSpotifyButton.accessibilityLabel = "Login with Spotify"
        loginWithSpotifyButton.accessibilityHint = "Logs you into the app using your Spotify account"
        loginWithSpotifyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        loginWithSpotifyButton.backgroundColor = UIColor(red: 0.12, green: 0.84, blue: 0.38, alpha: 1.0)
        loginWithSpotifyButton.tintColor = .black
        loginWithSpotifyButton.layer.cornerRadius = 25
        loginWithSpotifyButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginWithSpotifyButton.addTarget(self, action: #selector(onLoginWithSpotifyPressed), for: .touchUpInside)
        
        buttonsView.addSubview(loginWithSpotifyButton)
        
        let purpleColor = UIColor(red: 0.50, green: 0.11, blue: 0.84, alpha: 1.0)
        let loginLaterButton = UIButton(type: .system)
        loginLaterButton.setTitle("Login Later", for: .normal)
        loginLaterButton.accessibilityLabel = "Login Later"
        loginLaterButton.accessibilityHint = "Skips the login process for now"
        loginLaterButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        loginLaterButton.tintColor = purpleColor
        loginLaterButton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsView.addSubview(loginLaterButton)
        
        NSLayoutConstraint.activate([
            loginWithSpotifyButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor, constant: 50),
            loginWithSpotifyButton.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor, constant: -50),
            loginWithSpotifyButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginLaterButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor, constant: 50),
            loginLaterButton.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor, constant: -50),
            loginLaterButton.topAnchor.constraint(equalTo: loginWithSpotifyButton.bottomAnchor, constant: 14),
            loginLaterButton.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: -65),
            loginLaterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.layoutIfNeeded()
        setupTextWithGradient()
    }

    private func setupTextWithGradient() {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        containerView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let fullText = "find my Song"
        let prefix = "find my "
        let gradientText = "Song"
        let font = UIFont.systemFont(ofSize: 32, weight: .regular)
        
        let prefixSize = (prefix as NSString).size(withAttributes: [.font: font])
        let gradientSize = (gradientText as NSString).size(withAttributes: [.font: font])
        let totalSize = (fullText as NSString).size(withAttributes: [.font: font])
        
        let textLabel = UILabel()
        textLabel.text = fullText
        textLabel.font = font
        textLabel.textColor = .clear
        textLabel.frame = CGRect(
            x: (containerView.bounds.width - totalSize.width) / 2,
            y: 0,
            width: totalSize.width,
            height: containerView.bounds.height
        )
        
        containerView.addSubview(textLabel)
        
        let blackTextLabel = UILabel()
        blackTextLabel.text = prefix
        blackTextLabel.font = font
        blackTextLabel.textColor = .black
        blackTextLabel.frame = CGRect(
            x: textLabel.frame.origin.x,
            y: 0,
            width: prefixSize.width,
            height: containerView.bounds.height
        )
        
        containerView.addSubview(blackTextLabel)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#801CD6").cgColor,
            UIColor(hex: "#D61C70").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = CGRect(
            x: textLabel.frame.origin.x + prefixSize.width,
            y: 0,
            width: gradientSize.width,
            height: containerView.bounds.height
        )
        
        
        let textMask = CATextLayer()
        textMask.string = gradientText
        textMask.font = font
        textMask.fontSize = font.pointSize
        textMask.frame = CGRect(
            x: 0,
            y: (containerView.bounds.height - gradientSize.height) / 2,
            width: gradientSize.width,
            height: gradientSize.height
        )
        textMask.foregroundColor = UIColor.black.cgColor
        textMask.contentsScale = UIScreen.main.scale
        
        gradientLayer.mask = textMask
        containerView.layer.addSublayer(gradientLayer)
    }
    
    //  MARK:  Button Methods
    @objc private func onLoginWithSpotifyPressed() {
        let webVC = SpotifyWebViewController()
        webVC.delegate = self
        
        let nav = UINavigationController(rootViewController: webVC)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }
    
    // MARK: Webview Protocol
    func spotifyWebViewController(_ controller: SpotifyWebViewController, didReceiveCode code: String) {
        guard !code.isEmpty else {
            print("Empty code")
            return
        }
        
        fetchTokens(with: code)
    }
    
    //MARK: Login methods
    private func fetchTokens(with code: String) {
        spinner.startAnimating()
        
        Task {
            defer {
                spinner.stopAnimating()
            }
            
            do {
                let (accessToken, refreshToken) = try await SpotifyService.shared.requestAccessToken(withCode: code)
                handleSuccessfulLogin(accessToken: accessToken, refreshToken: refreshToken)
            } catch {
                handleLoginError(error)
            }
        }
    }

    private func handleSuccessfulLogin(accessToken: String, refreshToken: String) {
        let accessSaved = KeyChainService.create(value: accessToken, forKey: "accessToken")
        let refreshSaved = KeyChainService.create(value: refreshToken, forKey: "refreshToken")
        
        guard accessSaved, refreshSaved else { return }
    
        navigateToSearch()
    }

    private func handleLoginError(_ error: Error) {
        present(loginErrorAlert, animated: true)
    }
    
    private func navigateToSearch() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)


        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(self.biometricPromptAlert, animated: true)
        }
    }
}
