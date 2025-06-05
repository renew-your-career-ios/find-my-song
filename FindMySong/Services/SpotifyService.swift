//
//  SpotifyService.swift
//  FindMySong
//
//  Created by henrique.cisi on 05/06/25.
//

import Foundation

final class SpotifyService {
    static let shared = SpotifyService()

    private let clientId = "e2fc8bf189174ef196832cf74c1126a8"
    private let redirectURI = "fms://login/callback"
    private let scopes = "user-read-private playlist-modify-public playlist-read-public user-follow-read user-read-email"
    private let authorizeBaseURL = "https://accounts.spotify.com/authorize"
    private let responseType = "code"
    private let showDialog = "true"

    func getAuthURL() -> URL? {
        var components = URLComponents(string: authorizeBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "response_type", value: responseType),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "scopes", value: scopes),
            URLQueryItem(name: "show_dialog", value: showDialog)
        ]
        return components?.url
    }
}

