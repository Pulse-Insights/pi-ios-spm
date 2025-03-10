// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PulseInsights",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PulseInsights",
            targets: ["PulseInsights"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PulseInsights",
            dependencies: [],
            path: "PulseInsights/Sources/PulseInsights",
            exclude: ["Info.plist"],
            resources: [
                .process("images.xcassets"),
                .process("PaddingLabel.xib"),
                .process("PollResultItem.xib"),
                .process("StyledImageView.xib"),
                .process("SurveyCustomContentType.xib"),
                .process("SurveyItemView.xib"),
                .process("SurveyMainViewController.xib"),
                .process("SurveyPollResultView.xib"),
                .process("SurveySelectionType.xib"),
                .process("SurveyTextType.xib"),
                .process("SurveyView.xib"),
                .process("WidgetView.xib")
            ]
        ),
        .testTarget(
            name: "PulseInsightsTests",
            dependencies: ["PulseInsights"],
            path: "Tests/PulseInsightsTests",
            exclude: ["UI"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
