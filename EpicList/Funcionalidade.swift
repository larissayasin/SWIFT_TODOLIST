//
//  FuncionalidadeEnum.swift
//  EpicList
//
//  Created by Larissa Gonçalves on 10/6/15.
//  Copyright © 2015 Larissa. All rights reserved.
//

import Foundation
enum Funcionalidade : String {
    case Foto = "Foto", Notificacao = "Notificacao", Email = "Email"
    
    static let allValues = [Foto, Notificacao, Email]
}