////
////  Caching.swift
////  
////
////  Created by Kaira Diagne on 20/05/16.
////
////
//
////  Data Manager
//
//    // Two public functions through which data can be requested
//        // ReloadTopIfNeed(forceOnline: Bool)
//        // Loadmore()
//
//    // When the data has changed the manager broadcasts a DataManagerDataDidChange notification
//    // When the manager has loaded more data (Next Page) it broadcasts a DataManagerDidLoadMore notification
//    // When the data manager can not give any results, in the case of a search it should send a corresponding notification
//    // When an error has occured the manager post a DataManagerDidReceiveErrorNotification 
//
//
//    // Which data needs to be cached 
//        // Movie lists: Toplist: Popular, Toprated, Upcoming, Nowplaying
//        // 
//
//
//        // Response Caching
//        // NSURLCache in Memory and On disk cache
//        // Entities need a way to know when they were last updated: E-tag,last modified, date created?? (List entity)
//
//
//    // Use an object mapper
//
//
//    //
//
//    // Request
//
//ake a step back for a second.
//The remote service is the only party in the conversation that knows how long the response is valid for. When you request search results from Google, you should not make assumptions about how long those search results will be valid for - Google should be telling you. You should not be assuming that the results will always be different, or that they will never change. Only the service can know. But it can tell you!
//The HTTP protocol supports "freshness" information out of the box. This information formalizes the means for a server to tell a client how long a response is valid for, when to revalidate it, etc. In practice this is most often used by both client and remote caches to determine how long to hold onto responses received from a server.
//On iOS and MacOS, NSURLCache does all of the hard work for you. When you make a request to a remote resource the URL loading system defaults to NSURLRequestUseProtocolCachePolicy, which implements the logic of the HTTP protocol specification. NSURLCache will see the freshness information sent by the server and act accordingly. So if you make a request for an image and the freshness information specifies "this is good for a week", every time you request that image during that week it will be served from the cache rather than the network. The cache is your persistence layer.
//This means that if the JSON REST service you are making requests to implements that freshness information - which is clearly it's responsibility - it's very difficult to justify implementing another layer of caching or persistence on top of that (i.e. "Core Data Syncing"). It's unnecessary complexity, and in practice it can be very problematic. I've worked on several applications that implemented "syncing", in most of those we ended up removing that persistence layer and letting the protocol do the work. That gave us a more reliable, stable, and trouble free application.
//There are, of course, plenty of APIs and services out there that return absolutely incorrect freshness information. It happens. It sucks. It's still the responsibility of the service to get it right, even if you may have to work around it on the client. If you control the service though, take a step back and come up with a plan for delivering that freshness information. Your app will thank you.
//
//
//Now it is possible to store all received book objects instantly into Realm. Setting the update option of the add write transition true, ensures that existing book items will simply be updated and new book items will be created and added to Realm.
//Realm detects existing book objects with a primary key and in this case we use the server id of the book items.
//
//I ended up with the following solution.
//
//Implementations in the models:
//
//Set a property NSDate* modelUpdate that indicates the last update of the model. For models that should be deleted when they are old.
//Set a property BOOL modelDelete in every model that needs to be deleted. But don't delete anything while the app is running. (so the existing models on memory don't become invalidated)
//Strategy for recycling cached model on a server request:
//
//Check if a list of cached models exists (lets say cache A) for a given server request. (where modelDelete = NO)
//In parallel, even if cache exists, run the request to the server in background.
//Use cache A to show content to user as soon as possible. (Don't make the user wait)
//When the request to the server is done, save the new results to the cache. (cache B)
//Update what the user is seeing with the new data, gently with fades etc.
//Mark all the models of cache A to be deleted. (modelDelete = YES)
//Delete cache at the following times:
//
//When the app starts. (didFinishLaunchingWithOptions)
//When the app terminates. (applicationWillTerminate)
//With code like this:
//
//NSDate* limitDate = [NSDate dateWithTimeIntervalSinceNow:-(60.0 * 60.0 * 24.0 * 7.0)];
//RLMResults* modelProductListArray = [ModelProductList objectsInRealm:_cacheDb
//where:@"modelUpdate < %@ || modelDelete = YES", limitDate];
//[_cacheDb deleteObjects:modelProductListArray];
//
//
//
//// Our entities which have to be classes need a way to no when they where last updated.05
//// This we check in the header
//// E-tag
//
//// Additional Timestamp