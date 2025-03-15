import InitMacro

@Init
class KeyedEncoder<Key: CodingKey>: KeyedEncodingContainerProtocol {
	let encoder: TopEncoder
	let codingPath: [any CodingKey]

	func encodeNil(forKey key: Key) throws {
	}

	func encode(_ value: some Encodable, forKey key: Key) throws {
		try encoder.add(value, key: key, codingPath: codingPath)
	}

	func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
		.init(KeyedEncoder<NestedKey>(encoder: encoder, codingPath: codingPath + [key]))
	}

	func nestedUnkeyedContainer(forKey key: Key) -> any UnkeyedEncodingContainer {
		UnkeyedEncoder(encoder: encoder, codingPath: codingPath + [key])
	}

	func superEncoder() -> any Encoder {
		fatalError("superEncoder")
	}

	func superEncoder(forKey key: Key) -> any Encoder {
		fatalError("superEncoder(forKey:)")
	}
}
