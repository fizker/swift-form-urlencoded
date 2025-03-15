import InitMacro

@Init
class KeyedContainer<Key: CodingKey>: KeyedEncodingContainerProtocol, Container {
	var codingPath: [any CodingKey]

	var values: [String: String] = [:]

	var result: String {
		values.map { "\($0)=\($1)" }.joined(separator: "&")
	}

	func encodeNil(forKey key: Key) throws {
		values[key.stringValue] = nil
	}

	func encode(_ value: String, forKey key: Key) throws {
		values[key.stringValue] = value
	}

	func encode(_ value: some Encodable, forKey key: Key) throws {
		guard let convertible = value as? CustomStringConvertible
		else { throw NotImplemented("Failed at \(value)") }
		try encode(convertible.description, forKey: key)
	}

	func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
		.init(KeyedContainer<NestedKey>(codingPath: codingPath + [key]))
	}

	func nestedUnkeyedContainer(forKey key: Key) -> any UnkeyedEncodingContainer {
		fatalError("nestedUnkeyedContainer")
	}

	func superEncoder() -> any Encoder {
		fatalError("superEncoder")
	}

	func superEncoder(forKey key: Key) -> any Encoder {
		fatalError("superEncoder(forKey:)")
	}
}
