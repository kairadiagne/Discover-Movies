# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
inhibit_all_warnings!

def shared_pods
    pod 'SwiftLint'
end

target 'DiscoverMovies' do
  use_frameworks!

  # Pods for DiscoverMovies
  shared_pods
  pod 'SDWebImage'
  pod 'ChameleonFramework'
  pod 'youtube-ios-player-helper'
  pod 'BRYXBanner'
  pod 'SwiftLint'

  target 'DiscoverMoviesTests' do
    inherit! :search_paths
  end

  target 'DiscoverMoviesUITests' do
    inherit! :search_paths
  end

end

target 'TMDbMovieKit' do
  use_frameworks!

  # Pods for TMDbMovieKit
  shared_pods
  pod 'Alamofire'

  target 'TMDbMovieKitTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Mocker'
  end
  
end
