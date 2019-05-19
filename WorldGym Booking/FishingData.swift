//
//  FishingData.swift
//  WorldGym Booking
//
//  Created by 陳永展 on 2019/5/18.
//  Copyright © 2019 abc. All rights reserved.
//

import Foundation
class CWorkout{
    static let Workout = CWorkout()
    func upload(data: [String: Any] , finished:@escaping ((Bool)->())) {
        let apiStr = "https://sheetdb.io/api/v1/g7ltvq0lcl8j9"
        if let urlStr = apiStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            print(urlStr)
            var urlRequest = URLRequest(url:url)
            
            // Set request HTTP method to GET. It could be POST as well
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do{
                let data = try JSONSerialization.data(withJSONObject: data, options: [])
                let task = URLSession.shared.uploadTask(with: urlRequest, from: data, completionHandler:{(retData, res,err) in
                    if let returnData = retData, let dic = (try? JSONSerialization.jsonObject(with: returnData)) as? [String:String] {
                        print(dic)
                        finished(false)
                    }else{
                        finished(true)
                    }
                })
                task.resume()
            }catch{
                print(error)
            }
        }
    }
    func download(finish:@escaping (([CWorkoutOrder]?)->())) {
        var item = [CWorkoutOrder]()
        let apiStr = "https://sheetdb.io/api/v1/g7ltvq0lcl8j9"
        if let urlStr = apiStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            print(urlStr)
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in//另一個執行緒
                if let data = data
                {
                    do {
                        var i = 0
                        let Results = try JSONDecoder().decode(Array<WorkoutArr>.self, from: data)
                        for _ in Results{
                            let name = Results[i].name
                            let coach = Results[i].coach
                            let training = Results[i].training
                            let day = Results[i].day
//                            let time = Results[i].time
                            item.append(CWorkoutOrder(name: name, coach: coach, training: training, day: day))
                            i=i+1
                        }
                        print(Results)
                        if item.count != 0{
                            finish(item)
                        }else{
                            finish(nil)
                        }
                    }catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}
