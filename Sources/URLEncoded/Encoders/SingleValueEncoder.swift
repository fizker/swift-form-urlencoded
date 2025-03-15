import InitMacro

@Init
class SingleValueEncoder: SingleValueEncodingContainer {
	let encoder: TopEncoder
	let codingPath: [any CodingKey]

	func encode(_ value: some Encodable) throws {
		throw URLEncoderError.unsupportedContainer
	}

	func encodeNil() throws {
	}
}
