import InitMacro

protocol Container {
	var result: String { get }
}

struct NotImplemented: Error, CustomStringConvertible {
	var description: String

	init(_ message: String) {
		description = message
	}
}

@Init
public struct URLEncoder {
	public func encode<T: Encodable>(_ value: T) throws -> String {
		let e = _URLEncoder()
		try value.encode(to: e)
		return e.result
	}
}

@Init
class _URLEncoder: Encoder, Container {
	var codingPath: [any CodingKey] = []
	var userInfo: [CodingUserInfoKey : Any] = [:]

	var containers: [any Container] = []

	func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
		let container = KeyedContainer<Key>(codingPath: codingPath)
		containers.append(container)
		return .init(container)
	}

	func unkeyedContainer() -> any UnkeyedEncodingContainer {
		fatalError("unkeyedContainer")
	}

	func singleValueContainer() -> any SingleValueEncodingContainer {
		let container = SingleValueContainer(codingPath: codingPath)
		containers.append(container)
		return container
	}

	var result: String {
		containers.map(\.result).joined(separator: "&")
	}
}
