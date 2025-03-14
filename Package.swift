// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "swift-urlencoded",
	products: [
		.library(
			name: "URLEncoded",
			targets: ["URLEncoded"]
		),
	],
	targets: [
		.target(
			name: "URLEncoded"
		),
		.testTarget(
			name: "URLEncodedTests",
			dependencies: ["URLEncoded"]
		),
	]
)
