//
//  SuperheroTrailerViewController.swift
//  Flixster
//
//  Created by Ashley Bedford on 6/30/20.
//  Copyright © 2020 Ashley Bedford. All rights reserved.
//

import UIKit
import WebKit

class SuperheroTrailerViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var movie: [String:Any]!
    var trailers: [[String:Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getTrailers()
        
    }
    
    func getTrailers() {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie["id"]!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // This will run when the network request returns
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let trailers = dataDictionary["results"] as! [[String:Any]]
                
                self.trailers = trailers

                let trailer = self.trailers![0]
                
                let trailerURLString = URL(string:  "https://www.youtube.com/watch?v=\(trailer["key"]!)")
                
                let request = URLRequest(url: trailerURLString!)
                
                self.webView.load(request)
                
                }
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
