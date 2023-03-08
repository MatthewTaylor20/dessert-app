//
//  Desserts_AppTests.swift
//  Desserts AppTests
//
//  Created by Matthew Taylor on 3/6/23.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import Desserts_App

final class Desserts_AppTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testParseDessertJSON() {
        let dessertManager = DessertManager()
        do {
            let desserts = dessertManager.parseDessertJSON(try Data(contentsOf: URL(filePath: "StubbedDessert")))
            let expectedResult = [
                DessertModel(name: "Apam balik", imageURL: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!, iD: "53049"),
                DessertModel(name: "Apple & Blackberry Crumble", imageURL: URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")!, iD: "52893"),
                DessertModel(name: "Apple Frangipan Tart", imageURL: URL(string: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg")!, iD: "52768"),
                DessertModel(name: "Bakewell tart", imageURL: URL(string: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg")!, iD: "52767")
            ]
            XCTAssertEqual(desserts, expectedResult)
        }catch {
            print(error)
        }
    }
    
    func testParseRecipeJSON() {
        let recipeManager = RecipeManager()
        do {
            let recipe = recipeManager.parseRecipeJSON(try Data(contentsOf: URL(filePath: "StubbedRecipe")))
            let expectedResult = RecipeModel(
                name: "Bakewell tart",
                imageURL: URL(string: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg")!,
                iD: "52767",
                ingredients: "• plain flour: 175g/6oz\n• chilled butter: 75g/2½oz\n• cold water: 2-3 tbsp\n• raspberry jam: 1 tbsp\n• butter: 125g/4½oz\n• caster sugar: 125g/4½oz\n• ground almonds: 125g/4½oz\n• free-range egg, beaten: 1\n• almond extract: ½ tsp\n• flaked almonds: 50g/1¾oz\n",
                instructions: "To make the pastry, measure the flour into a bowl and rub in the butter with your fingertips until the mixture resembles fine breadcrumbs. Add the water, mixing to form a soft dough.\r\nRoll out the dough on a lightly floured work surface and use to line a 20cm/8in flan tin. Leave in the fridge to chill for 30 minutes.\r\nPreheat the oven to 200C/400F/Gas 6 (180C fan).\r\nLine the pastry case with foil and fill with baking beans. Bake blind for about 15 minutes, then remove the beans and foil and cook for a further five minutes to dry out the base.\r\nFor the filing, spread the base of the flan generously with raspberry jam.\r\nMelt the butter in a pan, take off the heat and then stir in the sugar. Add ground almonds, egg and almond extract. Pour into the flan tin and sprinkle over the flaked almonds.\r\nBake for about 35 minutes. If the almonds seem to be browning too quickly, cover the tart loosely with foil to prevent them burning.")
            
            XCTAssertEqual(recipe, expectedResult)
        }catch {
            print(error)
        }
    }
    

    
    
    
    

}
