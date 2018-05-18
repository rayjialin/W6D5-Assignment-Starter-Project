//
//  w6d5_ui_performance_testing.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by ruijia lin on 5/18/18.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest
@testable import w6d5_ui_performance_testing

class w6d5_ui_performance_testingPerformanceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        //        deleteAllMeal()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            PerformanceDataModel.doSomething()
            
            let mealName = "Burger"
            let numberOfCalories = 300
            
            addMeal(mealname: mealName, numberOfCalories: numberOfCalories)
            deleteMeal(mealName: mealName, numberOfCalories: numberOfCalories)
            
        }
        
        
        
    }
    
    // add a meal
    func addMeal(mealname: String, numberOfCalories: Int) {
        let app = XCUIApplication()
        app.navigationBars["Master"].buttons["Add"].tap()
        
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealname)
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText(String(numberOfCalories))
        addAMealAlert.buttons["Ok"].tap()
    }
    
    // delete a meal
    func deleteMeal(mealName: String, numberOfCalories: Int){
        let app = XCUIApplication()
        let staticText = app.tables.staticTexts["\(mealName) - \(String(numberOfCalories))"]
        staticText.swipeLeft()
        app.tables.buttons["Delete"].tap()
    }
    
    func deleteAllMeal(){
        let app = XCUIApplication()
        let tablesQuery = app.tables.cells
        while tablesQuery.count != 0{
            tablesQuery.element(boundBy: 0).swipeLeft()
            tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
        }
    }
    
}
