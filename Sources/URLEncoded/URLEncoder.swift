import Foundation

enum URLEncoderError: Error {
	case unsupportedContainer
}

public struct URLEncoder {
	public init() {}

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

class _URLEncoder: Encoder, TopEncoder {
	var codingPath: [any CodingKey] = []
	var userInfo: [CodingUserInfoKey : Any] = [:]

	init(codingPath: [any CodingKey] = [], userInfo: [CodingUserInfoKey : Any] = [:]) {
		self.codingPath = codingPath
		self.userInfo = userInfo
	}

	var values: [(key: [String], value: String?)] = []
	var result: String {
		var components = URLComponents()
		var queryItems: [URLQueryItem] = []

		func encode(_ value: String) -> String {
			components.queryItems = [URLQueryItem(name: "", value: value)]
			return (components.percentEncodedQuery?.dropFirst()).map(String.init) ?? value
		}

		for (names, value) in values {
			let names = names.map(encode)
			let name = (names.first ?? "") + names.dropFirst().map { "[\($0)]" }.joined()
			let item = URLQueryItem(name: name, value: value.map(encode))
			queryItems.append(item)
		}

		components.queryItems = queryItems
		return components.query ?? ""
	}

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
			values.append((codingPath.map(\.stringValue), value))
		} else {
			let encoder = _URLEncoder(codingPath: codingPath)
			try value.encode(to: encoder)
			values.append(contentsOf: encoder.values)
		}
	}

	func convert(_ value: some Encodable, codingPath: [any CodingKey]) -> String? {
		if let value = value as? URL {
			return value.absoluteString
		}
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
