//
//  SeriesLandingScreen.swift
//  Series
//
//  Created by thanos kottaridis on 21/7/23.
//

import SwiftUI
import Presentation

struct SeriesLandingScreen: View {
    
    @State private var headerHeight: CGFloat = 0.0
    let text = """
In the early hours of the morning, as the sun began to rise over the horizon, the sleepy town came to life. Birds chirped merrily from the treetops, and a gentle breeze rustled through the leaves. The aroma of freshly brewed coffee filled the air, drawing people towards the local café.

In the heart of the town, a bustling market was taking shape. Colorful stalls lined the streets, displaying an array of fresh fruits, vegetables, and handmade crafts. The chatter of vendors and customers created a lively atmosphere, echoing through the narrow alleys.

Meanwhile, a group of children played joyfully in the nearby park. Their laughter and giggles resonated with the carefree spirit of youth. Parents sat on the benches, watching their little ones with fond smiles.

As the day progressed, the town's historic buildings stood proudly, each telling its own story of times gone by. Tourists wandered through the cobbled streets, capturing photographs of the picturesque scenery.

In the distance, the majestic mountains loomed, their peaks adorned with a dusting of snow. A hiking trail meandered through the wilderness, inviting adventurers to explore the wonders of nature.

In the evening, the town's lights flickered to life, casting a warm glow over the streets. Restaurants and eateries filled with the tantalizing scents of delicious dishes, enticing visitors and locals alike.

As the night fell, the sky was a canvas of twinkling stars, and the moon bathed the town in a soft, silvery light. Peaceful and serene, the town settled into a gentle slumber, ready to embrace a new day when the sun would rise again."

I hope you enjoyed this little scene! If you have any specific topics or themes in mind, feel free to let me know, and I can generate text accordingly.

In the early hours of the morning, as the sun began to rise over the horizon, the sleepy town came to life. Birds chirped merrily from the treetops, and a gentle breeze rustled through the leaves. The aroma of freshly brewed coffee filled the air, drawing people towards the local café.

In the heart of the town, a bustling market was taking shape. Colorful stalls lined the streets, displaying an array of fresh fruits, vegetables, and handmade crafts. The chatter of vendors and customers created a lively atmosphere, echoing through the narrow alleys.

Meanwhile, a group of children played joyfully in the nearby park. Their laughter and giggles resonated with the carefree spirit of youth. Parents sat on the benches, watching their little ones with fond smiles.

As the day progressed, the town's historic buildings stood proudly, each telling its own story of times gone by. Tourists wandered through the cobbled streets, capturing photographs of the picturesque scenery.

In the distance, the majestic mountains loomed, their peaks adorned with a dusting of snow. A hiking trail meandered through the wilderness, inviting adventurers to explore the wonders of nature.

In the evening, the town's lights flickered to life, casting a warm glow over the streets. Restaurants and eateries filled with the tantalizing scents of delicious dishes, enticing visitors and locals alike.

As the night fell, the sky was a canvas of twinkling stars, and the moon bathed the town in a soft, silvery light. Peaceful and serene, the town settled into a gentle slumber, ready to embrace a new day when the sun would rise again."

I hope you enjoyed this little scene! If you have any specific topics or themes in mind, feel free to let me know, and I can generate text accordingly.
"""
    var body: some View {
        GenericHeaderOverlapWrapper(
            configurations: GenericHeaderConfigurations.Builder()
                .addTitle(title: Str.seriesLandingTitle)
                .addLeftIcon(iconName: "kebab-menu")
                .addLeftIconAction(action: {
                    // TODO: - ADD ACTION
                })
                .addRightIcon(iconName: "magnifyingglass")
                .addRightIconAction(action: {
                    // TODO: - ADD ACTION
                })
                .build(),
            headerHeight: $headerHeight
        ) {
            List {
                // 1. Add a Spacer as content Inset
                // in order to achive Overlap visual Effect.
                Spacer()
                    .listRowInsets(EdgeInsets())
                    .frame(height: headerHeight)
                
                ForEach(0..<100) { index in
                    SeriesSectionView()
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.blue))
                        .listRowSeparator(.hidden, edges: .all)
                }
            }
            .listStyle(.plain)
            
        }
    }
}

struct SeriesSectionView: View {
    var body: some View {
        VStack{
            Text("row")
        }.background(.green)
    }
}
    
    
struct SeriesLandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SeriesLandingScreen()
    }
}
