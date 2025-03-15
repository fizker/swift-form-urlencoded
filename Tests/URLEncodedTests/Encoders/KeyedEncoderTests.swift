import Testing
@testable import URLEncoded

struct KeyedEncoderTests {
	@Test
	func encode__stringValues_emptyCodingPath__encodesCorrectly() async throws {
		enum CodingKeys: CodingKey {
			case foo, bar
		}
		let encoder = _URLEncoder()
		let subject = KeyedEncoder<CodingKeys>(encoder: encoder, codingPath: [])

		try subject.encode("aaa", forKey: .foo)

		#expect(encoder.result == "foo=aaa")

		try subject.encode("bbb", forKey: .bar)

		#expect(encoder.result == "foo=aaa&bar=bbb")
	}

	@Test
	func encode__stringValues_someCodingPath__encodesCorrectly() async throws {
		enum CodingKeys: CodingKey {
			case foo, bar
		}
		let encoder = _URLEncoder()
		let subject = KeyedEncoder<CodingKeys>(encoder: encoder, codingPath: [CodingKeys.foo, SimpleCodingKey(stringValue: "baz")])

		try subject.encode("aaa", forKey: .foo)

		#expect(encoder.result == "foo[baz][foo]=aaa")

		try subject.encode("bbb", forKey: .bar)

		#expect("foo[baz][foo]=aaa&foo[baz][bar]=bbb" == encoder.result)
	}

	@Test
	func encode__object_emptyCodingPath__encodesCorrectly() async throws {
		enum CodingKeys: CodingKey {
			case foo, bar
		}
		let encoder = _URLEncoder()
		let subject = KeyedEncoder<CodingKeys>(encoder: encoder, codingPath: [])

		let value = SingleLevelObject(a: "1", b: 2)
		try subject.encode(value, forKey: .foo)

		#expect("foo[a]=1&foo[b]=2" == encoder.result)
	}
}
