import Testing
@testable import URLEncoded

struct URLEncoderInternalTests {
	@Test
	func add__singleLevelObject_emptyCodingPath__encodesCorrectly() async throws {
		let subject = _URLEncoder()
		let value = SingleLevelObject(a: "foo", b: 1)
		try subject.add(value, codingPath: [])

		#expect("a=foo&b=1" == subject.result)
	}

	@Test
	func add__singleLevelObject_valueInCodingPath__encodesCorrectly() async throws {
		let subject = _URLEncoder()
		let value = SingleLevelObject(a: "foo", b: 1)
		try subject.add(value, codingPath: [SimpleCodingKey(stringValue: "bar")])
		#expect("bar[a]=foo&bar[b]=1" == subject.result)
	}
}
