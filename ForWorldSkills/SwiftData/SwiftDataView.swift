//
//  SwiftDataView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 05.02.2024.
//

import SwiftUI
import SwiftData
import Observation

struct SwiftDataView: View {
    @State private var viewModel: Self.ViewModel
    
    init(context: ModelContext) {
        self._viewModel = State(wrappedValue: .init(context: context))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.dictionaries) { dictionary in
                    Text(dictionary.name)
                        .swipeActions {
                            Button("Delete") {
                                withAnimation(.easeInOut) {
                                    viewModel.removeDictionary(id: dictionary.id)
                                }
                            }
                            .tint(Color.red)
                            
                            Button("Update") {
                                viewModel.updateDictionary(id: dictionary.id)
                            }
                            .tint(Color.orange)
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        withAnimation(.easeInOut) {
                            viewModel.addDictionary()
                        }
                    }
                }
            }
        }
        
    }
}

extension SwiftDataView {
    @Observable final class ViewModel {
        var dictionaries: [DictionaryModel] = []
        
        private let context: ModelContext
        
        init(context: ModelContext) {
            self.context = context
            
            fetchDictionaries()
        }
        
        func fetchDictionaries() {
            let descriptor = FetchDescriptor<DictionaryModel>(
                sortBy: [
                    .init(\.createdAt, order: .reverse)
                ]
            )
            
            guard let dictionaries = try? context.fetch(descriptor) else { return }
            
            self.dictionaries = dictionaries
        }
        
        func addDictionary() {
            let dictionary = DictionaryModel(name: UUID().uuidString, words: [])
            
            context.insert(dictionary)
            
            fetchDictionaries()
        }
        
        func updateDictionary(id: String) {
            guard let index = dictionaries.firstIndex(where: { $0.id == id }) else { return }
            
            dictionaries[index].name = "New Name"
        }
        
        func removeDictionary(id: String) {
            try? context.delete(model: DictionaryModel.self, where: #Predicate { $0.id == id })
            
            fetchDictionaries()
        }
    }
}

#Preview {
    struct SwiftDataVie_Preview: View {
        
        let container: ModelContainer
        
        init() {
            do {
                container = try ModelContainer(for: WordModel.self, DictionaryModel.self, configurations: .init())
            } catch {
                fatalError()
            }
        }
        
        var body: some View {
            SwiftDataView(context: container.mainContext)
        }
    }
    
    return SwiftDataVie_Preview()
}
