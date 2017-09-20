//
//  Postservice+PostType.swift
//  CapProject
//
//  Created by Yveslym on 9/20/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
struct newsTtype {
   static let classCancle = "Class cancel"
   static let classUpdate = "class update"
   static let roomChange = "room change"
   static let midtermUpdate = "midterm update"
   static let examUpdate = "exam update"
   static let other = "other"
}

struct RessourceType {
    static let  youtubeLink = "youtube link"
    static let wikiLink = "wikiLink"
    static let otherLink = "other link"
    static let attachement = "attachement"
}

struct AssignmentType{
    static let homework = "homework"
    static let quiz = "quiz"
    static let exam = "exam"
    static let exercies = "exercices"
}

struct PostType {
    let news : newsTtype
    let ressources: RessourceType
    let assignment : AssignmentType
}
