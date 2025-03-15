import Testing
@testable import URLEncoded

struct SingleValueEncoderTests {
	@Test(arguments: ["foo", 1, SingleLevelObject(a: "a", b: 1)] as [Encodable & Sendable])
	func encode__various__throws(_ value: any Encodable) async throws {
		let encoder = _URLEncoder()
		let subject = SingleValueEncoder(encoder: encoder, codingPath: [])

		#expect(throws: URLEncoderError.unsupportedContainer) {
			try subject.encode(value)
		}
	}
}
