//
//  ContentView.swift
//  interval_timer
//
//  Created by Moha on 07/05/2023.
//

import SwiftUI
var timerTotal: Timer? = nil
var timerInterval: Timer? = nil
var totalTimeIsRunning = false
var intervalTimeIsRunning = false

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                VStack{
                    Text("Interval Timer")
                        .font(.largeTitle)
                        .background(Color.yellow)
                        .frame(width: 300, height: 300)
                        .bold()
                        .italic()
                    
                     Image(systemName: "stopwatch.fill")
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.red)
                        .font(.largeTitle)
                }
                
               
            }
        }   
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct ContentView: View {
    
    @State var startButton = "START             "
    @State var pauseButton = "play.fill"
    @State var unitSeconds = 0
    @State var tenthSeconds = 0
    @State var unitMinutes = 0
    @State var tenthMinutes = 0
    @State var unitHours = 0
    @State var unitSecondsI = 0
    @State var tenthSecondsI = 0
    @State var unitMinutesI = 0
    @State var tenthMinutesI = 0
    @State var unitHoursI = 0
    @State var records = [String]()

    
    var body: some View {
        VStack{
            VStack{
                Text("Total Time")
                Text("\(unitHours):\(tenthMinutes)\(unitMinutes):\(tenthSeconds)\(unitSeconds)")
                    .font(.title)
            }
            Spacer()
            VStack{
                Text("Lap Time")
                Text("\(unitHoursI):\(tenthMinutesI)\(unitMinutesI):\(tenthSecondsI)\(unitSecondsI)")
                    .font(.largeTitle)
                    .bold()
                    
            }
            
            HStack{
                Spacer()

                Button{
                    pause()
                }label:{
                    Image(systemName: pauseButton)                }
                .tint(.orange)
                .buttonStyle(.borderedProminent)

                Spacer()
                
                Button(role:.destructive){
                    pause()
                    reset()
                }label:{
                    Image(systemName: "xmark")
                }
                .tint(.red)
                .buttonStyle(.borderedProminent)
                
                Spacer()

            }
            .foregroundColor(Color.black)
            .font(.largeTitle)
            .bold()
            
            List {
                ForEach(records, id: \.self) {
                    Text("\($0)")
                }
            }
            
            Spacer()
            if totalTimeIsRunning == true {
                Button(startButton){
                    timeStarter()
                }
                .tint(.green)
                .font(.largeTitle)
                .foregroundColor(Color.black)
                .buttonStyle(.borderedProminent)
                .bold()
                
            }
        }
        .padding()
    }
    func reset(){
        if totalTimeIsRunning{
            unitSecondsI = 0
            tenthSecondsI = 0
            unitMinutesI = 0
            tenthMinutesI = 0
            unitHours = 0
            unitSeconds = 0
            tenthSeconds = 0
            unitMinutes = 0
            tenthMinutes = 0
            unitHours = 0
            timerInterval?.invalidate()
            timerTotal?.invalidate()
            records=[]
            
            
        }
    }
    func timeStarter(){
        if totalTimeIsRunning == false{
            totalTimeIsRunning = true
            IntervalStarter()
            startButton = "  LAP                "
            timerTotal = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
                if unitSeconds<9{
                    unitSeconds+=1
                }else if unitSeconds == 9 {
                    if tenthSeconds<5{
                        unitSeconds = 0
                        tenthSeconds+=1
                    } else if tenthSeconds == 5 {
                        if unitMinutes<9{
                            unitSeconds = 0
                            tenthSeconds = 0
                            unitMinutes += 1
                        } else if unitMinutes == 9 {
                            if tenthMinutes < 5 {
                                unitSeconds = 0
                                tenthSeconds = 0
                                unitMinutes = 0
                                tenthMinutes += 1
                            } else if tenthMinutes == 5{
                                unitSeconds = 0
                                tenthSeconds = 0
                                unitMinutes = 0
                                tenthMinutes = 0
                                unitHours += 1
                            }
                            
                            
                            
                        }
                        
                    }
                    
                }
                }
        }
        else if totalTimeIsRunning {
            records.append("\(unitHoursI):\(tenthMinutesI)\(unitMinutesI):\(tenthSecondsI)\(unitSecondsI)")
            unitSecondsI = 0
            tenthSecondsI = 0
            unitMinutesI = 0
            tenthMinutesI = 0
            unitHoursI = 0
        }
        
        
    }
    func pause(){
        if totalTimeIsRunning {
            timerInterval?.invalidate()
            timerTotal?.invalidate()
            pauseButton = "play.fill"
            totalTimeIsRunning=false
        }else{
            timeStarter()
            pauseButton = "pause.fill"
        }
    }
    func IntervalStarter(){
        timerInterval = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
            if unitSecondsI<9{
                unitSecondsI+=1
            }else if unitSecondsI == 9 {
                if tenthSecondsI<5{
                    unitSecondsI = 0
                    tenthSecondsI += 1
                } else if tenthSecondsI == 5 {
                    if unitMinutesI < 9{
                        unitSecondsI = 0
                        tenthSecondsI = 0
                        unitMinutesI += 1
                    } else if unitMinutesI == 9 {
                        if tenthMinutesI < 5 {
                            unitSecondsI = 0
                            tenthSecondsI = 0
                            unitMinutesI = 0
                            tenthMinutesI += 1
                        } else if tenthMinutesI == 5{
                            unitSecondsI = 0
                            tenthSecondsI = 0
                            unitMinutesI = 0
                            tenthMinutesI = 0
                            unitHoursI += 1
                        }
                        
                        
                        
                    }
                    
                }
                
            }
            }
        
        
    }
    
//    func timeStarter2(timer: inout Timer, seconds: inout Int, decaSeconds: inout Int, minutes: inout Int, decaMinutes: inout Int , hours: inout Int){
//        timerTotal = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
//            if seconds<9{
//                seconds += 1
//            }else if seconds == 9 {
//                if decaSeconds<5{
//                    seconds = 0
//                    decaSeconds+=1
//                } else if decaSeconds == 5 {
//                    if minutes<9{
//                        seconds = 0
//                        decaSeconds = 0
//                        minutes += 1
//                    } else if minutes == 9 {
//                        if decaMinutes < 5 {
//                            seconds = 0
//                            decaSeconds = 0
//                            minutes = 0
//                            decaMinutes += 1
//                        } else if decaMinutes == 5{
//                            seconds = 0
//                            decaSeconds = 0
//                            minutes = 0
//                            decaMinutes = 0
//                            hours += 1
//                        }
//
//
//
//                    }
//
//                }
//
//            }
//            }
//
//    }
  

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 7"))
        ContentView()
            .previewDevice("iPhone SE")
            .previewInterfaceOrientation(.landscapeLeft)
            }
        
    }

