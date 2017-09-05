//
//  PokemonTableViewController.swift
//  session3
//
//  Created by Aashita on 9/5/17.
//  Copyright © 2017 aashita. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let json = getJSON() //fetched the data
        self.pokemons = jsonToPokemon(data: json) //changed json data to pokemon objects
      //  for p in pokemons{
        //    print("\(p.name) \(p.imageURL)")
        //}
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    //converts json array to array of Pokemon (the new class) models
    func jsonToPokemon(data: [Any]) -> [Pokemon] {
        
        var pokemons:[Pokemon] = [] //array of all pokemons
        
        for p in data {
            var obj = p as! Dictionary<String, Any>
            //parse out the attributes interested in 
            
            let name = obj["name"] as! String
            let url = obj["img"] as! String
            
            let pokemon = Pokemon(name: name, imageURL: url)
            pokemons.append(pokemon) //add each object into array
        }
        
        return pokemons //return array
    }
    
    func getJSON() -> [Any] {
        //open file -> string rep of data
        //serialize into JSON/dictionary to parse
        //return serialized data
        
        if let filePath = Bundle.main.path(forResource: "pokedex", ofType: "json"){ //loaded file
            if let data = NSData(contentsOfFile: filePath) { //loaded file into bites data
                do {
                    let json = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String: Any] //serializing file
                    return json["pokemon"] as! [Any] //only want the pokemon array, return json objects
                } catch let error as NSError {
                    print("Error while loading json file.")
                    print(error.description)
                    return []; //if there is error print error
                }
            }
        }
       
        return [];
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows
        return self.pokemons.count //number of objects in pokemon array
    }

    
    
    //for each cell made in table view, this function is called
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath) //getting the cell

        // Configure the cell...

        let pokemon = self.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        do {
            let imageUrl = pokemon.imageURL
            let imageData = try Data(contentsOf: imageUrl)
            cell.imageView?.image = UIImage(data: imageData)
        } catch {
            print("can't load image URL")
        }

        
        return cell
    }
 
    
    

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
