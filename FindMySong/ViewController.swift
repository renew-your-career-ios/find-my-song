//
//  ViewController.swift
//  FindMySong
//
//  Created by saulo.santos.freire on 26/03/25.
//

import UIKit

class ViewController: UIViewController {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        // Main Stack View (Vertical)
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 1
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        
        // Constraints for the Main Stack View
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Title View (Top View)
        let titleView = UIView()
        titleView.backgroundColor = .systemBackground
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View inside of the Title View
        let titleStackView = UIStackView()
        titleStackView.spacing = 0.43
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.addSubview(titleStackView)
                
        // Constraints for the Title Label
        NSLayoutConstraint.activate([
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        titleStackView.addArrangedSubview(containerView)
        
        // Constraints for the Title Stack View
        NSLayoutConstraint.activate([
            titleStackView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -150)
        ])
        
        mainStackView.addArrangedSubview(titleView)
        
        // Buttons View (Bottom View)
        let buttonsView = UIView()
        buttonsView.backgroundColor = .systemBackground
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(buttonsView)
        
        // Login with Spotify Button
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
        
        // Login Later Button
        let loginLaterButton = UIButton(type: .system)
        loginLaterButton.setTitle("Login Later", for: .normal)
        loginLaterButton.accessibilityLabel = "Login Later"
        loginLaterButton.accessibilityHint = "Skips the login process for now"
        loginLaterButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        loginLaterButton.tintColor = purpleColor
        loginLaterButton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsView.addSubview(loginLaterButton)
        
        // Constraints for the Buttons
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
        
        gradientLayer.mask = textMask
        containerView.layer.addSublayer(gradientLayer)
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255)
    }
}
