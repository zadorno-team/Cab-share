//
//  RideView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 11/01/23.
//

import MapKit
import SwiftUI

struct RideView: View {
    @State var text: String
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    HStack{
                        Text("Hello, Sasha! Nice to see you in the  International Airport of Naples!")
                            .foregroundColor(.white)
                            .padding(20)
                        VStack{
                            Image(systemName: "cloud.sun.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 45))
                                .padding(.bottom, 30.0)
                                .opacity(0.7)
                        }
                    }.frame(width: 350)
                    .background(Color.blue)
                        .cornerRadius(25)
                        .padding(.top, 5)

                        TextField("Search ...", text: $text)
                            .overlay(
                                HStack{Image(systemName: "magnifyingglass")
                                        .foregroundColor(Color.black)
                                        .padding(.leading, 30)
                                    Text("Where to?")
                                        .foregroundColor(.black)
                                    Spacer()})
                        .frame(width: 350, height: 60)
                        .foregroundColor(.black)
                        .background(Color.white)
                            .cornerRadius(25)
                            .padding(20)
                                        
                        HStack{
                            Image(systemName: "airplane.departure")
                                .foregroundColor(.gray)
                                .font(.system(size: 30))
                            Text("Which flight you had?")
                                .foregroundColor(.gray)
                                .padding(.leading, 10)
                            Spacer()
                        }.padding(.leading, 25)
        //                    .overlay(Rectangle().frame(width: 300, height: 1, alignment: .trailing).foregroundColor(Color.gray), alignment: .bottom)
                        Divider()
                            .frame(width: 300)
                        
                        HStack{
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 30))
                            Text("   How many people with you?")
                                .foregroundColor(.gray)
                                .padding(.leading, 10)
                            Spacer()
                        }.padding(.leading, 25)
                        Divider()
                            .frame(width: 300)
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "star.fill")
                                .foregroundColor(.gray)
                            Text("Choose a saved place")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding([.top,.bottom])
                        .padding(.leading,25)
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "figure.run")
                                .foregroundColor(.gray)
                            Text("Choose an already made journey")
                                .foregroundColor(.gray)
                            Spacer()
                        }.padding(.leading,25)
                        .padding(.bottom)
                        
                        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))), interactionModes: [])
                            .frame(width: 350, height: 200)
                            .cornerRadius(25)
                    
                    Button{
                        
                    } label:{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                        Text("Search")
                            .foregroundColor(.black)
                    }.frame(width: 350, height: 50)
                    .background(.white)
                        .cornerRadius(25)
                        .padding()

            }

        }
            .navigationTitle(Text("Ride")
            .foregroundColor(.white))
            .preferredColorScheme(.dark)
        }
    }
}

struct RideView_Previews: PreviewProvider {
    static var previews: some View {
        RideView(text: "")
    }
}
