//
//  AluraLeilaoTests.swift
//  AluraLeilaoTests
//
//  Created by Jose Luis Damaren Junior on 25/04/23.
//

import XCTest
@testable import AluraLeilao

final class AluraLeilaoTests: XCTestCase {
    
    private var joao: Usuario!
    private var jose: Usuario!
    private var maria: Usuario!
    private var leiloeiro: Avaliador!

    override func setUpWithError() throws {
        leiloeiro = Avaliador()
        jose = Usuario(nome: "José")
        maria = Usuario(nome: "Maria")
        joao = Usuario(nome: "Joao")
    }

    override func tearDownWithError() throws {
    }
    
    func testDeveReceberUmLance() {
        let leilao = Leilao(descricao: "Play 5")
        XCTAssertEqual(0, leilao.lances?.count)
        leilao.propoe(lance: Lance(joao, 2000))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
    }
    
    func testDeveReceberVariosLances() {
        let leilao = Leilao(descricao: "Play 5")
        XCTAssertEqual(0, leilao.lances?.count)
        
        leilao.propoe(lance: Lance(joao, 2000))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
        
        leilao.propoe(lance: Lance(jose, 3000))
        
        XCTAssertEqual(2, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
        XCTAssertEqual(3000, leilao.lances?[1].valor)
    }
    
    func testDeveIgnorarDoisLancesSeguidosDoMesmoUser() {
        let leilao = Leilao(descricao: "Macbook Pro 16")
        
        leilao.propoe(lance: Lance(maria, 2000))
        leilao.propoe(lance: Lance(maria, 3000))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
    }
    
    func testDeveIgnorarMaisDeCincoLancesDoMesmoUsuario() {
        let leilao = Leilao(descricao: "Macbook Pro 16 - M1")
        
        leilao.propoe(lance: Lance(jose, 2000))
        leilao.propoe(lance: Lance(maria, 3000))
        
        leilao.propoe(lance: Lance(jose, 4000))
        leilao.propoe(lance: Lance(maria, 5000))
        
        leilao.propoe(lance: Lance(jose, 6000))
        leilao.propoe(lance: Lance(maria, 7000))
        
        leilao.propoe(lance: Lance(jose, 8000))
        leilao.propoe(lance: Lance(maria, 9000))
        
        leilao.propoe(lance: Lance(jose, 10000))
        leilao.propoe(lance: Lance(maria, 11000))
        
        // deve ignorar
        leilao.propoe(lance: Lance(jose, 12000))
        
        XCTAssertEqual(10, leilao.lances?.count)
        XCTAssertEqual(11000, leilao.lances?.last?.valor)
    }

}
