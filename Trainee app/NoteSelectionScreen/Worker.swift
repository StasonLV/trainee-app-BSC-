//
//  Worker.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 14.05.2022.
//

import Foundation

protocol WorkerType {
    var session: URLSession { get }
    func fetch()
}

class Worker: WorkerType {
    let session: URLSession
    
    init (session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func fetch() {
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/ios-test-ce687.appspot.com/o/Empty.json?alt=media&token=d07f7d4a-141e-4ac5-a2d2-cc936d4e6f18")!
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let json = String(data: data, encoding: .utf8)
            print(json ?? "")
        }
        task.resume()
    }
    
    
}
