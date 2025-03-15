import Testing
@testable import URLEncoded

struct SingleValueEncoderTests {
	@Test(arguments: [("foo", "key=foo"), (1, "key=1"), (SingleLevelObject(string: "a", int: 1), "key[string]=a&key[int]=1")] as [(Encodable & Sendable, String)])
	func encode__various__throws(_ value: any Encodable, expected: String) async throws {
		let encoder = _URLEncoder()
		let subject = SingleValueEncoder(encoder: encoder, codingPath: [SimpleCodingKey(stringValue: "key")])
		try subject.encode(value)
		#expect(expected == encoder.result)
	}
}
