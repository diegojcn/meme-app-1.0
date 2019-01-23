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
    
    let textDefault : String = "DIGITE O TEXTO"
    
    func initializer(){
        
        self.topText.delegate = self
        self.bottomText.delegate = self
        
        self.cameraBtn.isEnabled =  UIImagePickerController.isSourceTypeAvailable(.camera)
        
        self.topText.text = self.textDefault
        self.bottomText.text = self.textDefault
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let attributes = [
            NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -2,
            NSAttributedString.Key.paragraphStyle: paragraph,
            NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
            ] as! [String : Any]
        
        self.topText.defaultTextAttributes = attributes
        self.bottomText.defaultTextAttributes = attributes
        
        self.topText.clearsOnBeginEditing = true
        self.bottomText.clearsOnBeginEditing = true
        self.imagem.image = nil
        
        showTextFields(show: false)
        showButtons(show: false)
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
        
        if (textField.text?.elementsEqual(""))! {
            textField.text = textDefault
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard(tag: textField.tag)
        return true
    }
    
}
