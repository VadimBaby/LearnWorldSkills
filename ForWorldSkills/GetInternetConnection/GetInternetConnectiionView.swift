//
//  GetInternetConnectiionView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 30.01.2024.
//

import SwiftUI
import Network

final class NetworkMonitor {
    static let instance = NetworkMonitor()
    
    @Published private(set) var isConnected: Bool = false
    
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkQueue")
    
    private init() {
        connect()
    }
    
    private func connect() {
        networkMonitor.pathUpdateHandler = { path in
            let isConnected = path.status == .satisfied
            
            Task {
                await MainActor.run {
                    self.isConnected = isConnected
                }
            }
        }
        
        networkMonitor.start(queue: queue)
    }
}

struct GetInternetConnectiionView: View {
    
    @State private var isConnected: Bool = false
    
    var body: some View {
        VStack {
            if isConnected {
                Text("you are connected")
            } else {
                Text("check your wifi")
            }
        }
        .onReceive(NetworkMonitor.instance.$isConnected, perform: { value in
            self.isConnected = value
        })
    }
}

#Preview {
    GetInternetConnectiionView()
}
