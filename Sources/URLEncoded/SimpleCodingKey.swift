struct SimpleCodingKey: CodingKey {
	init(stringValue: String) {
		self.stringValue = stringValue
		self.intValue = Int(stringValue)
	}

	init(intValue: Int) {
		self.intValue = intValue
		self.stringValue = "\(intValue)"
	}

	var intValue: Int?
	var stringValue: String
}
