//
//  authorizationService.swift
//  FindMySong
//
//  Created by accenture.valves on 11/06/25.
//

import Foundation

class AuthorizationService {
    
    let clientId = "e2fc8bf189174ef196832cf74c1126a8"
    let clientSecret = "f9223ab6998f4b3497c96e02d8bc2f90"
    let url = URL(string: "https://accounts.spotify.com/api/token")!
    
    func exchangeCodeForToken(_ code: String) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let bodyParams = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": "fms://login/call-back"
        ]
        request.httpBody = bodyParams
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)
        
 
        let authString = "\(clientId):\(clientSecret)"
        let authData = authString.data(using: .utf8)!
        let base64Auth = authData.base64EncodedString()
        request.setValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: data) else {
        print("erro no login")
                return
            }
            
    
            KeychainHelper.save(tokenResponse.access_token, service: "spotify", account: "access_token")
            KeychainHelper.save(tokenResponse.refresh_token, service: "spotify", account: "refresh_token")
            
        
        }.resume()
    }
    
    func refreshAceessToken() {
        guard let refreshToken = KeychainHelper.read(service: "spotify", account: "refresh_token") else { return }
      
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let bodyParams = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
        ]
        request.httpBody = bodyParams.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)
        
        let auth = "\(clientId):\(clientSecret)"
        let authHeader = Data(auth.utf8).base64EncodedString()
        request.setValue("Basic \(authHeader)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data,
                  let _ = try? JSONDecoder().decode(TokenResponse.self, from: data) else {
        
                return
            }
        }.resume()
    }

     
}


