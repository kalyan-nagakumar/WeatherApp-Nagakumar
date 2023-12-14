//
//  ContentView.swift
//  NagaKumar-WeatherApp-SwiftUI
//
//  Created by Kalyan Vajrala on 11/27/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @State var nextFiveDaysArray:[Int] = Array(0...5)
    @StateObject var locationManager = LocationManager()
    @ObservedObject var currentWeatherVM : CurrentWeatherViewModel
    
    init( currentVMP: CurrentWeatherViewModel) {
        self.currentWeatherVM = currentVMP
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.mint,.white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                
                if locationManager.isLodaing {
                    LoadingView()
                }
                
                if currentWeatherVM.currentDataModle != nil && currentWeatherVM.futureDataModel != nil {
                    
                    ExtractedMainView(futureModel: $currentWeatherVM.futureDataModel, weatherData: $currentWeatherVM.currentDataModle)
                    
                    
                }
                
                
            }}.onAppear {
                
                locationManager.checkLMAuthorizationSatus()
                
            }.onReceive(locationManager.$location ) { locCoordinate in
                if let coordinate = locCoordinate {
                    Task {
                        await fetchData(locationCordinates: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
                    }
                }else{
                    
                    currentWeatherVM.errorMessage = "failed to respond"
                }
                
            }
    }
    
    func fetchData(locationCordinates:CLLocationCoordinate2D) async {
        do {
            
            try await currentWeatherVM.makeBothCalls(coordinates: CLLocation(latitude: locationCordinates.latitude, longitude: locationCordinates.longitude))
        }catch(let error) {
            print(error.localizedDescription)
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static let serviceImpl = ServiceLayerImpl()
    static var previews: some View {
        ContentView(currentVMP: CurrentWeatherViewModel(service: serviceImpl))
    }
}

struct ExtractedMainView: View {
    @Binding var futureModel:FutureWeatherModule?
    @Binding var weatherData : CurrentWeatherModel?
    var body: some View {
        VStack{
            MainWeatherdView(weatherData: $weatherData)
            Spacer()
            WeatherScrollView(futureModel: $futureModel)
            Spacer()
            
        }
    }
}


struct MainWeatherdView: View {
    
    @Binding var weatherData: CurrentWeatherModel?
    var body: some View {
        Text(weatherData?.name ?? " ")
            .font(.system(size: 32,weight: .medium,design: .default))
            .foregroundColor(.white)
            .background(Color.clear)
            .padding()
        //                    .frame(width: 200,height: 200)
        VStack(spacing: 8){
            Image(systemName: weatherData?.weather?.first?.getImageWithString ?? "questionmark.circle")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180,height: 180)
            Text("\(weatherData?.main?.temp?.formattedString() ?? "0.00")°")
                .font(.system(size: 70 ,weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}



struct WeatherScrollView: View {
    
    @Binding var futureModel:FutureWeatherModule?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(){
                ForEach(futureModel?.list ?? [], id: \.dt){ eachModel  in
                    
                    //
                    //                    NavigationView {
                    NavigationLink(destination: Color.brown) {
                        WeatherSubView(weatherDay: eachModel.dtTxt?.extractDay() ?? "Mon", WeatherImage: eachModel.weather?.first?.getImageWithString ?? "questionmark.circle", temperature: (eachModel.main?.temp ?? 10.00) )
                    }
                    .navigationTitle("")
                    //                    }
                    
                    
                }.padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
            }
            
            
        }
    }
}

struct WeatherSubView: View {
    var weatherDay:String
    var WeatherImage:String
    var temperature:Double
    
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
            Text("\(temperature.formattedString())°")
                .font(.system(size: 30 ,weight: .medium))
                .foregroundColor(.white)
        }
    }
}


