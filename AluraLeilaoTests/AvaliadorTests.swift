//
//  AvaliadorTests.swift
//  AluraLeilaoTests
//
//  Created by Jose Luis Damaren Junior on 25/04/23.
//

import XCTest
@testable import AluraLeilao

final class AvaliadorTests: XCTestCase {
    
    private var joao: Usuario!
    private var jose: Usuario!
    private var maria: Usuario!
    private var leiloeiro: Avaliador!

    override func setUpWithError() throws {
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
        leiloeiro = Avaliador()
    }

    override func tearDownWithError() throws {
    }
    
    func testDeveEntenderLancesEmOrdemCrescente() {
        // Cenario
        
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(maria, 250.0))
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(jose, 400.0))
        
        // Acao
        
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        
        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }
    
    func testDeveEntenderLeilaoComApenasUmLance() {
        let leilao = Leilao(descricao: "Play 4")
        leilao.propoe(lance: Lance(joao, 1000.0))
        
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }
    
    func testDeveEncontrarOsTresMaioresLances() {
        
        let leilao = CriadorDeLeilao().para(descricao: "Play 5")
            .lance(joao, 300)
            .lance(maria, 400)
            .lance(joao, 500)
            .lance(maria, 600)
            .constroi()
        
        try? leiloeiro.avalia(leilao: leilao)
        
        let listaDeLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaDeLances.count)
        XCTAssertEqual(600.0, listaDeLances[0].valor)
        XCTAssertEqual(500.0, listaDeLances[1].valor)
        XCTAssertEqual(400.0, listaDeLances[2].valor)
    }
    
    func testDeveIgnorarLeilaoSemNenhumLance() {
        let leilao = CriadorDeLeilao().para(descricao: "Play5").constroi()
        
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possível avaliar leilão sem lances", { error in
            print(error.localizedDescription)
        })
    }

}
