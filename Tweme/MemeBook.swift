//
//  MemeBook.swift
//  Tweme
//
//  Created by Sailesh Mittal on 7/7/14.
//  Copyright (c) 2014 Twitter. All rights reserved.
//


import Foundation
import UIKit

class MemeBook {
    var book: Meme[]
    
    init() {
        book = []
        book.append(Meme(description: "Hello1", image: UIImage(named: "meme1.jpg")))
        book.append(Meme(description: "Hello1", image: UIImage(named: "meme1.jpg")))
        book.append(Meme(description: "Hello1", image: UIImage(named: "meme1.jpg")))
        book.append(Meme(description: "Hello1", image: UIImage(named: "meme1.jpg")))
    }
    
    func size() -> Int {
        return book.count
    }
    
    func getMeme(index: Int) -> Meme {
        return book[index]
    }
}

class Meme {
    var description: String
    var image: UIImage
    init(description: String, image: UIImage) {
        self.description = description
        self.image = image
    }
}