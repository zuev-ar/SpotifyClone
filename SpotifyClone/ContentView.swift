//
//  ContentView.swift
//  SpotifyClone
//
//  Created by Arkasha Zuev on 30.11.2021.
//

import SwiftUI

struct Song: Identifiable {
    var id: String { title }
    let title: String
    let artist: String
    let coverString: String
}

struct ContentView: View {
    
    @State private var isPlaying = false
    @State private var isLiked = false
    
    let bgColor = Color(hue: 0.0, saturation: 0.0, brightness: 0.071)
    
    let songs = [
        Song(title: "Speak to Me / Breathe", artist: "Pink Floyd", coverString: "2"),
        Song(title: "On the Run", artist: "Pink Floyd", coverString: "2"),
        Song(title: "Time", artist: "Pink Floyd", coverString: "2"),
        Song(title: "The Great Gig in the Sky", artist: "Pink Floyd", coverString: "2"),
        Song(title: "Money", artist: "Pink Floyd", coverString: "2")
    ]
    
    func getOffsetY(reader: GeometryProxy) -> CGFloat {
        let offsetY: CGFloat = -reader.frame(in: .named("scrollView")).minY
        
        if offsetY < 0 {
            return offsetY / 1.3
        }
        
        return offsetY
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            GeometryReader { reader in
                let offsetY = getOffsetY(reader: reader)
                let height: CGFloat = (reader.size.height - offsetY) + offsetY / 3
                let minHeight: CGFloat = 120
                let opacity = (height - minHeight) / (reader.size.height - minHeight)
                
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        .scaleEffect(7)
                    
                    Image("1")
                        .resizable()
                        .frame(width: height < 0 ? 0 : height, height: height < 0 ? 0 : height)
                        .offset(y: offsetY)
                        .opacity(opacity)
                        .shadow(color: Color.black.opacity(0.5), radius: 30)
                }
                .frame(width: reader.size.width)
            }
            .frame(height: 250)
            
            Spacer().frame(height: 25)
            
            albumDetailsView
                .padding(.horizontal)
            
            Spacer().frame(height: 25)
            
            songsListView
                .padding(.horizontal)
        }
        .coordinateSpace(name: "scrollView")
        .background(bgColor.ignoresSafeArea())
    }
    
    var songsListView: some View {
        ForEach(songs) { song in
            HStack {
                Image(song.coverString)
                    .resizable()
                    .frame(maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(song.title)
                        .font(.title3)
                    
                    Text(song.artist)
                        .bold()
                        .font(.subheadline)
                        .opacity(0.8)
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .font(.system(size: 25))
                    .frame(maxHeight: .infinity)
                    .opacity(0.8)
            }
            .frame(height: 60)
            .foregroundColor(.white)
        }
    }
    
    var albumDetailsView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("The Dark Side of the Moon")
                    .font(.title)
                    .bold()
                
                HStack {
                    Image("2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text("Money")
                        .font(.title2)
                        .bold()
                }
                
                Text("Album - 1973")
                
                HStack(spacing: 30) {
                    Button {
                        isLiked.toggle()
                    } label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .font(.system(size: 30))
                            .padding(.top, 5)
                    }

                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .frame(maxHeight: .infinity)
                        .offset(y: 5)
                }
            }
            .foregroundColor(.white)
            
            Spacer()
            
            Button {
                isPlaying.toggle()
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.green)
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                }
                .frame(width: 80, height: 80)
            }
        }
        
//        ForEach(0 ..< 100) { _ in
//            Rectangle()
//                .foregroundColor(.white)
//                .frame(height: 100)
//                .opacity(0.3)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
