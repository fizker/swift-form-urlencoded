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

	@Test(arguments: [
		("a b", "a%20b"),
		("http://example.com/foo?bar=1&baz=2", "http://example.com/foo?bar%3D1%26baz%3D2"),
	])
	func add__string_stringsNeedEncoding__encodesCorrectly(value: String, encoded: String) async throws {
		let subject = _URLEncoder()

		try subject.add(value, key: SimpleCodingKey(stringValue: "key"), codingPath: [])

		#expect("key=\(encoded)" == subject.result)
	}

}
