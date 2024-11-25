//
//  ContentView.swift
//  WeSplit
//
//  Created by Aditya Sharma on 20/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount=0.0
    @State private var noofPeople=2
    @State private var tipPercentage=20
    @FocusState private var amountisFocused: Bool
    let tipPercentages = [10,20,30,40,0]
    
    
    var totalPerPerson: Double{
        let peopleCount=Double(noofPeople+2)
        let tips=Double(tipPercentage)
        let tipvalue=checkAmount/100*tips
        let grandTotal=checkAmount+tipvalue
        let amountPerPerson=grandTotal / peopleCount
        return amountPerPerson
    }
    
    
    var body: some View{
        NavigationStack {
            Form{
                Section{
                    TextField("Amount", value: $checkAmount,format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountisFocused)
                    Picker("Number of people",selection: $noofPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much do you want to Tip?"){
                    Picker("Tip Percentage",selection: $tipPercentage){
                        ForEach(tipPercentages, id:\.self){
                            Text($0,format:.percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    Text(totalPerPerson,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage==0 ? .red : .primary)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountisFocused{
                    Button("Done"){
                        amountisFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

