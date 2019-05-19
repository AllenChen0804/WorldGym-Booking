//
//  CourseOrder.swift
//  WorldGym Booking
//
//  Created by 陳永展 on 2019/5/18.
//  Copyright © 2019 abc. All rights reserved.
//

import Foundation
struct WorkoutArr:Codable {
    let name:String
    let coach:String
    let training:String
    let day:String
//    let time:String
}
class CWorkoutOrder{
    let name:String
    let coach:String
    let training:String
    let day:String
//    let time:String
    
    init(name:String , coach:String , training:String ,day:String) {
        self.name = name
        self.coach = coach
        self.training = training
        self.day = day
   
    }
}
