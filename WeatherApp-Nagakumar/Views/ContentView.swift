
//
//  ContentView.swift
//  NagaKumar-WeatherApp-SwiftUI
//
//  Created by Kalyan Vajrala on 11/27/23.
//

import SwiftUI
import CoreLocation
// adding a branch
// ContentView is the main view of the app.
// adding 2 commit
struct ContentView: View {
    
    // State object for managing location updates.
    @StateObject var locationManager = LocationManager()
    
    // Observed object for managing current weather data.
    @ObservedObject var currentWeatherVM : CurrentWeatherViewModel
    
    // ContentView initializer.
    init( currentVMP: CurrentWeatherViewModel) {
        self.currentWeatherVM = currentVMP
    }
    
    // Body of the ContentView.
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient for the entire view.
                LinearGradient(gradient: Gradient(colors: [.mint,.white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                // Loading view displayed while fetching data.
                if locationManager.isLodaing {
                    LoadingView()
                }
                
                // Main content view when data is available.
                if currentWeatherVM.currentDataModle != nil && currentWeatherVM.futureDataModel != nil {
                    ExtractedMainView(futureModel: $currentWeatherVM.futureDataModel, weatherData: $currentWeatherVM.currentDataModle)
                }
            }
        }
        .onAppear {
            // Check location manager authorization status on view appear.
            locationManager.checkLMAuthorizationSatus()
        }
        .onReceive(locationManager.$location ) { locCoordinate in
            // Fetch data when location updates.
            if let coordinate = locCoordinate {
                Task {
                    await fetchData(locationCordinates: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
                }
            } else {
                currentWeatherVM.errorMessage = "Failed to respond"
            }
        }
    }
    
    // Function to fetch data based on location coordinates.
    func fetchData(locationCordinates: CLLocationCoordinate2D) async {
        do {
            // Call ViewModel function to make API calls and update data.
            try await currentWeatherVM.makeBothCalls(coordinates: CLLocation(latitude: locationCordinates.latitude, longitude: locationCordinates.longitude))
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}

// Preview provider for ContentView.
struct ContentView_Previews: PreviewProvider {
    static let serviceImpl = ServiceLayerImpl()
    static var previews: some View {
        ContentView(currentVMP: CurrentWeatherViewModel(service: serviceImpl))
    }
}

// ExtractedMainView is a separate view for displaying main weather information.
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

// MainWeatherdView displays the main weather information.
struct MainWeatherdView: View {
    @Binding var weatherData: CurrentWeatherModel?
    
    var body: some View {
        Text(weatherData?.name ?? " ")
            .font(.system(size: 32,weight: .medium,design: .default))
            .foregroundColor(.white)
            .background(Color.clear)
            .padding()
        
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

// WeatherScrollView is a horizontal scroll view for displaying future weather information.
struct WeatherScrollView: View {
    @Binding var futureModel:FutureWeatherModule?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(){
                // Iterate through future weather data and display WeatherSubView for each entry.
                ForEach(futureModel?.list ?? [], id: \.dt){ eachModel  in
                    NavigationLink(destination: Color.brown) {
                        WeatherSubView(weatherDay: eachModel.dtTxt?.extractDay() ?? "Mon", WeatherImage: eachModel.weather?.first?.getImageWithString ?? "questionmark.circle", temperature: (eachModel.main?.temp ?? 10.00) )
                    }
                    .navigationTitle("")
                }
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
            }
        }
    }
}

// WeatherSubView displays individual future weather information.
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


