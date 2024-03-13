//
//  ForWorldSkillsApp.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 30.01.2024.
//

import SwiftUI
import SwiftData

@main
struct ForWorldSkillsApp: App {
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: DictionaryModel.self, WordModel.self)
        } catch {
            fatalError()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ImagePickerView()
            
           // UITestView()
            
//            HapticManagerView()
            
          //  KeyChainView()
//            TabView {
//                RotationRatingView()
//                    .tabItem {
//                        Image(systemName: "person.fill")
//                        Text("1")
//                    }
//                
//                MapView()
//                    .tabItem {
//                        Image(systemName: "gear")
//                        Text("2")
//                    }
//                SwiftDataView(mainContext: container.mainContext)
//                    .tabItem {
//                        Image(systemName: "house")
//                        Text("3")
//                    }
//            }
        }
    }
}
