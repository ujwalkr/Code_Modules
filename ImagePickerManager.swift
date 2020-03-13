//
//  ImagePickerManager.swift
//  MOH
//
//  Created by Ujwal K Raikar on 09/07/19.
//

import Foundation
import UIKit

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var picker = UIImagePickerController()
    var viewController: UIViewController?
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var completionHandler: ((UIImage) -> Void)?
    
    override init() {
        super.init()
    }
    
    func pickImage(_ viewController: UIViewController,_ completionHandler: @escaping (UIImage) -> Void ){
        self.completionHandler = completionHandler
        self.viewController = viewController
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
//        viewController.present(alert, animated: true, completion: nil)
        
        openCamera()
    }
    
    func openCamera() {
        alert.dismiss(animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            self.viewController?.present(picker, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Warning", message: "Camera not available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            viewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        alert.dismiss(animated: true, completion: nil)
            picker.sourceType = .photoLibrary
            self.viewController?.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        completionHandler?(image)
    }
    
    func close() {
        picker.dismiss(animated: true, completion: nil)
        completionHandler?(UIImage())
    }
}
