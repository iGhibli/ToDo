//
//  List.swift
//  ToDo
//
//  Created by iGhibli on 2020/11/29.
//

import UIKit

struct ListsModel {
    var icon: String = ""
    var title: String = ""
    var count: Int = 0
    var color: String = "red"
}

/*
enum ListIcon: String {
    case list = "list.bullet"
    case bookmark = "bookmark.fill"
    case mappin = "mappin"
    case gift = "gift.fill"
    case graduationcap = "graduationcap.fill"
    case doc = "doc.fill"
    case book = "book.fill"
    case creditcard = "creditcard.fill"
    case walk = "figure.walk"
    case stethoscope = "stethoscope"
    case pills = "pills.fill"
    case house = "house.fill"
    case building2 = "building.2.fill"
    case building = "building.columns.fill"
    case gamecontroller = "gamecontroller.fill"
    case headphones = "headphones"
    case leaf = "leaf.fill"
    case desktopcomputer = "desktopcomputer"
    case laptopcomputer = "laptopcomputer"
    case cart = "cart.fill"
    case airplane = "airplane"
    case tram = "tram.fill"
    case umbrella = "umbrella.fill"
    case sun = "sun.max.fill"
    case moon = "moon.fill"
    case snow = "snow"
    case flame = "flame.fill"
    case briefcase = "briefcase.fill"
    case terminal = "terminal.fill"
    case curlybraces = "curlybraces"
    case paintpalette = "paintpalette.fill"
}

let ListColor: [String: UIColor] = ["red": .red,
                                 "orange": .orange,
                                 "yellow": .yellow,
                                 "green": .green,
                                 "teal": .systemTeal,
                                 "blue": .blue,
                                 "purple": .purple,
                                 "pink": .systemPink,
                                 "indigo": .systemIndigo,
                                 "gray": .systemGray]
*/

let ListColorStr: [String] = ["red", "orange", "yellow", "green", "teal", "blue", "purple", "pink", "indigo", "gray"]
let ListColor: [UIColor] = [.red, .orange, .yellow, .green, .systemTeal, .blue, .purple, .systemPink, .systemIndigo, .systemGray]


let ListIcon: [String] = [
    "list.bullet",
    "bookmark.fill",
    "mappin",
    "gift.fill",
    "graduationcap.fill",
    "doc.fill",
    "book.fill",
    "creditcard.fill",
    "figure.walk",
    "stethoscope",
    "pills.fill",
    "house.fill",
    "building.2.fill",
    "building.columns.fill",
    "gamecontroller.fill",
    "headphones",
    "leaf.fill",
    "desktopcomputer",
    "laptopcomputer",
    "cart.fill",
    "airplane",
    "tram.fill",
    "umbrella.fill",
    "sun.max.fill",
    "moon.fill",
    "snow",
    "flame.fill",
    "briefcase.fill",
    "terminal.fill",
    "curlybraces",
    "paintpalette.fill"
]
