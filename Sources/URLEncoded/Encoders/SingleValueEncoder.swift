class SingleValueEncoder: SingleValueEncodingContainer {
	init(encoder: TopEncoder, codingPath: [any CodingKey]) {
		self.encoder = encoder
		self.codingPath = codingPath
	}

	let encoder: TopEncoder
	let codingPath: [any CodingKey]

	func encode(_ value: some Encodable) throws {
		try encoder.add(value, codingPath: codingPath)
	}

	func encodeNil() throws {
	}
}
