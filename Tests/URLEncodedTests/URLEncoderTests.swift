import Testing
import URLEncoded

struct URLEncoderTests {
	@Test
	func encode__singleLevelObjectWithPrimitiveValues__encodesCorrectly() async throws {
		let object = SingleLevelObject(a: "foo", b: 2)

		let subject = URLEncoder()

		let actual = try subject.encode(object)

		#expect("a=foo&b=2" == actual)
	}

	@Test
	func encode__nestedObject__encodesCorrectly() async throws {
		let object = MultiLevelObject(c: SingleLevelObject(a: "foo", b: 2))

		let subject = URLEncoder()

		let actual = try subject.encode(object)

		#expect("c[a]=foo&c[b]=2" == actual)
	}

	@Test
	func encode__objectWithArray__encodesCorrectly() async throws {
		let object = ObjectWithArray(array: [SingleLevelObject(a: "a", b: 1), SingleLevelObject(a: "b", b: 2)])

		let subject = URLEncoder()

		let actual = try subject.encode(object)

		#expect("array[0][a]=a&array[0][b]=1&array[1][a]=b&array[1][b]=2" == actual)
	}
}
