//
//  MalKitTests.swift
//  MalKitTests
//
//  Created by nktn on 2017/07/17.
//  Copyright © 2017年 nktn. All rights reserved.
//

import XCTest
import MalKit
import OHHTTPStubs


class MalKitTests: XCTestCase {
    let m = MalKit.sharedInstance
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test1SetUpdata() {
        m.setUserData(userId: "a", passwd: "b")
    }
    
    func test2VerifyCredentialsTrue(){
        let expectation = self.expectation(description: "testVerifyCredentialsTrue")
        let stub_1:Data = "<?xml version=\"1.0\" encoding=\"utf-8\"?><user><id>1</id><username>Xinil</username></user>".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub_1, statusCode: 200, headers: ["Content-Type" : "application/xml"])
        }))
        
       m.verifyCredentials { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 200)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test3VerifyCredentialsFalse(){
        let expectation = self.expectation(description: "testVerifyCredentialsFalse")
        let stub:Data = "Invalid credential".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            //_myanimelist server resoponse 401
            return OHHTTPStubsResponse(data: stub, statusCode: 401, headers: ["Content-Type" : "text/html"])
        }))
        m.verifyCredentials { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 401)
            XCTAssertNotNil(err)
            XCTAssertNil(data)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test4SearchAnime(){
        let expectation = self.expectation(description: "testSearchAnime")
        let stub:Data = "<?xml version=\"1.0\" encoding=\"utf-8\"?><anime><entry><id>2889</id><title>Bleach - The DiamondDust Rebellion</title><english>Bleach: Diamond Dust Rebellion</english><synonyms>Bleach: The Diamond Dust Rebellion - M&Aring;Bleach - The DiamondDust Rebellion - Mou Hitotsu no Hyourinmaru</synonyms><episodes>1</episodes><type>Movie</type><status>Finished Airing</status><start_date>2007-12-22</start_date><end_date>2007-12-22</end_date><synopsis>A valuable artifact known as &amp;quot;King's Seal&amp;quot; is stolen by a mysterious group of people during transport in Soul Society. Hitsugaya Toushiro, the 10th division captain of Gotei 13, who is assigned to transport the seal fights the leader of the group and shortly after goes missing. After the incident, Seireitei declares Hitsugaya a traitor and orders the capture and execution of Hitsugaya. Kurosaki Ichigo refuses to believe this, and along with Matsumoto Rangiku, Kuchiki Rukia and Abarai Renji swear to uncover the real mastermind of the stolen seal, find Hitsugaya and clear his name. Meanwhile, a rogue Hitsugaya searches for the perpetrators and uncovers a dark secret regarding a long dead shinigami. (from ANN)</synopsis><image>https://myanimelist.cdn-dena.com/images/anime/6/4052.jpg</image></entry></anime>".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            //_myanimelist server resoponse 200
            return OHHTTPStubsResponse(data: stub, statusCode: 200, headers: ["Content-Type" : "application/xml"])
        }))
        
        m.searchAnime("bleach", completionHandler: { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 200)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test5SearchAnimeNoContents(){
        let expectation = self.expectation(description: "testSearchAnimeNoContents")
        let stub:Data = "".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 204, headers: ["Content-Type" : "application/xml"])
        }))
        
        m.searchAnime("aaaaaaaaaaaaaaaaaaa", completionHandler: { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 204)
            XCTAssertNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test6SearchManga(){
        let expectation = self.expectation(description: "testSearchManga")
        let stub:Data = "<?xml version=\"1.0\" encoding=\"utf-8\"?><anime><entry><id>2889</id><title>Bleach - The DiamondDust Rebellion</title><english>Bleach: Diamond Dust Rebellion</english><synonyms>Bleach: The Diamond Dust Rebellion - M&Aring;Bleach - The DiamondDust Rebellion - Mou Hitotsu no Hyourinmaru</synonyms><episodes>1</episodes><type>Movie</type><status>Finished Airing</status><start_date>2007-12-22</start_date><end_date>2007-12-22</end_date><synopsis>A valuable artifact known as &amp;quot;King's Seal&amp;quot; is stolen by a mysterious group of people during transport in Soul Society. Hitsugaya Toushiro, the 10th division captain of Gotei 13, who is assigned to transport the seal fights the leader of the group and shortly after goes missing. After the incident, Seireitei declares Hitsugaya a traitor and orders the capture and execution of Hitsugaya. Kurosaki Ichigo refuses to believe this, and along with Matsumoto Rangiku, Kuchiki Rukia and Abarai Renji swear to uncover the real mastermind of the stolen seal, find Hitsugaya and clear his name. Meanwhile, a rogue Hitsugaya searches for the perpetrators and uncovers a dark secret regarding a long dead shinigami. (from ANN)</synopsis><image>https://myanimelist.cdn-dena.com/images/anime/6/4052.jpg</image></entry></anime>".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 200, headers: ["Content-Type" : "application/xml"])
        }))
        
        m.searchManga("bleach", completionHandler: { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 200)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test7SearchMangaNoContents(){
        let expectation = self.expectation(description: "testSearchMangaNoContents")
        let stub:Data = "".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 204, headers: ["Content-Type" : "application/xml"])
        }))
        
        m.searchManga("aaaaaaaaaaaaaaaaaaa", completionHandler: { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 204)
            XCTAssertNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test8AddAnime(){
        let expectation = self.expectation(description: "testAddAnime")
        let stub:Data = "Created".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 200, headers: ["Content-Type" : "text/html"])
        }))
        m.addAnime(21, status: 1) { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 200)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test9AddAnimeFailed(){
        let expectation = self.expectation(description: "testAddAnimeFailed")
        let stub:Data = "400 Bad Request".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 400, headers: ["Content-Type" : "text/html"])
        }))
        m.addAnime(110000, status: 1) { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 400)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test10AddManga(){
        let expectation = self.expectation(description: "testAddManga")
        let stub:Data = "Created".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 200, headers: ["Content-Type" : "text/html"])
        }))
        m.addManga(21, status: 1) { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 200)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test11AddMangaFailed(){
        let expectation = self.expectation(description: "testAddMangaFailed")
        let stub:Data = "400 Bad Request".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 400, headers: ["Content-Type" : "text/html"])
        }))
        m.addManga(110000, status: 1) { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 400)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    
    func test12UpdateAnime(){
        let expectation = self.expectation(description: "testUpdateAnime")
        let stub:Data = "Updated".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 200, headers: ["Content-Type" : "text/html"])
        }))
        m.updateAnime(20, status: 1) { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 200)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })

    }
    
    func test13UpdateAnimeFailed(){
        let expectation = self.expectation(description: "testUpdateAnimeFailed")
        let stub:Data = "400 Bad Request".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 400, headers: ["Content-Type" : "text/html"])
        }))
        m.updateAnime(110000, status: 1) { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 400)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
        
    }
    
    func test14UpdateManga(){
        let expectation = self.expectation(description: "testUpdateManga")
        let stub:Data = "Updated".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 200, headers: ["Content-Type" : "text/html"])
        }))
        m.updateManga(20, status: 1) { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 200)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
        
    }
    
    func test15UpdateMangaFailed(){
        let expectation = self.expectation(description: "testUpdateMangaFailed")
        let stub:Data = "400 Bad Request".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 400, headers: ["Content-Type" : "text/html"])
        }))
        m.updateManga(110000, status: 1) { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 400)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test16DeleteAnime(){
        let expectation = self.expectation(description: "testDeleteAnime")
        let stub:Data = "Deleted".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 200, headers: ["Content-Type" : "text/html"])
        }))
        m.deleteAnime(20, completionHandler: { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 200)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test17DeleteAnimeFailed(){
        let expectation = self.expectation(description: "testDeleteAnimeFailed")
        let stub:Data = "400 Bad Request".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 400, headers: ["Content-Type" : "text/html"])
        }))
        m.deleteAnime(110000, completionHandler: { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 400)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test18DeleteManga(){
        let expectation = self.expectation(description: "testDeleteManga")
        let stub:Data = "Deleted".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 200, headers: ["Content-Type" : "text/html"])
        }))
        m.deleteManga(20, completionHandler: { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 200)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test19DeleteMangaFailed(){
        let expectation = self.expectation(description: "testDeleteMangaFailed")
        let stub:Data = "400 Bad Request".data(using: .utf8)!
        _ = OHHTTPStubs.stubRequests(passingTest: { (request: URLRequest) -> Bool in
            return true
        }, withStubResponse:( { (request: URLRequest!) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: stub, statusCode: 400, headers: ["Content-Type" : "text/html"])
        }))
        m.deleteManga(110000, completionHandler: { (data, res, err) in
            XCTAssertEqual(res?.statusCode, 400)
            XCTAssertNotNil(data)
            XCTAssertNil(err)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: {(error) -> Void in
            OHHTTPStubs.removeAllStubs()
            return
        })
    }
    
    func test20PerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
