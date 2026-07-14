import SwiftUI

enum SkyBluePalette: String, CaseIterable {
    case SkyGlow
    case SummerSky
    case ClearWater
    case CoastalTeal
    
    var color: Color {
        switch self {
        case .SkyGlow:
            return Color(red: 188/255, green: 230/255, blue: 255/255)
        case .SummerSky:
            return Color(red: 124/255, green: 208/255, blue: 255/255)
        case .ClearWater:
            return Color(red: 66/255,  green: 178/255, blue: 236/255)
        case .CoastalTeal:
            return Color(red: 26/255,  green: 149/255, blue: 205/255)
        }
    }
}
enum MidnightNavyPalette: String, CaseIterable {
    case AbyssalBlack
    case MidnightNavy
    case DeepMariner
    case GlowingCobalt
    
    var color: Color {
        switch self {
        case .AbyssalBlack:
            return Color(red: 3/255, green: 11/255, blue: 30/255)
        case .MidnightNavy:
            return Color(red: 13/255, green: 31/255, blue: 77/255)
        case .DeepMariner:
            return Color(red: 26/255, green: 53/255, blue: 124/255)
        case .GlowingCobalt:
            return Color(red: 44/255, green: 82/255, blue: 178/255)
        }
    }
}
enum IceWhitePalette: String, CaseIterable {
    case PureSnow
    case GlacierFrost
    case PowderIce
    case ArcticBreeze
    
    var color: Color {
        switch self {
        case .PureSnow:
            return Color(red: 255/255, green: 255/255, blue: 255/255)
        case .GlacierFrost:
            return Color(red: 244/255, green: 249/255, blue: 252/255)
        case .PowderIce:
            return Color(red: 227/255, green: 239/255, blue: 245/255)
        case .ArcticBreeze:
            return Color(red: 197/255, green: 220/255, blue: 232/255)
        }
    }
}
enum OceanBluePalette: String, CaseIterable {
    case DeepNavy
    case OceanBlue
    case ScubaCyan
    case Seafoam
    
    var color: Color {
        switch self {
        case .DeepNavy:
            return Color(red: 11/255, green: 45/255, blue: 114/255)
        case .OceanBlue:
            return Color(red: 9/255, green: 146/255, blue: 194/255)
        case .ScubaCyan:
            return Color(red: 10/255, green: 196/255, blue: 224/255)
        case .Seafoam:
            return Color(red: 235/255, green: 244/255, blue: 246/255)
        }
    }
}
struct ContentView: View {
    static let Background1 = LinearGradient(colors: [OceanBluePalette.DeepNavy.color,OceanBluePalette.OceanBlue.color, OceanBluePalette.ScubaCyan.color, OceanBluePalette.Seafoam.color], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let Background2 = LinearGradient(colors: [IceWhitePalette.PureSnow.color,IceWhitePalette.GlacierFrost.color, IceWhitePalette.PowderIce.color, IceWhitePalette.ArcticBreeze.color], startPoint: .topTrailing, endPoint: .bottomLeading)
    static let Background3 = LinearGradient(colors: [MidnightNavyPalette.AbyssalBlack.color,MidnightNavyPalette.MidnightNavy.color, MidnightNavyPalette.DeepMariner.color, MidnightNavyPalette.GlowingCobalt.color], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let Background4 = LinearGradient(colors: [SkyBluePalette.SkyGlow.color,SkyBluePalette.SummerSky.color, SkyBluePalette.ClearWater.color, SkyBluePalette.CoastalTeal.color], startPoint: .topTrailing, endPoint: .bottomLeading)
    var body: some View {
        VStack{
            Dashboard()
        }
        .background(ContentView.Background3)
        
    }
}

#Preview {
    ContentView()
}

struct Dashboard: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 60)
                    .foregroundStyle(ContentView.Background1)
                VStack {
                    HStack{
                        
                    }
                    Text("Dashboard")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                        .padding(65)
                    
                    Button("Start Focus session") {
                    }
                    .foregroundStyle(.blue)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                }
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 350)
            .ignoresSafeArea(edges: .top)
            
            
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .foregroundStyle(ContentView.Background2)
                    .padding(.bottom, 15)
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 100, height: 100)
                            .foregroundStyle(ContentView.Background3)
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 100, height: 100)
                            .foregroundStyle(ContentView.Background3)
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 100, height: 100)
                            .foregroundStyle(ContentView.Background3)
                    }
                }
            }
            NavigationStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundStyle(.white)
                    
                    ZStack(alignment: .top) {
                        VStack{
                            HStack {
                                
                                Text("Today's Tasks")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                NavigationLink(destination: TasksPage()) {
                                    Text("Add Tasks")
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(.black)
                                        .cornerRadius(15)
                                }
                                .padding(.horizontal, 20)
                            }
                            List {
                                Text("Task 1")
                                Text("Task 2")
                                Text("Task 3")
                                Text("Task 4")
                            }
                            .foregroundStyle(.black)
                            .scrollContentBackground(.hidden)
                            .background(ContentView.Background1)
                        }
                        .padding(.top, 15)
                    }
                    .ignoresSafeArea()
                }
                
            }
            
            
        }
    }
}
#Preview {
    Dashboard()
}

struct TasksPage: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

#Preview {
    TasksPage()
}
