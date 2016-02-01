//
//  Filterer.swift
//  Filterer
//
//  Created by Heeki Park on 1/31/16.
//  Copyright © 2016 UofT. All rights reserved.
//

import Foundation

public struct Filterer {
    var intensity = 2
    var mask = 0b1000
    var maskR = false
    var maskG = false
    var maskB = false
    var maskA = false
    var contrast = 1.0
    
    public init(contrast: Double) {
        self.contrast = contrast
    }
    
    public init(intensity: Int, mask: Int) {
        self.intensity = intensity
        self.mask = mask
        if (mask & 0b1000 != 0) {
            maskR = true
        }
        if (mask & 0b0100 != 0) {
            maskG = true
        }
        if (mask & 0b0010 != 0) {
            maskB = true
        }
        if (mask & 0b0001 != 0) {
            maskA = true
        }
    }
    
    public func averageValues(image: RGBAImage) -> (red: Int, green: Int, blue: Int, alpha: Int) {
        var totalR = 0
        var totalG = 0
        var totalB = 0
        var totalA = 0
        
        for y in 0..<image.height {
            for x in 0..<image.width {
                let index = y*image.width + x
                let pixel = image.pixels[index]
                totalR += Int(pixel.red)
                totalG += Int(pixel.green)
                totalB += Int(pixel.blue)
                totalA += Int(pixel.alpha)
            }
        }
        
        let count = image.width * image.height
        return (totalR/count, totalG/count, totalB/count, totalA/count)
    }
    
    public func filter(image: RGBAImage) -> RGBAImage {
        let (avgR, avgG, avgB, avgA) = averageValues(image)
        for y in 0..<image.height {
            for x in 0..<image.width {
                let index = y*image.width + x
                var pixel = image.pixels[index]
                
                // color boosting
                if (maskR) {
                    let diffR = Int(pixel.red)-avgR
                    if (diffR > 0) {
                        pixel.red = UInt8(max(0, min(255, avgR+diffR*intensity)))
                    }
                }
                if (maskG) {
                    let diffG = Int(pixel.green)-avgG
                    if (diffG > 0) {
                        pixel.green = UInt8(max(0, min(255, avgG+diffG*intensity)))
                    }
                }
                if (maskB) {
                    let diffB = Int(pixel.blue)-avgB
                    if (diffB > 0) {
                        pixel.blue = UInt8(max(0, min(255, avgB+diffB*intensity)))
                    }
                }
                if (maskA) {
                    let diffA = Int(pixel.alpha)-avgA
                    if (diffA > 0) {
                        pixel.alpha = UInt8(max(0, min(255, avgA+diffA*intensity)))
                    }
                }
                
                // contrast change
                pixel.red = UInt8(max(0, min(255, Double(pixel.red)*contrast)))
                pixel.green = UInt8(max(0, min(255, Double(pixel.green)*contrast)))
                pixel.blue = UInt8(max(0, min(255, Double(pixel.blue)*contrast)))
                
                image.pixels[index] = pixel
            }
        }
        
        return image
    }
}