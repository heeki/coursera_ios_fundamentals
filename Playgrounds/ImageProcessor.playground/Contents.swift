//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

let rgba1 = RGBAImage(image: image)!
let filterer1 = Filterer(intensity: 2, mask: 0b0010)
let filtered1 = filterer1.filter(rgba1)
filtered1.toUIImage()

let rgba2 = RGBAImage(image: image)!
let filterer21 = Filterer(intensity: 2, mask: 0b1000)
let filterer22 = Filterer(intensity: 2, mask: 0b0100)
let filterer23 = Filterer(intensity: 2, mask: 0b0010)
//let processor2 = ImageProcessor(filters: filterer21)
//let processor2 = ImageProcessor(filters: filterer21, filterer22)
let processor2 = ImageProcessor(filters: filterer21, filterer22, filterer23)
let processed2 = processor2.process(rgba2)
processed2.toUIImage()

let rgba3 = RGBAImage(image: image)!
let filterer31 = Filterer(contrast: 0.75)
let filtered3 = filterer31.filter(rgba3)
filtered3.toUIImage()

let rgba4 = RGBAImage(image: image)!
let processor4 = ImageProcessor()
let processed4 = processor4.predefined(rgba4, filter: "boost-red")
//let processed4 = processor4.predefined(rgba4, filter: "boost-green")
//let processed4 = processor4.predefined(rgba4, filter: "boost-blue")
//let processed4 = processor4.predefined(rgba4, filter: "darken")
//let processed4 = processor4.predefined(rgba4, filter: "brighten")
processed4.toUIImage()
