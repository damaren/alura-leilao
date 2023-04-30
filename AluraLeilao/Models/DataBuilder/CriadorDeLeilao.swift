//
//  CriadorDeLeilao.swift
//  AluraLeilao
//
//  Created by Jose Luis Damaren Junior on 26/04/23.
//

import UIKit

class CriadorDeLeilao: NSObject {
    
    private var leilao: Leilao!
    
    func para(descricao: String) -> Self {
        leilao = Leilao(descricao: descricao)
        return self
    }
    
    func lance(_ usuario: Usuario, _ valor: Double) -> Self {
        leilao.propoe(lance: Lance(usuario, valor))
        
        return self
    }
    
    func constroi() -> Leilao {
        return leilao
    }
}
