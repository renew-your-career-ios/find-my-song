//
//  ViewController.swift
//  FindMySong
//
//  Created by saulo.santos.freire on 26/03/25.
//

import UIKit
import SafariServices
import LocalAuthentication


class LoginViewController: UIViewController , SFSafariViewControllerDelegate{
    
   let authorizationService = AuthorizationService()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        
        
        
        var components = URLComponents(string: "https://accounts.spotify.com/authorize")!
        components.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
           URLQueryItem(name: "client_id", value: "e2fc8bf189174ef196832cf74c1126a8"),
           URLQueryItem(name: "scope", value: "user-read-private playlist-modify-public playlist-read-public user-follow-read user-read-email"),
           URLQueryItem(name: "redirect_uri", value: "fms://login/call-back"),
           URLQueryItem(name: "show_dialog", value: "TRUE")
        ]

        
        
        
        
        let action = UIAction { [weak self] _ in
       
            self?.openSpotifyLogin()
         
        }

        loginWithSpotifyButton.addAction(action, for: .touchUpInside)

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
 
    
    func openSpotifyLogin() {
        guard let authURL = URL(string: "https://accounts.spotify.com/authorize?response_type=code&client_id=e2fc8bf189174ef196832cf74c1126a8&scopes=user-read-private%20playlist-modify-public%20playlist-read-public%20user-follow-read%20user-read-email&redirect_uri=fms://login/call-back&show_dialog=TRUE") else {
            return
        }

        let safariVC = SFSafariViewController(url: authURL)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }

     func selectBiometricPreference() {
        let alert = UIAlertController(
            title: "Login Com Biometria",
            message: "Deseja usar a biometria na próxima vez?",
            preferredStyle: .alert)
         
         alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { _ in
             UserDefaults.standard.set(true, forKey: "biometricLogin")
             //salva preferencia
         }))
         
         alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: { _ in
              //salva preferencia
         }))
         
        present(alert, animated: true)
    }
    
    func authenticateWithBiometricsIfNeeded() {
        if UserDefaults.standard.bool(forKey: "biometricLogin") {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Acesso ao Spotify") { success, error in
                    DispatchQueue.main.async {
                        if success {
                            self.authorizationService.refreshAceessToken()
                        }else{
                            print(error?.localizedDescription ?? "Erro ao autenticar com biometria")
                        }
                    }
                }
            }
        }
    }

}


