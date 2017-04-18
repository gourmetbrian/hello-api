//
//  Controller.swift
//  hello-api
//
//  Created by Brian Lane on 4/17/17.
//
//

import Foundation
import Kitura
import SwiftyJSON
import LoggerAPI
import CloudFoundryEnv
import Configuration

public class Controller {
    
    let router: Router
    let appEnv: ConfigurationManager
    var url: String {
        get { return appEnv.url }
    }
    
    var port: Int {
        get { return appEnv.port }
    }
    
    let vehicleArray: [Dictionary<String, Any> ] = [
        ["make":"Nissan", "model": "Murano", "year": 2017],
        ["make":"Nissan", "model": "Rogue", "year": 2017],
        ["make":"Dodge", "model": "Ram", "year": 2012]
    ]
    
    init() throws {
        appEnv = try ConfigurationManager()
        
        router = Router()
        
        router.get("/", handler: getMain)
        router.get("/vehicles", handler: getAllVehicles)
    }
    
    public func getMain(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        Log.debug("GET - / router handler...")
        var json = JSON([:])
        json["course"].stringValue = "Beginner APIs with Swift, Kitura, and Bluemix"
        json["myName"].stringValue = "Brian Lane"
        json["company"].stringValue = "com.bwlane"
        
        try response.status(.OK).send(json: json).end()
    }
    
    public func getAllVehicles(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        let json = JSON(vehicleArray)
        try response.status(.OK).send(json: json).end()
    }
    
    
}
