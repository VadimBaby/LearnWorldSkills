//
//  KeyChainView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 08.02.2024.
//

import SwiftUI

/*
 
 final class KeyChainManager {
     static func save(password: String, account: String) throws -> String {
         guard let passwordData = password.data(using: .utf8) else { throw KeyChainError.data }
         
         let query: [CFString: Any] = [
             kSecClass: kSecClassGenericPassword,
             kSecAttrAccount: account,
             kSecValueData: password
         ]
         
         let status = SecItemAdd(query as CFDictionary, nil)
         
         guard status != errSecDuplicateItem else { throw KeyChainError.duplicateItem }
         
         guard status == errSecSuccess else { throw KeyChainError.unkown(status: status) }
         
         return "Save"
     }
     
     static func getPassword(account: String) throws -> String {
         let query: [CFString: Any] = [
             kSecClass: kSecClassGenericPassword,
             kSecAttrAccount: account,
             kSecReturnData: kCFBooleanTrue as Any
         ]
         
         var result: AnyObject?
         
         let status = SecItemCopyMatching(query as CFDictionary, &result)
         
         guard status == errSecSuccess else { throw KeyChainError.unkown(status: status) }
         
         guard let data = result as? Data,
               let password = String(data: data, encoding: .utf8) else { throw KeyChainError.data }
         
         return password
     }
     
     static func saveOnlyPassword(password: String) throws -> String {
         guard let passwordData = password.data(using: .utf8) else { throw KeyChainError.data }
         
         let query: [CFString: Any] = [
             kSecClass: kSecClassGenericPassword,
             kSecValueData: passwordData
         ]
         
         let status = SecItemAdd(query as CFDictionary, nil)
         
         guard status != errSecDuplicateItem else { throw KeyChainError.duplicateItem }
         
         guard status == errSecSuccess else { throw KeyChainError.unkown(status: status) }
         
         return "Save"
     }
     
     static func getOnlyPassword() throws -> String {
         let query: [CFString: Any] = [
             kSecClass: kSecClassGenericPassword,
             kSecReturnData: kCFBooleanTrue as Any,
             kSecReturnAttributes: kCFBooleanTrue as Any
         ]
         
         var result: AnyObject?
         
         let status = SecItemCopyMatching(query as CFDictionary, &result)
         
         guard status == errSecSuccess else { throw KeyChainError.unkown(status: status) }
         
         guard let data = result as? Data,
               let password = String(data: data, encoding: .utf8) else { throw KeyChainError.data }
         
         return password
     }
     
     static func removePassword() throws -> String {
         let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword]
         let status = SecItemDelete(query as CFDictionary)
         
         guard status == errSecSuccess else { throw KeyChainError.unkown(status: status) }
         
         return "Remove"
     }
 }
 
 */

enum KeyChainError: Error {
    case duplicateItem
    case unkown(status: OSStatus)
    case data
}

final class KeyChainManager {
    static func save(password: String, account: String) throws -> String {
        guard let passwordData = password.data(using: .utf8) else  { throw KeyChainError.data }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: passwordData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else { throw KeyChainError.duplicateItem }
        
        guard status == errSecSuccess else { throw KeyChainError.unkown(status: status) }
        
        return "Save"
    }
    
    static func getPassword(account: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else { throw KeyChainError.unkown(status: status) }

        guard let data = result as? Data,
              let password = String(data: data, encoding: .utf8) else { throw KeyChainError.data }
        
        return password
     }
    
    static func saveOnlyPassword(password: String) throws -> String {
        guard let passwordData = password.data(using: .utf8) else { throw KeyChainError.data }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: passwordData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else { throw KeyChainError.duplicateItem }
        
        guard status == errSecSuccess else { throw KeyChainError.unkown(status: status) }
        
        return "Save"
    }
    
    static func getOnlyPassword() throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecReturnAttributes: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else { throw KeyChainError.unkown(status: status) }
        
        guard let data = result as? Data,
              let password = String(data: data, encoding: .utf8) else { throw KeyChainError.data }
        
        return password
    }
    
    static func removePassword() throws -> String {
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword]
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else { throw KeyChainError.unkown(status: status) }
        
        return "Remove"
    }
}

struct KeyChainView: View {
    
    @State private var account: String = ""
    @State private var password: String = ""
    @State private var status: String = ""
    
    var body: some View {
        VStack {
            TextField("Account", text: $account)
            TextField("Password", text: $password)
            Button("Save") {
                do {
                    status = try KeyChainManager.saveOnlyPassword(password: password)
                } catch {
                    status = "error: \(error.localizedDescription)"
                }
            }
            Text(status)
            Button("Get") {
                do {
                    password = try KeyChainManager.getOnlyPassword()
                } catch {
                    status = "error: \(error.localizedDescription)"
                }
            }
            Button("delete") {
                do {
                    status = try KeyChainManager.removePassword()
                } catch {
                    status = "error: \(error.localizedDescription)"
                }
            }
//            TextField("Account", text: $account)
//            TextField("Password", text: $password)
//            Button("Save") {
//                do {
//                    status = try KeyChainManager.save(password: password, account: account)
//                } catch {
//                    status = "error: \(error.localizedDescription)"
//                }
//            }
//            Text(status)
//            Button("Get") {
//                do {
//                    password = try KeyChainManager.getPassword(account: account)
//                } catch {
//                    status = "error: \(error.localizedDescription)"
//                }
//            }
        }
    }
}

#Preview {
    KeyChainView()
}
