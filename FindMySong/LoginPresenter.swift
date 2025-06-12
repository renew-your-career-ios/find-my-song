//
//  LoginPresenter.swift
//  FindMySong
//
//  Created by accenture.valves on 12/06/25.
//
import AuthenticationServices
import LocalAuthentication

class LoginPresenter {
    
    let authorizationService = AuthorizationService()
    var authSession: ASWebAuthenticationSession?
    weak var delegate: LoginPresenterDelegate?

    func checkForSavedCredentialsAndAuthenticate() {
        if let _ = KeychainHelper.read(service: "spotify", account: "accessToken") {
            delegate?.presentBiometric()
        } else {
            delegate?.presentSpotifyLogin()
        }
    }

    func navigateToHome(){}


    func openSpotifyLogin() {
        let clientID = "e2fc8bf189174ef196832cf74c1126a8"
        let redirectURI = "fms://login/call-back"
        let scopes = "user-read-private playlist-modify-public playlist-read-public user-follow-read user-read-email"
        let encodedScopes = scopes.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let authURLString = "https://accounts.spotify.com/authorize?response_type=code&client_id=\(clientID)&scope=\(encodedScopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"

        guard let authURL = URL(string: authURLString) else { return }

        authSession = ASWebAuthenticationSession(
            url: authURL,
            callbackURLScheme: "fms"
        ) { callbackURL, error in
            if let error = error {
                print("Erro na autenticação: \(error.localizedDescription)")
                return
            }

            guard let callbackURL = callbackURL,
                  let components = URLComponents(url: callbackURL, resolvingAgainstBaseURL: false),
                  let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
                print("Código de autorização não encontrado.")
                return
            }

            print("Código de autorização recebido: \(code)")
            self.authorizationService.exchangeCodeForToken(code)
            self.delegate?.selectBiometricPreference()
            self.delegate?.navigateToMainScreen()
        }

        authSession?.presentationContextProvider = delegate as? ASWebAuthenticationPresentationContextProviding
        authSession?.prefersEphemeralWebBrowserSession = true
        authSession?.start()
    }
}
