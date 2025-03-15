import InitMacro

enum URLEncoderError: Error {
	case unsupportedContainer
}

@Init
public struct URLEncoder {
	public func encode<T: Encodable>(_ value: T) throws -> String {
		let e = _URLEncoder()
		try value.encode(to: e)
		return e.result
	}
}

protocol TopEncoder: Encoder {
	func add(_ value: some Encodable, key: some CodingKey, codingPath: [any CodingKey]) throws
	func add(_ value: some Encodable, codingPath: [any CodingKey]) throws
}
extension TopEncoder {
	func add(_ value: some Encodable, key: some CodingKey, codingPath: [any CodingKey]) throws {
		try add(value, codingPath: codingPath + [key])
	}
}

@Init
class _URLEncoder: Encoder, TopEncoder {
	var codingPath: [any CodingKey] = []
	var userInfo: [CodingUserInfoKey : Any] = [:]

	var values: [String] = []
	var result: String { values.joined(separator: "&") }

	func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
		return .init(KeyedEncoder<Key>(encoder: self, codingPath: codingPath))
	}

	func unkeyedContainer() -> any UnkeyedEncodingContainer {
		UnkeyedEncoder(encoder: self, codingPath: codingPath)
	}

	func singleValueContainer() -> any SingleValueEncodingContainer {
		return SingleValueEncoder(encoder: self, codingPath: codingPath)
	}

	func add(_ value: some Encodable, codingPath: [any CodingKey]) throws {
		if let value = convert(value, codingPath: codingPath) {
			let names = codingPath.map(\.stringValue)
			let name = (names.first ?? "") + names.dropFirst().map { "[\($0)]" }.joined()
			values.append("\(name)=\(value)")
		} else {
			let encoder = _URLEncoder(codingPath: codingPath)
			try value.encode(to: encoder)
			values.append(encoder.result)
		}
	}

	func convert(_ value: some Encodable, codingPath: [any CodingKey]) -> String? {
		if let number = value as? any Numeric {
			return "\(number)"
		}
		if let value = value as? String {
			return value
		}
		if let value = value as? Bool {
			return "\(value)"
		}

		return nil
	}
}
