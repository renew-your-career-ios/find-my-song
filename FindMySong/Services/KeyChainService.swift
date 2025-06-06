//
//  KeyChainService.swift
//  FindMySong
//
//  Created by henrique.cisi on 06/06/25.
//

import Foundation
import Security

enum KeychainOperation: String {
    case add = "add"
    case delete = "delete"
    case update = "update"
    case read = "read"
}

enum KeyChainService {
    
    //MARK: Keychain public methods
    static func create(value: String, forKey key: String) -> Bool {
        
        guard let data = value.data(using: .utf8) else { return false}
        
        var query = formatQuery(forKey: key)
        
        SecItemDelete(query as CFDictionary)
        
        query[kSecValueData as String] = data
        
        let hasSaved = SecItemAdd(query as CFDictionary, nil)
        
        return checkOperationStatus(hasSaved, operation: .add)
    }
    
    static func read(forKey key: String) -> String? {
        var query = formatQuery(forKey: key)
            query[kSecReturnData as String] = kCFBooleanTrue
            query[kSecMatchLimit as String] = kSecMatchLimitOne
            
            var value: CFTypeRef?
            let hasRead = SecItemCopyMatching(query as CFDictionary, &value)
            
            guard checkOperationStatus(hasRead, operation: .read) else { return nil }
        
            guard let data = value as? Data,
                  let value = String(data: data, encoding: .utf8) else {
                return nil
            }
            return value
    }
    
    static func update(value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let query = formatQuery(forKey: key)
        
        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data
        ]
        
        let hasUpdated = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        
        return checkOperationStatus(hasUpdated, operation: .update)
    }
    
    static func delete(forKey key: String) -> Bool {
        let query = formatQuery(forKey: key)
        
        let hasRemoved = SecItemDelete(query as CFDictionary)

        return checkOperationStatus(hasRemoved, operation: .delete)
    }
    
    //MARK: Private helpers
    private static func formatQuery(forKey key: String) -> [String: Any] {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
    }
    
    private static func checkOperationStatus(_ status: OSStatus, operation: KeychainOperation) -> Bool {
        switch (operation, status) {
        case (_, errSecSuccess): return true
        case(.delete, errSecItemNotFound): return true
        default : return false
        }
    }
}
