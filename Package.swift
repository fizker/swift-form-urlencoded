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
		.package(url: "https://github.com/fizker/swift-macro-init.git", branch: "main"),
	],
	targets: [
		.target(
			name: "URLEncoded",
			dependencies: [
				.product(name: "InitMacro", package: "swift-macro-init"),
			]
		),
		.testTarget(
			name: "URLEncodedTests",
			dependencies: ["URLEncoded"]
		),
	]
)
