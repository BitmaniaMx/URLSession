//
//  ViewController.swift
//  URLSession
//
//  Created by Rafael González on 28/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        let url = URL(string: "https://httpstat.us/404")!
        //let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        var httpResponse = HTTPURLResponse()
        
        
        // Create a URLSession
        let session = URLSession.shared
        
        // Create a data task with a URL request
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Check for a valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                print("Invalid response")
                httpResponse = (response as? HTTPURLResponse)!
                print("statusCode: ", httpResponse.statusCode)
                return
            }
            
            // Check if there's data
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Parse and use the data
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print("JSON Data: \(json)")
                
            } catch {
                print("JSON parsing error: \(error)")
            }
        }
        
        // Start the task
        task.resume()
        
    }
   
}

