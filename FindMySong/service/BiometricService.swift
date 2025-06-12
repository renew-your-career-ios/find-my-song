//
//  BiometricService.swift
//  FindMySong
//
//  Created by accenture.valves on 12/06/25.
//

import LocalAuthentication

final class BiometryService {

    enum BiometryResult {
        case success
        case failure(Error?)
        case notAvailable
    }

    static let shared = BiometryService()

    private let context = LAContext()

    private init() {}

    func isBiometryAvailable() -> Bool {
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }

    func authenticateUser(reason: String = "Autenticação com biometria", completion: @escaping (BiometryResult) -> Void) {
        guard isBiometryAvailable() else {
            completion(.notAvailable)
            return
        }

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                if success {
                    completion(.success)
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
