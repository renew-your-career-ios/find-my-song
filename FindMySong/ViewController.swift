//
//  ViewController.swift
//  FindMySong
//
//  Created by saulo.santos.freire on 26/03/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
    }
    
    func setupStackView() {
        view.backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        let titleView = setupTitleView()
        let buttonsView = setupButtonsView()
        
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(buttonsView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor,),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
 
        ])
    }
    
    func setupTitleView() -> UIView {
        let titleView = UIView()
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        
        let title = Constants.LoginPage.Text.title
        let attributedText = NSMutableAttributedString(string: title, attributes: [
            .font: UIFont.boldSystemFont(ofSize: 32)
        ])
        
        let songRange = (title as NSString).range(of: Constants.LoginPage.range)
        
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: songRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor(named: Constants.LoginPage.Color.loginPurple)!, range: songRange)
        
        titleLabel.attributedText = attributedText
        
        titleView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: -150)
        ])
        
        return titleView
    }
    
    func setupButtonsView () -> UIView {
        let buttonsView = UIView()
        
        
        let loginWithSpotifyButton = setupButton(
                title: Constants.LoginPage.Text.loginWithSpotify,
                titleColor: .black,
                backgroundColor: UIColor(named: Constants.LoginPage.Color.loginGreen),
                font: .systemFont(ofSize: 17, weight: .bold),
                cornerRadius: 24
            )
        
        let loginLaterButton = setupButton(
                title: Constants.LoginPage.Text.loginLater,
                titleColor: UIColor(named: Constants.LoginPage.Color.loginPurple)!,
                backgroundColor: nil,
                font: .systemFont(ofSize: 17, weight: .regular),
                cornerRadius: nil
            )
        
        
        buttonsView.addSubview(loginWithSpotifyButton)
        buttonsView.addSubview(loginLaterButton)
        
        NSLayoutConstraint.activate([
            loginWithSpotifyButton.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor),
            loginWithSpotifyButton.widthAnchor.constraint(equalToConstant: 336),
            loginWithSpotifyButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginLaterButton.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor),
            loginLaterButton.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor),
            loginLaterButton.topAnchor.constraint(equalTo: loginWithSpotifyButton.bottomAnchor, constant: 14),
            loginLaterButton.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: -30),
            loginLaterButton.widthAnchor.constraint(equalToConstant: 336),
            loginLaterButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        return buttonsView
    }
    
    func setupButton(title: String, titleColor: UIColor, backgroundColor: UIColor?, font: UIFont, cornerRadius: CGFloat?) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        
        if let backgroundColor = backgroundColor {
            button.backgroundColor = backgroundColor
        }
        
        if let cornerRadius = cornerRadius {
            button.layer.cornerRadius = cornerRadius
        }

        return button
    }
}

