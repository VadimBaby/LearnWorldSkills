//
//  CustoomTabView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 11.02.2024.
//

import SwiftUI
import UIKit
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}


struct tab {
    let title: String
    let systemImage: String
}

enum TabEnum: String, CaseIterable {
    case home, news, music, settings
    
    var content: tab {
        switch self {
        case .home:
            tab(title: "Home", systemImage: "house.fill")
        case .news:
            tab(title: "News", systemImage: "newspaper")
        case .music:
            tab(title: "Music", systemImage: "person.fill")
        case .settings:
            tab(title: "Settings", systemImage: "gear")
        }
    }
    
    @ViewBuilder var view: some View {
        switch self {
        case .home:
            ScrollView {
                VStack {
                    ForEach(0...50, id: \.self) { _ in
                        Rectangle()
                            .fill(Color.orange)
                            .frame(height: 70)
                    }
                }
                .padding()
            }
        case .news:
            Button("title") {
                if let url = URL(string: "http://nkeivt.ru") {
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    
                    windowScene?.windows.first?.rootViewController?.present(SFSafariViewController(url: url), animated: true)
                }
            }
        case .music:
            Text("Music")
        case .settings:
            Text("Settings")
        }
    }
}

struct CustoomTabView: View {
    
    @State private var selection: TabEnum = .home
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                selection.view
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                 //   .ignoresSafeArea()
                
                HStack(spacing: 0) {
                    ForEach(TabEnum.allCases, id: \.rawValue) { tab in
                        VStack {
                            if selection == tab {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 45, height: 2)
                                    .shadow(color: Color.blue, radius: 2)
                            } else {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height: 2)
                            }
                            Image(systemName: tab.content.systemImage)
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text(tab.content.title)
                                .font(.system(size: 12))
                        }
                        .foregroundStyle(selection == tab ? Color.blue : Color.gray)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            selection = tab
                        }
                    }
                }
                .frame(height: 65 + geo.safeAreaInsets.bottom, alignment: .top)
                .frame(maxWidth: .infinity)
                .background {
                    Color.white
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: -10)
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
}

#Preview {
    CustoomTabView()
}
