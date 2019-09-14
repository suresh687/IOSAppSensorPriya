//
//  PSensorTableViewController.swift
//  SensorAppPriya
//
//  Created by Suresh on 9/14/19.
//  Copyright © 2019 Priya. All rights reserved.
//

import UIKit
import CoreData

class PSensorTableViewController: UITableViewController,UINavigationControllerDelegate {
    
    //var items = [["id":"1","name":"A","desc":"Sensor1"],["id":"2","name":"B","desc":"Sensor2"]]
    var items = [Sensor]()
    var managedObjectContext:NSManagedObjectContext!
   // var indextoEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadSensorData()
        
    }
    func loadSensorData()
    {
        let sensorRequest:NSFetchRequest<Sensor> = Sensor.fetchRequest()
        do{
           items = try managedObjectContext.fetch(sensorRequest)
            self.tableView.reloadData()
        }catch{
            print("Count not load the data")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 100
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
  //  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //    if editingStyle==UITableViewCellEditingStyle.delete{
      //      managedObjectContext.delete(self.items[indexPath.row])
        //    self.loadSensorData()
        //}
        
    //}
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete"){(action,indexPath) in
            self.managedObjectContext.delete(self.items[indexPath.row])
            self.loadSensorData()
            
        }
        let Edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.updateSensor(ind: indexPath.row)
            
        }
          //  self.managedObjectContext.delete(self.items[indexPath.row])
            
            
        
        //self.loadSensorData()
        return [delete,Edit]
        
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PSensorTableViewCell
        let itemObject = items[indexPath.row]
        cell.IDLabel.text = itemObject.id
        cell.NameLabel.text = itemObject.name
        cell.DescriptionLabel.text = itemObject.desc
        //indextoEdit = indexPath.row

        // Configure the cell...

        return cell
    }
    
    @IBAction func addSensor(_ sender: Any) {
        self.addPage()
        
    }
    func updateSensor(ind : Int)
    {
        
        //let sensorItem = Sensor(context: managedObjectContext)
        
        let inputAlert = UIAlertController(title: "Sensor Details", message: "Update Sensor Id,Name,Description", preferredStyle: .alert)
        //print(ind)
       // print(items[ind].name)
        let sensorUpdate = items[ind] as NSManagedObject
        
             inputAlert.addTextField{(textfield:UITextField) in textfield.placeholder = "ID"
            textfield.text = self.items[ind].id
        }
        inputAlert.addTextField{(textfield:UITextField) in textfield.placeholder = "Name"
            textfield.text = self.items[ind].name
        }
        inputAlert.addTextField{(textfield:UITextField) in textfield.placeholder = "Description"
            textfield.text = self.items[ind].desc
        }
        inputAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: {(action:UIAlertAction) in
            let IDtextfield = inputAlert.textFields?.first
            let Nametextfield = inputAlert.textFields![1]
            let Desctextfield = inputAlert.textFields?.last
            if IDtextfield?.text != "" && Nametextfield.text != "" && Desctextfield?.text != "" {
                //print("HI")
                //sensorItem.id = IDtextfield?.text
                
                let n = Nametextfield.text
                //sensorItem.name = n
                //print("Name:\(n)")
                //sensorItem.desc = Desctextfield?.text
                sensorUpdate.setValue(IDtextfield?.text, forKey: "id")
                sensorUpdate.setValue(n, forKey: "name")
                sensorUpdate.setValue(Desctextfield?.text, forKey: "desc")
                do{
                    try self.managedObjectContext.save()
                    self.loadSensorData()
                }catch{
                    print("could not save")
                }
                
            }
        }))
        inputAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(inputAlert, animated: true, completion: nil)
    }
    
    func addPage()
    {
        let sensorItem = Sensor(context: managedObjectContext)
        let inputAlert = UIAlertController(title: "Sensor Details", message: "Enter Sensor Id,Name,Description", preferredStyle: .alert)
        inputAlert.addTextField{(textfield:UITextField) in textfield.placeholder = "ID"
        }
        inputAlert.addTextField{(textfield:UITextField) in textfield.placeholder = "Name"
        }
        inputAlert.addTextField{(textfield:UITextField) in textfield.placeholder = "Description"
        }
        inputAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: {(action:UIAlertAction) in
            let IDtextfield = inputAlert.textFields?.first
            let Nametextfield = inputAlert.textFields![1]
            let Desctextfield = inputAlert.textFields?.last
            if IDtextfield?.text != "" && Nametextfield.text != "" && Desctextfield?.text != "" {
                print("HI")
                sensorItem.id = IDtextfield?.text
                
                let n = Nametextfield.text
                sensorItem.name = n
                //print("Name:\(n)")
                sensorItem.desc = Desctextfield?.text
                do{
                    try self.managedObjectContext.save()
                    self.loadSensorData()
                }catch{
                    print("could not save")
                }
                
            }
        }))
        inputAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(inputAlert, animated: true, completion: nil)    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
