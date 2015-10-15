//
//  DBSet.swift
//  EpicList
//
//  Created by Larissa Gonçalves on 10/8/15.
//  Copyright © 2015 Larissa. All rights reserved.
//

import Foundation
import RealmSwift

class DBSet{
    
    //var realm = try! Realm()
    
    func populateCategoria() throws{
        let realm = try! Realm()
        let cTrabalho = Categoria()
        cTrabalho.descricao = "Trabalho"
        cTrabalho.isRemovivel = false
        
        let cSaude = Categoria()
        cSaude.descricao = "Saúde"
        cSaude.isRemovivel = false
        
        let cVida = Categoria()
        cVida.descricao = "Vida"
        cVida.isRemovivel = false
        
       try realm.write{
            realm.add(cTrabalho)
            realm.add(cSaude)
            realm.add(cVida)
        }
    }
    
    func populateNivel() throws{
        let realm = try! Realm()
        let nUm = Nivel()
        nUm.nroNivel = 1
        nUm.nroAtividades = 5
        nUm.funcionalidade = Funcionalidade.Foto.rawValue
        
        let nDois = Nivel()
        nDois.nroNivel = 2
        nDois.nroAtividades = 5
        nDois.funcionalidade = Funcionalidade.Email.rawValue
        
        
        let nTres = Nivel()
        nTres.nroNivel = 3
        nTres.nroAtividades = 10
        nTres.funcionalidade = Funcionalidade.Notificacao.rawValue
        
       try realm.write{
            realm.add(nUm)
            realm.add(nDois)
            realm.add(nTres)
        }
    }
}