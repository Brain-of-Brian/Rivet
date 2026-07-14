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
        NavigationStack {
            Dashboard()
        }
        .background(ContentView.Background3)
    }
}

#Preview {
    ContentView()
}

struct TabBarPlaceholder: View {
    var body: some View {
        HStack {
            NavigationLink(destination: Dashboard().toolbar(.hidden, for: .navigationBar)) {
                VStack {
                    Text("Dashboard")
                        .font(.caption)
                    Text("icon....")
                        .font(.caption2)
                }
            }
            .frame(maxWidth: .infinity)
            
            NavigationLink(destination: TasksPage().toolbar(.hidden, for: .navigationBar)) {
                VStack {
                    Text("Tasks")
                        .font(.caption)
                    Text("icon...")
                        .font(.caption2)
                }
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                Text("settings")
                    .font(.caption)
                Text("icon...")
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
        .background(IceWhitePalette.PureSnow.color)
    }
}

struct AppUsageCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 80, height: 100)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(ContentView.Background3)
                Text("later")
                    .font(.caption2)
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                Text("screentime ex")
                    .font(.caption2)
                    .foregroundStyle(.red)
            }
        }
    }
}

struct TaskCardExpanded: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    Text("placeholder")
                        .font(.headline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Spacer()
                    Text("e")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                HStack {
                    Circle()
                        .stroke(OceanBluePalette.OceanBlue.color, lineWidth: 2)
                        .frame(width: 18, height: 18)
                    Text("placeholder")
                        .font(.subheadline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                }
                HStack {
                    Circle()
                        .stroke(OceanBluePalette.OceanBlue.color, lineWidth: 2)
                        .frame(width: 18, height: 18)
                    Text("placeholder")
                        .font(.subheadline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                }
                HStack {
                    Circle()
                        .stroke(OceanBluePalette.OceanBlue.color, lineWidth: 2)
                        .frame(width: 18, height: 18)
                    Text("placeholder")
                        .font(.subheadline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                }
            }
            .padding()
        }
        .padding(.horizontal, 20)
    }
}

struct TaskCardCollapsed: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            HStack {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(OceanBluePalette.ScubaCyan.color)
                VStack(alignment: .leading) {
                    Text("placeholder")
                        .font(.headline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Text("placeholder")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding()
        }
        .padding(.horizontal, 20)
    }
}

struct BreakdownStepCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(IceWhitePalette.PureSnow.color)
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    Text("placeholder")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.white)
                }
                Text("placeholder")
                    .font(.subheadline)
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                Spacer()
                Text("placeholder")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding()
        }
        .padding(.horizontal, 20)
    }
}

struct AppSelectRow: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 36)
                .foregroundStyle(ContentView.Background3)
            Text("placeholder")
                .font(.body)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
            Spacer()
            Circle()
                .stroke(OceanBluePalette.OceanBlue.color, lineWidth: 2)
                .frame(width: 22, height: 22)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct ColorDot: View {
    var body: some View {
        Circle()
            .frame(width: 36, height: 36)
            .foregroundStyle(OceanBluePalette.OceanBlue.color)
    }
}

// MARK: - Dashboard

struct Dashboard: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 60)
                    .foregroundStyle(ContentView.Background3)
                VStack {
                    HStack {
                        Text("placeholder")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 100, height: 36)
                                .foregroundStyle(MidnightNavyPalette.DeepMariner.color)
                            Text("placeholder")
                                .font(.caption)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 50)
                    
                    Text("placeholder")
                        .font(.system(size: 56, weight: .bold))
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                        .padding(.top, 20)
                    
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(SkyBluePalette.SummerSky.color)
                    
                    NavigationLink(destination: FocusSetupPage().toolbar(.hidden, for: .navigationBar)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(height: 55)
                                .foregroundStyle(OceanBluePalette.OceanBlue.color)
                            Text("placeholder")
                                .font(.headline)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 25)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 350)
            .ignoresSafeArea(edges: .top)
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .foregroundStyle(ContentView.Background2)
                    .padding(.bottom, 15)
                HStack(spacing: 12) {
                    AppUsageCard()
                    AppUsageCard()
                    AppUsageCard()
                    AppUsageCard()
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(IceWhitePalette.GlacierFrost.color)
                
                VStack {
                    HStack {
                        Text("placeholder")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                            .padding(.leading, 20)
                        
                        Spacer()
                        NavigationLink(destination: NewTaskPage().toolbar(.hidden, for: .navigationBar)) {
                            Text("placeholder")
                                .font(.subheadline)
                                .bold()
                                .foregroundStyle(OceanBluePalette.OceanBlue.color)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 15)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            TaskCardExpanded()
                            TaskCardCollapsed()
                            TaskCardCollapsed()
                        }
                    }
                    
                    TabBarPlaceholder()
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    Dashboard()
}

