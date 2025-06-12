//
//  TokenResponse.swift
//  FindMySong
//
//  Created by accenture.valves on 11/06/25.
//

struct TokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let refresh_token: String
}
