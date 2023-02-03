//
//  LobbyGroupView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 23/01/23.
//
import MapKit
import SwiftUI

struct LobbyGroupView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
#warning("TODO: Change coordinate with the position where the taxi will go")
                    Map(coordinateRegion: .constant(MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))),
                        interactionModes: [])
                    .frame(width: 350, height: 200)
                    .cornerRadius(25)
                    HStack {
#warning("Instead of do all this button, we just need to do one with a foreach for each user")
                        Button {
#warning("TODO: Fill with a variable that open a sheet that shows the user's profile")
                        } label: {
                            Image("noimage")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(25)
                                .padding(10)
                        }
                        Button {
#warning("TODO: Fill with a variable that open a sheet that shows the user's profile")
                        } label: {
                            Image("noimage")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(25)
                                .padding(10)
                        }
                        Button {
                            #warning("some action")
                        } label: {
                            Image("noimage")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(25)
                                .padding(10)
                        }
                        Button {
                            #warning("some action")
                        } label: {
                            Image("noimage")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(25)
                                .padding(10)
                        }
                    }
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("Piazza Garibali, 25 Napoli")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding(.leading, 10)
                        Spacer()
                    }.padding()
                        .padding(.leading, 10)
                    HStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("2.15 PM")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding(.leading, 10)
                        Spacer()
                    }.padding(.leading, 25)
                        .padding(.bottom)
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("4/4")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding(.leading, 10)
                        Spacer()
                    }.padding(.leading, 25)
                        .padding(.bottom)
                    HStack {
                        Image(systemName: "car.fill")
                            .resizable()
                            .frame(width: 30, height: 25)
                        Text("CA2764DF")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding(.leading, 10)
                        Spacer()
                    }.padding(.leading, 25)
                        .padding(.bottom)
                    HStack {
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .frame(width: 30, height: 23)
                        Text("5.99$")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding(.leading, 10)
                        Spacer()
                    }.padding(.leading, 25)
                    NavigationLink(destination: ChatView(), label: {
                        Text("Chat with the group")
                            .foregroundColor(.white)
                    }).frame(width: 350, height: 50)
                        .background(.blue)
                        .cornerRadius(25)
                        .padding()
                        .padding(.top, 40)
                }.navigationTitle("Lobby")
            }
//            .navigationBarItems(trailing: NavigationLink(destination: , isActive: isQuitted, label: Text("Quit")))
        }.preferredColorScheme(.dark)
    }
}

struct LobbyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyGroupView()
    }
}
