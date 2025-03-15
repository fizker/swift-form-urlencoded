import Foundation

enum EnumValue: String, Codable {
	case foo, bar
}

struct SingleLevelObject: Codable {
	var string: String?
	var int: Int?
	var `enum`: EnumValue?
	var url: URL?
}

struct MultiLevelObject: Codable {
	var nested: SingleLevelObject
}

struct ObjectWithArray: Codable {
	var array: [SingleLevelObject]
}
