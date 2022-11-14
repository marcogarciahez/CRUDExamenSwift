//
//  ContentView.swift
//  CRUDExamenMobiliario
//
//  Created by Roberto Marco García Hernández on 10/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        ZStack{
            NavigationView(){
                VStack{
                    List{
                        ForEach(arrayMobiliario){
                            mobiliario in
                            HStack{
                                Text(mobiliario.nombre)
                                Spacer()
                                HStack{
                                    NavigationLink(destination: EditarView(mobiliario: mobiliario)) {
                                        Image(systemName: "pencil")
                                    }
                                    Image(systemName: "trash")
                                    
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    @State var arrayMobiliario = [Mobiliario(id: 1, nombre: "Silla Tecate", precioUnitario: 100, existencia: 6, categoria: "Sillas"), Mobiliario(id: 2, nombre: "Mesa blanca larga", precioUnitario: 200, existencia: 2, categoria: "Mesas"), Mobiliario(id: 3, nombre: "Silla romana", precioUnitario: 100, existencia: 12, categoria: "Sillas"), Mobiliario(id: 4, nombre: "Sillon puff", precioUnitario: 200, existencia: 6, categoria: "Sillon"), Mobiliario(id: 5, nombre: "Mesa de marmol", precioUnitario: 200, existencia: 6, categoria: "Mesas")]
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


struct EditarView: View {
    @State var mobiliario: Mobiliario
    @State var nombre: String = ""
    @State var precio: Float = 0
    @State var existencia: Int = 0
    @State var categoria: String = ""
    @State var arrayCategorias = ["Sillas","Mesas","Sillon","Cocina"]
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                Text("Editar")
                    .font(.title)
                    .bold()
                Text("Nombre:")
                TextField(mobiliario.nombre, text: $nombre)
                Stepper("Precio: " + String(precio),value: $precio, in: 0...130)
                Stepper("Existencias: " + String(existencia),value: $existencia, in: 0...130)
               // Text("Categoria:")
                Picker(selection: $categoria, label: Text("Categoria:")) {
                    Text("Sillas").tag("Silla")
                    Text("Mesas").tag("Mesas")
                    Text("Sillon").tag("Sillon")
                    Text("Cocina").tag("Cocina")
                }
            }
            .padding()
        }
    }
}
