//
//  Users.swift
//  PHN Company Task
//
//  Created by Rachana Pandit on 23/12/22.
//

import Foundation

struct Response:Decodable
{
    var page:Int
    var per_page:Int
    var total:Int
    var total_pages:Int
    var data:[DataUser]
}

struct DataUser:Decodable{
    var id:Int
    var email:String
    var first_name:String
    var last_name:String
    var avatar:String
}
