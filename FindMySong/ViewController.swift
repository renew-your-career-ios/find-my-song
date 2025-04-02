//
//  ViewController.swift
//  FindMySong
//
//  Created by saulo.santos.freire on 26/03/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginWithSpotifyButton: UIButton!
    @IBOutlet weak var loginLaterButton: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        loginWithSpotifyButton.transform = CGAffineTransform(translationX: 0, y: 300)

        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
            self.loginWithSpotifyButton.transform = .identity
        })
        
        loginLaterButton.alpha = 0
        loginLaterButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.loginLaterButton.alpha = 1
            self.loginLaterButton.transform = .identity
        })
    }


}

