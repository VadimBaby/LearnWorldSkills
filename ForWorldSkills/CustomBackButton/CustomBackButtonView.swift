//
//  CustomBackButtonView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 31.01.2024.
//

import SwiftUI

struct CustomBackButtonView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Go to Second Screen") { SecondScreen() }
            }
            .navigationTitle("First Screen")
        }
    }
}

struct SecondScreen: View {
    
    @State private var isOpen: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Seccond Screen")
            Button("Open Sheet") {
                self.isOpen = true
            }
            Button("Back") {
                dismiss()
            }
        }
        .sheet(isPresented: $isOpen, content: {
            SecondScreenSheet()
        })
        .navigationTitle("Second Screen")
        .navigationBarBackButtonHidden()
        
    }
}

struct SecondScreenSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Hide") {
            dismiss()
        }
    }
}

#Preview {
    CustomBackButtonView()
}