// MARK: - Tasks Page

struct TasksPage: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 60)
                    .foregroundStyle(ContentView.Background3)
                VStack {
                    HStack {
                        Text("placeholder")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 100, height: 36)
                                .foregroundStyle(MidnightNavyPalette.DeepMariner.color)
                            Text("placeholder")
                                .font(.caption)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 50)
                    
                    Text("placeholder")
                        .font(.system(size: 72, weight: .bold))
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                        .padding(.top, 20)
                    
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(SkyBluePalette.SummerSky.color)
                    
                    NavigationLink(destination: NewTaskPage().toolbar(.hidden, for: .navigationBar)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(height: 55)
                                .foregroundStyle(ContentView.Background1)
                            Text("placeholder")
                                .font(.headline)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 25)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 350)
            .ignoresSafeArea(edges: .top)
            
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(IceWhitePalette.GlacierFrost.color)
                
                VStack {
                    ScrollView {
                        VStack(spacing: 12) {
                            TaskCardExpanded()
                            TaskCardCollapsed()
                            TaskCardCollapsed()
                        }
                        .padding(.top, 20)
                    }
                    
                    TabBarPlaceholder()
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    TasksPage()
}

// MARK: - New Task Page

struct NewTaskPage: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("placeholder")
                        .font(.body)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                }
                Spacer()
                Text("placeholder")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 70, height: 36)
                        .foregroundStyle(SkyBluePalette.SkyGlow.color)
                    Text("placeholder")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 30)
            
            Text("placeholder")
                .font(.title2)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            
            Text("placeholder")
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            Divider()
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 50)
                    .foregroundStyle(SkyBluePalette.SkyGlow.color)
                HStack {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    Text("placeholder")
                        .font(.body)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Spacer()
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            
            Text("placeholder")
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            
            HStack(spacing: 16) {
                ColorDot()
                ColorDot()
                ColorDot()
                ColorDot()
                ColorDot()
                ColorDot()
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            NavigationLink(destination: BreakdownPage().toolbar(.hidden, for: .navigationBar)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 55)
                        .foregroundStyle(ContentView.Background1)
                    Text("placeholder")
                        .font(.headline)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(IceWhitePalette.PureSnow.color)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NewTaskPage()
}

// MARK: - Breakdown Page

struct BreakdownPage: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundStyle(ContentView.Background4)
                VStack(alignment: .leading, spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 130, height: 32)
                            .foregroundStyle(OceanBluePalette.OceanBlue.color)
                        Text("placeholder")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                    }
                    .padding(.top, 50)
                    
                    Text("placeholder")
                        .font(.subheadline)
                        .foregroundStyle(MidnightNavyPalette.DeepMariner.color)
                    
                    Text("placeholder")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    
                    HStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 18)
                                .frame(height: 50)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                            Text("placeholder")
                                .font(.caption)
                                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 18)
                                .frame(height: 50)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                            Text("placeholder")
                                .font(.caption)
                                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                        }
                    }
                }
                .padding(.horizontal, 25)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 280)
            .ignoresSafeArea(edges: .top)
            
            ScrollView {
                VStack(spacing: 12) {
                    BreakdownStepCard()
                    BreakdownStepCard()
                    BreakdownStepCard()
                    BreakdownStepCard()
                    BreakdownStepCard()
                }
                .padding(.top, 20)
            }
            
            NavigationLink(destination: TasksPage().toolbar(.hidden, for: .navigationBar)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 55)
                        .foregroundStyle(ContentView.Background1)
                    Text("placeholder")
                        .font(.headline)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Button {
                dismiss()
            } label: {
                Text("placeholder")
                    .font(.body)
                    .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
            }
            .padding(.top, 12)
            .padding(.bottom, 30)
        }
        .background(ContentView.Background2)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    BreakdownPage()
}

