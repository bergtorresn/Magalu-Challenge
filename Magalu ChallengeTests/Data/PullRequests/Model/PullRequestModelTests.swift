//
//  PullRequestModelTests.swift
//  Magalu ChallengeTests
//
//  Created by Rosemberg Torres on 28/10/24.
//

import XCTest

final class PullRequestModelTests: XCTestCase {
    
    func testInit() {
        let model = PullRequestModel(id: 1,
                                     title: "Fix pymdownx.emoji extension warning",
                                     body: "Fix pymdownx.emoji",
                                     url: "https://github.com/square/okhttp/pull/8559",
                                     createdAt: "2024-10-19T18:23:17Z",
                                     user: PullRequestUserModel(name: "jaredsburrows",
                                                                avatar: "https://avatars.githubusercontent.com/u/1739848?v=4"))
        
        XCTAssertEqual(model.id, 1)
        XCTAssertEqual(model.title, "Fix pymdownx.emoji extension warning")
        XCTAssertEqual(model.body, "Fix pymdownx.emoji")
        XCTAssertEqual(model.url, "https://github.com/square/okhttp/pull/8559")
        XCTAssertEqual(model.createdAt, "2024-10-19T18:23:17Z")
        XCTAssertEqual(model.user.name, "jaredsburrows")
        XCTAssertEqual(model.user.avatar, "https://avatars.githubusercontent.com/u/1739848?v=4")
    }
    
    func testDecodingWithCompleteJson() {
        let json = """
         {     "id": 1,
               "title": "Fix pymdownx.emoji extension warning",
               "user": {
                 "login": "jaredsburrows",
                 "avatar_url": "https://avatars.githubusercontent.com/u/1739848?v=4",
               },
               "html_url": "https://github.com/square/okhttp/pull/8559",
               "created_at": "2024-10-19T18:23:17Z",
               "body": "Fix pymdownx.emoji",
    }
    """.data(using: .utf8)!
        
        do {
            let model = try JSONDecoder().decode(PullRequestModel.self, from: json)
            XCTAssertEqual(model.id, 1)
            XCTAssertEqual(model.title, "Fix pymdownx.emoji extension warning")
            XCTAssertEqual(model.body, "Fix pymdownx.emoji")
            XCTAssertEqual(model.url, "https://github.com/square/okhttp/pull/8559")
            XCTAssertEqual(model.createdAt, "19/10/2024 ás 15:23:17")
            XCTAssertEqual(model.user.name, "jaredsburrows")
            XCTAssertEqual(model.user.avatar, "https://avatars.githubusercontent.com/u/1739848?v=4")
        } catch {
            XCTFail("Decoding failed with error \(error)")
        }
    }
    
    func testDecodingWithoutBodyValue() {
        let json = """
         {     "id": 1,
               "title": "Fix pymdownx.emoji extension warning",
               "user": {
                 "login": "jaredsburrows",
                 "avatar_url": "https://avatars.githubusercontent.com/u/1739848?v=4",
               },
               "html_url": "https://github.com/square/okhttp/pull/8559",
               "created_at": "2024-10-19T18:23:17Z",
               "body": null,
    }
    """.data(using: .utf8)!
        
        do {
            let model = try JSONDecoder().decode(PullRequestModel.self, from: json)
            XCTAssertEqual(model.id, 1)
            XCTAssertEqual(model.title, "Fix pymdownx.emoji extension warning")
            XCTAssertEqual(model.body, "")
            XCTAssertEqual(model.url, "https://github.com/square/okhttp/pull/8559")
            XCTAssertEqual(model.createdAt, "19/10/2024 ás 15:23:17")
            XCTAssertEqual(model.user.name, "jaredsburrows")
            XCTAssertEqual(model.user.avatar, "https://avatars.githubusercontent.com/u/1739848?v=4")
        } catch {
            XCTFail("Decoding failed with error \(error)")
        }
    }
    
    func testParseCreatedAtDateWithSuccess() {
        let expectedResult = "19/10/2024 ás 15:23:17"
        
        let model = PullRequestModel(id: 1,
                                     title: "Fix pymdownx.emoji extension warning",
                                     body: "Fix pymdownx.emoji",
                                     url: "https://github.com/square/okhttp/pull/8559",
                                     createdAt: "2024-10-19T18:23:17Z",
                                     user: PullRequestUserModel(name: "jaredsburrows",
                                                                avatar: "https://avatars.githubusercontent.com/u/1739848?v=4"))
        
        let dateFormatted = model.parseCreatedAtDate(dateFromJson: model.createdAt)
        
        XCTAssertEqual(dateFormatted, expectedResult)
    }
    
    func testParseCreatedAtDateErrorUseDefaultDate() {
        let model = PullRequestModel(id: 1,
                                     title: "Fix pymdownx.emoji extension warning",
                                     body: "Fix pymdownx.emoji",
                                     url: "https://github.com/square/okhttp/pull/8559",
                                     createdAt: "2024-10-19",
                                     user: PullRequestUserModel(name: "jaredsburrows",
                                                                avatar: "https://avatars.githubusercontent.com/u/1739848?v=4"))
        
        let dateFormatted = model.parseCreatedAtDate(dateFromJson: model.createdAt)
        
        XCTAssertEqual(dateFormatted, model.createdAt)
    }
}
