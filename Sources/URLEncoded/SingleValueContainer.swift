import InitMacro

@Init
class SingleValueContainer: SingleValueEncodingContainer, Container {
	var result: String = ""

	func encode(_ value: String) throws {
		result = value
	}

	func encode(_ value: some Encodable) throws {
		guard let convertible = value as? CustomStringConvertible
		else { fatalError("Failed at \(value)") }
		try encode(convertible.description)
	}

	var codingPath: [any CodingKey]

	func encodeNil() throws {
	}
}
