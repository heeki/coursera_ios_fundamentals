import Foundation

public struct ImageProcessor {
    var filters = [Filterer]()
    let filter1 = Filterer(intensity: 2, mask: 0b1000)
    let filter2 = Filterer(intensity: 2, mask: 0b0100)
    let filter3 = Filterer(intensity: 2, mask: 0b0010)
    let filter4 = Filterer(contrast: 0.75)
    let filter5 = Filterer(contrast: 1.25)
    
    public init() {
    }
    
    public init(filters: Filterer...) {
        for filter in filters {
            self.filters.append(filter)
        }
    }
    
    /*
    public mutating func addFilters(filters: Filterer...) {
        for filter in filters {
            self.filters.append(filter)
        }
    }
    */
    
    public func process(image: RGBAImage) -> RGBAImage {
        var filtered = image
        for filterer in filters {
            filtered = filterer.filter(filtered)
        }
        return filtered
    }
    
    public func predefined(image: RGBAImage, filter: String) -> RGBAImage {
        var filtered: RGBAImage
        switch filter {
        case "boost-red":
            filtered = filter1.filter(image)
        case "boost-green":
            filtered = filter2.filter(image)
        case "boost-blue":
            filtered = filter3.filter(image)
        case "darken":
            filtered = filter4.filter(image)
        case "brighten":
            filtered = filter5.filter(image)
        default:
            filtered = image
        }
        return filtered
    }
    
}