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
                                    Image(systemName: "trash")
                                    Image(systemName: "pencil")
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    @State var arrayMobiliario = [Mobiliario(id: 1, nombre: "Silla Tecate", precioUnitario: 100, existencia: 6, categoria: "Sillas"), Mobiliario(id: 2, nombre: "Mesa blanca larga", precioUnitario: 200, existencia: 2, categoria: "Mesas"), Mobiliario(id: 3, nombre: "Silla romana", precioUnitario: 100, existencia: 12, categoria: "Sillas"), Mobiliario(id: 4, nombre: "Sillon puff", precioUnitario: 200, existencia: 6, categoria: "Sillon")]
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
