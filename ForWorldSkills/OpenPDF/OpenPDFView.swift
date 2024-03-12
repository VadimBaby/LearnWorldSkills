//
//  OpenPDFView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 30.01.2024.
//

import SwiftUI
import PDFKit

struct OpenPDFView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Open PDf") {
                PDFKitView()
            }
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        
        if let url = Bundle.main.url(forResource: "document", withExtension: "pdf") {
            if let document = PDFDocument(url: url) {
                pdfView.document = document
            }
        }
        
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
}

#Preview {
    OpenPDFView()
}
