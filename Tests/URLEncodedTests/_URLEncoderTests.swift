import Testing
@testable import URLEncoded

struct URLEncoderInternalTests {
	@Test
	func add__singleLevelObject_emptyCodingPath__encodesCorrectly() async throws {
		let subject = _URLEncoder()
		let value = SingleLevelObject(string: "foo", int: 1)
		try subject.add(value, codingPath: [])

		#expect("string=foo&int=1" == subject.result)
	}

	@Test
	func add__singleLevelObject_valueInCodingPath__encodesCorrectly() async throws {
		let subject = _URLEncoder()
		let value = SingleLevelObject(string: "foo", int: 1)
		try subject.add(value, codingPath: [SimpleCodingKey(stringValue: "bar")])
		#expect("bar[string]=foo&bar[int]=1" == subject.result)
	}
}
