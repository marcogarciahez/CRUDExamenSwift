//
//  ContentView.swift
//  CRUDExamenMobiliario
//
//  Created by Roberto Marco García Hernández on 10/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var coreDM: CoreDataManager
    @State var arrayMobiliario = [Mobiliario]()
    var body: some View {
        ZStack{
            NavigationView(){
                VStack{
                    Text("Lista de mobiliario")
                        .font(.title)
                        .bold()
                    List{
                        ForEach(arrayMobiliario, id: \.self){
                            mobiliario in
                            HStack{
                                Text(mobiliario.nombre ?? "")
                                Spacer()
                                HStack{
                                    NavigationLink(destination: EditarView(coreDM: coreDM, mobiliario: mobiliario)) {
                                    }
                                    
                                }
                            }
                            
                        }
                        .onDelete(perform: {
                            indexSet in indexSet.forEach({
                                index in
                                let mobiliario = arrayMobiliario[index]
                                coreDM.borrarMobiliario(mobiliario: mobiliario)
                            })
                        })
                    }
                    Button {
                        coreDM = CoreDataManager()
                        arrayMobiliario = coreDM.obtenerMobiliario()
                    } label: {
                        Text("Recargar lista")
                    }.padding()

                    NavigationLink("Nuevo mobiliario", destination: GuardarView(coreDM: coreDM))

                }
            }
            .onAppear{
                coreDM = CoreDataManager()
                arrayMobiliario = coreDM.obtenerMobiliario()
            }
        }
    }
    
    /*func delete(at offsets: IndexSet) {
        coreDM.borrarMobiliario(mobiliario: )
        }*/
    
    
  /*  @State var arrayMobiliario = [Mobiliario(id: 1, nombre: "Silla Tecate", precioUnitario: 100, existencia: 6, categoria: "Sillas"), Mobiliario(id: 2, nombre: "Mesa blanca larga", precioUnitario: 200, existencia: 2, categoria: "Mesas"), Mobiliario(id: 3, nombre: "Silla romana", precioUnitario: 100, existencia: 12, categoria: "Sillas"), Mobiliario(id: 4, nombre: "Sillon puff", precioUnitario: 200, existencia: 6, categoria: "Sillon"), Mobiliario(id: 5, nombre: "Mesa de marmol", precioUnitario: 200, existencia: 6, categoria: "Mesas")]*/
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}


struct EditarView: View {
    let coreDM: CoreDataManager
    @State var mobiliario: Mobiliario
    //@State var id: Int = 0
    @State var nombre: String = ""
    @State var precio: Float = 0
    @State var existencia: Int = 0
    @State var categoria: String = ""
    @State var arrayCategorias = ["Sillas","Mesas","Sillon","Cocina"]
    private let numberFormatter = NumberFormatter()
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                Text("Editar")
                    .font(.title)
                    .bold()
                Text("Nombre:")
               TextField(nombre, text: $nombre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Precio")
                TextField("", value: $precio, formatter: numberFormatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                Stepper("Existencias: " + String(existencia),value: $existencia, in: 0...130)
               // Text("Categoria:")
                HStack{
                    Spacer()
                    Text("Selecciona una categoria:")
                    Picker(selection: $categoria, label: Text("Categoria:")) {
                        Text("Sillas").tag("Silla")
                        Text("Mesas").tag("Mesas")
                        Text("Sillon").tag("Sillon")
                        Text("Cocina").tag("Cocina")
                    }
                    Spacer()
                }
                HStack{
                    Spacer()
                    Button {
                        mobiliario.nombre = nombre
                        mobiliario.precioUnitario = precio
                        mobiliario.existencia = Int64(existencia)
                        mobiliario.categoria = categoria
                        print(mobiliario)
                        coreDM.actualizarMobiliario(mobiliario: mobiliario)
                    } label: {
                        Text("Actualizar mobiliario")
                    }
                    Spacer()
                }
                
            }
            .padding()
        }.onAppear{
            numberFormatter.numberStyle = .currency
            numberFormatter.maximumFractionDigits = 2
            nombre = mobiliario.nombre!
            precio = mobiliario.precioUnitario
            existencia = Int(mobiliario.existencia)
            categoria = mobiliario.categoria!
            
        }
    }
}

struct GuardarView: View {
    @State var nombre: String = ""
    @State var precio: Float = 0
    @State var existencia: Int = 0
    @State var id: Int = 0
    @State var categoria: String = ""
    @State var arrayCategorias = ["Sillas","Mesas","Sillon","Cocina"]
    private let numberFormatter = NumberFormatter()
    let coreDM: CoreDataManager
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                Text("Nuevo mobiliario")
                    .font(.title)
                    .bold()
                Stepper("ID: " + String(id),value: $id, in: 0...130)
                Text("Nombre:")
                
                TextField("", text: $nombre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Precio:")
                TextField("", value: $precio, formatter: numberFormatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                Stepper("Existencias: " + String(existencia),value: $existencia, in: 0...130)
               // Text("Categoria:")
                HStack{
                    Spacer()
                    Text("Selecciona una categoria:")
                    Picker(selection: $categoria, label: Text("Categoria:")) {
                        Text("Sillas").tag("Silla")
                        Text("Mesas").tag("Mesas")
                        Text("Sillon").tag("Sillon")
                        Text("Cocina").tag("Cocina")
                    }
                    Spacer()
                }
                HStack{
                    Spacer()
                    Button {
                        coreDM.guardarMobiliario(id: id, nombre: nombre, precio_unitario: precio, existencia: existencia, categoria: categoria)
                    } label: {
                        Text("Guardar mobiliario")
                    }
                    Spacer()
                }
                
                

                
            }
            .padding()
        }.onAppear{
            numberFormatter.numberStyle = .currency
            numberFormatter.maximumFractionDigits = 2
        }
    }
}
