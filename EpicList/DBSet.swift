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
    
    let realm = try! Realm()
    
    func populateCategoria(){
        let cTrabalho = Categoria()
        cTrabalho.descricao = "Trabalho"
        cTrabalho.isRemovivel = false
        
        let cSaude = Categoria()
        cSaude.descricao = "Saúde"
        cSaude.isRemovivel = false
        
        let cVida = Categoria()
        cVida.descricao = "Vida"
        cVida.isRemovivel = false
        
        realm.write{
            self.realm.add(cTrabalho)
            self.realm.add(cSaude)
            self.realm.add(cVida)
        }
    }
    
    func populateNivel(){
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
        
        realm.write{
            self.realm.add(nUm)
            self.realm.add(nDois)
            self.realm.add(nTres)
        }
    }
}