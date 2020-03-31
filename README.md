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


# 5. [Encode and Decode Manually](https://github.com/c4arl0s/EncodingAndDecodingCustomTypes#encodinganddecodingcustomtypes)
