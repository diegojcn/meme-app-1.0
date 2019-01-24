//
//  MemeView.swift
//  MemeGenApp
//
//  Created by Diego Neves on 19/08/18.
//  Copyright © 2018 Estudo. All rights reserved.
//

import Foundation
import UIKit

class MemeView : UIView, UITextFieldDelegate{
    
    @IBOutlet weak var imagem: UIImageView!
    
    @IBOutlet weak var cameraBtn: UIButton!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var trashBtn: UIButton!
    
    @IBOutlet weak var imageView: UIView!
    
    @IBOutlet weak var btnView: UIView!
    
    func initializer(){
        
        self.cameraBtn.isEnabled =  UIImagePickerController.isSourceTypeAvailable(.camera)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let attributes = [
            NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -2,
            NSAttributedString.Key.paragraphStyle: paragraph,
            NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
            ] as! [String : Any]
        
        setStyle(toTextField: self.topText, memeTextAttributes: attributes, textDefault : "TOP")
        setStyle(toTextField: self.bottomText, memeTextAttributes: attributes, textDefault : "BOTTOM")
        
        self.imagem.image = nil
        
        showTextFields(show: false)
        showButtons(show: false)
    }
    
    func setStyle(toTextField textField: UITextField, memeTextAttributes : [String : Any], textDefault : String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.delegate = self
        textField.clearsOnBeginEditing = true
        textField.text = textDefault
    }
    
    func showButtons(show: Bool){
        
        if(show){
            self.shareBtn.isHidden = false
            self.trashBtn.isHidden = false
        }else{
            self.shareBtn.isHidden = true
            self.trashBtn.isHidden = true
        }
        
    }
    
    func showToolBar(show: Bool){
        if(show){
            self.btnView.isHidden = false
        } else{
            self.btnView.isHidden = true
        }
        
    }
    
    func showTextFields(show: Bool){
        if(show){
            
            self.topText.isHidden = false
            self.bottomText.isHidden = false
        }else{
            self.topText.isHidden = true
            self.bottomText.isHidden = true
        }
        
    }
    
    func dismissKeyboard(tag : Int){
        if(tag == 0){
            self.topText.resignFirstResponder()
        }else if ((tag == 1)){
            self.bottomText.resignFirstResponder()
        }
    }
    
    @objc func hideKeyboard()
    {
        self.topText.resignFirstResponder()
        self.bottomText.resignFirstResponder()
    }
    
}


extension MemeView {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if textField.tag == 0 {
            textField.text = "TOP"
        }else if textField.tag == 1 {
            textField.text = "BOTTOM"
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard(tag: textField.tag)
        return true
    }
    
}
