// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "swift-urlencoded",
	platforms: [
		.iOS(.v13),
		.macCatalyst(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.watchOS(.v6),
	],
	products: [
		.library(
			name: "URLEncoded",
			targets: ["URLEncoded"]
		),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "URLEncoded",
			dependencies: [
			]
		),
		.testTarget(
			name: "URLEncodedTests",
			dependencies: ["URLEncoded"]
		),
	]
)
