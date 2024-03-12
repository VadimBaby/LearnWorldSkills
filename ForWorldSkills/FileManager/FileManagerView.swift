//
//  FileManagerView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 02.02.2024.
//

import SwiftUI
import PhotosUI

//If true, this method creates any nonexistent parent directories as part of creating the directory in path. If false, this method fails if any of the intermediate parent directories does not exist. This method also fails if any of the intermediate path elements corresponds to a file and not a directory.

final class LocalFileManager {
    static let instance = LocalFileManager()
    
    private let fileManager: FileManager = .default
    
    func getImage(name: String) -> UIImage? {
        guard let url = getURLToImage(name: name),
              fileManager.fileExists(atPath: url.path())
        else { return nil }
        
        return UIImage(contentsOfFile: url.path())
    }
    
    func saveImage(name: String, image: UIImage) {
        createFolderIfNeeded()
        
        guard let url = getURLToImage(name: name),
              let data = image.jpegData(compressionQuality: 1.0),
              !fileManager.fileExists(atPath: url.path())
        else { return }
        
        try? data.write(to: url)
    }
    
    func removeImage(name: String) {
        guard let url = getURLToImage(name: name),
              fileManager.fileExists(atPath: url.path()) else { return }
        
        try? fileManager.removeItem(at: url)
    }
    
    private func getURLToImage(name: String) -> URL? {
        return fileManager
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("images", conformingTo: .folder)
            .appendingPathComponent("\(name).jpeg", conformingTo: .image)
    }
    
    private func createFolderIfNeeded() {
        guard let path = fileManager
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("images", conformingTo: .folder)
            .path()
        else { return }
        
        if !fileManager.fileExists(atPath: path) {
            try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true)
        }
    }
}

struct FileManagerView: View {
    
    @State private var savedImage: UIImage? = nil
    
    @State private var image: UIImage? = nil
    
    @State private var picker: PhotosPickerItem? = nil
    
    var body: some View {
        VStack {
            if let savedImage {
                Image(uiImage: savedImage)
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            
            PhotosPicker("Tap Me", selection: $picker, matching: .images, preferredItemEncoding: .automatic)
            
            HStack {
                Button("Save") {
                    if let image {
                        LocalFileManager.instance.saveImage(name: "image", image: image)
                    }
                }
                Button("Get") {
                    savedImage = LocalFileManager.instance.getImage(name: "image")
                }
                Button("Remove") {
                    LocalFileManager.instance.removeImage(name: "image")
                }
            }
        }
        .onChange(of: picker) { _, newValue in
            newValue?.loadTransferable(type: Data.self, completionHandler: { result in
                switch result {
                case .success(let data):
                    if let data {
                        image = UIImage(data: data)
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            })
        }
    }
}

#Preview {
    FileManagerView()
}

/*
 
 final class LocalFileManager {
     static let instance = LocalFileManager()
     
     private let fileManager: FileManager = .init()
     
     func saveImage(name: String, image: UIImage) {
         createFolderIfNeeded()
         
         guard let data = image.jpegData(compressionQuality: 1.0),
               let url = getUrlToImage(name: name)  else { return }
         
         do {
             try data.write(to: url)
         } catch {
             print(error.localizedDescription)
         }
     }
     
     func getImage(name: String) -> UIImage? {
         guard let url = getUrlToImage(name: name),
               fileManager.fileExists(atPath: url.path()) else { return nil }
         
         return UIImage(contentsOfFile: url.path())
     }
     
     func removeImage(name: String) {
         guard let url = getUrlToImage(name: name),
               fileManager.fileExists(atPath: url.path()) else { return }

         try? fileManager.removeItem(atPath: url.path())
     }
     
     private func getUrlToImage(name: String) -> URL? {
         return fileManager
             .urls(for: .cachesDirectory, in: .userDomainMask)
             .first?
             .appendingPathComponent("imageFolder", conformingTo: .folder)
             .appendingPathComponent("\(name).jpeg", conformingTo: .image)
     }
     
     private func createFolderIfNeeded() {
         guard let path = fileManager
             .urls(for: .cachesDirectory, in: .userDomainMask)
             .first?
             .appendingPathComponent("imageFolder", conformingTo: .folder)
             .path() else { return }
         
         if !fileManager.fileExists(atPath: path) {
             do {
                 try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true)
                 print("create folder")
             } catch {
                 print("folder error: \(error.localizedDescription)")
             }
         }
     }
 }
 
 */
