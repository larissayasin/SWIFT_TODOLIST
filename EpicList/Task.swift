//
//  Task.swift
//  EpicList
//
//  Created by Larissa Gonçalves on 10/6/15.
//  Copyright © 2015 Larissa. All rights reserved.
//

import RealmSwift

class Task: Object {
    
    dynamic var id = 0
    dynamic var titulo = ""
    dynamic var descricao = ""
    dynamic var imagem:NSString?
    dynamic var categoria : Categoria?
    dynamic var data: NSDate?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
