//
//  Response.swift
//  ApollonAssignment
//
//  Created by Poonam on 13/08/21.
//

import Foundation

struct Response : Codable {
    var ok : Bool
    var result : ResponseResult
   
}

struct ResponseResult: Codable {
    var code : String
    var short_link : String;
    var full_short_link : String;
    var short_link2 : String;
    var full_short_link2 : String;
    var short_link3 : String;
    var full_short_link3 : String;
    var share_link : String;
    var full_share_link : String;
    var original_link : String;
    
   
}


