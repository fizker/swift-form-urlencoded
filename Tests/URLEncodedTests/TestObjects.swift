struct SingleLevelObject: Codable {
	var a: String
	var b: Int
}

struct MultiLevelObject: Codable {
	var c: SingleLevelObject
}

struct ObjectWithArray: Codable {
	var array: [SingleLevelObject]
}
