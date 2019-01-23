//
//  MemeViewControllerswift
//  MemeGenApp
//
//  Created by Diego Neves on 19/08/18.
//  Copyright © 2018 Estudo. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController , UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet var memeView: MemeView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.memeView.initializer()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(MemeViewController.keyboardChange(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeViewController.keyboardChange(_:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeViewController.keyboardChange(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    deinit {
        
        unsubscribeFromKeyboardNotifications()
    }
    
    @objc func keyboardChange(_ notification:Notification) {
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            
            view.frame.origin.y -= getKeyboardHeight(notification)
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self.memeView, action: #selector(self.memeView.hideKeyboard))
            tapGesture.cancelsTouchesInView = false
            
            self.view.addGestureRecognizer(tapGesture)
            
        } else {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height/2
    }
    
    func showToolBarAndNavBar(show: Bool) {
        
        if show {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.memeView.showToolBar(show: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.memeView.showToolBar(show: false)
        }
        
    }
    
    func generateMemedImage() -> UIImage {
        
        showToolBarAndNavBar(show: false)
        
        UIGraphicsBeginImageContext(self.memeView.imageView.frame.size)
        self.memeView.imageView.drawHierarchy(in: self.memeView.imageView.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        showToolBarAndNavBar(show: true)
        
        return memedImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.memeView.imagem.image = image
            self.memeView.showTextFields(show: true)
            self.memeView.showButtons(show: true)
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clean(_ sender: Any) {
        
        self.memeView.initializer()
    }
    
    
    @IBAction func chooseImageOrTakePhoto(_ sender: UIButton) {
        
        if sender.tag == 0 {
            self.imagePicker.sourceType = .photoLibrary
        } else if sender.tag == 1 {
            self.imagePicker.sourceType = .camera
        }
        
        present(self.imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func createNewMeme(_ sender: UIButton){
        let memedImage = generateMemedImage()
        
         let meme = Meme(topText: self.memeView.topText.text!, bottomText: self.memeView.bottomText.text!, originalImagem: self.memeView.imagem, memedImage: memedImage)
        
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                
                self.save(meme: meme)
               
            }
        }
    
        self.present(controller, animated: true, completion: nil)
    }
    
    func save(meme : Meme){
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    
}

