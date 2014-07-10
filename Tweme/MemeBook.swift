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
        book.append(Meme(description: "Success Kid", image: UIImage(named: "1.jpg")))
        book.append(Meme(description: "Socially Awkward Penguin", image: UIImage(named: "2.jpg")))
        book.append(Meme(description: "Futurama Fry", image: UIImage(named: "3.jpg")))
        book.append(Meme(description: "Most Interesting Man", image: UIImage(named: "4.jpg")))
        book.append(Meme(description: "Philosoraptor", image: UIImage(named: "5.jpg")))
        book.append(Meme(description: "Condescending Wonka", image: UIImage(named: "6.jpg")))
        book.append(Meme(description: "Boromir", image: UIImage(named: "7.jpg")))
        book.append(Meme(description: "Drunk Baby", image: UIImage(named: "8.jpg")))
        book.append(Meme(description: "Baby Godfather", image: UIImage(named: "9.jpg")))
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