//
//  APIEndpointTests.swift
//  PulseInsights
//
//  Created by shenlongshenlongshenlong on 2025/3/7.
//

import XCTest
@testable import PulseInsights

final class APIEndpointTests: XCTestCase {
    var sut: PulseInsights!
    
    override func setUp() {
        super.setUp()
        LocalConfig.instance.bIsDebugModeOn = true
        sut = PulseInsights("test-account-id", enableDebugMode: true)
        sut.setHost("test-host.example.com")
        
        URLProtocol.registerClass(MockURLProtocol.self)
        print("URLProtocol registered")
    }
    
    override func tearDown() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        LocalConfig.instance.surveyPack = Survey()
        LocalConfig.instance.bIsDebugModeOn = false
        sut = nil
        super.tearDown()
    }
    
    // MARK: serve()
    func testServeAPI_WhenSuccessful_ShouldParseResponse() async throws {
        let mockResponse = """
        {
            "survey": {
                "id": 7498,
                "name": "Test Survey"
            }
        }
        """
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertTrue(request.url?.path.contains("/serve") ?? false)
            
            let urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
            XCTAssertNotNil(urlComponents?.queryItems?.first(where: { $0.name == "udid" }))
            XCTAssertNotNil(urlComponents?.queryItems?.first(where: { $0.name == "device_type" }))
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockResponse.data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "API call completed")
        PulseInsightsAPI.serve { success in
            XCTAssertTrue(success)
            XCTAssertEqual(LocalConfig.instance.surveyPack.survey.surveyId, "7498")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func testServeAPI_WhenServerReturnsError_ShouldReturnFalse() async throws {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, "error".data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "API call completed")
        PulseInsightsAPI.serve { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    // MARK: setDeviceData()
    func testSetDeviceData_ShouldSendCorrectRequest() async throws {
        let testData = ["key1": "value1", "key2": "value2"]
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertTrue(request.url?.path.contains("/devices/") ?? false)
            XCTAssertTrue(request.url?.path.contains("/set_data") ?? false)
            
            let urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
            XCTAssertNotNil(urlComponents?.queryItems?.first(where: { $0.name == "key1" && $0.value == "value1" }))
            XCTAssertNotNil(urlComponents?.queryItems?.first(where: { $0.name == "key2" && $0.value == "value2" }))
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, "{}".data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "API call completed")
        
        MockURLProtocol.completionHandler = {
            expectation.fulfill()
        }
        
        PulseInsightsAPI.setDeviceData(testData)
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    // MARK: getSurveyInformation()
    func testGetSurveyInformation_WithValidId_ShouldParseResponse() async throws {
        let mockResponse = """
        {
            "survey": {
                "id": 7498,
                "name": "Test Survey"
            }
        }
        """
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertTrue(request.url?.path.contains("/surveys/7498") ?? false)
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockResponse.data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "API call completed")
        PulseInsightsAPI.getSurveyInformation(with: "7498") { success in
            XCTAssertTrue(success)
            XCTAssertEqual(LocalConfig.instance.surveyPack.survey.surveyId, "7498")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }

    func testGetSurveyInformation_WithEmptyId_ShouldReturnFalse() async throws {
        let expectation = XCTestExpectation(description: "API call completed")
        PulseInsightsAPI.getSurveyInformation(with: "") { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    // MARK: getQuestionDetail()
    func testGetQuestionDetail_WhenSuccessful_ShouldParseSurveyTickets() async throws {
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
        
        LocalConfig.instance.strCheckingSurveyID = "test-survey-123"
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertTrue(request.url?.path.contains("/surveys/test-survey-123/questions") ?? false)
            
            let urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
            XCTAssertNotNil(urlComponents?.queryItems?.first(where: { $0.name == "identifier" }))
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockResponse.data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "API call completed")
        PulseInsightsAPI.getQuestionDetail { success in
            XCTAssertTrue(success)
            XCTAssertFalse(LocalConfig.instance.surveyTickets.isEmpty)
            XCTAssertEqual(LocalConfig.instance.surveyTickets.count, 2)
            
            if LocalConfig.instance.surveyTickets.count > 0 {
                let firstQuestion = LocalConfig.instance.surveyTickets[0]
                XCTAssertEqual(firstQuestion.surveyId, "123")
                XCTAssertEqual(firstQuestion.content, "How would you rate our service?")
                XCTAssertEqual(firstQuestion.question_type, "single_choice_question")
                XCTAssertEqual(firstQuestion.possible_answers?.count, 3)
            }
            
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }

    func testGetQuestionDetail_WhenServerReturnsError_ShouldReturnFalse() async throws {
        LocalConfig.instance.strCheckingSurveyID = "test-survey-123"
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, "error".data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "API call completed")
        PulseInsightsAPI.getQuestionDetail { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    // MARK: postAnswers()
    func testPostAnswers_ShouldSendCorrectRequest() async throws {
        MockURLProtocol.requestHandler = { request in
            XCTAssertTrue(request.url?.path.contains("/submissions/") ?? false)
            XCTAssertTrue(request.url?.path.contains("/answer") ?? false)
            
            let urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
            XCTAssertNotNil(urlComponents?.queryItems?.first(where: { $0.name == "question_id" && $0.value == "q123" }))
            XCTAssertNotNil(urlComponents?.queryItems?.first(where: { $0.name == "answer_id" && $0.value == "a456" }))
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, "{}".data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "API call completed")
        PulseInsightsAPI.postAnswers("a456", strQuestionID: "q123", strQuestiontype: Define.piSurveyTypeSingleChoiseQuestion) { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    // MARK: postAllAtOnce()
    func testPostAllAtOnce_ShouldSendCorrectRequest() async throws {
        let testAnswers = [
            SurveyAnswer(
                question_id: "q1",
                question_type: Define.piSurveyTypeSingleChoiseQuestion,
                answer: "a1"
            ),
            SurveyAnswer(
                question_id: "q2",
                question_type: Define.piSurveyTypeFreeTextQuestion,
                answer: "text response"
            )
        ]
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertTrue(request.url?.path.contains("/submissions/") ?? false)
            XCTAssertTrue(request.url?.path.contains("/all_answers") ?? false)
            
            let urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
            XCTAssertNotNil(urlComponents?.queryItems?.first(where: { $0.name == "answers" }))
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, "{}".data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "API call completed")
        PulseInsightsAPI.postAllAtOnce(testAnswers) { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    // MARK: viewedAt()
    func testViewedAt_ShouldSendCorrectRequest() async throws {
        LocalConfig.instance.strSubmitID = "test-submission-456"
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertTrue(request.url?.path.contains("/submissions/test-submission-456/viewed_at") ?? false)
            
            let urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
            XCTAssertNotNil(urlComponents?.queryItems?.first(where: { $0.name == "identifier" }))
            XCTAssertNotNil(urlComponents?.queryItems?.first(where: { $0.name == "viewed_at" }))
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, "{}".data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "API call completed")
        PulseInsightsAPI.viewedAt { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }

    func testViewedAt_WhenServerReturnsError_ShouldReturnFalse() async throws {
        LocalConfig.instance.strSubmitID = "test-submission-456"
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, "error".data(using: .utf8)!)
        }
        
        let expectation = XCTestExpectation(description: "API call completed")
        PulseInsightsAPI.viewedAt { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
}

// Mock URL Protocol
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    static var completionHandler: (() -> Void)?
    
    override class func canInit(with request: URLRequest) -> Bool {
        print("MockURLProtocol.canInit called for URL: \(request.url?.absoluteString ?? "")")
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        print("MockURLProtocol.canonicalRequest called")
        return request
    }
    
    override func startLoading() {
        print("MockURLProtocol.startLoading called")
        guard let handler = MockURLProtocol.requestHandler else {
            print("No request handler available")
            fatalError("Handler is unavailable.")
        }
        
        do {
            let (response, data) = try handler(request)
            
            print("Sending mock response with status code: \(response.statusCode)")
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            print("Sending mock data: \(String(data: data, encoding: .utf8) ?? "")")
            client?.urlProtocol(self, didLoad: data)
            
            print("Finishing request")
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            print("Mock request failed with error: \(error)")
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        if let completionHandler = MockURLProtocol.completionHandler {
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
    
    override func stopLoading() {
        print("MockURLProtocol.stopLoading called")
    }
}
