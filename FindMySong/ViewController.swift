//
//  ViewController.swift
//  FindMySong
//
//  Created by saulo.santos.freire on 26/03/25.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let titleText = "find my Song"
        let attributedTitleText = NSMutableAttributedString(string: titleText)
        attributedTitleText.addAttributes([
            .font: UIFont.systemFont(ofSize: 32, weight: .bold),
            .foregroundColor: UIColor.black
        ], range: NSRange(location: 0, length: 7))
        attributedTitleText.addAttributes([
            .font: UIFont.systemFont(ofSize: 32, weight: .regular),
            .foregroundColor: UIColor(hex: "#801CD6"),
        ], range: NSRange(location: 8, length: 4))
        
        let titleLabel = UILabel()
        titleLabel.attributedText = attributedTitleText

        let loginWithSpotifyButton: UIButton = {
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = UIColor(hex: "#1ED760")
            config.baseForegroundColor = .black
            config.cornerStyle = .capsule
            config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20)
            
            let attributedTitle = AttributedString("Login with Spotify", attributes: AttributeContainer([
                   .font: UIFont.systemFont(ofSize: 17, weight: .bold)
               ]))
               config.attributedTitle = attributedTitle
            
            let button = UIButton(configuration: config)
            return button
        }()
        
        let loginLaterButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Login later", for: .normal)
            button.tintColor = UIColor(hex: "#801CD6")
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            return button
        }()
        
        let titleView: UIView = {
            let view = UIView()
            view.addSubview(titleLabel)
            return view
        }()
        let buttonView: UIView = {
            let view = UIView()
            view.addSubview(loginWithSpotifyButton)
            view.addSubview(loginLaterButton)
            return view
        }()
  
        
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleView, buttonView])
            stackView.axis = .vertical
            stackView.spacing = 1
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            return stackView
        }()
        
        view.addSubview(stackView)
       
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginWithSpotifyButton.translatesAutoresizingMaskIntoConstraints = false
        loginLaterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
          

            loginWithSpotifyButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            loginWithSpotifyButton.bottomAnchor.constraint(equalTo: loginLaterButton.topAnchor, constant: -14),
            loginWithSpotifyButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -47),
            loginWithSpotifyButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 47),

            loginLaterButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            loginLaterButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -65),
            loginLaterButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 47),
            loginLaterButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -47),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150)
        ])
    }


}