// MARK: - Focus Setup

struct FocusSetupAllAppsBottom: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 90)
                    .foregroundStyle(IceWhitePalette.PureSnow.color)
                VStack(spacing: 6) {
                    Text("placeholder")
                        .font(.headline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal, 20)
            
            HStack {
                Text("placeholder")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Spacer()
                Text("placeholder")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 20)
            
            TaskCardExpanded()
            TaskCardCollapsed()
        }
    }
}

struct FocusSetupSelectAppsBottom: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 44)
                    .foregroundStyle(IceWhitePalette.PureSnow.color)
                HStack {
                    Text("placeholder")
                        .font(.body)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, 20)
            
            VStack(spacing: 4) {
                AppSelectRow()
                AppSelectRow()
                AppSelectRow()
                AppSelectRow()
                AppSelectRow()
            }
            
            Text("placeholder")
                .font(.caption)
                .foregroundStyle(.gray)
                .padding(.horizontal, 20)
                .padding(.top, 8)
            
            HStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 40)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                    Text("placeholder")
                        .font(.subheadline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 40)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    Text("placeholder")
                        .font(.subheadline)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 40)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                    Text("placeholder")
                        .font(.subheadline)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct FocusSetupPage: View {
    @Environment(\.dismiss) var dismiss
    @State private var showSelectApps = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundStyle(ContentView.Background3)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Text("placeholder")
                                .font(.body)
                                .foregroundStyle(IceWhitePalette.PureSnow.color)
                        }
                        Spacer()
                        Text("placeholder")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(IceWhitePalette.PureSnow.color)
                        Spacer()
                        Text("placeholder")
                            .font(.body)
                            .foregroundStyle(.clear)
                    }
                    .padding(.top, 50)
                    
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(SkyBluePalette.SummerSky.color)
                        .padding(.top, 20)
                    
                    Text("placeholder")
                        .font(.title)
                        .bold()
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                    
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(SkyBluePalette.SkyGlow.color)
                }
                .padding(.horizontal, 25)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .ignoresSafeArea(edges: .top)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    HStack(spacing: 0) {
                        Button {
                            showSelectApps = false
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 44)
                                    .foregroundStyle(showSelectApps ? IceWhitePalette.PureSnow.color : OceanBluePalette.OceanBlue.color)
                                Text("placeholder")
                                    .font(.subheadline)
                                    .foregroundStyle(showSelectApps ? MidnightNavyPalette.MidnightNavy.color : IceWhitePalette.PureSnow.color)
                            }
                        }
                        
                        Button {
                            showSelectApps = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 44)
                                    .foregroundStyle(showSelectApps ? OceanBluePalette.OceanBlue.color : IceWhitePalette.PureSnow.color)
                                Text("placeholder")
                                    .font(.subheadline)
                                    .foregroundStyle(showSelectApps ? IceWhitePalette.PureSnow.color : MidnightNavyPalette.MidnightNavy.color)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    if showSelectApps {
                        FocusSetupSelectAppsBottom()
                    } else {
                        FocusSetupAllAppsBottom()
                    }
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 55)
                    .foregroundStyle(OceanBluePalette.OceanBlue.color)
                Text("placeholder")
                    .font(.headline)
                    .foregroundStyle(IceWhitePalette.PureSnow.color)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(IceWhitePalette.GlacierFrost.color)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    FocusSetupPage()
}
