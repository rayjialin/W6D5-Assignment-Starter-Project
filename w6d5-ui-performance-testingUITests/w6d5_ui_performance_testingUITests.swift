//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by ruijia lin on 5/17/18.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        deleteAllMeal()
        
    }
    
    func testAddMeal(){
        let mealName = "Burger"
        let numberOfCalories = 300
        
        addMeal(mealname: mealName, numberOfCalories: numberOfCalories)
    }
    
    func addMeal(mealname: String, numberOfCalories: Int) {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
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
    
    func testShowMealDetail(){
        let mealName = "Burger"
        let numberOfCalories = 300
        
        showMealDetail(mealName: mealName, numberOfCalories: numberOfCalories)
        
    }
    
    func testDeleteAMeal(){
        let mealName = "Burger"
        let numberOfCalories = 300
        
        deleteMeal(mealName: mealName, numberOfCalories: numberOfCalories)
    }
    
    func deleteAllMeal(){
        let app = XCUIApplication()
        let tablesQuery = app.tables.cells
        while tablesQuery.count != 0{
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
        }
        
//        XCTAssert(tablesQuery.count == 0)
    }
    
    func deleteMeal(mealName: String, numberOfCalories: Int){
        let app = XCUIApplication()
        let staticText = app.tables.staticTexts["\(mealName) - \(String(numberOfCalories))"]
        staticText.swipeLeft()
        app.tables.buttons["Delete"].tap()
    }
    
    func showMealDetail(mealName: String, numberOfCalories: Int){
        let staticText = "\(mealName) - \(String(numberOfCalories))"
        let app = XCUIApplication()
        app.tables.staticTexts[staticText].tap()
        let detailMeal = app.staticTexts["detailMeal"].label
        XCTAssert(detailMeal == staticText, "Expected to  be displaying detail meal")
        app.navigationBars["Detail"].buttons["Master"].tap()
    }
    
}
