//
//  ImagePicker.swift
//  ETracker
//
//  Created by Ancel Dev account on 26/6/24.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage
    
    //
//    @Binding var imagePicked: Bool
    @Binding var receiptEnum: ReceiptEnum?
    //
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                //
//                parent.imagePicked = true
                switch parent.sourceType {
                case .camera:
                    parent.receiptEnum = .photo
                case .photoLibrary:
                    parent.receiptEnum = .image
                case .savedPhotosAlbum:
                    return
                @unknown default:
                    return
                }
                //
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

