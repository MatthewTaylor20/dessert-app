//
//  DessertData.swift
//  Desserts App
//
//  Created by Matthew Taylor on 3/6/23.
//

import Foundation

struct DessertData: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
