//
//  PartyDetail.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/12.
//

import SwiftUI

struct PartyDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Character.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Character.id, ascending: false)],
        animation: .default
    ) var fetchedCharacterList: FetchedResults<Character>
    @State private var isNameChange = false
    @ObservedObject var party: Party
    @State private var name :String
    @State private var characterArray : [Character]
        
    init(party: Party){
        self.party = party
        _name = State(initialValue: party.name ?? "調整用")
        _characterArray = State(initialValue: party.characterArray)
    }
    
     var body: some View {
        VStack{
            if isNameChange {
    
                HStack{
                    TextField("パーティ名",text: $name)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 250)
                                    .padding()
                    .font(.title)
                    Button("OK"){
                        party.name = name
                        save()
                        isNameChange.toggle()
                    }
                        .font(.title)
                      
                }
              
            }else{
                Toggle("\(name)", isOn: $isNameChange)
                    .font(.title)
                    .toggleStyle(.button)
            }
            
            Form{
                ForEach(0..<6){id in
                    NavigationLink(
                        destination: CharacterPicker(party: party, character: characterArray[id]),
                        label: {
                            HStack{
                                Text(party.characterArray[id].name ?? "誰やねん")
                                Spacer()
                                Text("攻撃力:")
                                Text(String(format:"%.2f", Double(party.characterArray[id].powerPerSecond)/10000))
                                Text("万")
                                Text("＋\(party.characterArray[id].powerUpMe(party: party))%")
                            }
                        }
                    )
                }
                NavigationLink("最大化"){
                    MaximizePartyAttack(party: party)
                }
            }
            .frame(height: 400)
            
            HStack{
                Text("道具デッキ選択：")
                NavigationLink(party.dougutati?.name ?? "なし" ){
                    DouguTatiPicker(party: party)
                }
            }
             
            HStack{
                Text("敵体力減少:-\(party.specialEffectCalculateInThisParty(specialEffect: SpecialEffect.tehai_HP.rawValue))%")
                Text("攻撃時間:+\(party.specialEffectCalculateInThisParty(specialEffect: SpecialEffect.tehai_time.rawValue))秒")
                Text("ポイント倍率:+\(party.specialEffectCalculateInThisParty(specialEffect: SpecialEffect.tehai_pt.rawValue))％")
            }.lineLimit(1)
                .minimumScaleFactor(0.1)
            
            Text("全体補正:+\(party.specialEffectCalculateInThisParty(specialEffect: SpecialEffect.forALL.rawValue))%")
            
            HStack{
                Text("倒せる敵の上限:")
                Text(String(format:"%.2f", Double(party.maxDamageOfOneGame())/100000000))
                Text("億")
            }
            
            HStack{
                Text("倒せる敵のレベル:")
                Text(String(levelData[party.defeatablLevelIndex()][0]))
                Text("Lv,")
                Text("次のレベルまで")
                Text(String(differenceOfNextLevel()))
                Text("万")
            }
            
            HStack{
                Text("獲得ポイント　通常:")
                Text(String(getPoints(int2or3: 2)))
                Text(",暴騰:")
                Text(String(getPoints(int2or3: 3)))
            }
        
            Spacer()
        }
        .onAppear{
            characterArrayReset(changedCharacterArray: characterArray)}
        
        .navigationTitle("Party")
        .navigationBarTitleDisplayMode(.inline)
    
     }
    
    private func characterArrayReset(changedCharacterArray: [Character]){
        let newCharacterArray = minRequiredPartyMemberCreate(characterArray: changedCharacterArray)
        characterArray = newCharacterArray
    }
    
    private func minRequiredPartyMemberCreate (characterArray: [Character])->[Character]{
        var newCharacterArray = characterArray
        while newCharacterArray.count < minRequiredPartyMember {
            newCharacterArray.append(fetchedCharacterList[newCharacterArray.count - 1])
        }
        return newCharacterArray
    }
    private func save(){
        try? viewContext.save()
    }

}

extension PartyDetail{
    func differenceOfNextLevel()->Int{
        let difference = levelData[party.defeatablLevelIndex()+1][1]*100-party.maxDamageOfOneGame()/10000
        return difference
    }
    func getPoints(int2or3:Int)->Int{
        var points = levelData[party.defeatablLevelIndex()][int2or3]
        points *= (100+party.specialEffectCalculateInThisParty(specialEffect: SpecialEffect.tehai_pt.rawValue))
        points /= 100
        
        return points
    }
}
