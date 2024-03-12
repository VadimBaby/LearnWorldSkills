//
//  RealTimeView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 31.01.2024.
//

import SwiftUI
import Combine

struct PostModel: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

struct RealTimeView: View {
    
    @StateObject private var viewModel: Self.ViewModel = .init()
    
    var body: some View {
        Group {
            if let post = viewModel.post {
                VStack {
                    Text(post.title)
                }
            } else {
                ProgressView()
            }
        }
    }
}

extension RealTimeView {
    final class ViewModel: ObservableObject {
        @Published var post: PostModel? = nil
        
        private var cancellables: Set<AnyCancellable> = .init()
        
        init() {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map{ $0.data }
                .decode(type: PostModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { complition in
                    switch complition {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                } receiveValue: {[weak self] post in
                    self?.post = post
                }
                .store(in: &cancellables)
        }
    }
}

#Preview {
    RealTimeView()
}
