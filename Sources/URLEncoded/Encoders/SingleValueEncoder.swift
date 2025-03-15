import InitMacro

@Init
class SingleValueEncoder: SingleValueEncodingContainer {
	let encoder: TopEncoder
	let codingPath: [any CodingKey]

	func encode(_ value: some Encodable) throws {
		try encoder.add(value, codingPath: codingPath)
	}

	func encodeNil() throws {
	}
}
