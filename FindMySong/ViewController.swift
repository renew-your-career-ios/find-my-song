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
        let loginWithSpotifyButton = UIButton(type: .system)
        
        loginWithSpotifyButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginWithSpotifyButton.setTitle(Constants.LoginPage.Text.loginWithSpotify, for: .normal)
        loginWithSpotifyButton.setTitleColor(.black, for: .normal)
        loginWithSpotifyButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        loginWithSpotifyButton.backgroundColor = UIColor(named: Constants.LoginPage.Color.loginGreen)
        loginWithSpotifyButton.layer.cornerRadius = 24
        
        
        let loginLaterButton = UIButton(type: .system)
        
        loginLaterButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginLaterButton.setTitle(Constants.LoginPage.Text.loginLater, for: .normal)
        loginLaterButton.setTitleColor(UIColor(named: Constants.LoginPage.Color.loginPurple), for: .normal)
        loginLaterButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        
        
        buttonsView.addSubview(loginWithSpotifyButton)
        buttonsView.addSubview(loginLaterButton)
        
        NSLayoutConstraint.activate([
            loginWithSpotifyButton.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor),
            loginLaterButton.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor),
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
}

