//
//  Meme.swift
//  MemeGenApp
//
//  Created by Diego Neves on 14/01/19.
//  Copyright © 2019 Estudo. All rights reserved.
//

import Foundation
import UIKit


struct Meme {
    
    let topText: String
    
    let bottomText: String
    
    let originalImagem: UIImageView
    
    let memedImage : UIImage
    
    init(topText: String, bottomText: String, originalImagem: UIImageView, memedImage: UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.originalImagem = originalImagem
        self.memedImage = memedImage

    }

    
}

