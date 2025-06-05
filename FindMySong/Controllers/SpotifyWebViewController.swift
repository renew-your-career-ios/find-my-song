//
//  SpotifyWebViewController.swift
//  FindMySong
//
//  Created by henrique.cisi on 05/06/25.
//

import UIKit
import WebKit

class SpotifyWebViewController: UIViewController, WKNavigationDelegate {

    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login with Spotify"
        view.backgroundColor = .systemBackground

        webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        if let url = SpotifyService.shared.getAuthURL() as URL? {
            webView.load(URLRequest(url: url))
        }
    }

    @objc private func closeWebView() {
        dismiss(animated: true)
    }
}
