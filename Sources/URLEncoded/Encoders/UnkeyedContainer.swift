class UnkeyedEncoder: UnkeyedEncodingContainer {
	init(encoder: TopEncoder, codingPath: [any CodingKey]) {
		self.encoder = encoder
		self.codingPath = codingPath
	}

	let encoder: TopEncoder
	let codingPath: [any CodingKey]

	var count: Int = 0

	func encodeNil() throws {
	}

	func encode(_ value: some Encodable) throws {
		defer { count += 1 }
		try encoder.add(value, key: SimpleCodingKey(intValue: count), codingPath: codingPath)
	}

	func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
		.init(KeyedEncoder(encoder: encoder, codingPath: codingPath + [SimpleCodingKey(intValue: count)]))
	}

	func nestedUnkeyedContainer() -> any UnkeyedEncodingContainer {
		UnkeyedEncoder(encoder: encoder, codingPath: codingPath + [SimpleCodingKey(intValue: count)])
	}

	func superEncoder() -> Encoder {
		fatalError("init(codingPath:) has not been implemented")
	}

	func superEncoder(forKey key: CodingKey) -> Encoder {
		fatalError("superEncoder(forKey:)")
	}
}
