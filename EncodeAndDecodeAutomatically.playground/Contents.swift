import UIKit

struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    // Landamark now supports the Codable methods init(from:) and encode(to:)
    // even though they are not written as part of its declaration.
}






