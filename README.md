# EncodingAndDecodingCustomTypes

Encoding And Decoding Custom Types (Apple Documentation to practice)

1. [Overview](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#1-overview)
2. [Encode and Decode Automatically](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#2-encode-and-decode-automatically)
3. [Encode or Decode Exclusively](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#3-encode-or-decode-exclusively)
4. [Choose Properties to Encode and Decode Using Coding Keys](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#4-choose-properties-to-encode-and-decode-using-coding-keys)
5. [Encode and Decode Manually](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#5-encode-and-decode-manually)


# 1. [Overview](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#encodinganddecodingcustomtypes)

```swift
struct Landmark {
    var name: String
    var foundingYear: Int
}
```

# 2. [Encode and Decode Automatically](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#encodinganddecodingcustomtypes)

```swift
struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    
    // Landmark now supports the Codable methods init(from:) and encode(to:), 
    // even though they aren't written as part of its declaration.
}
```

- All properties have to conform Codable to Globally conform Codable

```swift
struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Landmark: Codable {
    // Double, String, and Int all conform to Codable.
    var name: String
    var foundingYear: Int
    
    // Adding a property of a custom Codable type maintains overall Codable conformance.
    var location: Coordinate
}
```

- Array, Dictionary and Optional also confomr to Codable

```swift
struct Landmark: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate
    
    // Landmark is still codable after adding these properties.
    var vantagePoints: [Coordinate]
    var metadata: [String: String]
    var website: URL?
}
```

# 3. [Encode or Decode Exclusively](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#encodinganddecodingcustomtypes)

- only encodable

```swift
struct LandMark: Encodable {
	var name: String
	var foundingYear: Int
}
```

- only decodable

```swift
struct LandMark: Decodable {
	var name: String
	var foundingYear: Int
}
```

# 4. [Choose Properties to Encode and Decode Using Coding Keys](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#encodinganddecodingcustomtypes)

- create an enumerator with each property to coding the key.

```swift
struct LandMark: Codable {
	var name: String
	var foundingYear: Int
	var location: Coordinate
	var vantagePoints: [Coordinate]

	enum CodingKeys: String, CodingKey {
		case name = "title"
		case foundingYear = "founding_date"

		case location
		case vantagePoints
	}
}
```

# 5. [Encode and Decode Manually](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#encodinganddecodingcustomtypes)

- If you structure of your swift type differs from the structure of its encoded form, you can provide a custom implementation of Encodable and Decodable to define your own encoding and decoding logic.

- In this example, the Coordinate structure is expanded to support an elevation property that is nested inside of an additionalInfo container:

```swift
struct Coordinate {
    var latitude: Double
    var longitude: Double
    var elevation: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case additionalInfo
    }
    
    enum AdditionalInfoKeys: String, CodingKey {
        case elevation
    }
}
```

- Because the encoded form of the Coordinae type contains a second level of nested information, the type's adoption of the Encodable and Decodable protocols uses two enumerations that each list the complete set of coding keys used on a particular level.

- The  Coordinate structure is extended to conform to the Decodable protocol by implementing its required initializer, init(from:)

```swift
extension Coordinate: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        
        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
    }
}
```

- The initializer populates a Coordinate instance by using methods on the Decoder instance it receives as a parameter. The Coordinate instance's two properties are initialized using the keyed container APIS provided by the Swift standard library.

- This example shows how the Coordinate structure can be extended to conform to the Encodable protocol by implementing its required method, encode(to:)

```swift
extension Coordinate: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        
        var additionalInfo = container.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        
        try additionalInfo.encode(elevation, forKey: .elevation)
    }
}
```

