//
//  ContentView.swift
//  NagaKumar-WeatherApp-SwiftUI
//
//  Created by Kalyan Vajrala on 11/27/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var nextFiveDaysArray:[Int] = Array(0...5)
    @StateObject var locationManager = LocationManager()
    
    
    var body: some View {
        ZStack{
             
            LinearGradient(gradient: Gradient(colors: [.mint,.white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            if locationManager.isLodaing {
                ExtractedMainView(nextFiveDaysArray: $nextFiveDaysArray)
                    .blur(radius: 10)
                LoadingView()
            }else {
                ExtractedMainView(nextFiveDaysArray: $nextFiveDaysArray)
                if let locationCordinates = locationManager.location {
                    Text("you coordinates are \(locationCordinates.latitude),\(locationCordinates.latitude)")
                }
            }
            
        }.onAppear{
            locationManager.checkLMAuthorizationSatus()
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct MainWeatherdView: View {
    
    var body: some View {
        Text("Irving,Texas")
            .font(.system(size: 32,weight: .medium,design: .default))
            .foregroundColor(.white)
            .background(Color.clear)
            .padding()
        //                    .frame(width: 200,height: 200)
        VStack(spacing: 8){
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180,height: 180)
            Text("76")
                .font(.system(size: 70 ,weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}

struct WeatherScrollView: View {
    
    @Binding var nextFiveDaysArray:[Int]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(){
                ForEach(0..<nextFiveDaysArray.count){ day in
                    
                    WeatherSubView(weatherDay: "THU", WeatherImage: "cloud.sun.fill", temperature: 83)
                    
                }.padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
                
            }
        }
    }
}

struct WeatherSubView: View {
    var weatherDay:String
    var WeatherImage:String
    var temperature:Int
    
    var body: some View {
        VStack(alignment: .center){
            Text(weatherDay)
                .font(.system(size: 20 ,weight: .medium))
                .foregroundColor(.white)
            Image(systemName: WeatherImage)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50,height: 50)
            Text("\(temperature)")
                .font(.system(size: 30 ,weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct ExtractedMainView: View {
    @Binding var nextFiveDaysArray:[Int]

    var body: some View {
       VStack{
            MainWeatherdView()
            Spacer()
            WeatherScrollView(nextFiveDaysArray: $nextFiveDaysArray)
            Spacer()
            
        }
    }
}
