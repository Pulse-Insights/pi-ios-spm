//
//  FunctionalTests.swift
//  PulseInsights
//
//  Created by shenlongshenlongshenlong on 2025/3/10.
//

import XCTest
@testable import PulseInsights

final class PulseInsightsFunctionalTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        LocalConfig.instance.reset()
        PIPreferencesManager.sharedInstance.changeHostUrl("")
        URLProtocol.registerClass(MockURLProtocol.self)
        MockURLProtocol.requestHandler = nil
    }
    
    override func tearDown() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }
    
    // MARK: Initial and config
    func testInitialization_ShouldSetCorrectDefaults() {
        let sut = PulseInsights("test-account-id")
        
        XCTAssertEqual(LocalConfig.instance.strAccountID, "test-account-id")
        XCTAssertTrue(LocalConfig.instance.surveyWatcherEnable)
        XCTAssertFalse(LocalConfig.instance.previewMode)
        XCTAssertEqual(LocalConfig.instance.customData, [:])
    }
    
    func testInitialization_WithCustomParameters_ShouldSetCorrectValues() {
        let customData = ["key1": "value1", "key2": "value2"]
        let sut = PulseInsights("test-account-id", enableDebugMode: true, automaticStart: false, previewMode: true, customData: customData)
        
        XCTAssertEqual(LocalConfig.instance.strAccountID, "test-account-id")
        XCTAssertFalse(LocalConfig.instance.surveyWatcherEnable)
        XCTAssertTrue(LocalConfig.instance.previewMode)
        XCTAssertEqual(LocalConfig.instance.customData, customData)
    }
    
    func testConfigAccountID_ShouldUpdateAccountID() {
        let sut = PulseInsights("initial-account-id")
        
        sut.configAccountID("new-account-id")
        
        XCTAssertEqual(LocalConfig.instance.strAccountID, "new-account-id")
    }
    
    func testSetHost_ShouldUpdateHostURL() {
        let sut = PulseInsights("test-account-id")
        let originalHost = PIPreferencesManager.sharedInstance.getServerHost()
        
        sut.setHost("test-host.example.com")
        
        XCTAssertEqual(PIPreferencesManager.sharedInstance.getServerHost(), "test-host.example.com")
        XCTAssertNotEqual(PIPreferencesManager.sharedInstance.getServerHost(), originalHost)
    }
    
    // MARK: View track
    func testSetViewName_ShouldUpdateViewNameAndController() {
         let sut = PulseInsights("test-account-id")
         let mockController = UIViewController()
         
         sut.setViewName("TestView", controller: mockController)
         
         XCTAssertEqual(LocalConfig.instance.strRunningViewName, "TestView")
         XCTAssertEqual(LocalConfig.instance.strViewName, "TestView")
         XCTAssertEqual(sut.getViewController(), mockController)
     }
    
    // MARK: setScanFrequency
    func testSwitchSurveyScan_ShouldToggleScanningState() {
        let sut = PulseInsights("test-account-id")
        
        sut.switchSurveyScan(false)
        XCTAssertFalse(sut.isSurveyScanWorking())
        
        sut.switchSurveyScan(true)
        XCTAssertTrue(sut.isSurveyScanWorking())
    }
    
    func testSetScanFrequency_ShouldCreateAndConfigureTimer() {
        let sut = PulseInsights("test-account-id")
        
        XCTAssertNil(LocalConfig.instance.mScanTimer, "Timer should be nil initially")
        
        sut.setScanFrequency(30)
        XCTAssertEqual(LocalConfig.instance.iTimerDurationInSecond, 30, "Timer duration should be updated")
        XCTAssertNotNil(LocalConfig.instance.mScanTimer, "Timer should be created")
        XCTAssertTrue(LocalConfig.instance.mScanTimer!.isValid, "Timer should be valid")
        
        sut.setScanFrequency(0)
        XCTAssertNil(LocalConfig.instance.mScanTimer, "Timer should be nil after setting frequency to 0")
    }
    
    func testSetScanFrequency_WhenCalledMultipleTimes_ShouldReplaceExistingTimer() {
        let sut = PulseInsights("test-account-id")
        
        sut.setScanFrequency(30)
        let firstTimer = LocalConfig.instance.mScanTimer
        XCTAssertNotNil(firstTimer, "First timer should be created")
        
        sut.setScanFrequency(60)
        let secondTimer = LocalConfig.instance.mScanTimer
        XCTAssertNotNil(secondTimer, "Second timer should be created")
        XCTAssertNotEqual(ObjectIdentifier(firstTimer!), ObjectIdentifier(secondTimer!), "Second timer should be a different instance")
        XCTAssertEqual(LocalConfig.instance.iTimerDurationInSecond, 60, "Timer duration should be updated to new value")
    }
    
    func testTimerActivity_IndirectlyThroughScanFrequency() {
        let sut = PulseInsights("test-account-id")
        sut.switchSurveyScan(true)
        
        LocalConfig.instance.iSurveyEventCode = Define.piEventCodeAccountReseted
        
        let expectation = XCTestExpectation(description: "API call completed")
        MockURLProtocol.requestHandler = { request in
            XCTAssertTrue(request.url?.path.contains("/serve") ?? false)
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let responseData = """
            {
                "survey": {
                    "id": 7498,
                    "name": "Test Survey"
                }
            }
            """.data(using: .utf8)!
            
            expectation.fulfill()
            
            return (response, responseData)
        }
        
        sut.setScanFrequency(1)
        
        wait(for: [expectation], timeout: 3.0)
        
        XCTAssertEqual(LocalConfig.instance.iSurveyEventCode, Define.piEventCodeNormal, "Event code should be reset to Normal after processing")
        
        sut.setScanFrequency(0)
    }
    
    // MARK: serve
    func testServe_ShouldCallAPIAndHandleResponse() async throws {
        let sut = PulseInsights("test-account-id")
        let serveExpectation = XCTestExpectation(description: "Serve API call completed")
        let questionDetailExpectation = XCTestExpectation(description: "Question Detail API call completed")
        
        MockURLProtocol.requestHandler = { request in
            if request.url?.path.contains("/serve") ?? false {
                print("Handling /serve request")
                
                XCTAssertTrue(request.url?.path.contains("/serve") ?? false)
                
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                let responseData = """
                {
                    "survey": {
                        "id": 1234,
                        "name": "Test Survey"
                    }
                }
                """.data(using: .utf8)!
                
                serveExpectation.fulfill()
                
                return (response, responseData)
            }
            else if request.url?.path.contains("/questions") ?? false {
                print("Handling /questions request")
                
                XCTAssertTrue(request.url?.path.contains("/surveys/1234/questions") ?? false)
                
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                let mockResponse = """
                [
                    {
                        "id": 123,
                        "content": "How would you rate our service?",
                        "question_type": "single_choice_question",
                        "possible_answers": [
                            {
                                "id": 1,
                                "content": "Excellent"
                            },
                            {
                                "id": 2,
                                "content": "Good"
                            },
                            {
                                "id": 3,
                                "content": "Average"
                            }
                        ]
                    },
                    {
                        "id": 456,
                        "content": "Any additional comments?",
                        "question_type": "free_text_question"
                    }
                ]
                """
                let responseData = mockResponse.data(using: .utf8)!
                
                questionDetailExpectation.fulfill()
                
                return (response, responseData)
            }
            else {
                print("Handling unexpected request: \(request.url?.path ?? "unknown")")
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, "{}".data(using: .utf8)!)
            }
        }

        sut.serve()
        
        await fulfillment(of: [serveExpectation, questionDetailExpectation], timeout: 5.0)
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1秒

        print("surveyPack.survey.surveyId: \(LocalConfig.instance.surveyPack.survey.surveyId)")
        print("surveyTickets count: \(LocalConfig.instance.surveyTickets.count)")
        
        XCTAssertEqual(LocalConfig.instance.surveyPack.survey.surveyId, "1234", "Survey ID should be set correctly")
        XCTAssertFalse(LocalConfig.instance.surveyTickets.isEmpty, "Survey tickets should not be empty")

        if !LocalConfig.instance.surveyTickets.isEmpty {
            let firstQuestion = LocalConfig.instance.surveyTickets[0]
            XCTAssertEqual(firstQuestion.surveyId, "123", "Question ID should be set correctly")
            XCTAssertEqual(firstQuestion.content, "How would you rate our service?", "Question content should be set correctly")
            XCTAssertEqual(firstQuestion.question_type, "single_choice_question", "Question type should be set correctly")
            XCTAssertEqual(firstQuestion.possible_answers?.count, 3, "Question should have 3 answers")
        }
    }
    
    // MARK: Context data
    func testSetContextData_WithMergeTrue_ShouldMergeWithExistingData() {
        let sut = PulseInsights("test-account-id")
        let initialData = ["key1": "value1", "key2": "value2"]
        sut.setContextData(initialData)
        
        let newData = ["key2": "updated", "key3": "value3"]
        sut.setContextData(newData, merge: true)
        
        let expectedData = ["key1": "value1", "key2": "updated", "key3": "value3"]
        XCTAssertEqual(LocalConfig.instance.customData, expectedData)
    }

    func testSetContextData_WithMergeFalse_ShouldReplaceExistingData() {
        let sut = PulseInsights("test-account-id")
        let initialData = ["key1": "value1", "key2": "value2"]
        sut.setContextData(initialData)
        
        let newData = ["key3": "value3", "key4": "value4"]
        sut.setContextData(newData, merge: false)
        
        XCTAssertEqual(LocalConfig.instance.customData, newData)
    }

    func testClearContextData_ShouldRemoveAllContextData() {
        let sut = PulseInsights("test-account-id")
        let initialData = ["key1": "value1", "key2": "value2"]
        sut.setContextData(initialData)
        
        sut.clearContextData()
        
        XCTAssertEqual(LocalConfig.instance.customData, [:])
    }
    
    // MARK: UDID
    func testResetUdid_ShouldGenerateNewUdid() {
        let sut = PulseInsights("test-account-id")
        let originalUdid = LocalConfig.instance.strUDID
        
        sut.resetUdid()
        
        XCTAssertNotEqual(LocalConfig.instance.strUDID, originalUdid)
        XCTAssertEqual(LocalConfig.instance.iSurveyEventCode, Define.piEventCodeAccountReseted)
    }
    
    // MARK: present()
    func testPresent_WithValidSurveyID_ShouldFetchAndDisplaySurvey() async throws {
        let sut = PulseInsights("test-account-id")
        sut.setHost("testDomain")
        let surveyInfoExpectation = XCTestExpectation(description: "Survey info API call completed")
        let questionDetailExpectation = XCTestExpectation(description: "Question detail API call completed")
        
        MockURLProtocol.requestHandler = { request in
            if request.url?.path.contains("/surveys/1234/questions") ?? false {
                print("Handling /surveys/1234/questions request")
                
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                let responseData = """
                [
                    {
                        "id": 123,
                        "content": "How would you rate our service?",
                        "question_type": "single_choice_question",
                        "possible_answers": [
                            {
                                "id": 1,
                                "content": "Excellent"
                            },
                            {
                                "id": 2,
                                "content": "Good"
                            },
                            {
                                "id": 3,
                                "content": "Average"
                            }
                        ]
                    },
                    {
                        "id": 456,
                        "content": "Any additional comments?",
                        "question_type": "free_text_question"
                    }
                ]
                """.data(using: .utf8)!
                
                print("Questions response: \(String(data: responseData, encoding: .utf8) ?? "")")
                questionDetailExpectation.fulfill()
                return (response, responseData)
            }
            else if request.url?.path.contains("/surveys/1234") ?? false {
                print("Handling /surveys/1234 request")
                
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                let responseData = """
                {
                    "survey": {
                        "id": 1234,
                        "name": "Test Survey"
                    }
                }
                """.data(using: .utf8)!
                
                print("Survey info response: \(String(data: responseData, encoding: .utf8) ?? "")")
                surveyInfoExpectation.fulfill()
                return (response, responseData)
            }
            else {
                print("Handling unexpected request: \(request.url?.path ?? "unknown")")
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, "{}".data(using: .utf8)!)
            }
        }
        
        sut.present("1234")
        
        await fulfillment(of: [surveyInfoExpectation, questionDetailExpectation], timeout: 3.0)
        try await Task.sleep(nanoseconds: 1_000_000_000)

        print("surveyPack.survey.surveyId: \(LocalConfig.instance.surveyPack.survey.surveyId)")
        print("strCheckingSurveyID: \(LocalConfig.instance.strCheckingSurveyID)")
        print("surveyTickets count: \(LocalConfig.instance.surveyTickets.count)")
        
        XCTAssertEqual(LocalConfig.instance.strCheckingSurveyID, "1234")
        XCTAssertEqual(LocalConfig.instance.surveyPack.survey.surveyId, "1234")
        XCTAssertFalse(LocalConfig.instance.surveyTickets.isEmpty, "Survey tickets should not be empty")
        
        if !LocalConfig.instance.surveyTickets.isEmpty {
            let firstQuestion = LocalConfig.instance.surveyTickets[0]
            XCTAssertEqual(firstQuestion.surveyId, "123", "Question ID should be set correctly")
            XCTAssertEqual(firstQuestion.content, "How would you rate our service?", "Question content should be set correctly")
            XCTAssertEqual(firstQuestion.question_type, "single_choice_question", "Question type should be set correctly")
            XCTAssertEqual(firstQuestion.possible_answers?.count, 3, "Question should have 3 answers")
        }
    }
}
