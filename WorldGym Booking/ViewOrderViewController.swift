//
//  ViewOrderViewController.swift
//  WorldGym Booking
//
//  Created by 陳永展 on 2019/5/16.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

class ViewOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    
    
    @IBOutlet weak var tableview: UITableView!
    
    var item=[CWorkoutOrder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         download()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func download(){
//        self.activityIndicator.isHidden = false
//        self.activityIndicator.startAnimating()
        CWorkout.Workout.download(finish: {item in
            if let item = item{
                self.item = item
                DispatchQueue.main.async {
                    self.tableview.reloadData()
//                    self.activityIndicator.stopAnimating()
//                    self.activityIndicator.isHidden=true
                }
            }
        })
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func refreshBtn(_ sender: Any) {
        download()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CourseViewCell else{return UITableViewCell()}
        cell.name.text = item[indexPath.row].name
        cell.coach.text = item[indexPath.row].coach
        cell.training.text = item[indexPath.row].training
        cell.day.text = item[indexPath.row].day
        
        return cell
    }
}
