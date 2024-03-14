//
//  ImagePickerView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 05.03.2024.
//

import SwiftUI

struct UICameraPickerControllerRepresentable: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.sourceType = .camera
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
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
            self.showScreen = false
        }
    }
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
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
            self.showScreen = false
        }
    }
}


struct ImagePickerView: View {
    
    @State private var image: UIImage? = nil
    @State private var showPhotos: Bool = false
    @State private var showCamera: Bool = false
    @State private var showConfirmationDialog: Bool = false
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
            }
            Button("Open", action: { showConfirmationDialog.toggle() })
        }
        .frame(maxHeight: .infinity)
        .sheet(isPresented: $showPhotos, content: {
            UIImagePickerControllerRepresentable(image: $image, showScreen: $showPhotos)
        })
        .sheet(isPresented: $showCamera, content: {
            UICameraPickerControllerRepresentable(image: $image, showScreen: $showCamera)
        })
        .confirmationDialog("Dialog", isPresented: $showConfirmationDialog) {
            Button("Камера") {
                self.showCamera = true
            }
            Button("Галерея") {
                self.showPhotos = true
            }
        }
    }
}

#Preview {
    ImagePickerView()
}
