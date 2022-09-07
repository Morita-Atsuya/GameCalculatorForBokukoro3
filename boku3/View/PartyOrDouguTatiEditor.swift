//
//  PartyOrDouguTatiEditor.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/31.
//

import SwiftUI

struct PartyOrDouguTatiEditor: View {
    @State private var partyOrDouguTati = true
    
    var body: some View {
        VStack{
            Picker("",selection: $partyOrDouguTati){
                Text("Party").tag(true)
                Text("DouguTati").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            .padding()
            
            if partyOrDouguTati {
                PartyEditor()
            }else{
                DouguTatiEditor()
            }
        }
    }
}

struct PartyOrDouguTatiEditor_Previews: PreviewProvider {
    static var previews: some View {
        PartyOrDouguTatiEditor()
    }
}
