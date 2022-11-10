//
//  Mobiliario.swift
//  CRUDMobiliario
//
//  Created by Roberto Marco García Hernández on 09/11/22.
//

import Foundation

struct Mobiliario: Identifiable {
    var id: Int
    var nombre: String
    var precioUnitario: Double
    var existencia: Int
    var categoria: String
    
    init(id: Int, nombre: String, precioUnitario: Double, existencia: Int, categoria: String) {
        self.id = id
        self.nombre = nombre
        self.precioUnitario = precioUnitario
        self.existencia = existencia
        self.categoria = categoria
    }
    
}
