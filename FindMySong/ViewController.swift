//
//  ViewController.swift
//  FindMySong
//
//  Created by saulo.santos.freire on 26/03/25.
//

import UIKit

class ViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let spotifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login With Spotify", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 0.11, green: 0.73, blue: 0.33, alpha: 1.00)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    
    private let loginLaterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login Later", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(UIColor(hex: "#801CD6"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTextWithGradient()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(containerView)
        view.addSubview(spotifyButton)
        view.addSubview(loginLaterButton)
        
        NSLayoutConstraint.activate([
            // Container do texto com gradiente
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            
            // Botão do Spotify
            spotifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spotifyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 542.5),
            spotifyButton.widthAnchor.constraint(equalToConstant: 250),
            spotifyButton.heightAnchor.constraint(equalToConstant: 60),
            
            // Botão Login Later
            loginLaterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLaterButton.topAnchor.constraint(equalTo: spotifyButton.bottomAnchor, constant: 20),
            loginLaterButton.widthAnchor.constraint(equalToConstant: 250),
            loginLaterButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Adiciona ações aos botões
        spotifyButton.addTarget(self, action: #selector(spotifyButtonTapped), for: .touchUpInside)
        loginLaterButton.addTarget(self, action: #selector(loginLaterButtonTapped), for: .touchUpInside)
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
    
    @objc private func spotifyButtonTapped() {
        print("Botão do Spotify pressionado!")
    }
    
    @objc private func loginLaterButtonTapped() {
        print("Login Later pressionado!")
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
