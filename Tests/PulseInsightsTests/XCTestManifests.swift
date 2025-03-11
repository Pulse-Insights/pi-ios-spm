//
//  XCTestManifests.swift
//  PulseInsights
//
//  Created by shenlongshenlongshenlong on 2025/3/7.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(NetworkServiceTests.allTests),
    ]
}
#endif
