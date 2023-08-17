//
//  ContentView.swift
//  UnitConverter
//
//  Created by bharat venna on 17/08/23.
//
/*Problem Statement:
 You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.
 
 Which units you choose are down to you, but you could choose one of these:
 
 Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
 Length conversion: users choose meters, kilometers, feet, yards, or miles.
 Time conversion: users choose seconds, minutes, hours, or days.
 Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
 If you were going for length conversion you might have:
 
 A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
 A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
 A text field where users enter a number.
 A text view showing the result of the conversion.
 */

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue = 0.0 //created varible to enter the input value
    @State private var inputUnit = "°C" //created variable to store or keep track of the input unit
    @State private var outputUnit = "°C" //created variable to store or keep track of the output unit
    private var units = ["°C", "°F", "°K"] // created array of strings to represent the available units for looping
    
    @FocusState var keyBoardFocus: Bool // variable for tracking the keyboard focus
    
    var convertedValue: Double { // computed variable converting the inputValue of any units to °C
        if(inputUnit == "°C"){ // °C to °C
            return inputValue * 1
        } else if(inputUnit == "°F"){ // °F to °C
            return (inputValue - 32.0) * (5/9)
        } else if(inputUnit == "°K"){ // °K to °C
            return inputValue - 273.15
        } else {
            return 0.0
        }
    }
    
    var outputValue: Double { //computed variable converting the convertedValue to other units (°C, °F, °K)
        
        if(outputUnit == "°C"){ //°C to °C
            return convertedValue * 1
        }else if(outputUnit == "°F"){ //°C to °F
            return convertedValue * (9/5) + 32
        }else if(outputUnit == "°K"){ // °C to °K
            return convertedValue + 273.15
        }else{
            return 0.0
        }
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Text("Enter value to convert")
                    TextField("Enter Temperature", value: $inputValue, format: .number) //Creating TextField for entering the value you want to convert
                        .keyboardType(.decimalPad) // formatting the keyboard to be decimalpad
                        .focused($keyBoardFocus) // keyboard focus toggle
                }
                Section{
                    Picker("units", selection:$inputUnit){ // Creating segmented picker for selecting the input units
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented) // converts picker style to segments
                }
            header: { // header for picker
                Text("Select input units")
            }
                Section{
                    Picker("units", selection: $outputUnit){ // segmented picker for the selection of output units
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented) // converts picker style to segments
                }
            header: {
                Text("Select output units") // header for picker
            }
                Section{
                    Text("Result: \(outputValue.formatted())") // creating view to display result
                }
            }
            .navigationTitle("Temperature converter") // heading for the view
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){ // adding button to the keyboard toolbar
                    Spacer()
                    Button("Done"){
                        keyBoardFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
