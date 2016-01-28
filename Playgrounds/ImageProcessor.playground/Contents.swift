//: Playground - noun: a place where people can play

import UIKit

/*
func myImageAvg(image: RGBAImage) -> (red: Int, green: Int, blue: Int, alpha: Int) {
    var myTotR = 0
    var myTotG = 0
    var myTotB = 0
    var myTotA = 0
    
    for y in 0..<image.height {
        for x in 0..<image.width {
            let index = y*image.width + x
            let pixel = image.pixels[index]
            myTotR += Int(pixel.red)
            myTotG += Int(pixel.green)
            myTotB += Int(pixel.blue)
            myTotA += Int(pixel.alpha)
        }
    }
    
    let myTot = image.width * image.height
    return (myTotR/myTot, myTotG/myTot, myTotB/myTot, myTotA/myTot)
}
*/


func myImageFilter(image: RGBAImage) -> UIImage {
    var pixel = image.pixels[0]
    print(Int(pixel.red), Int(pixel.green), Int(pixel.blue))

    /*
    for y in 0..<image.height {
        for x in 0..<image.width {
            let index = y*image.width + x
            var pixel = image.pixels[index]
            let bias = 1
            pixel.red = min(max(Int(pixel.red)+bias, 0), 255)
            pixel.green = min(max(Int(pixel.green)+bias, 0), 255)
            pixel.blue = max(Int(pixel.green)+bias, 0)

            image.pixels[index] = pixel
        }
    }
    */
    
    return image.toUIImage()!
}


let image = UIImage(named: "sample")!
let myImage = RGBAImage(image: image)!

//let (myAvgR, myAvgG, myAvgB, myAvgA) = myImageAvg(myImage)
//let (myAvgR, myAvgG, myAvgB, myAvgA) = (118, 98, 83, 255)
//let myFiltered = myImageFilter(myImage)


