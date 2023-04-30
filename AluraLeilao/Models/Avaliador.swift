//
//  Avaliador.swift
//  Leilao
//
//  Created by Alura Laranja on 04/05/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import Foundation

enum ErroAvaliador: Error {
    case LeilaoSemNenhumLance(String)
}

class Avaliador {
    
    private var maiorDeTodos = Double.leastNonzeroMagnitude
    private var menorDeTodos = Double.greatestFiniteMagnitude
    
    private var maiores: [Lance] = []
    
    func avalia(leilao:Leilao) throws {
        
        if leilao.lances?.count == 0 {
            throw ErroAvaliador.LeilaoSemNenhumLance("Não é possível avaliar leilão sem lances")
        }
        
        guard let lances = leilao.lances else { return }
        
        for lance in lances {
            if lance.valor > maiorDeTodos {
                maiorDeTodos = lance.valor
            }
            if lance.valor < menorDeTodos {
                menorDeTodos = lance.valor
            }
        }
        
        pegaOsMaioresLancesNoLeilao(leilao)
    }
    
    func maiorLance() -> Double {
        return maiorDeTodos
    }
    
    func menorLance() -> Double {
        return menorDeTodos
    }
    
    private func pegaOsMaioresLancesNoLeilao(_ leilao: Leilao) {
        guard let lances = leilao.lances else { return }
        
        let lancesOrdenados = lances.sorted(by: { lance1, lance2 in
            return lance1.valor > lance2.valor
        })
        
        let maioresLances = lancesOrdenados.prefix(3)
        
        maiores = Array(maioresLances)
    }
    
    func tresMaiores() -> [Lance] {
        return maiores
    }
}
