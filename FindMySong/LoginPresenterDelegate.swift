//
//  LoginPresenterDelegate.swift
//  FindMySong
//
//  Created by accenture.valves on 12/06/25.
//

protocol LoginPresenterDelegate: AnyObject {
    func presentBiometric()
    func presentSpotifyLogin()
    func navigateToMainScreen()
    func selectBiometricPreference()
}
