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
       // nUm.funcionalidade = Funcionalidade.Foto
        
        
        
    }
}
/*

private void populateNivel(){
Realm realm = Realm.getDefaultInstance();
realm.beginTransaction();
Nivel nImagem = realm.createObject(Nivel.class);
nImagem.setFuncionalidade(FuncionalidadeEnum.INCLUIR_FOTO.toString());
nImagem.setNroNivel(2);
nImagem.setNroAtividades(5);
nImagem.setTexto("Agora você pode adicionar imagens a suas notas!");

Nivel nCalendario = realm.createObject(Nivel.class);
nCalendario.setFuncionalidade(FuncionalidadeEnum.ADICIONAR_CALENDARIO.toString());
nCalendario.setNroNivel(3);
nCalendario.setNroAtividades(10);
nCalendario.setTexto("Agora você pode adicionar data a suas notas!");
realm.commitTransaction();

}
*/