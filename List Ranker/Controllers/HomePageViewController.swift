//
//  HomePageViewController.swift
//  List Ranker
//
//  Created by Daniel Rivera on 3/11/21.
//  Copyright © 2021 Daniel Rivera. All rights reserved.
//

import UIKit
import RealmSwift

class HomePageViewController: UIViewController {
    
    

    @IBOutlet weak var listImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print()
        testRealm()

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        listImageView.isUserInteractionEnabled = true
        listImageView.addGestureRecognizer(imageTap)
    
    }
    
    @objc func imageTapped() {
        performSegue(withIdentifier: "gotoOptions", sender: self)
    }

    // Upload default lists if Realm has no data.
    
    func testRealm(){
    
        do{
            let realm = try Realm()
            let realmResults = realm.objects(SavedList.self)
                   if realmResults.count == 0 {
                       createDefaultLists()
                   }
            
        } catch {
            print("Error connecting to realm, \(error)")
        }
       
        
    }
    
    func createDefaultLists(){
        let mcuMovies = ["Iron Man","The Incredible Hulk","Thor","Iron Man 2","Captain America:vThe First Avenger","THe Avengers","Iron Man 3","Thor: The Dark World","Captain America: The Winter Soldier","Guardians of the Galaxy","Avengers: Age of Ultron","Ant-Man","Captain America: Civil War","Doctor Strange","Guardians of the Galaxy Vol. 2","Spider-Man: Homecoming","Thor: Ragnarok","Black Panther","Avengers: Infinity War","Ant-Man and the Wasp","Captain Marvel","Avengers: Endgame","Spider-Man: Far from Home"]
        let mcuMoviesTitle = "MCU Movies"
        
        let starwarsMovies = ["The Phantom Menance","Attack of the Clones","Revenge of the Sith","A New Hope","Empire Strikes Back","Return of the Jedi","The Force Awakens","The Last Jedi","The Rise of Skywalker","Rogue One","Solo: A Star Wars Story","The Clone Wars"]
        
        let starwarsMoviesTitle = "Star Wars Movies"

        let mcu = SavedList()
        mcu.listName = mcuMoviesTitle
        for movie in mcuMovies {
            mcu.listItems.append(movie)
        }
        let starwars = SavedList()
        starwars.listName = starwarsMoviesTitle
        
        for movie in starwarsMovies {
            starwars.listItems.append(movie)
        }
        
       
        do{
            let realm = try Realm()
            try realm.write {
                realm.add(mcu)
                realm.add(starwars)
            }
        } catch {
            print("Error connecting to realm, \(error)")
        }
        
        
        
    }

}
