//
//  PhotoPickerView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 31.01.2024.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    
    @State private var image: UIImage? = nil
    @State private var picker: PhotosPickerItem? = nil
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            
            PhotosPicker(selection: $picker) {
                Text("tap me")
            }
        }
        .onChange(of: picker) { _, newValue in
            newValue?.loadTransferable(type: Data.self, completionHandler: { result in
                switch result {
                case .success(let data):
                    if let data {
                        self.image = UIImage(data: data)
                    }
                case .failure(let failure):
                    print("error")
                }
            })
        }
    }
}

#Preview {
    PhotoPickerView()
}
