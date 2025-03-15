import Foundation
import Testing
import URLEncoded

struct URLEncoderTests {
	@Test
	func encode__singleLevelObjectWithPrimitiveValues__encodesCorrectly() async throws {
		let object = SingleLevelObject(string: "foo", int: 2)

		let subject = URLEncoder()

		let actual = try subject.encode(object)

		#expect("string=foo&int=2" == actual)
	}

	@Test
	func encode__nestedObject__encodesCorrectly() async throws {
		let object = MultiLevelObject(nested: SingleLevelObject(string: "foo", int: 2))

		let subject = URLEncoder()

		let actual = try subject.encode(object)

		#expect("nested[string]=foo&nested[int]=2" == actual)
	}

	@Test
	func encode__objectWithArray__encodesCorrectly() async throws {
		let object = ObjectWithArray(array: [SingleLevelObject(string: "a", int: 1), SingleLevelObject(string: "b", int: 2)])

		let subject = URLEncoder()

		let actual = try subject.encode(object)

		#expect("array[0][string]=a&array[0][int]=1&array[1][string]=b&array[1][int]=2" == actual)
	}

	@Test
	func encode__objectWithEnum__encodesCorrectly() async throws {
		let object = SingleLevelObject(enum: .foo)

		let subject = URLEncoder()

		let actual = try subject.encode(object)

		#expect("enum=foo" == actual)
	}

	@Test
	func encode__valuesRequirePercentEncoding__encodesCorrectly() async throws {
		let object = SingleLevelObject(string: "a&b=c+d", url: URL(string: "http://example.com/foo?bar=baz+fa&baz[1]=zapp")!)

		let subject = URLEncoder()

		let actual = try subject.encode(object)

		#expect("string=a%26b%3Dc+d&url=http://example.com/foo?bar%3Dbaz+fa%26baz%255B1%255D%3Dzapp" == actual)
	}

}
