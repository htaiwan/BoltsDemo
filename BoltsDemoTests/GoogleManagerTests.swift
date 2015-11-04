//
//  GoogleManagerTests.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/4/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import XCTest
@testable import BoltsDemo

class GoogleManagerTests: XCTestCase {
    
    let manager = GoogleManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testLogoutAddress3Fail() {
        let expectation = expectationWithDescription("尚未登入，此API呼叫失敗")
        
        manager.getAddress3(adderss: "台北市內湖區民權東路6段280巷155弄213號6樓之21") { (error, result) -> () in
            if error == nil {
                XCTFail() // 不應該成功
            } else {
                expectation.fulfill() // 達到我們預期的失敗
            }
        }
        
        // 等待Asyn Tasks回覆
        waitForExpectationsWithTimeout(3.0, handler: nil)
    }
    
    

    func testLoginGetAddress3Fail() {
        
        // 建立一個mockup Object假設登入成功
        class MockGoogleManager: GoogleManager {
            override var isLogin: Bool {
                return true
            }
        }
        
        let manager = MockGoogleManager()
        let expectation = expectationWithDescription("登入，但輸入不正確address，此API呼叫失敗")
        
        manager.getAddress3(adderss: "") { (error, result) -> () in
            if error == nil {
                XCTFail() // 不應該要成功
            } else {
                expectation.fulfill() // 達到我們預期的失敗
            }
        }
        
        // 等待Asyn Task回覆
        waitForExpectationsWithTimeout(3.0, handler: nil)
        
    }
    
    func testLoginGetAddress3Success() {
        
        // 建立一個mockup Object假設登入成功
        class MockGoogleManager: GoogleManager {
            override var isLogin: Bool {
                return true
            }
        }
        
        let manager = MockGoogleManager()
        let expectation = expectationWithDescription("登入，輸入正確address，此API呼叫成功")
        
        manager.getAddress3(adderss: "台北市內湖區民權東路6段280巷155弄213號6樓之21") { (error, result) -> () in
            if error == nil {
                expectation.fulfill()  // 達到我們預期成功
            } else {
                XCTFail() // 不應該要失敗
            }
        }
        
        // 等待Asyn Task回覆
        waitForExpectationsWithTimeout(3.0, handler: nil)
        
    }

    
}
