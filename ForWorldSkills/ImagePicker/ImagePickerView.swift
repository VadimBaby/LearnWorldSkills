//
//  ImagePickerView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 05.03.2024.
//

import SwiftUI

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    // from SwiftUI to UIKit
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var showScreen: Bool
        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            
            self.image = image
            
            showScreen = false
        }
        
    }
}


struct ImagePickerView: View {
    
    @State private var image: UIImage? = nil
    @State private var show: Bool = false
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
            }
            Button("Open", action: { show.toggle() })
        }
        .sheet(isPresented: $show, content: {
            UIImagePickerControllerRepresentable(image: $image, showScreen: $show)
        })
    }
}

#Preview {
    ImagePickerView()
}
